import matplotlib.pyplot as plt
from draw import *
import numpy as np

def plot(ROWS, start_pos, rowe, cole, grid):
	Map = np.zeros(shape=(ROWS,ROWS,3))

	# Empty Path to be made white
	for row in grid:
		for spot in row:
			for neighbor in spot.neighbors:
				r,c = neighbor.get_pos()
				Map[c, r, 0] = 255
				Map[c, r, 1] = 255
				Map[c, r, 2] = 255

	
	for num,points in enumerate(start_pos):
		if(num == len(start_pos) - 1):
			# Current Position to be made BLUE
			print(points)
			Map[points[1], points[0], 0] = 0
			Map[points[1], points[0], 1] = 0
			Map[points[1], points[0], 2] = 255

		else:
			print(points)
			# Path point to be made Red
			Map[points[1], points[0], 0] = 255
			Map[points[1], points[0], 1] = 0
			Map[points[1], points[0], 2] = 0

	# End point to be made Green
	Map[cole, rowe, 0] = 0
	Map[cole, rowe, 1] = 255
	Map[cole, rowe, 2] = 0

	Map = Map.astype(int)
	print(Map)
	# Now Plotting the image
	plt.imshow(Map)
	plt.show()