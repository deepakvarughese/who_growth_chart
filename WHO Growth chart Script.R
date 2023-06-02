##WHO Growth Charts

library(tidyverse)
library(here)
library(rio)
library(janitor)


## Importing Data
wfa_b_05 <- import("wfa_boys_0-to-5_boys.xlsx")
wfa_g_05 <- import("wfa_girls_0-to-5-years.xlsx")


wfa_b_05 <- wfa_b_05 %>% 
  mutate(sex = "male")

wfa_g_05 <- wfa_g_05 %>% 
  mutate(gender = "female")


wfa <- bind_rows(wfa_b_05 , wfa_g_05)

## Input Variables
age1 <- 12
wt1 <- 12
sex <- "female"


wfa_plot <-wfa %>% 
  filter(gender == sex) %>% 
  ggplot(aes(x=Month)) +
  geom_line(aes(y=SD3neg), colour="#D55E00") +
  geom_line(aes(y=SD2neg), colour="#E69F00") +
  geom_line(aes(y=SD2), colour="#E69F00") +
  geom_line(aes(y=SD3), colour="#D55E00") +
  theme_bw() +
  scale_x_continuous(expand=c(0,0),
                     breaks = c(0,1,2,6,12,18,24,36,48,60),
                     minor_breaks = seq(1, 60, 1)) +
  scale_y_continuous(expand=c(0,0),
                     breaks = c(seq(0, 28, 2)),
                     minor_breaks = seq(0, 28, 0.5)) +
  geom_vline(xintercept = c(1,2,6,12,18,24,36,48,60),
             linetype="longdash", colour="#999999") +
  ylab("Weight (Kg)") +
  ggtitle(paste("Weight For Age 0-60 Months" , sex, sep = " - "))+
  theme(panel.border = element_blank()) +
  geom_ribbon(aes(ymin=0, ymax=SD2neg), fill = "#D55E00",alpha = 0.10) +
  geom_ribbon(aes(ymin=SD2neg, ymax=SD2), fill = "#009E73",alpha = 0.10) +
  geom_ribbon(aes(ymin=SD1neg, ymax=SD1), fill = "#009E76",alpha = 0.10) +
  geom_ribbon(aes(ymin=SD2, ymax=28), fill = "#D55E00",alpha = 0.10) +
  geom_point(aes(x = age1 , y = wt1), size = 1.5) +
  geom_point(aes(x = age1 , y = wt1), shape = 4, size = 3, alpha =0.20)


wfa_plot


