*This do file is written by Fumiya Uchikoshi on September 30, 2018
cd "/Users/fumiyau/Documents/GitHub/OrderMatters/"
log using `"`path'OrderMattersReplication`=subinstr("`c(current_date)'"," ","",.)'.log"', replace
use "/Users/fumiyau/Desktop/JGSS_LCS_Submission/Data/jgss2009lcs_v3R.dta",clear
*Data construction
do "/Users/fumiyau/Documents/GitHub/OrderMatters/1.DataConst.do"
*Expand the data
do "/Users/fumiyau/Documents/GitHub/OrderMatters/2.Expand.do"
*Labeling variables/values
do "/Users/fumiyau/Documents/GitHub/OrderMatters/4.Labeling.do"
*Analysis
do "/Users/fumiyau/Documents/GitHub/OrderMatters/5.Descriptive.do"
do "/Users/fumiyau/Documents/GitHub/OrderMatters/6.PSMatching.do"
do "/Users/fumiyau/Documents/GitHub/OrderMatters/7.KMEstimation.do"
do "/Users/fumiyau/Documents/GitHub/OrderMatters/8.Multivariate.do"
cd "/Users/fumiyau/Documents/GitHub/OrderMatters/"
log close

  
  
