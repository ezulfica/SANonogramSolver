# SANonogramSolver
Nonogram Solver using Simulated Annealing

I will try to present the funniest project i have done. It's about using Simulated Annealing with nonogram to solve them.
The thing is, with nonogram. If we set : 
- n = numbers of rows * numbers of columns
- k = numbers of black cells

We can make a lot of combination before solving it, precisely : <img src="https://raw.githubusercontent.com/ezulfica/SANonogramSolver/main/img/binom.png" style="display: block; margin: auto;" />

Since it's using simulated annealing method, it is possible to not obtain the solution by the number of iteration defined. 

# The generation and transition :

It is possible to start with two way : 

## Random generation : 
Firstly we place k black cells randomly. 

### Associated transition : 
We then choose one black cells among the exceeding rows and columns and then change it with an empty cells where it is require to add one cells

<img src="https://raw.githubusercontent.com/ezulfica/SANonogramSolver/main/img/ezgif-7-254174d756.gif" style="display: block; margin: auto;" />

## Second generation : 
We respect the condition on the row

### Associated transition :
We move the black cells to the right or left only. 

<img src="https://raw.githubusercontent.com/ezulfica/SANonogramSolver/main/img/ezgif-7-b83879f7d8.gif" style="display: block; margin: auto;" />

# The cost function : 

For the cost function, let's suppose that the Solution S : 

<img src="https://raw.githubusercontent.com/ezulfica/SANonogramSolver/main/img/err1.png" style="display: block; margin: auto;" />
and a state G : 

<img src="https://raw.githubusercontent.com/ezulfica/SANonogramSolver/main/img/err2.png" style="display: block; margin: auto;" />

In order to compute the error the maximum number of segments is calculated (s). 
For each segments we took the numbers of black cells, and if the number of segments is lesser than s, we add zeros. 

n_S = (2,1,1)
n_G = (1,2,0)
Then : 

Cost = |n_S - n_G| = |2-1| + |1-2| + |1-0| = 3. 

We compute every cost by rows and columns (named NB_conflits, which in french mean the numbers of conflicts)

## The reason of this metric
In order to verify if we have a good cell allocation, our cost function tells us three things : 
- If we have the required numbers of cells
- If we have the required numbers of segments
- If we have the required numbers of cells by segments



