# Make Messy Data ---------------------------------------------------------
# Eugene Joh
# 2019-05-21

# generate random data
#  - age
#  - name
#  - sex
#  - area
#  - hypothetical immune status
#  - hypothetical Ab serum concentration

# install.packages("randomNames")
library(randomNames)

make_messy_data <- function(
  nrow = 100,
  mean_age = 40,
  sd_age = 14,
  mean_serum = 90,
  sd_serum = 0.6,
  na = TRUE,
  seed = 1) {
  
  if (nrow < 2) stop("please enter number > 1")
  set.seed(seed)
  rand_ <- function(N, M, sd = 1) {
    vec <- rnorm(N, M/N, sd)
    round(vec / sum(vec) * M)
  }
  
  rand_m <- abs(rand_(2, nrow/2, sd = 3))
  rand_f <- abs(rand_(2, nrow/2, sd = 2))
  
  area_m <-
    c(
      "Downtown, Toronto",
      "downton, Toronto",
      "Nord York, Tornto",
      "North York, Tornto",
      "Erindale, Mississauga",
      "Etobioke, Toronto",
      "Etobicoke, Toronto",
      "Scarborough, Toronto",
      "Bronte, Oakville",
      "Yonge-Eglinton, oronto",
      "Yong-Eglington, Toronto",
      "Port Credit, mississauga",
      "Parkdale, Toronto"
    )
  
  df <- data.frame(
    full_name = c(randomNames::randomNames(n = round(nrow/2), gender = 0), 
                  randomNames::randomNames(n = round(nrow/2), gender = 1))[1:nrow], 
    sex = c(
      rep("Male", rand_m[1]),
      rep("m", rand_m[2]),
      rep("Female", rand_f[1]),
      rep("F", rand_f[2]))[1:nrow], 
    age = abs(round(rnorm(n = nrow, mean = mean_age, sd = sd_age))),
    area = sample(x = area_m, size = nrow, replace = TRUE),
    immune_status = rpois(n = nrow, lambda = 1),
    serum_igm = paste(round(replace(rlnorm(n = nrow, meanlog = log(mean_serum), sdlog = sd_serum), 
                                    sample(1:nrow,size = 0.05*nrow, replace = TRUE), 
                                    sample(c(-1,-99), size = 0.05*nrow, replace = TRUE)),
                            1), "mg/dL"),
    stringsAsFactors = FALSE
  )
  
  if (na) {
    df <- as.data.frame(
      do.call("cbind", 
              lapply(df, function(x) {
                i <- sample(
                  c(TRUE, NA),
                  prob = c(0.95, 0.05),
                  size = length(x),
                  replace = TRUE)
                x[i]
              })
      ), stringsAsFactors = FALSE)
  }
  
  df[sample(nrow(df)),]
  
}

# run function
df1 <- make_messy_data(nrow = 600, mean_age = 39, sd_age = 10, mean_serum = 90, seed = 1)
df2 <- make_messy_data(nrow = 200, mean_age = 5, sd_age = 2, mean_serum = 70, sd_serum = 0.4, seed = 2)
df3 <- make_messy_data(nrow = 200, mean_age = 60, sd_age = 12, mean_serum = 100, sd_serum = 0.6, seed = 3)

# export as .csv
if (!dir.exists(file.path(getwd(), "data"))) dir.create(file.path(getwd(), "data"))
write.csv(x = df1, file = file.path(getwd(), "data", "messy_data_01.csv"), row.names = FALSE)
write.csv(x = df2, file = file.path(getwd(), "data", "messy_data_02.csv"), row.names = FALSE)
write.csv(x = df3, file = file.path(getwd(), "data", "messy_data_03.csv"), row.names = FALSE)