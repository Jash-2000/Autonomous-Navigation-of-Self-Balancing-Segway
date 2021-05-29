# Autonomous Navigation and Balance of 2-Wheeled Self-Balancing Segway Robot

Research Project under **[Dr. Puneeth Mishra](https://www.bits-pilani.ac.in/pilani/puneetmishra/Profile)**, under the domain of [**Industrial Instrumentation and Automation Control**](https://drive.google.com/file/d/1s5DQQBiqCRzZao_UDhHWK7q6NdQnE2wv/view?usp=sharing). 

The Project involves the **Desgin and Implementation of a precise Control model** for a **2-wheeled Segway Robot** for implementing a **parametized self-balancing robot**. Additionally, the robot can also plan its path and **navigate autonomously**. **Constraints on the physical model** were modelled precisley keeping into account the frictional and electrical resistances. Finally, various high speed and precise **Soft Computing techniques** were deployed for tuning the controllers and planning path.  

The project's Tech Stack Inolved the following:
 * **Path Planning Module**
    1. Using Artificial Potential Field.
    2. Using Gravitational Search Algorithm.
    3. Deviational Transformationa and Shift of Frames.
 * **Navigation Module**
    1. Modelling of Chasis, Motor, Pole and Battery system.
    2. LQR Controller Design for Radial movement.
    3. Advance PID Controller for Angular movement.
    4. Feedback Balance Scheme for the Verticle Pole. 


**The Servo Problem is defined as the dynamic response when the controller changes its set-point and Regulatory Problem is defined when the Controller tries to Manipulate the system input to counteract the effects of disturbances. The figure below shows these responses for the developed LQR Controller**

| Regulatory Action | Servo Action |
| ----------------- | ------------ |
| ![Regulatory Action](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Regulatory%20Action.jpg) | ![Servo Action](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Servo%20Action.jpg) |

**The precision in the movement of the Bot is as plotted below ( Input given was 7 units towards North)**
![Precise Path Planning](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Precise%20Path%20Planning.jpg)

**The Voltage Supplied to 2 wheels vary as per the requirement. For a simple Servo Acion, where both the wheels get same Input (Theta = 0), the following graph was developed ( note that the Y-axis units are in mV)**
![Voltage Graph](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Voltage.PNG)

---

## How to Run the Project

The Project involves the servo as well as regulatory control of a 2-wheeled segway robot. BFO-LQR and Genetic-LQR are used for the balance of the bot and Ant Colony Optimization based PID tuning is done for the bot's angular control.
The Path Planning is done using 2 strategies: APF and GSA and the co-ordinates are communicated to MATLAB via python wrapper. 

Additional features can be addded like considering the human's weight and/or speed control with angular dip (as available in new segways).

The Presentation can be found [here](https://docs.google.com/presentation/d/1ksmdR5DNKdCcXbnUg9fruMfYAnvMTaGtsh33f6NXTIc/edit#slide=id.gcc9c102ac7_0_0) and the final report can be found [here](https://docs.google.com/document/d/1I3v9-CtLqWZXrXXcUxuTgMAddK_5AzI-V6CtLki1vE0/edit#).

---

## Controller Design

  * Steady State Model - 
  * LQR - 
  * PID - 
  * Multi-Step Model - 
  
---

## Soft Computing Algorithms

  * For LQR Design - 
  * For Tuning PID - 
  * For Path Planning - 

---

## Points to consider.

  1. The co-ordinate system of different systems are fairly different and this can cause a lot of trouble.

  ![Co-Ordinate System](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Images/Co-Ordinate%20System.jpg)

  2. Communication to and from MATLAB and Simulink and other user defined functions is only possible through the Base workspace and it is impotant to use **evalin()** and **assignin()** functions for that.

  3. The Dynamics for the radial and Angular movement differ and thus, we need to model the control scheme accordingly.