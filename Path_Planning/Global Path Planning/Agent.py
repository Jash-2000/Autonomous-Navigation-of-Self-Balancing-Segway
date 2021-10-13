# Agent class for Agent attributes

import math
from cv2 import cv2
from positional import Position

class Agent:
    """
    Creates an Agent object
    
    Parameters
    ----------
    position : Position
        Position of agent in world
    scan_radius : int, optional
        Step size of agent, by default 1
    possible_moves : int, optional
        Number of point generated around agent, by default 6
    draw_radius : int, optional
        Radius for visualization, by default 5
    draw_color : tuple, optional
        Color for visulization, by default (255,0,0)

    """

    def __init__(self, position, scan_radius=1, possible_moves=6, draw_radius=5, draw_color=(255,0,0)):
        
        # Property attributes
        self.position = position
        self._scan_radius = scan_radius
        self._possible_moves = possible_moves

        # Visual attributes
        self._draw_radius = draw_radius
        self._draw_color = draw_color

    def draw(self, image):
        cv2.circle(image, (int(self.position.x), int(self.position.y)), 
            self._draw_radius, self._draw_color, -1)  # Fill

    def get_possible_moves(self):
        """
        Makes a list of points around agent
        
        Returns
        -------
        list
            List of points around agent

        """

        angle_increment = (2*math.pi)/self._possible_moves # 2pi/n
        angle = -angle_increment # Going one step negative to start from zero
        possible_moves_list = []
        for _ in range(self._possible_moves):
            # Starting from angle 0
            angle += angle_increment
            possible_moves_list.append(Position(self._scan_radius * math.cos(angle) + self.position.x,
                                                self._scan_radius * math.sin(angle) + self.position.y))

        return possible_moves_list