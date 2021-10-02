## Path movement
from draw import *
import numpy as np

def islastmove(i,j,I,J):
	if( ((I - i)**2 + (J - j)**2)**0.5 <= np.sqrt(2) ): 
		return True
	else:
		return False

def reset_path(grid, origGrid):
	for row in grid:
		for spot in row:
			if(spot.color == PURPLE):
				spot.reset()
	
	for Row in origGrid:
		for Spot in Row:
			if(Spot.is_tree()):
				R,C = Spot.get_pos()
				grid[R][C].make_tree()
			elif(Spot.is_barrier()):
				R,C = Spot.get_pos()
				grid[R][C].make_barrier()

def mover(draw, grid, origGrid, start, end):
	
	i, j = start.get_pos()
	I, J = end.get_pos()


	if islastmove(i,j,I,J):
		print("This is the last move")
		start = end
		end.make_start()
		end = None
		return 0, start, end
	else:
		print("This is not the last move")
		for neigh in start.neighbors:
			if(neigh.color == PURPLE):
				start = neigh
				start.make_start()
				break
		reset_path(grid, origGrid)
		draw()
		return 1, start, end