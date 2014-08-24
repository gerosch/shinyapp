###############################################################################
## Coursera Course: 09 Developing Data Products                              ##
## Course Project                                                            ##
###############################################################################
## R ##### Author: Gero Schmidt ###### Version: 1.00 ###### Date: 2014-08-24 ##
###############################################################################
## This is the server.R part of the shiny project for the Course Project     ##
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

distanceProjectile <- function(velo,alpha,gcnst) {
  ((velo^2)/gcnst)*sin(2*(pi*alpha/180))
}

heightProjectile <- function(velo,alpha,gcnst) {
  ((velo^2)/(2*gcnst))*(sin(pi*alpha/180)^2)
}

trajectoryProjectile <- function(xval,velo,alpha,gcnst) {
  (xval*tan(pi*alpha/180))-(gcnst*xval^2)/(2*velo^2*cos(pi*alpha/180)^2)
}

# Define server logic for the app calculation
shinyServer(function(input, output) {
  
  # Process reactive output (text and plot)
  
  # Input parameters
  output$inpParms <- renderText({paste(
    "### Angle:",input$pangle,"[°] ", 
    "### Velocity:",input$pvelocity,"[m/s] ",
    "### Gravity:",input$paccel,"[m/s^2]")})

  # Predicted maximum travel distance of projectile
  output$preDist  <- renderText({paste("Maximum distance traveled: ", 
                                        round(distanceProjectile(
                                          velo  =input$pvelocity,
                                          alpha =input$pangle,
                                          gcnst =as.numeric(input$paccel)),2),
                                       "meters")})

  # Predicted maximum travel height of projectile
  output$preHght  <- renderText({paste("Maximum height traveled: ", 
                                       round(heightProjectile(
                                         velo  =input$pvelocity,
                                         alpha =input$pangle,
                                         gcnst =as.numeric(input$paccel)),2),
                                       "meters")})

  # Predicted trajectory plot of projectile  
  output$trajectoryPlot <- renderPlot({
    
    dist <- distanceProjectile(
      velo  = input$pvelocity,
      alpha = input$pangle,
      gcnst = as.numeric(input$paccel))

    x <- seq (0, dist, length = 50)
    y <- trajectoryProjectile(
      xval  = x,
      velo  = input$pvelocity,
      alpha = input$pangle,
      gcnst = as.numeric(input$paccel))
    
    # Draw trajectory plot
    plot(x, y, col = "blue", main="Predicted Trajectory of Projectile", type="l", 
      xlab="Travel distance [m]", ylab="Travel height [m]")
  })
})
