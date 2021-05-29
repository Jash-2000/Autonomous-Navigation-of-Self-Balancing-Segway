# Autonomous Navigation and Balance of 2-Wheeled Self-Balancing Segway Robot

Research Project under **[Dr. Puneeth Mishra](https://www.bits-pilani.ac.in/pilani/puneetmishra/Profile)**, under the domain of [**Industrial Automation and Control**](https://drive.google.com/file/d/1s5DQQBiqCRzZao_UDhHWK7q6NdQnE2wv/view?usp=sharing). 

The project's Tech Stack Inolved the following:
 * Path planning
 * Controlled movement( angluar as well as radial ) 
 * Balancing
 * Real World noise Filtering and tackling

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

---

## References

 1. **[For Segway's Control]**

* Design and Control for Differential Drive Mobile Robot [https://www.ijert.org/research/design-and-control-for-differential-drive-mobile-robot-IJERTV6IS100138.pdf](https://www.ijert.org/research/design-and-control-for-differential-drive-mobile-robot-IJERTV6IS100138.pdf)
* Mohammed, I. K., & Abdulla, A. I. (2020). Balancing a Segway robot using LQR controller based on genetic and bacteria foraging optimization algorithms. TELKOMNIKA (Telecommunication Computing Electronics and Control), 18(5), 2642. [https://doi.org/10.12928/telkomnika.v18i5.14717](https://doi.org/10.12928/telkomnika.v18tsi5.14717)
* EIT TUK. (2018, February 7). State Space Control for the Pendulum-Cart System: A short tutorial on using Matlab® and Simulink®. [YouTube](https://www.youtube.com/watch?v=hAI8Ag3bzeE)
* mouhknowsbest. (2013, June 24). 4.4 Segway Robots. [YouTube](https://www.youtube.com/watch?v=bJM9jU-P_H0)
* Bhanot, S. (2021). Process Control: Principles And Application. OXFORD UNIVERSITY PRESS.
* EIT TUK. (2018, February 7). State Space Control for the Pendulum-Cart System: A short tutorial on using Matlab® and Simulink®. [YouTube](https://www.youtube.com/watch?v=hAI8Ag3bzeE)
* T. (2018). turnwald/CAE_Exercise. [GitHub](https://github.com/turnwald/CAE_Exercise)

 2. **[Optimization Strategies for dynamic control]**

 2.1 __Bacteria Foraging__

  - NCTEL. (2016, May 19). Bacterial Foraging Optimization by Er Neha Sharma. [YouTube](https://www.youtube.com/watch?v=oB1hghTwl6Y)
  - Chen, H., Zhu, Y., & Hu, K. (2011). Adaptive Bacterial Foraging Optimization. Abstract and Applied Analysis, 2011, 1/27. https://doi.org/10.1155/2011/108269
  - A. (2017). avandekleut/bacterial-foraging. [Biomimicry of Bacterial Foraging for Optimization and Control](https://github.com/avandekleut/bacterial-foraging).
  - Chen, H., Zhu, Y., & Hu, K. (2011). Adaptive Bacterial Foraging Optimization. Abstract and Applied Analysis, 2011, 1–27. https://doi.org/10.1155/2011/108269
  
 2.2 __Linear Quadratic Regulator(LQR) Controller__
 
  - MathWorks. (2021). Linear-Quadratic Regulator (LQR) design - MATLAB lqr.[Design a LQR controller in MATLAB.](https://www.mathworks.com/help/control/ref/lqr.html)
  - Steve Brunton. (2017, January 29). Linear Quadratic Regulator (LQR) Control for the Inverted Pendulum on a Cart [Control Bootcamp]. [YouTube](https://www.youtube.com/watch?v=1_UobILf3cc)
  - MIT Robotics. (2021). Course | edX. [Introduction to Control System Design-Computational State Space Approaches](https://learning.edx.org/course/course-v1:MITx+6.302.1x+2T2016/home).
  - S. Chantarachit, "Development and Control Segway by LQR adjustable Gain," 2019 International Conference on Information and Communications Technology (ICOIACT), Yogyakarta, Indonesia, 2019, pp. 649-653, [doi: 10.1109/ICOIACT46704.2019.8938489](https://ieeexplore.ieee.org/document/8938489).
  
 2.3 __Genetic Algorithm__
 
  - S. Choueiry, M. Owayjan, H. Diab and R. Achkar, "Mobile Robot Path Planning Using Genetic Algorithm in a Static Environment," 2019 Fourth International Conference on Advances in Computational Tools for Engineering Applications (ACTEA), 2019, pp. 1-6, doi: 10.1109/ACTEA.2019.8851100.

 2.4 __Reinforcement Learning__
 
  - J. (2021). Jash-2000/Pole-Balance-Control-Algorithms. [GitHub](https://github.com/Jash-2000/Pole-Balance-Control-Algorithms)


 2.5 __Other Fuzzy and PID techniues__
 
  - PID Theory Explained. (2020). [PID Theory Explained](https://www.ni.com/en-in/innovations/white-papers/06/pid-theory-explained.html)
  - A. A. Ahmed and A. F. Saleh Alshandoli, "On replacing a PID controller with Neural Network controller for Segway," 2020 International Conference on Electrical Engineering (ICEE), Istanbul, Turkey, 2020, pp. 1-4, [doi: 10.1109/ICEE49691.2020.9249811](https://ieeexplore.ieee.org/document/9249811). 
  - Odry, Á., Fullér, R., Rudas, I. J., & Odry, P. (2020). Fuzzy control of self‐balancing robots: A control laboratory project. Computer Applications in Engineering Education, 28(3), 512–535. https://doi.org/10.1002/cae.22219


 3. **[Sensor-Fusion and Estimation Techniques]**

 * How to Use a Kalman Filter in Simulink. (2018, October 4). How to Use a Kalman Filter in Simulink - [File Exchange - MATLAB Central](https://in.mathworks.com/matlabcentral/fileexchange/69004-how-to-use-a-kalman-filter-in-simulink?s_eid=PSM_15028)
 * State Estimation Using Time-Varying Kalman Filter - MATLAB & Simulink - MathWorks India. (2021). [MathWorks](https://in.mathworks.com/help/control/getstart/estimating-states-of-time-varying-systems-using-kalman-filters.html).
 *  How to Use an Extended Kalman Filter in Simulink. (2018, October 4). How to Use an Extended Kalman Filter in Simulink - File Exchange - MATLAB Central. https://in.mathworks.com/matlabcentral/fileexchange/69005-how-to-use-an-extended-kalman-filter-in-simulink?s_eid=PSM_15028
 *  Becker, A. (2018). Online Kalman Filter Tutorial. Kalman Filter Tutorial. https://www.kalmanfilter.net/alphabeta.html
 *  Kalman Filter. (2020). Kalman [Lecture](https://ece.montana.edu/seniordesign/archive/SP14/UnderwaterNavigation/kalman_filter.html)
 *  A. (2021). aipiano/ESEKF_IMU. [GitHub](https://github.com/aipiano/ESEKF_IMU)

 4. **[Path Planning and Ambient Intelligence]**

 * Y. (2019). Yaaximus/artificial-potential-field-matlab. [GitHub](https://github.com/Yaaximus/artificial-potential-field-matlab)
 * B. (2016). bearadamsj/multi-agent-with-obstacle-avoidance. [GitHub](https://github.com/bearadamsj/multi-agent-with-obstacle-avoidance)
 * Zauner, C., Gattringer, H., Müller, A., & Jörgl, M. (2019). Optimal planning and control of a segway model taking into account spatial obstacles. PAMM, 19(1), 1–2. https://doi.org/10.1002/pamm.201900149