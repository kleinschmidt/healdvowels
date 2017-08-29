# This code was provided to Shannon Heald to extract the talker-specific,
# time-of-day-specific and marginal statistics from her vowel corpus.

## ---------------------------------------------------------------- ##
## Shannon, f you import your data and assign it to the variable name "df",
## (as on line 17), the rest of the code should execute without error,
## as long as "Speaker", "Vowel", "F1" and "F2" are the relevant column 
## names in the data frame. 

## NOTE: this code will save FIVE (5) .txt files to your working directory, 
## each file containing a different set of variance-covariance measurements. 

library(dplyr)

setwd("/.../.../")

df <- read.table("...")


##---------------------------------------------- 
# F1xF2 covariance by speaker for each vowel
##---------------------------------------------- 

cov_by_speaker <- df %>% 
  group_by(Speaker, Vowel) %>%
  summarise(
	# these means and SDs are redundant with what you shared before. I recalculate them here
	# for the convenience of having all measurements in a single file. 
    F1.mean = mean(F1),
    F2.mean = mean(F2),
    F3.mean = mean(F3),
    
    F1.sd = sd(F1),
    F2.sd = sd(F2),
    F3.sd = sd(F3),
	
	# the variance / covariance below is the crucial new bit.
    F1.var = var(F1),
    F2.var = var(F2),
    F3.var = var(F3),
    
    F1.F2.covar = cov(F1, F2),
    F1.F3.covar = cov(F1,F3),
    F2.F3.covar = cov(F2,F3)
  )
write.table(cov_by_speaker, file = "covariance-by-speaker.txt", sep = "\t", row.names = FALSE, quote = FALSE)



##---------------------------------------------- 
# F1xF2 covariance by speaker and time of day for each vowel
##---------------------------------------------- 

cov_by_speaker_and_TOD <- df %>% 
  group_by(Speaker, Vowel, Time) %>%
  summarise(
    F1.mean = mean(F1),
    F2.mean = mean(F2),
    F3.mean = mean(F3),
    
    F1.sd = sd(F1),
    F2.sd = sd(F2),
    F3.sd = sd(F3),
	
	F1.var = var(F1),
    F2.var = var(F2),
    F3.var = var(F3),
    
    F1.F2.covar = cov(F1, F2),
    F1.F3.covar = cov(F1,F3),
    F2.F3.covar = cov(F2,F3)
  )
write.table(cov_by_speaker_and_TOD, file = "covariance-by-speaker-and-TOD.txt", sep = "\t", row.names = FALSE, quote = FALSE)



##---------------------------------------------- 
# F1xF2 covariance by time of day for each vowel (marginalizing across talkers)
##---------------------------------------------- 

cov_by_TOD <- df %>% 
  group_by(Vowel, Time) %>%
  summarise(
    F1.mean = mean(F1),
    F2.mean = mean(F2),
    F3.mean = mean(F3),
    
    F1.sd = sd(F1),
    F2.sd = sd(F2),
    F3.sd = sd(F3),
	
	F1.var = var(F1),
    F2.var = var(F2),
    F3.var = var(F3),
    
    F1.F2.covar = cov(F1, F2),
    F1.F3.covar = cov(F1,F3),
    F2.F3.covar = cov(F2,F3)
  )
write.table(cov_by_TOD, file = "covariance-by-TOD.txt", sep = "\t", row.names = FALSE, quote = FALSE)




##---------------------------------------------- 
# F1xF2 covariance for each vowel (across speakers)
##---------------------------------------------- 

cov_across_speakers <- df %>% 
  group_by(Vowel) %>%
  summarise(
    F1.mean = mean(F1),
    F2.mean = mean(F2),
    F3.mean = mean(F3),
    
    F1.sd = sd(F1),
    F2.sd = sd(F2),
    F3.sd = sd(F3),
	
	F1.var = var(F1),
    F2.var = var(F2),
    F3.var = var(F3),
    
    F1.F2.covar = cov(F1, F2),
    F1.F3.covar = cov(F1,F3),
    F2.F3.covar = cov(F2,F3)
  )
write.table(cov_across_speakers, file = "covariance-across-speakers.txt", sep = "\t", row.names = FALSE, quote = FALSE)




##---------------------------------------------- 
# F1xF2 covariance for each vowel (across speakers, but averaging by speaker first)  
##---------------------------------------------- 

cov_across_speakers.alt <- df %>% 
  group_by(Speaker, Vowel) %>%
  summarise(
  	F1 = mean(F1),
  	F2 = mean(F2),
  	F3 = mean(F3)
  	) %>%
   group_by(Vowel) %>%
   summarise(
    F1.mean = mean(F1),
    F2.mean = mean(F2),
    F3.mean = mean(F3),
    
    F1.sd = sd(F1),
    F2.sd = sd(F2),
    F3.sd = sd(F3),
	
	F1.var = var(F1),
    F2.var = var(F2),
    F3.var = var(F3),
    
    F1.F2.covar = cov(F1, F2),
    F1.F3.covar = cov(F1,F3),
    F2.F3.covar = cov(F2,F3)
  )
write.table(cov_across_speakers.alt, file = "covariance-across-speakers-ALT.txt", sep = "\t", row.names = FALSE, quote = FALSE)
