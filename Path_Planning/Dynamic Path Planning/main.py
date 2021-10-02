print("\n This is the A-star Visualization. Once you choose the input image for the map, the map will render into a grid fromat. To see it again into the original format, press the 's' key")
input("You can then add the trees but you wont be able to alter the system boundaries. \nPress any key to continue to choose your image")

import time
from map import *
from draw import *
from astar import *
from plotter import *
from move import mover

import pygame
import math
from queue import PriorityQueue

start_pos = []

def get_clicked_pos(pos, rows, width):
	gap = width // rows
	y, x = pos

	row = y // gap
	col = x // gap

	return row, col

def main(win, width):
	
	if (flag == 0):
		Map, pad = getDetails()
		ROWS = pad			
		grid = make_grid(ROWS, width)
		original_grid = make_grid(ROWS, width)
	
		for numr,r in enumerate(Map):
			for numc,c in enumerate(r):
				if( Map[numr][numc] == '@'):
					grid[numc][numr].make_barrier()
					original_grid[numc][numr].make_barrier()
				if(Map[numr][numc] == 'T'):
					grid[numc][numr].make_tree()
					original_grid[numc][numr].make_tree()
	else:
		ROWS = int(input("\n Enter the number of rows you want in the blank map. : "))
		grid = make_grid(ROWS, width)
		original_grid = make_grid(ROWS, width)
			
	start = None
	end = None

	run = True			# If True, Pygame engine would work.
	while run:
		draw(win, grid, ROWS, width)			# Showing Colour of each node at every iteration.
		
		# Getting event type output from Pygame engine 
		for event in pygame.event.get():
			if event.type == pygame.QUIT:
				run = False

			if pygame.mouse.get_pressed()[0]: # LEFT
				pos = pygame.mouse.get_pos()
				row, col = get_clicked_pos(pos, ROWS, width)
				spot = grid[row][col]
				if not start and spot != end:
					start = spot
					start.make_start()

				elif not end and spot != start:
					end = spot
					end.make_end()

				elif spot != end and spot != start:
					spot.make_tree()

			elif pygame.mouse.get_pressed()[2]: # RIGHT
				pos = pygame.mouse.get_pos()
				row, col = get_clicked_pos(pos, ROWS, width)
				spot = grid[row][col]
				spot.reset()
				if spot == start:
					start = None
				elif spot == end:
					end = None

			if event.type == pygame.KEYDOWN:
			
				if event.key == pygame.K_SPACE and start and end:
					finish = 1
					while(finish):
						# Now we ensure that the view point of the robot is just of 3 unit radius.
						for row in grid:
							for spot in row:
								p1 = spot.get_pos()
								p2 = start.get_pos()
								if( h(p1,p2) <= 5 and spot.ngh_update == 0):
									spot.update_neighbors(grid)
								else:
									if(spot.ngh_update == 0):
										spot.all_neighbors(grid)

						(rows,cols) = start.get_pos()
						start_pos.append((rows, cols))
						rowe,cole = end.get_pos()
						plot(ROWS, start_pos, rowe, cole, grid)

						# This is the step where we actually apply the algorithm.
						algorithm(lambda: draw(win, grid, ROWS, width), grid, start, end)
						finish, start, end = mover(lambda: draw(win, grid, ROWS, width), grid, original_grid, start, end)
						time.sleep(5)

				if event.key == pygame.K_r:
					start = None
					end = None
					grid = make_grid(ROWS, width)

				if event.key == pygame.K_s:
					showImg()
	pygame.quit()

main(WIN, WIDTH)