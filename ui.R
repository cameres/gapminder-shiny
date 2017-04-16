library(shiny)
require('ggvis')
source('utils.R')

regions <- get_regions()

fluidPage(
  titlePanel("Sliders"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Region", "Region", regions, selected=regions, multiple=TRUE),
      sliderInput("year", "year:", 1960, 2014, 1,
                  step = 1, animate=
                    animationOptions(interval=100, loop=TRUE))
    ),
    mainPanel(
      ggvisOutput("ggvis")
    )
  )
)