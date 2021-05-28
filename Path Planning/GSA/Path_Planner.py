def path_planning(agents, obtacles, G):
    SUCCES = 0
    plt.plot(Xs, Ys, "*k")
    plt.plot(Xg, Yg, "*m")
    t = 0
    while ((t < Episodes) and (N / 2 > SUCCES)):
        t += 1
        SUCCES = 0
        worst = agents[0].fit
        best = agents[0].fit
        b = 0
        for i in range(N):
            agents[i].calc_fit(obtacles, t)
            if (agents[i].fit > worst):
                worst = agents[i].fit
            if (agents[i].fit < best):
                best = agents[i].fit
                b = i
        SUM_m = 0
        bw = best - worst
        for i in range(N):
            agents[i].calc_m(worst, bw)
            SUM_m += agents[i].m

        for i in range(N):
            agents[i].calc_M(SUM_m)
            agents[i].calc_F(agents, i, t, worst + 3 * bw / 4)
            agents[i].calc_a()
            agents[i].calc_V()

        for i in range(N):
            agents[i].calc_position(t)
            SUCCES += agents[i].Succes
            if (t > SHOW):
                plt.plot(agents[i].x[t - 1], agents[i].y[t - 1], ".w")
                plt.plot(agents[i].x[t], agents[i].y[t], ".b")
                plt.pause(0.1)

        G = G0 * math.exp(zet * -t / Episodes)

    D = []
    index = []
    fit_data = []
    L = 0
    for i in range(N):
        d = 0
        if (not agents[i].colision):
            for n in range(t - 1):
                d += math.sqrt(
                    pow(agents[i].x[n + 1] - agents[i].x[n], 2) + pow(agents[i].y[n + 1] - agents[i].y[n], 2))
            D.append(math.ceil(d))
            index.append(i)
            L += 1
    id = D.index(min(D))
    id = index[id]

    for n in range(t):
        s = 0
        for i in range(L):
            s += agents[index[i]].fit_mat[n]
        fit_data.append(s / L)

    return id, t, fit_data, min(D)
