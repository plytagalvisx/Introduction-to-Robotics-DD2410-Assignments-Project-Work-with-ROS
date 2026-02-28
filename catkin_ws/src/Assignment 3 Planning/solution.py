#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from math import atan2, atan, sin, pi
import heapq
from dubins import *  # provides step()

def wrap_to_pi(a):
    while a <= -pi:
        a += 2*pi
    while a > pi:
        a -= 2*pi
    return a

def clamp(v, lo, hi):
    return lo if v < lo else hi if v > hi else v

def euclidean_norm(dx, dy): # magnitude of vector (dx, dy)
    return (dx**2 + dy**2)**0.5

def euclidean_distance_between_points(x1, y1, x2, y2):
    return ((x2 - x1)**2 + (y2 - y1)**2)**0.5

# pseudocode for Theta*: https://en.wikipedia.org/wiki/Theta*
def line_of_sight(a, b, occ, nx, ny):
    """
    Bresenham-style line-of-sight check on a grid.

    a, b: (ix, iy) integer grid cells
    occ: 2D bool grid where occ[ix][iy] == True means occupied
    nx, ny: grid size

    Returns True if every traversed cell on the line is inside bounds and free.
    """
    x0, y0 = a
    x1, y1 = b

    dx = abs(x1 - x0)
    dy = -abs(y1 - y0)

    sx = 1 if x0 < x1 else -1
    sy = 1 if y0 < y1 else -1

    err = dx + dy  # dy is negative

    while True:
        # bounds + occupancy check
        if not (0 <= x0 < nx and 0 <= y0 < ny):
            return False
        if occ[x0][y0]: # if cell is occupied, no line of sight
            return False

        if x0 == x1 and y0 == y1:
            return True

        e2 = 2 * err
        if e2 >= dy:
            if x0 == x1:
                return True
            err += dy
            x0 += sx
        if e2 <= dx:
            if y0 == y1:
                return True
            err += dx
            y0 += sy

# Theta* Planner:
def theta_star_grid(start, goal, occ, nx, ny):
    """
    Theta* any-angle path planning on an 8-connected grid.

    start, goal: (ix, iy)
    occ: 2D bool grid where occ[ix][iy] == True means occupied
    nx, ny: grid size

    Returns: list of cells [(ix, iy), ...] or None if no path found.
    """
    # 8-connected neighbors
    nbrs = [(-1,0),(1,0),(0,-1),(0,1),(-1,-1),(-1,1),(1,-1),(1,1)]

    def heuristic(c): # based on Euclidean distance in grid coordinates
        return euclidean_distance_between_points(goal[0], goal[1], c[0], c[1])
    
    def cost(a, b): 
        return euclidean_distance_between_points(b[0], b[1], a[0], a[1])

    # gScore + parent
    g = {start: 0.0}
    parent = {start: start}

    openh = [(heuristic(start), start)]  # (f, node)
    closed = set()

    while openh:
        _, s = heapq.heappop(openh)
        if s in closed:
            continue
        closed.add(s)

        if s == goal:
            # reconstruct path
            path = [s]
            while parent[path[-1]] != path[-1]:
                path.append(parent[path[-1]])
            path.reverse()
            return path

        sx, sy = s
        ps = parent[s]

        for dx, dy in nbrs:
            nb = (sx + dx, sy + dy)
            nx2, ny2 = nb

            if not (0 <= nx2 < nx and 0 <= ny2 < ny):
                continue
            if occ[nx2][ny2]: # if cell is occupied, no path through it
                continue
            if nb in closed:
                continue

            # Ensure neighbor has entries
            # Initialize values for neighbor if it is 
            # not already in the open list
            if nb not in g:
                g[nb] = float("inf")
                parent[nb] = None

            # This part of the algorithm is the main difference between A* and Theta*
            # --- update_vertex(s, nb) ---
            # If line-of-sight(parent(s), nb), try bypassing s
            if ps is not None and line_of_sight(ps, nb, occ, nx, ny):
                cand = g[ps] + cost(ps, nb)
                if cand < g[nb]:
                    g[nb] = cand
                    parent[nb] = ps
                    heapq.heappush(openh, (g[nb] + heuristic(nb), nb))
            else:
                cand = g[s] + cost(s, nb)
                if cand < g[nb]:
                    g[nb] = cand
                    parent[nb] = s
                    heapq.heappush(openh, (g[nb] + heuristic(nb), nb))
    return None

# A* planner:
def astar_path_planner(start, goal, occ_grid, nx, ny):
    """
    A* on an 8-connected grid.

    start, goal: (ix, iy)
    occ: 2D boolean grid where occ[ix][iy] == True means occupied
    nx, ny: grid dimensions

    Returns: list of cells [(ix,iy), ...] or None
    """
    neighbours = [(-1,0),(1,0),(0,-1),(0,1),(-1,-1),(-1,1),(1,-1),(1,1)]

    def heuristic(a, b): # based on Euclidean distance in grid coordinates
        return euclidean_distance_between_points(a[0], a[1], b[0], b[1])

    openh = [(heuristic(start, goal), 0.0, start)]  # (f, g, node) open heap
    came  = {start: None} # best known parent for each cell
    gbest = {start: 0.0} # best known g score for each cell
    visited  = set() # closed set (visited cells)

    while openh:
        _, g, cur = heapq.heappop(openh)
        if cur in visited:
            continue
        visited.add(cur) # mark current cell as visited

        if cur == goal: # reconstruct path
            path = []
            while cur is not None:
                path.append(cur)
                cur = came[cur] # move backwards through parents to reconstruct path
            return path[::-1] # reverse path to get from start to goal

        cx, cy = cur
        for dx, dy in neighbours:
            nx2, ny2 = cx + dx, cy + dy
            if not (0 <= nx2 < nx and 0 <= ny2 < ny): # if cell is out of bounds, skip
                continue
            if occ_grid[nx2][ny2]: # if cell is occupied, skip
                continue

            nxt = (nx2, ny2) # neighbour cell
            ng = g + euclidean_norm(dx, dy) # cost to move to neighbour (neighbour g score)

            if ng < gbest.get(nxt, 1e18):
                gbest[nxt] = ng
                came[nxt] = cur
                heapq.heappush(openh, (ng + heuristic(nxt, goal), ng, nxt)) # push neighbour to open heap with f = g + h

    return None

# Pure pursuit tracker/controller:
def pure_pursuit_controller(car, waypoints, dt=0.01, Ld=1.0, waypoint_tol=0.5, t_max=80.0):
    """
    Tracks waypoints using pure pursuit.

    Returns: (controls, times)
    """
    max_phi = pi / 4

    # Initial state
    x, y, theta = car.x0, car.y0, 0.0
    t = 0.0
    controls = []
    times = [0.0]
    wi = 0

    def done_xy(x, y): # when we're close enough to the goal, we can stop
        return euclidean_distance_between_points(x, y, car.xt, car.yt) < 1.5

    while t < t_max and not done_xy(x, y):
        # advance index if close (checkpoint completed --> go to next checkpoint). "Did I reach this waypoint?"
        while wi < len(waypoints) - 1 and euclidean_distance_between_points(waypoints[wi][0], waypoints[wi][1], x, y) < waypoint_tol: # if we're close to the current waypoint, advance to the next one
            wi += 1

        # Pure Pursuit lookahead target selection: choose a target at least Ld away (aim further ahead so steering is smoother). "Where should I aim right now?"
        tj = wi
        while tj < len(waypoints) - 1 and euclidean_distance_between_points(waypoints[tj][0], waypoints[tj][1], x, y) < Ld: # if the current target is too close, try pushing forward to find a further target
            tj += 1
        tx, ty = waypoints[tj]

        heading_to_target = atan2(ty - y, tx - x)
        heading_err = wrap_to_pi(heading_to_target - theta) # heading error to target position. theta is the current heading of the car, so this is how much we need to turn to face the target
        kappa = 2.0 * sin(heading_err) / max(Ld, 1e-6) # curvature to reach target (pure pursuit control law)
        phi = clamp(atan(kappa), -max_phi, max_phi) # steering angle command (clamped to max_phi)

        x, y, theta = step(car, x, y, theta, phi, dt=dt)

        controls.append(phi)
        t += dt
        times.append(t)

    return controls, times


def solution(car):
    env = car._environment # 20x10 environment described by a rectangle [(0,0),(20,0),(20,10),(0,10)], containing n circular obstacles of radius r, positioned randomly within

    # Create occupancy grid representation + obstacle inflation
    res = 0.25 # grid resolution (smaller = better but slower)
    margin = 0.55 # inflate obstacles margin
    inflated = [(ox, oy, r + margin) for (ox, oy, r) in car.obs]

    nx = int(env.lx / res) + 1 # number of grid cells in x direction
    ny = int(env.ly / res) + 1 # number of grid cells in y direction

    def safe_inflated(x, y): # returns true (safe) if (x, y) is in bounds and not in collision with any inflated obstacle
        if x < 0 or x > env.lx or y < 0 or y > env.ly:
            return False
        for (ox, oy, rr) in inflated:
            if euclidean_distance_between_points(x, y, ox, oy) <= rr:
                return False
        return True

    def to_cell_coordinates(x, y): # to grid coordinates (ix, iy)
        ix = int(round(x / res))
        iy = int(round(y / res))
        return max(0, min(nx - 1, ix)), max(0, min(ny - 1, iy))

    def to_world_coordinates(ix, iy): # to world coordinates (x, y) at cell center
        return ix * res, iy * res

    # Build occupancy grid
    occ_grid = [[False] * ny for _ in range(nx)]
    for ix in range(nx):
        x = ix * res
        for iy in range(ny):
            y = iy * res
            if not safe_inflated(x, y):
                occ_grid[ix][iy] = True # occupied cell
            else:
                occ_grid[ix][iy] = False # free cell

    start = to_cell_coordinates(car.x0, car.y0) # transform start position to grid coordinates 
    goal  = to_cell_coordinates(car.xt, car.yt) # transform goal position to grid coordinates

    # ____________________________________________________________________________________________________

    # Use A*:
    # cells = astar_path_planner(start, goal, occ_grid, nx, ny) # plan path in grid coordinates (list of cells) using A*
    # if cells is None:
    #     # fallback: no path found; return a minimal valid output
    #     return [0.0], [0.0, 0.01]
    # waypoints = [to_world_coordinates(ix, iy) for (ix, iy) in cells] # convert path from grid coordinates to world coordinates (list of waypoints)

    # ____________________________________________________________________________________________________

    # Use Theta*:
    cells = theta_star_grid(start, goal, occ_grid, nx, ny)
    if cells is None:
        # fallback: no path found; return a minimal valid output
        return [0.0], [0.0, 0.01]
    waypoints = [to_world_coordinates(ix, iy) for (ix, iy) in cells]  # then feed to pure pursuit

    # ____________________________________________________________________________________________________

    controls, times = pure_pursuit_controller(car, waypoints, dt=0.01, Ld=1.0, waypoint_tol=0.5, t_max=80.0) # track waypoints with pure pursuit controller to get controls and times

    return controls, times