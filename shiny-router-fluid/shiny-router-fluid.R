library(shiny)
library(shiny.router)
library(bslib)

# This creates a link to a given route inside a list item of a menu
links <- function(link, label) {
  link_id <- glue::glue("link-{stringr::str_replace_all(link, '/', '')}")
  tags$li(
    a(id = link_id, class = "link-item", href = route_link(link), label)
  )
}

# This creates a menu with a title, icon, and links to all pages.
menu <- tags$div(
  class = "my-nav-bar",
  tags$div(
    class = "my-nav-title",
    # add generic icon using Font Awesome
    tags$i(class = "fa fa-home"),
    # make the title a link to the "Home" route
    tags$a(href = route_link("/"), "My Title")
  ),
  tags$ul(
    class = "my-nav-list",
    links("/", "Home"),
    links("other", "Other page"),
    links("third", "A third page")
  )
)

# This creates UI for each page.
page <- function(title, content) {
  div(
    class = "my-page",
    div(
      titlePanel(title),
      p(content)
    )
  )
}

# Create the pages.
root_page <- page(
  "Home page",
  list(
    "Welcome on sample routing page!",
    tags$br(),
    lorem::ipsum(7)
  )
)
other_page <- page(
  "Some longer page",
  list(
    "Lorem ipsum dolor sit amet.",
    tags$br(),
    lorem::ipsum(20)
  )
)
third_page <- page(
  "Third Page", 
  list(
    p("this is how i can add our group's stuff"),
    shiny::actionButton("myButton", "Click me!", style = "primary")
  )

)

# Make output for our router in main UI of Shiny app.
ui <- tagList(
  tags$head(
    tags$link(
      rel = "stylesheet", 
      href = "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
    ),
    tags$style(
      HTML(
        "html {
          position: relative;
          min-height: 100%;
        }
        body {
          min-height: 100vh;
          display: flex;
          flex-direction: column;
          margin: 0;
        }
        html, body {
          height: calc(100% - 140px);
          display: flex;
          flex-direction: column;
        }
        .my-nav-bar {
          display: flex;
          align-items: center;
          justify-content: space-between;
          position: relative;
          top: 0;
          left: 0;
          padding: 1vw;
          width: 100%;
          background-color: #005030;
          color: white;
          text-align: right;
        }
        .my-nav-title {
          display: flex;
          align-items: center;
          font-size: 1.5em;
          color: white;
          margin-right: auto;
        }
        .my-nav-title i {
          margin-right: 0.5em;
        }
        .my-nav-title a {
          color: white;
          text-decoration: none;
        }
        .my-nav-title a:hover {
          cursor: pointer;
        }
        .my-nav-list {
          list-style-type: none; 
          margin: 0; 
          padding: 0; 
          overflow: hidden;
        }
        .my-nav-list li {
          display: inline; 
          margin-right: 1vw;
        }
        .link-item {
          color: white;
          text-decoration: none;
        }
        .link-item.selected {
          font-weight: bold;
          font-decoration: underline;
        }
        body {
          margin-bottom: 60px; /* Margin bottom by footer height */
        }
        .my-page {
          flex-grow: 1;
          margin: 0 auto; 
          padding: 10px; 
          width: 100%;
        }
        .footer {
          margin-top: auto;
          flex-shrink: 0;
          padding: 10px;
          height: 140px;
          width: 100%;
          background-color: #f47321;
          color: white;
          text-align: center;
          display: flex;
          justify-content: space-between;
          flex-wrap: wrap;
        }
        .footer-column {
          flex: 1;
          padding: 10px;
          /* consider adding a min width */
        }"
      )
    )
  ),
  menu,
  page_fluid(
    router_ui(
      route("/", root_page),
      route("other", other_page),
      route("third", third_page)
    )
  ),
  tags$footer(
    class = "footer",
    div(class = "footer-column", "Footer text"),
    div(class = "footer-column", "Footer text"),
    div(class = "footer-column", "Footer text"),
    div(class = "footer-column", "Footer text")
  )
)

# Plug router into Shiny server.
server <- shinyServer(function(input, output, session) {
  router_server()
})

shinyApp(ui, server)
