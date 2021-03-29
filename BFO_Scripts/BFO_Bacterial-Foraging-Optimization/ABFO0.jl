using LinearAlgebra ## "norm"
using StatsBase ## for function "sample"
"""
This function computes the **adaptive BFO (Bacterial Foraging Optimization)**
**Inputs**: <br>
1. **J** = a function with domain R^n <br>
2. **Range** = [-10,10], exploration range: Range^n <br><br>
3. **N_A** = 2, number of adaptions (every N_A iterations) <br>
4. **t_max** = 100 , max of t, where t is the index of adaption iteration <br>
5. **C_init** = (Range[2]-Range[1])/S, initial run-length unit <br>
6. **alpha** = 10, paramter for "run-length unit" decay <br>
7. **n** = 2, dimension of the input of J <br>
8. **S** = 10, number of bacteria <br>
9. **Sr** = 4, number of bacteria removed in reproductive step <br>
10. **Nc** = 20, number of chemotactic steps <br>
11. **Ns** = 5, number of swim steps <br>
12. **Nre** = 50, number of reproductive steps <br>
13. **Ned** = 10, elimination and dispersal steps <br>
14. **Ped** = 0.3, probability of elimination <br>

**Output**: a dictionary that stores <br>
1. the minimum value of J <br>
2. the point achieving this minimu value <br>
3. the path of each bacterium (for plotting illustration) <br>
"""
function ABFO0(J, Range; alpha = 10, N_A = 2, t_max = 10, n = 2::Int, S = 10::Int, Sr = 4::Int, Nc = 20::Int, 
        Ns = 5::Int, Nre = 50::Int, Ned = 10::Int, Ped = 0.3::Float64, C_init = ((Range[2]-Range[1])/S)::Float64)
    ## randomly generate S bacteria in Range^n
    Ci = copy(C_init) ## run-length unit; will be adapted gradually
    B_loc = (Range[2]-Range[1])*rand(n,S).+Range[1] ## B_loc = Bacteria locations
    ## a dictionary recording the path of bacterium i
    Path_Dict = Dict(i=>[zeros(n,0) B_loc[:,i]] for i=1:S)
    t = 0 ## counter for adaption of Ci
    while (t<t_max) ## index for adaption
        if (t%N_A==0)
            Ci = Ci/alpha
        end
        t = t+1
        for l = 1:Ned ## index of elimination-dispersal steps
            for k = 1:Nre ## index of reproductive steps
                for j = 1:Nc ## index of chemotactic steps
                    ## Chemotactic Step
                    for i = 1:S ## index of bacterium
                        ## Tumble/Swim
                        Path_i = copy(B_loc[:,i]) ## record the path of bacterium i
                        m = 0 ## counter for swimming
                        delta_i = randn(n) ## random "tumble" direction (uniform on (n-1)-sphere)
                        while m<Ns
                            J_last = J(B_loc[:,i]) ## last fitness value
                            B_i_loc_new = B_loc[:,i] + Ci*delta_i/norm(delta_i) ## new location
                            J_new = J(B_i_loc_new) ## new fitness value
                            if J_new<J_last ## swim
                                m = m+1
                                J_last = copy(J_new)
                                B_loc[:,i] = B_i_loc_new
                                ## update the path of bacterium i
                                Path_i = [Path_i B_i_loc_new]
                            else
                                m = Ns ## don't swim 
                            end
                        end
                        ## update the path of bacterium i
                        if Path_Dict[i][:,end]!=B_loc[:,i]
                            Path_Dict[i] = [Path_Dict[i] B_loc[:,i]]
                        end
                    end
                end
                if k<Nre
                    ## Reproductive Step
                    ## (!!!) I define the health of a bacterium as the J value of its current location
                    Health = [J(B_loc[:,i]) for i=1:S]
                    Health_sort = sortslices([Health collect(1:S)], dims = 1) ## sort the bacteria according to health
                    B_survive = Array{Int,1}(Health_sort[1:S-Sr,2]) ## ## pick out the most healthy (S-Sr) bacteria
                    B_rep = sort([B_survive;B_survive[1:Sr]]) ## reproduce the most healthy Sr bacteria
                    B_loc = B_loc[:,B_rep]
                    
                    ## update the path dictionary
                    for i = 1:S
                        if Path_Dict[i][:,end]!=B_loc[:,i]
                            Path_Dict[i] = [Path_Dict[i] B_loc[:,i]]
                        end
                    end
                end
            end
            ## Elimination-Dispersal Step
            if l<Ned
                KillAlive = [sample([false, true], aweights([Ped,1-Ped])) for i=1:S] # true = alive, false = kill
                N_kill = S - sum(KillAlive) ## number of kiilled bacteria
                ## randomly generate a bacterium for each killed bacterium
                Alive = findall(KillAlive)
                Kill = setdiff(collect(1:S),Alive)
                B_loc = sortslices([[Alive'; B_loc[:,Alive]] [Kill';(Range[2]-Range[1])*rand(n,length(Kill)).+Range[1]]], dims = 2)[2:n+1,:]
                ## update the path dictionary
                for i = 1:S
                    if Path_Dict[i][:,end]!=B_loc[:,i]
                        Path_Dict[i] = [Path_Dict[i] B_loc[:,i]]
                    end
                end
            end
        end
        ## Update the bacterium locations to the history best location
        B_loc_new = zeros(n,0)
        for i = 1:S
            Path_i = Path_Dict[i]
            B_loc_i_new = Path_i[:,findmin([J(Path_i[:,s]) for s=1:size(Path_i,2)])[2]]
            B_loc_new = [B_loc_new B_loc_i_new]
        end
        B_loc_new
        B_loc = copy(B_loc_new)
        ## update the path of bacterium i
        for i=1:S
            if Path_Dict[i][:,end]!=B_loc[:,i]
                Path_Dict[i] = [Path_Dict[i] B_loc[:,i]]
            end
        end
    end
    B_best = Int(sortslices([[J(B_loc[:,i]) for i=1:S] collect(1:S)], dims = 1)[1,2]) ## best bacterium
    X_best = B_loc[:,B_best] ## best location for minimizing J
    J_best = J(X_best) ## best (minimum) J value
    return Dict("Minimum"=>J_best, "Minimum Point"=>X_best, "Path_Dict"=>Path_Dict)
end