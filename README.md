# `headlvowels`: Distributions of vowels from Heald and Nussbaum (2015)

Heald, S. L. M., & Nusbaum, H. C. (2015). Variability in vowel production within
and between days. _PLoS ONE, 10(9)_, e0136791–e0136791.
https://doi.org/10.1371/journal.pone.0136791


## Installation

```r
devtools::install_github("kleinschmidt/healdvowels")
```

## Use

Because of human subjects protections, only aggregate summaries of vowel
formants are included, in the form of means and covariance matrices for each
vowel, conditioned on:

  * Time of day:

    ``` r
    healdvowels::by_time
    #> # A tibble: 21 x 4
    #>    Vowel  Time      model Vowel_ascii
    #>    <chr> <chr>     <list>       <chr>
    #>  1     æ    t1 <list [2]>          AE
    #>  2     æ    t2 <list [2]>          AE
    #>  3     æ    t3 <list [2]>          AE
    #>  4     ɑ    t1 <list [2]>          AH
    #>  5     ɑ    t2 <list [2]>          AH
    #>  6     ɑ    t3 <list [2]>          AH
    #>  7     i    t1 <list [2]>          EE
    #>  8     i    t2 <list [2]>          EE
    #>  9     i    t3 <list [2]>          EE
    #> 10     ɛ    t1 <list [2]>          EH
    #> # ... with 11 more rows
    ```
    
  * Speaker

    ``` r
    healdvowels::by_speaker
    #> # A tibble: 56 x 4
    #>    Speaker Vowel      model Vowel_ascii
    #>      <chr> <chr>     <list>       <chr>
    #>  1       1     æ <list [2]>          AE
    #>  2       1     ɑ <list [2]>          AH
    #>  3       1     i <list [2]>          EE
    #>  4       1     ɛ <list [2]>          EH
    #>  5       1     ɪ <list [2]>          IH
    #>  6       1     u <list [2]>          OO
    #>  7       1     ʌ <list [2]>          UH
    #>  8       2     æ <list [2]>          AE
    #>  9       2     ɑ <list [2]>          AH
    #> 10       2     i <list [2]>          EE
    #> # ... with 46 more rows
    ```

  * Speaker and time of day joinly
  
    ``` r
    healdvowels::by_speaker_time
    #> # A tibble: 168 x 5
    #>    Vowel Speaker  Time      model Vowel_ascii
    #>    <chr>   <chr> <chr>     <list>       <chr>
    #>  1     æ       1    t1 <list [2]>          AE
    #>  2     æ       1    t2 <list [2]>          AE
    #>  3     æ       1    t3 <list [2]>          AE
    #>  4     æ       2    t1 <list [2]>          AE
    #>  5     æ       2    t2 <list [2]>          AE
    #>  6     æ       2    t3 <list [2]>          AE
    #>  7     æ       3    t1 <list [2]>          AE
    #>  8     æ       3    t2 <list [2]>          AE
    #>  9     æ       3    t3 <list [2]>          AE
    #> 10     æ       4    t1 <list [2]>          AE
    #> # ... with 158 more rows
    ```
  
Additionally, the overall (marginal) distributions of each vowel are included:

``` r
healdvowels::marginal
#> # A tibble: 7 x 3
#>   Vowel      model Vowel_ascii
#>   <chr>     <list>       <chr>
#> 1     æ <list [2]>          AE
#> 2     ɑ <list [2]>          AH
#> 3     i <list [2]>          EE
#> 4     ɛ <list [2]>          EH
#> 5     ɪ <list [2]>          IH
#> 6     u <list [2]>          OO
#> 7     ʌ <list [2]>          UH
```

The `model` column is a list column, where each entry is a list with `mu` (mean
vector) and `Sigma` (covariance matrix):

``` r
healdvowels::marginal$model[[1]]
#> $mu
#>        F1        F2        F3 
#>  844.9351 1794.3590 2608.0486 
#> 
#> $Sigma
#>            F1         F2        F3
#> F1 11621.7654   312.2359  9679.805
#> F2   312.2359 46300.8625 28703.813
#> F3  9679.8054 28703.8127 71828.838
```

These models can be used with
[`phondisttools`](https://github.com/kleinschmidt/phondisttools) in the same way
that models trained from raw F1×F2 values can be.
