###########################################################
# Title: Conditional Panels with grade
#
# Description:
#   This shiny app contains three different tabs, and different 
#   grade visualizers.
#
# Details:
#   The graphics in each tab are obtained with ggvis
#
# Author: Pinshuo Ye
###########################################################

# required packages
library(shiny)
library(ggvis)
library(dplyr)

#loading functions
#load dataset and functions
source("../code/functions.R")
dat <- read.csv('../data/cleandata/cleanscores.csv')

#creating a table
categorical <- c('HW1','HW2','HW3','HW4','HW5',"HW6","HW7","HW8","HW9",
                 "Test1","Test2","Quiz")
axisname <- names(dat[-23])
Grade <- c("A", "A-", "A+", "B", "B-", "B+", "C", "C-", "C+", "D", "F")
Freq <- c(54, 31, 16, 52, 29, 30, 38, 27, 23, 19, 15)
Prop <- rep(0, 11)
for(i in 1:11){
  Prop[i] <- Freq[i]/sum(Freq)
}

dat1 <- data.frame(
  Grade,
  Freq,
  Prop 
)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Grade Visualizer"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      #first conditional tab showing the grade distribution
      conditionalPanel(
        condition = "input.tabselected==1",
        h3("Grades Distribution"),
        tableOutput("dat1")),
      
      #second conditional tab with bin width
      conditionalPanel(
        condition = "input.tabselected==2",
        selectInput("var1", "X-axis variable", 
                    categorical, selected = "HW1"),
        sliderInput("width", "Bin Width", 
                    min = 1, max = 10, value = 3)),
      
      #third conditional tab with x, y variable, opacity and lines
      conditionalPanel(
        condition = "input.tabselected==3",
        selectInput("var2", "X-axis variable",
                    axisname, selected = "Test1"),
        selectInput("var3", "Y-axis variable",
                    axisname, selected = "overall"),
        sliderInput("opacity", "Opacity", 
                    min = 0, max = 1, value = 0.5),
        radioButtons("button", label = "Show line", choices = list("none" = 1, "lm" = 2, "loess" = 3),
                     selected = 1))),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Barchart", value = 1, 
                           ggvisOutput("barchart")),
                  tabPanel("Histogram", value = 2, 
                           ggvisOutput("histogram"),
                           h4("Summary Statistics"),
                           verbatimTextOutput("summary")),
                  tabPanel("Scatterplot", value = 3, 
                           ggvisOutput("scatterplot"),
                           h4("Correlation:"),
                           verbatimTextOutput("correlation")),
                  id = "tabselected")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  #first tab
  vis_barchart <- reactive({
    #command showing the grade distribution tables
    output$dat1 <- renderTable(dat1)
    #draw the bar chart with the group of grades
    dat%>%
      ggvis(x = ~Grade, fill := "#3fbfea")%>%
      layer_bars(stroke := '#3fbfea',fillOpacity := 0.8, 
                 fillOpacity.hover := 1)%>%
      #add y axis
      add_axis("y", title = "frequency")
  })
  vis_barchart %>% bind_shiny("barchart")
  
  #second tab
  vis_histogram <- reactive({
    var1 <- prop("x",as.symbol(input$var1))
    #draw barchart with input width and x variables
    dat%>%
      ggvis(x = var1,fill := "#abafb5")%>%
      layer_histograms(stroke := 'white',width = input$width,
                       fillOpacity := 0.8, fillOpacity.hover := 1)
  })
  vis_histogram %>% bind_shiny("histogram")
  #command for showing the summary statistics tables
  output$summary <- renderPrint(print_stats(summary_stats(dat[ ,input$var1]) ))
  
  #third tab
  vis_point <- reactive({
    var2 <- prop("x", as.symbol(input$var2))
    var3 <- prop("y",as.symbol(input$var3))
    #conditional choice according to "show line" choice
    if(input$button == 1){
      dat %>%
        ggvis(x = var2, y = var3) %>%
        layer_points(fillOpacity := input$opacity)
    }else if(input$button == 2){
      dat %>%
        ggvis(x = var2, y = var3) %>%
        layer_points(fillOpacity := input$opacity)%>%
        #draw the prediction line with method lm
        layer_model_predictions(model = "lm")
      
    }else if(input$button == 3){
      dat %>%
        ggvis(x = var2, y = var3) %>%
        layer_points(fillOpacity := input$opacity)%>%
        #draw the prediction line with method loess
        layer_model_predictions(model = "loess")
    }
  })
  #drw the graph
  vis_point %>% bind_shiny("scatterplot")
  
  #output the correlation 
  output$correlation <- renderPrint(cor(dat[[input$var2]], dat[[input$var3]]))
}

# Run the application 
shinyApp(ui = ui, server = server)


