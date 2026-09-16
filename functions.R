# function to conditionally change a row
mutate_cond <- function(.data, condition, ..., envir = parent.frame()) {
  condition <- eval(substitute(condition), .data, envir)
  .data[condition, ] <- .data[condition, ] %>% mutate(...)
  .data
}

# get predictions from final survival model
pred_surv_cox_tt_wt <- function(fit, data, newdata, times, w){
  b <- coef(fit); b_tt <- b["tt(mean_bmi)"]; b_static <- b[names(b)!="tt(mean_bmi)"]
  form_static <- ~ sex + household_smoking_status + titbits + diet_type2 + diet_raw + colour2 + imd_cat + ovary_exp + mean_bmi + exa_fetch_cat_90
  X <- model.matrix(form_static, data)[,-1,drop=FALSE]; Xnew <- model.matrix(form_static, newdata)[,-1,drop=FALSE]
  X <- X[, names(b_static), drop=FALSE]; Xnew <- Xnew[, names(b_static), drop=FALSE]
  g <- function(t) log((t/365.25)/10)
  event_times <- sort(unique(data$censor_age_days[data$status_death==1]))
  S <- sapply(times, function(t_star){
    H <- 0
    for(t in event_times[event_times <= t_star]){
      risk <- data$censor_age_days >= t
      deaths <- data$censor_age_days == t & data$status_death == 1
      d_w <- sum(w[deaths])
      lp_risk <- as.numeric(X[risk,,drop=FALSE] %*% b_static) + b_tt * data$mean_bmi[risk] * g(t)
      denom <- sum(w[risk] * exp(lp_risk))
      dH0 <- d_w / denom
      lp_new <- as.numeric(Xnew %*% b_static) + b_tt * newdata$mean_bmi * g(t)
      H <- H + dH0 * exp(lp_new)
    }
    exp(-H)
  })
  names(S) <- paste0(times/365.25, "y")
  S
}

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}