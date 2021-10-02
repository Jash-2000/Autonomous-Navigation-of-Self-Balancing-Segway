# Path Planning using PathGAN - A star Algorithm 

**One of the major milestones I have achieved in this repository is extension of Astar algorithm for dynamic path planning scenario and its visualization.**

The current version runs in diagonally aswell, assuming that the cost of moving diagonally is 
**cost times sqrt(2)** ( in accordance to the pythagoras theorem). I have used the **Eucledian distance for the heuristic.**

This project implements Astar algorithm for a GLobal search as well as dynamic search case wherein a robot maps and finds the optimal path simultaneously. 
	* The first type of case is useful in outdoor mapping, where the robot has the entire map beforehand ( using Global Positioning Sensors).
	* The second type of problem is quite essential in real world scenario of indoor mapping or any case where we do not know the global attributes ( like in case of navigation of MARS Rover).

```
A* (pronounced "A-star") is a graph traversal and path search algorithm, which is often used in many fields of computer science due to 
its completeness, optimality, and optimal efficiency. AStar, being an informed search algorithm, is the best solution in many cases. 
Astar is simple an optimized fusion on Djikstra and Greedy Search Algorithms.
```

This readme file contains the basic explaination of the code and also description of each file present in the repository. 

The implementation of Dynamic Astar is an extention ( and a little bit change in GUI ) of the standard implementation. I have thus, added lots of comments in the **Global Path Planning Scripts** but there are not much comments in the **Dynamic Path Planning Scripts**.

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
	```
	2. Install all the requirements ( assuming you have python installed), by running the following script:
	```
	```
	3.  
