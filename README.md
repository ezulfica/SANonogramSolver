# SANonogramSolver
Nonogram Solver using Simulated Annealing

I will try to present the funniest project i have done. It's about using Simulated Annealing with nonogram to solve them.
The thing is, with nonogram. If we set : 
- n = numbers of rows * numbers of columns
- k = numbers of black cells

We can make a lot of combination before solving it, precisely : <img src="https://raw.githubusercontent.com/ezulfica/SANonogramSolver/main/img/binom.png" style="display: block; margin: auto;" />

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

<img src="https://raw.githubusercontent.com/ezulfica/SANonogramSolver/main/img/err1.png" style="display: block; margin: auto;" />
<img src="https://raw.githubusercontent.com/ezulfica/SANonogramSolver/main/img/err2.png" style="display: block; margin: auto;" />

Since it's using simulated annealing method, it is possible to not obtain the solution, or it takes a lot of times. 



