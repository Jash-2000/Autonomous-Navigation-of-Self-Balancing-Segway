import numpy as np
import matplotlib.pyplot as plt
import random
import math

from Path_Planner import *
from Agent import *
from Obstacle import *

# Parameters
N = 30  # number of agents
G0 = 20  # G0 gravity 50
G = G0
Eps = 0.001  # small constant ???
Xs = -45  # START position
Ys = -45
Xg = 45  # GOAL position
Yg = 45
alfa = 1000  # penalty
Area = 100  # size area
robot_radius = 4.0
Episodes = 600.0  # simulation time
zet = 0.1  # zeta parameter exp to change gravity
SHOW = 3000
len = Area / 2
xmax = ymax = len
xmin = ymin = -len


def main():
    print("potential_field_planning start")
    obtacles = []
    agents = []
    viel = random.randint(20, 30)
    plt.grid(True)
    plt.axis("equal")

    for i in range(viel):
        obtacles.append(obtacle(random.randint(-len, len), random.randint(-len, len)))
        plt.plot(obtacles[i].x, obtacles[i].y, "o")

    plt.grid(True)
    plt.axis("equal")
    for _ in range(N):
        agents.append(agent(Xs, Ys))

    id, t, data, path = path_planning(agents, obtacles, G)

    plt.cla()
    fig1 = plt.figure()
    ax1 = fig1.add_subplot(1, 1, 1)
    k = 9
    for i in range(viel):
        ax1.plot(obtacles[i].x, obtacles[i].y, "o")
    ax1.plot(Xs, Ys, "*k")
    ax1.plot(Xg, Yg, "*m")

    ax1.plot(agents[id].x, agents[id].y, linewidth=1)
    ax1.set_title('path')

    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    ax.plot(agents[id].fit_mat, color='tab:blue', label='best_fit')
    ax.plot(data, color='tab:orange', label='average_fit')
    ax.set_title('fit function')
    fig.legend(loc='upper right')

    print(t)
    print(path)
    plt.show()

if __name__ == '__main__':
    main()