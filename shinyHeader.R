library(shiny)
library(bslib)

theme <- bslib::bs_theme(
  version = 5, 
  primary = "#005030",
  secondary = "#f47321"
)

ui <- bslib::page_navbar(
  title = "Feaster Lab and description",
  theme = theme,
  bg = bslib::bs_get_variables(theme, "primary"), # Set the navbar's background color
  sidebar = NULL, # no sidebar
  footer = tags$div(
    class = "footer bg-secondary text-white",
    style = "position: absolute; bottom: 0; width: 100%; height: 60px; line-height: 60px; text-align: center;",
    "Footer text"
  ),
  tabPanel(
    title = "Tab 1",
    value = "tab1",
    icon = icon("home"),
    fluidRow(
      column(
        width = 12,
        h1(
          "Tab 1",
          style = "padding: 10px; background-color: #f47321; color: #fff"
        )
      )
    )
  ),
  tabPanel(
    title = "Tab 2",
    value = "tab2",
    icon = icon("home"),
    fluidRow(
      column(
        width = 12,
        h1("Tab 2")
      )
    )
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)