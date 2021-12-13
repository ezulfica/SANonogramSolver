#Simulated Annealing function
#With our initial state, we permute one black cell with one white cell. 
#We then choose, under an acceptance probability whether we keep the initial state or not.

#The function needs : 
# the initial state X (a matrix or vector)
# the clues in columns and rows (c_clues & r_clues)
# the numbers of rows and columns (nrows & ncols) 
# the temperature (beta_v)

#The first transition is taking from the metric function which row and col need to have less black cells and which one need to have more. 
#The second one, since it depends of the second generation, moves only column by column, changing one black cell to a white one from the same row


transition = list(
  transition1 = function(X, r_clues, c_clues, nrows, ncols, beta_v){
  #We permutate one black cells and one white. Then reject or accept the change
  
  s1 = count_conflit(X, r_clues, c_clues, nrows, ncols) #risk for the initial state
  
  #choosing randomly one black cell to permute
  d_val_1 = if(length(s1$to_add) > 0) sample(s1$to_move, size = 1) else (sample(which(X == 1),1)) 
  #choosing randomly one white cell to permute
  d_val_0 = if(length(s1$to_add) > 0) sample(s1$to_add, size = 1) else (sample(which(X == 0),1))
  
  #New state, copy of the inital
  X_new = X
  #Applying permutation
  X_new[c(d_val_1,d_val_0)] = X_new[c(d_val_0,d_val_1)]
  
  
  s2 = count_conflit(X_new, r_clues, c_clues, nrows, ncols) #risk for the new state
  
  delta = s2$s - s1$s #comparing both risk
  alpha_v = min(exp(-beta_v * delta), 1) #acceptance probability
  U = runif(1)
  delta = delta * (U < alpha_v) #keeping or not the delta difference of risk
  if (U < alpha_v) return(list("X" = X_new, "delta" = delta)) else return(list("X" = X, "delta" = delta))
  }, 
  
  transition2 = function(X, r_clues, c_clues, nrows, ncols, beta_v){
    #Depends of the second options of the generation of initial state (generate =2)
    #Choosing a row and then permute one black cell with a white from the same row
    
    r_rank = sample(1:nrows, size = 1) #select randomly a row
    r_values = X[r_rank,] #select all values from the row
    
    #If we have a filled row of black cells, we need to choose another one
    while (sum(r_values) == ncols) {
      r_rank = sample((1:nrows)[-r_rank], size = 1)
      r_values = X[r_rank,]
    }
    
    d_val_1 = sample(which(r_values == 1), size = 1) #choose one value equals to one
    d_val_0 = sample(which(r_values == 0), size = 1) #choose one value equals to zero

    X_new = X
    X_new[r_rank, c(d_val_1,d_val_0)] = X_new[r_rank, c(d_val_0,d_val_1)] #permute the two value in a copy of X

    s1 = count_conflit(X, r_clues, c_clues, nrows, ncols) #errors for the initial state
    s2 = count_conflit(X_new, r_clues, c_clues, nrows, ncols) #errors for the new state

    delta = s2$s - s1$s #loss
    alpha_v = min(exp(-beta_v * delta), 1) #threshold of acceptability

    U = runif(1)
    Z = X_new*(U < alpha_v) + X*(U >= alpha_v)
    delta = delta * (U < alpha_v)

    if (U < alpha_v) s = s2 else s = s1

    return(list("X" = Z, "delta" = delta, row_error = s$row_error, col_error = s$col_error))
    }
)