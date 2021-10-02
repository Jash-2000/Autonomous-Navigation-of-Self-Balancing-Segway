import math
from queue import PriorityQueue
import pygame
import math
from queue import PriorityQueue

WIDTH = 600    # Width of the Pygame Window.

# Setting Window Size
WIN = pygame.display.set_mode((WIDTH, WIDTH))
pygame.display.set_caption("A* Path Finding Algorithm")

RED = (255, 0, 0)
GREEN = (0, 255, 0)
BLUE = (0, 255, 0)
YELLOW = (255, 255, 0)
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
PURPLE = (128, 0, 128)
ORANGE = (255, 165 ,0)
GREY = (128, 128, 128)
TURQUOISE = (64, 224, 208)

"""
	Each Node Object would have diffeent properties that would define its state for the algorithm.
	The Grid in the pygame defination would have rows*cols number of Node Objects.
"""
class Node:
	def __init__(self, row, col, width, total_rows):
		self.row = row
		self.col = col
		self.x = row * width   # Coordinates
		self.y = col * width   # Coordinates
		self.color = WHITE
		self.neighbors = []
		self.width = width
		self.total_rows = total_rows

	def get_pos(self):
		return self.row, self.col

	def is_closed(self):
		return self.color == RED

	def is_open(self):
		return self.color == GREEN

	def is_barrier(self):
		return self.color == BLACK

	def is_start(self):
		return self.color == ORANGE

	def is_end(self):
		return self.color == TURQUOISE

	def reset(self):
		self.color = WHITE

	def make_start(self):
		self.color = ORANGE

	def make_closed(self):
		self.color = RED

	def make_open(self):
		self.color = GREEN

	def make_barrier(self):
		self.color = BLACK

	def make_end(self):
		self.color = TURQUOISE

	def make_path(self):
		self.color = PURPLE

	# Drawing the the grid space in pygame.
	def draw(self, win):
		pygame.draw.rect(win, self.color, (self.x, self.y, self.width, self.width))

	"""
		Updates the Neighbour's list by the following logic:
			-> A neightbhbour node must not be barrier
			-> A neighbour node can be the end node.

		The neighbour is a list of touples of Node, cost of going there.
	"""
	def update_neighbors(self, grid):
		self.neighbors = []

		if self.row > 0 and self.col > 0 and not grid[self.row - 1][self.col -1 ].is_barrier(): # UP-LEFT
			self.neighbors.append(grid[self.row - 1][self.col -1 ])

		if self.row < self.total_rows - 1 and self.col > 0 and not grid[self.row + 1][self.col -1 ].is_barrier(): # UP-RIGHT
			self.neighbors.append(grid[self.row + 1][self.col -1 ])

		if self.row >0 and self.col < self.total_rows - 1 and not grid[self.row - 1][self.col + 1].is_barrier(): # DOWN-LEFT
			self.neighbors.append(grid[self.row - 1][self.col + 1])

		if self.row < self.total_rows - 1 and self.col < self.total_rows - 1 and not grid[self.row + 1][self.col+1].is_barrier(): # DOWN-RIGHT
			self.neighbors.append(grid[self.row + 1][self.col+1])

		if self.row < self.total_rows - 1 and not grid[self.row + 1][self.col].is_barrier(): # DOWN
			self.neighbors.append(grid[self.row + 1][self.col])

		if self.row > 0 and not grid[self.row - 1][self.col].is_barrier(): # UP
			self.neighbors.append(grid[self.row - 1][self.col])

		if self.col < self.total_rows - 1 and not grid[self.row][self.col + 1].is_barrier(): # RIGHT
			self.neighbors.append(grid[self.row][self.col + 1])

		if self.col > 0 and not grid[self.row][self.col - 1].is_barrier(): # LEFT
			self.neighbors.append(grid[self.row][self.col - 1])

	def __lt__(self, other):
		return False

"""
	In this function, we draw the actual grid on pygame engine.
	Each grid in Pygame gets initialized with an empty Node Object.

	Outputs -> A 2-D list called grid that has its indivisdual elemnts as the Nodes.
"""
def make_grid(rows, width):
	grid = []
	gap = width // rows
	for i in range(rows):
		grid.append([])
		for j in range(rows):
			node = Node(i, j, gap, rows)
			grid[i].append(node)

	return grid

"""
	Draws the grid lines.
"""
def draw_grid(win, rows, width):
	gap = width // rows
	for i in range(rows):
		pygame.draw.line(win, GREY, (0, i * gap), (width, i * gap))
		for j in range(rows):
			pygame.draw.line(win, GREY, (j * gap, 0), (j * gap, width))
"""
	This function draws a grid box for every node.
	The draw function inside the class draws only for individual nodes.
"""
def draw(win, grid, rows, width):
	win.fill(WHITE)

	for row in grid:
		for node in row:
			node.draw(win)

	draw_grid(win, rows, width)
	pygame.display.update()