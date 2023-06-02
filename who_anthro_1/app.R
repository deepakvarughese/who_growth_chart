library(shiny)
library(shinyWidgets)
library(ggplot2)
library(rsconnect)




ui<-fluidPage(
    
    titlePanel("WHO Anthropometry"),
    sliderInput(inputId = "age1", label = "Age of Child in months", min = 0, max = 60,
                 value =5), 
    sliderInput(inputId = "wt1", label = "Weight of the child in Kg", min = 0, max =  40, value = 5),
    radioButtons(inputId = "sex",
                 label = "Choose sex",
                 choices = c("male" = "male",
                             "Female" = "female"),
                 inline = TRUE),
    mainPanel(plotOutput("plot")
    )
)




server<-function(input,output){
    output$plot<- renderPlot({
       wfa %>% 
            filter( gender == input$sex) %>% 
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
            geom_point(aes(x = input$age1 , y = input$wt1), size = 1.5) +
            geom_point(aes(x = input$age1 , y = input$wt1), shape = 4, size = 3, alpha =0.20)
        
        
    })
    
}

shinyApp(ui,server)







