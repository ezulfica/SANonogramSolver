# Function to solve nonogram
# Take in input : 
#   r_clues : a list of clues for the rows 
#   c_clues : a list of clues for the column
#   beta0 : an numeric : the initial temparature for simulated annealing
#   n_simul : an integer : number of iteration
#   generate : 1 or 2 : generation of the initial state. The first is random, the second generate a grid with the respected condition on the rows
#   tv : 1 or 2 : transition version. value are 1 or 2. 1 work for every generate but 2 will only work for generate = 2
#   step : an integer : step to print the number of conflict or plot a result (it does it every step)
#   restart : TRUE or FALSE. If you want to reuse the precedent simulation result
#   X_BEST : a vector or a Matrix that will be use if you restart
#   plot_result : TRUE or FALSE. If you want to show a plot of the working solver. Will plot every step
#   plot_solution : TRUE or FALSE. If the solution already exist, you can also plot it next to the current result
  
  
solve_nonogram = function(r_clues = NULL, c_clues = NULL, n_simul, beta0, generate = c(1,2), tv, step = 1000, restart = FALSE, X_BEST = NULL, plot_result = F, plot_solution = F) {
  
  nrows = length(r_clues)
  ncols = length(n_cols)
  
  #If we choose to restart, we use the best state found during the last simulation
  if (restart) X = list(X = X_BEST, "delta" = 0) else X = generate_initial_state[[generate]](r_clues, c_clues)
  
  X_BEST = X #set the BEST state as the initial one
  H = rep(0,n_simul) #pre-allocated vector to save the risk of each iteration
  H[1] = count_conflit(X$X, r_clues, c_clues, nrows, ncols)$s #adding the first risk
  
  #text and ggplot model to plot the result as a table
  nb_conflit = paste("N = 1\n", "NB Conflits = ", H[1])
  p2 = plot_nonogram(X$X, r_clues, c_clues) + ggtitle(label = nb_conflit)
  
  #If we set plot_solution as TRUE
  if (plot_result && plot_solution && !is.null(nonogram$nonogram)) {
    p1 = plot_nonogram(nonogram$nonogram, r_clues, c_clues) + ggtitle("Solution")
    plot_grid(p1,p2) 
    if (is.null(nonogram$nonogram) && plot_result) print("No solution to plot !") 
  } else if (plot_result) print(p2)
  
  
  for (i in 2:n_simul){
    #increasing the temperature if cooling is TRUE
    beta_v = beta0 *log(i-1) * (i>2) + beta0 *(i == 2)
    #changing the initial state
    X = transition[[tv]](X = X$X, r_clues, c_clues, nrows, ncols, beta_v = beta_v)
    
    #Saving the new cost
    H[i] = H[i-1] + X$delta
    
    if (H[i] < min(H[1:i-1])) X_BEST = X #if we have a better risk, we change our X_BEST
    
    #To plot a result, with or without the solution, every step
    if (i %% step == 0 && H[i] != 0) {
      nb_conflit = paste("N =", i ,"\n", "NB Conflits =", H[i])
      p2 = plot_nonogram(X$X, r_clues, c_clues) + ggtitle(nb_conflit) 
      if (plot_result && plot_solution && !is.null(nonogram$nonogram)){print(plot_grid(p1, p2))} else if(plot_result) {print(p2)}
      print(nb_conflit)
      }
  
    
    #When the loss is null, we stop the loop
    if (H[i] == 0 && H[i] != H[i-1]) {
      nb_conflit = paste("N =", i ,"\n", "NB Conflits =", H[i])
      p2 = plot_nonogram(X$X, r_clues, c_clues) + ggtitle(nb_conflit)
      if (plot_result && plot_solution && !is.null(nonogram$nonogram)) {print(plot_grid(p1, p2))} else if(plot_result){print(p2)}
      break
      }
      
  }
  return(list(result = X$X, cost = H, best_result = X_BEST$X))
}