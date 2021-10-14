# Incremental SLAM Engine - Active Astar 

The Pygame engine is specifically build to simulate active/incremental mapping and localization for a simple bot. Major milestones I have achieved in this project are:- 
1. Extension of Astar algorithm for dynamic path planning scenario. 
2. Development of the bot's movement and planning visualizations.
3. Developing the sensor output visualization plots in matplotlib.

The system uses grid based assumptions and the bot can run in any of the 9 blocks, assuming that the cost of moving diagonally is 
**Unit_Cost x sqrt(2)** ( in accordance to the pythagoras theorem). I have used the **Eucledian distance for the heuristic.**

This project implements Astar algorithm for a Global search as well as dynamic search case wherein a robot maps and finds the optimal path simultaneously. 
	* The first type of case is useful in outdoor mapping, where the robot has the entire map beforehand ( using Global Positioning Sensors).
	* The second type of problem is quite essential in real world scenario of indoor mapping or any case where we do not know the global attributes ( like in case of navigation of MARS Rover).

```
A* (pronounced "A-star") is a graph traversal and path search algorithm, which is often used in many fields of computer science due to 
its completeness, optimality, and optimal efficiency. AStar, being an informed search algorithm, is the best solution in many cases. 
Astar is simple an optimized fusion on Djikstra and Greedy Search Algorithms.
```

---
## Pygame for visualization purposes

Pygame is a python library for creating simple GUI for developing games. I have utilized the platform over here to visualize the real time path planning of the robot in both the cases.

The Pygame engine has to calibrated according to your Screen size using the following line (in draw.py):
```python
	WIDTH = 600    # Width of the Pygame Window.
```

---
## Setup Instructions

1. Clone this repository using the following command
```
	git clone https://github.com/Jash-2000/Active-Mapping-Visualizer-Python.git
```

2. Install all the requirements ( assuming you have python installed), by running the following script:
```
	pip install requirements.txt
```

3. Choose the map image you want to work with
```
	By default I have used 3 maps but you can add your own custom maps to the engine. A typical .map file has 3 identifiers - '@' for map boundary, 'T' for tree/obstacle and '.' for empty space. Once you choose the map, the map image will pop up, press escape to close that file and initiate the pygame server. 
```

4. Choose strating and ending points and obstacle locations
```
	Once the pygame server opens, use left mouse click to select the strating and ending positions. Press on any other empty spot to make it an obstacle. Finally press "Space Bar" to strat the simulation.
```

---
## Expected Output

I simulated the robot to run on the 'Hard.map' file as shown below, and gave it an complex starting and ending point to track. 

<img src="https://github.com/Jash-2000/Active-Mapping-Visualizer-Python/blob/main/Maps/hard.png" alt="Hard Map" width="200"/>


The series of images below will show the sensor outputs, where black colour represents the occupancy grid, red pixels represents the path it has covered and blue and green pixels represents the current position of the bot and the final goal point, respectively.

| Phase Number | Image	|
|--------------|--------|
|	1      | <img src="https://github.com/Jash-2000/Active-Mapping-Visualizer-Engine/blob/main/Phase_Output/Phase_1.png" alt="Hard Map" width="400"/> |
|	9      | <img src="https://github.com/Jash-2000/Active-Mapping-Visualizer-Engine/blob/main/Phase_Output/Phase_9.png" alt="Hard Map" width="400"/> |
|	17      | <img src="https://github.com/Jash-2000/Active-Mapping-Visualizer-Engine/blob/main/Phase_Output/Phase_17.png" alt="Hard Map" width="400"/> |
|	25      | <img src="https://github.com/Jash-2000/Active-Mapping-Visualizer-Engine/blob/main/Phase_Output/Phase_25.png" alt="Hard Map" width="400"/> |
|	33      | <img src="https://github.com/Jash-2000/Active-Mapping-Visualizer-Engine/blob/main/Phase_Output/Phase_33.png" alt="Hard Map" width="400"/> |
|	41      | <img src="https://github.com/Jash-2000/Active-Mapping-Visualizer-Engine/blob/main/Phase_Output/Phase_41.png" alt="Hard Map" width="400"/> |
|	45      | <img src="https://github.com/Jash-2000/Active-Mapping-Visualizer-Engine/blob/main/Phase_Output/Phase_1.png" alt="Hard Map" width="400"/> |


The GIF below will show how the bot incrementally maps the environment while planning its path and accordingly makes the descisions dynamically.

![Working_GIF](https://github.com/Jash-2000/Active-Mapping-Visualizer-Engine/blob/main/Active_Mapping.mov) [Link](https://github.com/Jash-2000/Active-Mapping-Visualizer-Engine/blob/main/Active_Mapping.mov)
