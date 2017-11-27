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
  titlePanel("Conditional Panels"),
  
  # Sidebar with different widgets depending on the selected tab
  sidebarLayout(
    sidebarPanel(
      #first conditional tab showing the grade distribution
      conditionalPanel(
        condition = "input.tabselected==1",
        h3("Grades Distribution"),
        tableOutput("gd_pro")),
      
      #second conditional tab with bin width
      conditionalPanel(
        condition = "input.tabselected==2",
        selectInput("var1", "X-axis variable", 
                    categorical, selected = "HW1"),
        sliderInput("width", "Bin Width", 
                    min = 1, max = 10, value = 3)),
      
      #Third conditional panel
      conditionalPanel(
        condition = "input.tabselected==3",
        selectInput("var2", "X-axis variable",
                    axisname, selected = "Test1"),
        selectInput("var3", "Y-axis variable",
                    axisname, selected = "overall"),
        sliderInput("opacity", "Opacity", 
                    min = 0, max = 1, value = 0.5),
        radioButtons("button", label = "Show line", choices = list("none" = 1, "lm" = 2, "loess" = 3),
                     selected = 1)))
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Barchart", value = 1, 
                           ggvisOutput("barchart")),
                  tabPanel("Histogram", value = 2, 
                           ggvisOutput("histogram")),
                  id = "tabselected")
    )
  )
)


# Define server logic
server <- function(input, output) {
  # Barchart (for 1st tab)
  vis_barchart <- reactive({
    # Normally we could do something like ggvis(x = ~mpg),
    # but since the inputs are strings, we need to do a little more work.
    var1 <- prop("x", as.symbol(input$var1))
    mtcars %>% 
      ggvis(x = var1, fill := "#ef623b") %>% 
      layer_bars(stroke := '#ef623b', width = input$width,
                 fillOpacity := 0.8, fillOpacity.hover := 1) %>%
      add_axis("y", title = "frequency")
  })
  
  vis_barchart %>% bind_shiny("barchart")
  
  
  # Histogram (for 2nd tab)
  vis_histogram <- reactive({
    # Normally we could do something like ggvis(x = ~mpg),
    # but since the inputs are strings, we need to do a little more work.
    var2 <- prop("x", as.symbol(input$var2))
    
    mtcars %>% 
      ggvis(x = var2, fill := "#abafb5") %>% 
      layer_histograms(stroke := 'white',
                       width = input$bins)
  })
  
  vis_histogram %>% bind_shiny("histogram")
  
}

# Run the application 
shinyApp(ui = ui, server = server)
