library(tidyverse)
library(readxl)
library(ggpubr)

meta <- read_excel("data/lysotracker_7dpf_23102024.xlsx") %>%
  mutate(
    genotype = factor(genotype, levels = c("wt", "het", "hom"))
  )

data <- read_csv("data/Results_FIJI_macro.csv") %>%
  dplyr::select(-1) %>%
  mutate(
    # get the fish_id to match with the genotype metadata
    fish_id = str_extract(
      Label, pattern = "\\d{1,2}") %>% # a number exactly once or twice
      as.numeric(),
    .after = Label
    ) %>%
  left_join(meta)

# output to send to betty
data %>%
  write.csv("output/resultswgeno.csv")

data %>%
  ggbarplot(
    x = "genotype",
    y = "IntDen",
    add = c("mean_sd", "jitter")
    ) +
  stat_compare_means()

data %>%
  ggbarplot(
    x = "genotype",
    y = "Area",
    add = c("mean_sd", "jitter")
  ) +
  stat_compare_means()

data %>%
  ggbarplot(
    x = "genotype",
    y = "RawIntDen",
    add = c("mean_sd", "jitter")
  ) +
  stat_compare_means()

data %>%
  ggbarplot(
    x = "genotype",
    y = "Mean",
    add = c("mean_sd", "jitter")
  ) +
  stat_compare_means()

data %>%
  ggbarplot(
    x = "genotype",
    y = "RawIntDen",
    add = c("mean_sd", "jitter")
  ) +
  stat_compare_means()
