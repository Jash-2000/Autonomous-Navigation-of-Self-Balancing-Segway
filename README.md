# Autonomous Navigation and Balance of 2-Wheeled Self-Balancing Segway Robot

Research Project under **[Dr. Puneeth Mishra](https://www.bits-pilani.ac.in/pilani/puneetmishra/Profile)**, under the domain of [**Industrial Automation and Control**](https://drive.google.com/file/d/1s5DQQBiqCRzZao_UDhHWK7q6NdQnE2wv/view?usp=sharing). 

The project's Tech Stack Inolved the following:
 * Path planning
 * Controlled movement( angluar as well as radial ) 
 * Balancing

The Servo and Regulatory response of the model for balancing is as follows:

| Regulatory Action | Servo Action |
| ----------------- | ------------ |
| ![Regulatory Action](https://user-images.githubusercontent.com/47540320/119830455-e7dc6380-bf19-11eb-9e39-bc87ba84b8cd.jpg) | ![Servo Action](https://user-images.githubusercontent.com/47540320/119830462-e90d9080-bf19-11eb-9c32-3aefaa1d1599.jpg) |

**The combined action of radial as well as angular movement for the Segway is shown in the graphs below**

---

## Details of the project

The Project involves the servo as well as regulatory control of a 2-wheeled segway robot. BFO-LQR and Genetic-LQR are used for the balance of the bot and Ant Colony Optimization based PID tuning is done for the bot's angular control.
The Path Planning is done using 2 strategies: APF and GSA and the co-ordinates are communicated to MATLAB via python wrapper. 

Additional features can be addded like considering the human's weight and/or speed control with angular dip (as available in new segways).

The Presentation can be found [here](https://docs.google.com/presentation/d/1ksmdR5DNKdCcXbnUg9fruMfYAnvMTaGtsh33f6NXTIc/edit#slide=id.gcc9c102ac7_0_0) and the final report can be found [here](https://docs.google.com/document/d/1I3v9-CtLqWZXrXXcUxuTgMAddK_5AzI-V6CtLki1vE0/edit#).

---

## Points to consider.

  1. The co-ordinate system of different systems are fairly different and this can cause a lot of trouble.

  ![Co-Ordinate System](https://github.com/Jash-2000/Autonomous-Navigation-of-Self-Balancing-Segway/blob/main/Co-Ordinate%20System.jpg)

  2. Communication to and from MATLAB and Simulink and other user defined functions is only possible through the Base workspace and it is impotant to use **evalin()** and **assignin()** functions for that.
