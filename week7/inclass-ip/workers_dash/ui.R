library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "Women In Workplace"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Distribution Earning", tabName = "widgets", icon = icon("chart-area")),
      menuItem(text = "Data", icon = icon("table"))
    )
  ),
  dashboardBody()
)