# Position class for position based calculations
import math

class Position:
    """
    Creates a Position object
    x : double
        x coordinate
    y : double
        y coordinate
        
    """
    def __init__(self, x, y):

        self.x = x
        self.y = y
    
    """
    Calculates the Eucledian distance between current position and the position passed as parameter
    It can also be usedd as static function by specifying class name and giving two parameters
        
    """
    def calculate_distance(self, other):
        return math.sqrt((self.x - other.x)**2 + (self.y - other.y)**2)
    
    """
    Calculates squared distance between current position and the position passed as parameter
    It can also be usedd as static function by specifying class name and giving two parameters
    """
    def calculate_distance_squared(self, other):
        return (self.x - other.x)**2 + (self.y - other.y)**2