###############################################################################
## Coursera Course: 09 Developing Data Products                              ##
## Course Project                                                            ##
###############################################################################
## R ##### Author: Gero Schmidt ###### Version: 1.00 ###### Date: 2014-08-24 ##
###############################################################################
## This is the ui.R part of the shiny project for the Course Project         ##
## in <Developing Data Products>.                                            ##
###############################################################################
## Disclaimer: The sample code described herein is provided on an "as is"    ##
## basis, without warranty of any kind. The author does not warrant,         ##
## guarantee or make any representations regarding the use, results of use,  ##
## accuracy, timeliness or completeness of any data or information relating  ##
## to this code. The author disclaims all warranties, express or implied,    ##
## and in particular, disclaims all warranties of merchantability, fitness   ##
## for a particular purpose, and warranties related to the code, or any      ##
## service or software related thereto. The author shall not be liable for   ##
## any direct, indirect or consequential damages or costs of any type        ##
## arising out of any action taken by you or others related to this code.    ##
###############################################################################
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Trajectory of a Projectile"),
  
  # Sidebar panel
  sidebarLayout(
    sidebarPanel(
      # Help text
      helpText("Create a ballistic trajectory of a projectile launched from the surface. 
        It is the path that a thrown or launched projectile will take under the action 
        of gravity, neglecting all other forces, such as friction from air resistance. 
        You can specify the velocity and angle at which the
        projectile is launched as well as the gravitational acceleration from a 
        given selection. 
        Note, that the trajectory is independent of the mass of the projectile."),
      
      # Input for the angle of the projectile on ground
      sliderInput("pangle",
                  "Angle at which the projectile is launched (Degrees):",
                  min = 0,
                  max = 90,
                  value = 45),

      # Input for the velocity of the projectile on ground
      sliderInput("pvelocity",
                  "Velocity at which the projectile is launched (meters per second):",
                  min = 0,
                  max = 100,
                  value = 10),

      # Input for the gravitational acceleration (g=9.81 m/s2 on Earth)
      radioButtons("paccel", "Gravitational acceleration (meters per second^2):",
                   c("Earth (9.81 m/s^2)" = 9.81,
                     "Moon (1.622 m/s^2)" = 1.622,
                     "Mars (3.711 m/s^2)" = 3.711,
                     "Jupiter (24.79 m/s^2)" = 24.79))
    ),

    # Show a plot of the trajectory of the projectile
    mainPanel(
      h4("Selected trajectory parameters"),
      textOutput("inpParms"),

      h4("Prediction of projectile trajectory:"),
      # Trajectory Distance
      textOutput("preDist"),
      # Trajectory Height
      textOutput("preHght"),
      
      # Trajectory Plot
      plotOutput("trajectoryPlot") 
     )
  )
))
