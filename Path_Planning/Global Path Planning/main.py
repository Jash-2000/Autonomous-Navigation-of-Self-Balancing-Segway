print("\n This is the A-star Visualization. Once you choose the input image for the map, the map will render into a grid fromat. To see it again into the original format, press the 's' key \n")
input("Press any key to continue to choose your image")

from map import *
from draw import *
from astar import *

import pygame
import math
from queue import PriorityQueue

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
	
		for numr,r in enumerate(Map):
			for numc,c in enumerate(r):
				if ( Map[numr][numc] == '@' or Map[numr][numc] == 'T'):
					grid[numc][numr].make_barrier() 
	else:
		ROWS = int(input("\n Enter the number of rows you want in the blank map. : "))
		grid = make_grid(ROWS, width)
			
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
					spot.make_barrier()

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
					for row in grid:
						for spot in row:
							spot.update_neighbors(grid)

					# This is the step where we actually apply the algorithm.
					algorithm(lambda: draw(win, grid, ROWS, width), grid, start, end)

				if event.key == pygame.K_r:
					start = None
					end = None
					grid = make_grid(ROWS, width)

				if event.key == pygame.K_s:
					showImg()
	pygame.quit()

main(WIN, WIDTH)