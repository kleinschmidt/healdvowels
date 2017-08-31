library(devtools)
library(tidyverse)

vowel_ipa <- tribble(
  ~Vowel, ~Vowel_ipa,
  "AE",   "æ",
  "AH",   "a",
  "EE",   "i",
  "EH",   "ɛ",
  "IH",   "ɪ",
  "OO",   "u",
  "UH",   "ʌ"
)

set_dimnames <- function(x, names) {
  dimnames(x) <- names
  x
}

read_var_cov <- function(fn, grouping_vars) {
  readr::read_delim(fn, delim="\t") %>%
    group_by_(.dots=grouping_vars) %>% 
    do(model = list(mu = c(.$F1.mean, .$F2.mean, .$F3.mean) %>%
                      set_names(c("F1", "F2", "F3")),
                    Sigma = matrix(c(.$F1.var, .$F1.F2.covar, .$F1.F3.covar,
                                     .$F1.F2.covar, .$F2.var, .$F2.F3.covar,
                                     .$F1.F3.covar, .$F2.F3.covar, .$F3.var),
                                   ncol = 3) %>%
                      set_dimnames(list(c("F1", "F2", "F3"),
                                        c("F1", "F2", "F3")))
                    )
       ) %>%
    left_join(vowel_ipa, by="Vowel")
}

by_speaker <- read_var_cov(fn="covariance-by-speaker.txt",
                           c("Speaker", "Vowel"))

by_time <- read_var_cov(fn="covariance-by-TOD.txt", c("Vowel", "Time"))

by_speaker_time <- read_var_cov(fn="covariance-by-speaker-and-TOD.txt",
                                c("Vowel", "Speaker", "Time"))

marginal <- read_var_cov(fn="covariance-across-speakers.txt", "Vowel")

models <- tribble(
  ~grouping,  ~models,
  "Marginal", mutate(marginal, group="all"),
  "Talker", select(by_speaker, group=Speaker, Vowel, Vowel_ipa, model),
  "Time", select(by_time, group=Time, Vowel, Vowel_ipa, model),
  "Time+Talker", by_speaker_time %>%
                   mutate(group=paste(Speaker, Time, sep="_")) %>%
                   select(group, Vowel, Vowel_ipa, model)
)

devtools::use_data(by_speaker, by_time, by_speaker_time, marginal, models, overwrite=TRUE)
