# use this example on how to dynamically change tabs conditionally.
# nav_panel "B" is show only after data has been uploaded successfully

shinyApp(
  page_fillable(
    sidebarLayout(
      sidebarPanel(
        fileInput("file1", "Choose data to import.", accept = NULL)
      ),
      mainPanel(
        navset_card_tab(
          id = "container",
          nav_panel("A", "upload something"),
          nav_panel("B", "upload: SUCCESS!")
        )
      )
    )
  ),
  function(input, output) {
    newFile <- reactiveVal()
    fileData <- reactive({
      if (is.null(input$file1)) {
        return(NULL)
      }
      rio::import(input$file1$datapath)
    })
    observe({
      newFile(fileData())
      if (!is.null(newFile())) {
        nav_select(id = "container", selected = "B")
      }
    })
  }
)




# for the app... this works
newFile <- reactiveVal()
fileData <- reactive({
  if (is.null(input$file1)) {
    return(NULL)
  }
  rio::import(input$file1$datapath)
})

observe({
  newFile(fileData())
  if (!is.null(newFile())) {
    nav_select(id = "main_tabset", selected = "Data")
  }
})
