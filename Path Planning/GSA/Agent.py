class agent():
    """
    Create agent (one planet, object, mass)
    """
    def __init__(self, x, y):
        self.x = []
        self.y = []
        self.fit_mat = []
        self.m = 0.0
        self.M = 0.0
        self.x.append(Xs)
        self.y.append(Ys)
        self.x.append(Xs + random.randint(-3, 3))
        self.y.append(Ys + random.randint(-3, 3))
        self.fit = math.sqrt(pow(Xg - Xs, 2) + pow(Yg - Ys, 2))
        self.Vx = random.randint(-3, 3)
        self.Vy = random.randint(-3, 3)
        self.ax = 0.0
        self.ay = 0.0
        self.Fx = 0.0
        self.Fy = 0.0
        self.Succes = 0
        self.colision = False

    def calc_position(self, t):
        """
        Calculate actual position 
        :param t:
        :return:
        """
        x = math.ceil(self.x[t] + self.Vx)
        y = math.ceil(self.y[t] + self.Vy)
        x += random.randint(-1, 1)
        y += random.randint(-1, 1)
        if (self.fit < 5):
            self.y.append(Yg)
            self.x.append(Xg)
            self.Succes = 1

        else:
            self.y.append(y)
            self.x.append(x)

    def calc_fit(self, obtacles, t):
        colision = False
        if ((self.x[t] - self.x[t - 1]) == 0):
            A = 1
            B = self.x[t]
            C = 0
        else:
            A = (self.y[t] - self.y[t - 1]) / (self.x[t] - self.x[t - 1])
            C = self.y[t - 1] - self.x[t - 1] * (self.y[t] - self.y[t - 1]) / (self.x[t] - self.x[t - 1])
            B = -1
        d = math.sqrt(pow(A, 2) + pow(B, 2))
        if (self.x[t - 1] > self.x[t]):
            Xup = self.x[t - 1]
            Xdown = self.x[t]
        else:
            Xup = self.x[t]
            Xdown = self.x[t - 1]
        if (self.y[t - 1] > self.y[t]):
            Yup = self.y[t - 1]
            Ydown = self.x[t]
        else:
            Yup = self.y[t]
            Ydown = self.y[t - 1]
        for i, _ in enumerate(obtacles):
            if ((abs(A * obtacles[i].x + B * obtacles[i].y + C) / d < robot_radius / 2) and (
                    obtacles[i].x < Xup + robot_radius / 2) and (obtacles[i].x > Xdown - robot_radius / 2) and (
                    obtacles[i].y < Yup + robot_radius / 2) and (obtacles[i].y > Ydown - robot_radius / 2)):
                colision = True
        if (colision):
            self.fit = math.sqrt(pow(Xg - self.x[t], 2) + pow(Yg - self.y[t], 2)) + alfa
            self.colision = True
        else:
            self.fit = math.sqrt(pow(Xg - self.x[t], 2) + pow(Yg - self.y[t], 2))
        self.fit_mat.append(self.fit)

    def calc_m(self, worst, bw):
        k = self.fit - worst
        if (k == 0):
            k = -random.random()
        self.m = k / bw
        # self.m = k / N

    def calc_M(self, sum_m):
        self.M = self.m / sum_m

    def calc_V(self):
        self.Vx = random.random() * self.Vx + self.ax
        self.Vy = random.random() * self.Vy + self.ay

    def calc_a(self):
        self.ax = self.Fx / self.M
        self.ay = self.Fy / self.M

    def calc_F(self, agents, i, t, limit_k):
        self.Fx = 0
        self.Fy = 0
        for n in range(N):
            if n != i:
                if (agents[n].fit < limit_k):
                    dx = agents[n].x[t] - self.x[t]
                    dy = agents[n].y[t] - self.y[t]
                    E = math.sqrt(pow(dx, 2) + pow(dy, 2))
                    GME = G * self.M * agents[n].M / (E + Eps)
                    Fx = GME * dx
                    self.Fx = random.random() * Fx + self.Fx
                    Fy = GME * dy
                    self.Fy = random.random() * Fy + self.Fy