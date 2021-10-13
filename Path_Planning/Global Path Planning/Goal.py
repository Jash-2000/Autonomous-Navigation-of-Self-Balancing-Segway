import math
from cv2 import cv2
from positional import Position

# Goal class for Goal object
class Goal:
    """
    Creates a Goal object
    
    Parameters
    ----------
    position : Position
        Position of Goal in the world
    mu : int, optional
        Peak of distribution, by default 1
    sigma : int, optional
        Spread of distribution, by default 1
    draw_radius : int, optional
        Radius for visualization, by default 5
    draw_color : tuple, optional
        Color for visualization, by default (0,255,0)
        
    """

    def __init__(self, position, mu=1, sigma=1, draw_radius=5, draw_color=(0,255,0)):

        # Property attributes
        self.position = position
        self._mu = mu
        self._sigma = sigma

        # Visual attributes
        self._draw_radius = draw_radius
        self._draw_color = draw_color

    def draw(self, image):
        cv2.circle(image, (int(self.position.x), int(self.position.y)), 
            self._draw_radius, self._draw_color, -1)  # Fill

    # Attribute type function
    def get_attraction_force(self, position):
        """
        Attraction force calculation function
        
        Parameters
        ----------
        position : Position
            Position of cell to check force at
        
        Returns
        -------
        double
            The value of attraction at cell

        """

        # Implementing attraction equation
        dist_value = -(1/(self._sigma*math.sqrt(2*math.pi))) * math.exp(-(Position.calculate_distance_squared(self.position,position)/(2*self._sigma*self._sigma)))
        return dist_value