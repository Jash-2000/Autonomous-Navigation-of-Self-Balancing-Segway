import numpy as np 
from cv2 import cv2
import math
import scipy.io

from positional import Position
from Goal import *
from Agent import *
from Obstacle import *

# Main
if __name__ == '__main__':
    
    # Defining world dimensions
    world_size = (500, 500)

    # Initializing blank canvas(OpenCV) with white color
    image = np.ones((world_size[1],world_size[0],3),dtype=np.uint8) * 255

    # Defining agent and goal
    agent = Agent(Position(350, 50), scan_radius=10, possible_moves=30)
    goal = Goal(Position(350, 450), sigma=math.sqrt(world_size[0]**2 + world_size[1]**2))

    # Defining obstacles in a list
    sigma_obstacles = 5
    obstacles = [
                Obstacle(Position(250, 180), sigma=sigma_obstacles, draw_radius=4*sigma_obstacles), 
                Obstacle(Position(250, 280), sigma=sigma_obstacles, draw_radius=4*sigma_obstacles),
                Obstacle(Position(250, 380), sigma=sigma_obstacles, draw_radius=4*sigma_obstacles), 
                Obstacle(Position(350, 180), sigma=sigma_obstacles, draw_radius=4*sigma_obstacles), 
                Obstacle(Position(350, 280), sigma=sigma_obstacles, draw_radius=4*sigma_obstacles), 
                Obstacle(Position(350, 380), sigma=sigma_obstacles, draw_radius=4*sigma_obstacles)
                ]

    # Drawing objects
    agent.draw(image)
    goal.draw(image)
    for obstacle in obstacles:
        obstacle.draw(image)

    # Displaying initial frame and wait for intial key press
    cv2.imshow('Output', image)

    Theta_list = []

    while Position.calculate_distance(agent.position, goal.position) > 10:
        possible_moves = agent.get_possible_moves()
        min_value = math.inf
        best_move = possible_moves[0] # initializing best move with first move
        
        # Finding move with the least value
        for move in possible_moves:
            move_value = goal.get_attraction_force(move)
            for obstacle in obstacles:
                move_value += obstacle.get_repulsion_force(move)

            if move_value < min_value:
                min_value = move_value
                best_move = move
        

        Theta_list.append(math.atan( (best_move.y - agent.position.y)/(best_move.x - agent.position.x) ))

        # Setting best move as agent's next position
        agent.position = best_move

        # Displaying updated frame
        agent.draw(image)
        cv2.imshow('Output', image)
        cv2.waitKey(20)
    
    # Hold on last frame
    cv2.waitKey(0) 

arr = np.asarray(Theta_list)
scipy.io.savemat('points.mat', dict(arr=arr))