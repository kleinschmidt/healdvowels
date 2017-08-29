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
  

read_var_cov <- function(fn) {
  readr::read_delim(fn, delim="\t") %>%
    rowwise() %>%
    do(mu = c(.$F1.mean, .$F2.mean, .$F3.mean),
       Sigma = matrix(c(.$F1.var, .$F1.F2.covar, .$F1.F3.covar,
                        .$F1.F2.covar, .$F2.var, .$F2.F3.covar,
                        .$F1.F3.covar, .$F2.F3.covar, .$F3.var),
                      ncol = 3)
       )
}

f <- read_var_cov(fn="data-raw/covariance-by-speaker.txt")
