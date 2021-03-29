using LinearAlgebra ## "norm"
using StatsBase ## "sample"
using Statistics ## "mean"

## Some parts have been vectorized for better performance.
"""
**BFO** is a function that computes the **classical (non-adaptive) BFO (Bacterial Foraging Optimization)**<br><br>
**Inputs**:
1. **J**: a function with domain R^n
2. **Range**: exploration range: Range^n <br><br>

3. **S** = 10, number of bacteria
4. **Sr** = 4,  number of bacteria removed in reproductive step
5. **Nc** = 20, number of chemotactic steps
6. **Ns** = 5, number of swim steps
7. **Nre** = 5, number of reproductive steps
8. **Ned** = 2, elimination and dispersal steps
9. **Ped** = 0.3, probability of elimination
10. **Ci** = (mean(Range[:,2].-Range[:,1])/S), the run-length unit
**Output**: a dictionary that stores
1. the minimum value of J
2. the point achieving this minimu value
3. the path of each bacterium (for plotting illustration)
"""
function BFO(J, Range::Array{Float64,2}; S = 10::Int, Sr = 4::Int, Nc = 20::Int, Ns = 5::Int, 
        Nre = 5::Int, Ned = 2::Int, Ped = 0.3::Float64, Ci = (mean(Range[:,2].-Range[:,1])/S)::Float64)
    
    n = size(Range,1) ## dimension of the input of J
    ## randomly generate S bacteria in Range
    B_loc = RandPts(Range,S)
    ## a dictionary recording the path of bacterium i
    Path_Dict = Dict{Int,Array{Float64,2}}(i=>[zeros(n,0) B_loc[:,i]] for i=1:S)
    for l = 1:Ned ## index of elimination-dispersal steps
        for k = 1:Nre ## index of reproductive steps
            for j = 1:Nc ## index of chemotactic steps
                ## Chemotactic Step; variable used: Range, S, B_loc, Ci, J
                println("Chemotactic step $j")
                @time Chemo = ChemotacticStep(J, Range::Array{Float64,2}, S::Int, Ns::Int, Ci::Float64, B_loc::Array{Float64,2})
                B_loc = Chemo[1]
                for i=1:S
                    Path_Dict[i] = [Path_Dict[i] Chemo[2][i]]
                end
            end ## end of chemotactic steps
            
            if k<Nre
                ## Reproductive Step; variable used: B_loc, Sr, S, J
                println("Reproduction step $k")
                @time Repro = ReproductionStep(J, B_loc::Array{Float64,2}, Sr::Int, S::Int, n::Int)
                B_loc = Repro[1]
                for i=1:S
                    Path_Dict[i] = [Path_Dict[i] Repro[2][i]]
                end
            end
        end
        ## Elimination-Dispersal Step; variable used: Ped, Range, B_loc
        println("Elimination-Dispersal step $l")
        if l<Ned
            @time EliDis = ElimDispStep(B_loc, Ped, Range, S, n)
            B_loc = EliDis[1]
            for i=1:S
                Path_Dict[i] = [Path_Dict[i] EliDis[2][i]]
            end
        end
    end
    B_best = Int(sortslices([[J(B_loc[:,i]) for i=1:S] collect(1:S)], dims = 1)[1,2]) ## best bacterium
    X_best = B_loc[:,B_best] ## best location for minimizing J
    J_best = J(X_best) ## best (minimum) J value
    return Dict("Minimum"=>J_best, "Minimum Point"=>X_best, "Path_Dict"=>Path_Dict)
end

"""
**ChemotacticStep** is a function performing the chemotactic step in BFO.
"""
function ChemotacticStep(J, Range::Array{Float64,2}, S::Int, Ns::Int, Ci::Float64, B_loc::Array{Float64,2})
    Path = Dict{Int, Array{Float64,2}}(i=>zeros(size(Range,1),2) for i=1:S)
    ToSwim = collect(1:S) ## monitor the swimming bacteria
    Tumble = RandUnit(Range,S)
    m = 0 ## index of swimming
    while (length(ToSwim)!=0)&(m<Ns) ## tumble/swim
        m = m + 1
        J_old = [J(B_loc[:,i]) for i in ToSwim]
    
        B_loc_new = copy(B_loc)
        B_loc_new[:,ToSwim] = B_loc[:,ToSwim].+Ci*Tumble[:,ToSwim]
                    
        ## Mirror back the out-of-range bacteria
        ## Range_tail = Range[:,2]
        ## Range_head = Range[:,1]
        ## 1. mirror back bacteria tumbling out from below
        B_loc_new[:,ToSwim] = (abs.(B_loc_new[:,ToSwim].-Range[:,1])).+Range[:,1]
        ## 2. mirror back bacteria tumbling out from above
        B_loc_new[:,ToSwim] = Range[:,2].-(abs.(Range[:,2].-B_loc_new[:,ToSwim]))
    
        ## Evaluate J at new locations
        J_new = [J(B_loc_new[:,i]) for i in ToSwim]
    
        ## Find out improved bacteria and update the swimming ones
        ToSwim = ToSwim[findall(J_new.<J_old)]
    
        for i in ToSwim
            Path[i] = [Path[i] B_loc_new[:,i]]
        end
        B_loc[:,ToSwim] = B_loc_new[:,ToSwim]
    end ## end of tumble/swim
    return (B_loc,Path)
end

"""
**ReproductionStep** is a function performing the reproduction step in BFO.
"""
function ReproductionStep(J, B_loc::Array{Float64,2}, Sr::Int, S::Int, n::Int)
    Path = Dict{Int,Array{Float64,2}}(i=>zeros(n,2) for i=1:S)
    ## (!!!) I define the health of a bacterium as the J value of its current location
    Health = [J(B_loc[:,i]) for i=1:S]
    Health_sort = sortslices([Health collect(1:S)], dims = 1) ## sort the bacteria according to health
    B_survive = Array{Int,1}(Health_sort[1:S-Sr,2]) ## ## pick out the most healthy (S-Sr) bacteria
    B_die = setdiff(collect(1:S), B_survive)
    B_loc[:,B_die] = B_loc[:,B_survive[1:Sr]] ## reproduce the most healthy Sr bacteria
    for i in B_die
        Path[i] = [Path[i] B_loc[:,i]]
    end
    return (B_loc, Path)
end

"""
**ElimDispStep** is a function performing the elimination-dispersal step in BFO.
"""
function ElimDispStep(B_loc::Array{Float64,2}, Ped::Float64, Range::Array{Float64,2}, S::Int, n::Int)
    Path = Dict{Int,Array{Float64,2}}(i=>zeros(n,0) for i=1:S)
    Alive = findall([sample([false, true], aweights([Ped,1-Ped])) for i=1:S]) # true = alive, false = kill
    Killed = setdiff(collect(1:S),Alive) ## kiilled bacteria            
    ## Rebuild the killed bacteria in random locations in Range
    B_loc[:,Killed] = RandPts(Range,length(Killed))
    ## update the path dictionary
    for i in Killed
        Path[i] = [Path[i] B_loc[:,i]]
    end
    return (B_loc, Path)
end

"""
**RandPts** is a function that randomly uniformly generates m points in dimension size(Range,2) inside Range. <br>
Inputs: <br>
m: number of random points to generate <br>
Range: dim x 2 matrix; the d-th row is the range of the d-th coordinate <br>
Output: <br>
an dim x m matrix; each column is a desired random vector. <br>
"""
function RandPts(Range::Array{Float64,2}, m::Int)
    ## dim = size(Range,1)
    ## randPts = rand(dim,m)
    ## Coeff = (Range[:,2].-Range[:,1])
    ## Intercept = Range[:,1]
    ## randPts = ((Range[:,2].-Range[:,1]).*rand(size(Range,1),m)).+Range[:,1]
    return ((Range[:,2].-Range[:,1]).*rand(size(Range,1),m)).+Range[:,1]
end

"""
**RandUnit** is a function generating m random unit vectors in dimension d. The vector generated is uniform with respect to a Range where random walk is to be applied. <br>
**Inputs**: <br>
1. Range: a d x m matrix; the kth row is the range for the kth variable.
2. m: number of vectors to generate <br>
**Output**: <br>
an d x m matrix whose columns are the desired vectors. <br>
"""
function RandUnit(Range::Array{Float64,2}, m::Int)
    ## d = size(Range,1)
    ## Scales = Range[:,2].-Range[:,1]
    Rand = (rand(size(Range,1),m).-1/2).*(Range[:,2].-Range[:,1])
    for k = 1:m
        Rand[:,k]./=norm(Rand[:,k])
    end
    return Rand
end