library(shiny)
require('ggvis')
source('utils.R')

joined_df <- load_data()

function(input, output) {
  reactive_df <- reactive({
    subset_year <- joined_df[joined_df$year == input$year, ]
    subset_region <- subset_year[subset_year$Region %in% input$Region, ]
    subset_population <- subset_region[subset_region$population %in% input$Region, ]
    subset_region
  }) 
  
  vis <- reactive({
    subset_df <- reactive_df()
    ggvis(subset_df, ~life, ~fert_rate, fill=~Region, opacity := 0.75) %>%
      layer_points(key := ~Country.Name, size=~pop) %>%
      scale_numeric("x", domain = c(10, 90), nice = FALSE, clamp = TRUE) %>%
      scale_numeric("y", domain = c(0.5, 9), nice = FALSE, clamp = TRUE) %>%
      add_tooltip(function(data){
        paste0("Country: ", data$Country.Name, "<br>", 
               "Region: ", data$Region, "<br>",
               "Life Expectancy: ", data$life, "<br>",
               "Fertility Rate: ", data$fert_rate, "<br>")
      }, "hover")
  })
  
  vis %>% bind_shiny("ggvis", "ggvis_ui")
}