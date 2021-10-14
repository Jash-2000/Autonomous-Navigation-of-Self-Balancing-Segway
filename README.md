# Autonomous Navigation and Balance of 2-Wheeled Self-Balancing Segway Robot

The Project involves the **Desgin and Development of a precise Control model** for a **2-wheeled Segway Robot** for implementing a **parametized( give and input as distance, speed or even a function of angular dip as present in new segways) self-balancing robot**. Additionally, the robot can also plan its path and **navigate autonomously and implement mapping incrementally**. **Constraints on the physical model** were modelled precisley keeping into account the frictional and electrical resistances. Finally, various high speed and precise **Soft Computing techniques** were deployed for tuning the controllers and planning path.  

The project's Tech Stack Inolved the following:
 * **Path Planning Module**
    1. Using Artificial Potential Field for non-dynamic path planning module.
    2. Used Active - Astar for incremental SLAM. Here the bot could plan dynamically even without initial knowledge of the world.
    3. Deviational Transformationa and Shift of Frames.
 
 * **Navigation Module**
    1. Modelling of Chasis, Motor, Pole and Battery system.
    2. LQR Controller Design for Radial movement.
    3. Advance PID Controller for Angular movement.
    4. Feedback Balance Scheme for the Verticle Pole. 

* **Parameter Tuning**
    1. Ricarti Solver Model was used for LQR's cost equation.
    2. Bacteria Foraging and Genetic Algorithm were used to find Q and R matrix.
    3. Ant Colony Optimization was utilized for tuning P,I and D parameters. 
    

**The Servo Problem is defined as the dynamic response when the controller changes its set-point and Regulatory Problem is defined when the Controller tries to Manipulate the system input to counteract the effects of disturbances. The figure below shows these responses for the developed LQR Controller**

| Regulatory Action | Servo Action |
| ----------------- | ------------ |
| ![Regulatory Action](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Regulatory%20Action.jpg) | ![Servo Action](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Servo%20Action.jpg) |

**The precision in the movement of the Bot is as plotted below ( Input given was 7 units towards North)**. Notice how the controller does not move in a straight line due to the **Real-world contoller constraints and frcitional losses**.

![Precise Path Planning](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Precise%20Path%20Planning.PNG)

**The Voltage Supplied to 2 wheels vary as per the requirement. For a simple Servo Acion, where both the wheels get same Input (Theta = 0), the following graph was developed ( note that the Y-axis units are in mV)**

![Voltage Graph](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Voltage.PNG)

---

## Running the Project - Example with steps

The Project has a complex pipeline, scripted in different languages. A central pipeline with a better user interface is under construction. Follow the following steps to run the script.
  1. Clone the following repository and install Python( and additionally OpenCV and Spicy.io ) and setup your Matlab ( This project uses 2021b version ).
  
  2. Open the **Path Planning** folder and run any algorithm. For example, running APF would be like the following:
   ```cmd
      cd Path Planning
      cd Global Path Planning
      python main.py
   ```
   You can change the number and positions of the Obstacles in the **main.py** script. After running the code, the result would look like the following:
   
 <img src="https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Estimated%20Path%20Planning.PNG" width="200" />
  
  
   Instead, if you are willing to use Dynamic Path Planning of Incremental Learning, you can run it as per the instructions given [here](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Path_Planning/Readme.md). The output would look like this:

 <img alt = "Map Pic" src="https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Vids/Complete_Model_Astar.mp4" width="200" />
    
   3. After you close the script, a file would be created in the same root directory, with the name **points.mat**. Add this file to Matlab and release its contents. The workspace would now have an array with the name **arr**. This vector contains the Angluar deviations needed (as the radial distance is fixed to 10 in main.py (**scan distance**))
   ![Angular Changes in the plot](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Astar_Angle_Dip_Segway.png)
   
   4. **SegwayV4_combined.slx** contains the final simulation for the Sequential **Controller Design**. It is already configured to run with the autostep solver (ode45). Also make sure that the simulation time remains 5 second. The following figure shows my simulation file with the 2 subsystems acting as the controllers. 
   
   ![Segway_simulink](https://user-images.githubusercontent.com/47540320/120081091-50257380-c0d9-11eb-91c5-c454cd282a93.PNG)
   
   5. Run the MATLAB script **Segway_modelV6.m** and wait for the results to show up. The following path will show up and this is the actual path that would be generated with the given physical parameters.
   ![Actual Path](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Astar_Path_Segway.png)
   
   6. Other figures showing different parameters are as follows: 
   
   |    Distance Travelled    |    Angular Dip in Pole   |    Angular movement by the controller    |    
   |    ------------------    |    -------------------   |    ---------------------------------     |
   |  ![Distance](https://user-images.githubusercontent.com/47540320/120081076-3f74fd80-c0d9-11eb-80ce-954a885b83be.PNG)    |  ![Inverted Pendulum](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Dip%20in%20Segway.png) |  ![Angular Variation](https://user-images.githubusercontent.com/47540320/120081385-09d11400-c0db-11eb-979d-e6d555c356ed.PNG) |
 
---

## Controller Design

  * Steady State Model - The ss model was made taking into account the Chasis, Motors, Wheel and the Pole. The model used 4 state variables - **Radial Distance, Linear Speed, Angular Dip in pole, Rate of Angular Dip**. The output of the model were **Distance and Angular Dip in Pole**. 
  
  * LQR - Linear Quadratic Regulator controller was used to take care of balanced radial movement of the bot (i.e. 1-D movement only). A set point change can be given to any state hence, we can order the bot to autonomously move, attain a speed or even attach a functional block relating the angular dip with the speed of the bot!!! The following figure shows the Regulatory and Servo Response of both the outputs.
  
  ![Ouputs of LQR](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Servo%20and%20Reg%20Action.PNG)
  
  * PID - The PID module was used to controller the Bot's angular movement. Both the Wheels recieved different Input in order to move in angular fashion. The tuning was done in a way to achive the same time constant as the LQR controller. A PID fashion was choosen as this model was of SISO type. The following image shows the PID controll in action for an input of 90 degrees (1.57 rad).
  
  ![PID Controller](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Angular%20Dynamics%20of%20BOT.png)
  
---

## Images and Videos for Active Path planning module

The following table shows how the bot tackles the issue of dynamic path planning. In the series of figures below, the bot does not know about an obstacle in its path ahead. As soon as it recieves the map, it dynamically updates the path it has planned. 

| Phase 1   | Phase 2   | Phase 3   | Phase 4   |
|-----------|-----------|-----------|-----------|
|![](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Screenshot%202021-10-11%20at%205.12.34%20PM.png)  | ![](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Screenshot%202021-10-11%20at%204.47.46%20PM.png) | ![](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Screenshot%202021-10-11%20at%204.48.04%20PM.png) | ![](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Screenshot%202021-10-11%20at%204.48.23%20PM.png) | ![](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Screenshot%202021-10-11%20at%204.48.45%20PM.png) |

More information about all the phases is available in this folder : [Phase_Output](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/tree/main/Phase_Output)


The following Video summarizes the process:

[![Watch the video](https://i9.ytimg.com/vi/5eUxYay-Muo/mq2.jpg?sqp=CMSfoosG&rs=AOn4CLBCIYm_Z4v1Gz-9HiVHitL-r1AI3A)](https://youtu.be/5eUxYay-Muo)

---

## Soft Computing Algorithms

  * For LQR Design - Bacteria Foraging and Genetic Algorithm were used for tuning the params for LQR controller. For the design and given constraints, GA proved to be a better option. The following figure shows the Deviation of Q11 with Iteration number
  ![Q11](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Q11vsIteration.PNG)
 
  * For Tuning PID - Seperate PID Controllers were used for the 2 wheels based on the control function developed. PID controller also used a Low pass Filter for Noise Filteration and other tuning characteristics. The Finas equation was as follows
  ```
        s = tf('s');
        tf_PID = P + I/s + D*N/(1 + N/s);
  ```
   
  * For Path Planning - The following figure is self explainatory. For smapling of the points in the path, I used the technique of **constant Radial Scan** where the scan radius was fixed to 10. 

    |   GSA     |   APF     |
    |   ---     |   ---     |
    |   ![](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/GSA.png)   |   ![](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/APF.PNG)   |
    
---

## Points to consider.

  1. The co-ordinate system of different systems are fairly different and this can cause a lot of trouble.

  ![Co-Ordinate System](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Co-Ordinate%20System.jpg)

  2. Communication to and from MATLAB and Simulink and other user defined functions is only possible through the Base workspace and it is impotant to use **evalin()** and **assignin()** functions for that.

  3. The Dynamics for the radial and Angular movement differ and thus, we need to model the control scheme accordingly.
  
  4. It is very important to keep into account that the speed varies according to the distance that needs to be covered and that the time taken remain constant. 

---

### If you find my work helpful in anyway, please do not forget to Star my repository.

An incomplete report for the report can be found [here](https://docs.google.com/document/d/1I3v9-CtLqWZXrXXcUxuTgMAddK_5AzI-V6CtLki1vE0).
