rm(list = ls())

logistic_growth <- function(N0, K, r, time) {
  Nt <- K / (1 + ((K - N0) / N0) * exp(-r * time))
  return(Nt)
}


logistic_growth(N0 = 100, K = 6000, r = 0.27, time = 40)

time_vector <- seq(from = 0, to = 50, by = 0.1)

pop_1 <- logistic_growth(N0 = 100, K = 6000, r = 0.27, time = time_vector)

pop_1_vec <- vector(mode = "numeric", length = length(time_vector))





r_seq <- seq(from = 0.2, to = 0.4, by = 0.01)

out_matrix <- matrix(nrow = length(time_vector), ncol = length(r_seq))


for (i in seq_along(r_seq)) { #out loop of growth rates
  for (j in seq_along(time_vector)) { #inner loop of time steps
    population <- logistic_growth(N0 = 100, K = 6000, r = r_seq[i],
                                  time = time_vector[j])
    out_matrix[j, i] <- population
  }
}




for (i in seq_along(time_vector)) {
  population <- logistic_growth(N0 = 100, K = 6000, r = 0.27, time = time_vector[i]) 
  pop_1_vec[i] <- population
}

pop_time_1 <- data.frame(time_vector, pop_1_vec)

ggplot(data = pop_time_1, aes(x = time_vector, y = pop_1_vec)) + 
  geom_line()


## Create a sequence of growth rate values:
r_seq <- seq(from = 0.2, to = 0.4, by = 0.01)

out_matrix <- matrix(nrow = length(time_vector), ncol = length(r_seq))

## Creating df

out_df <- data.frame(out_matrix, time = time_vector)
view(out_df)

colnames(out_df) <- c(paste0("growth_rate_", r_seq), "time")

out_df_long <- out_df %>% 
  pivot_longer(cols = -time, names_to = "growth_rate", values_to = "population_size")
view(out_df_long)

ggplot(data = out_df_long, aes(x = time, y = population_size)) +
  geom_line(aes(color = growth_rate), show.legend = FALSE) +
  theme_minimal()
