*KM estimation
stset lmonth, failure(bev2==1) id(id)
cd "/Users/fumiyau/Documents/GitHub/OrderMatters/Results/KMEstimation"
recode bripreg7 1=1 0=2, gen(bripregx7)
*keep lmonth bev2 id group7 bripregx7
*bysort id: egen maxlmonth=max(lmonth)
*keep if lmonth==maxlmonth
*drop maxlmonth
*group7 (propensity score matching conducted): 1 Premarital pregnancy 2 other
*bripregx7 (observed): 1 Premarital pregnancy 2 other

stsum ,by(group7)
sts graph, by(group7) ytitle("The probability of not having the second child") title("") xtitle("Month at risk from twelve months after first childbearing")  legend(position(6) cols(2) order(1 2) label(1 "Premarital Pregnancy (7 months)") label(2 "Other Pregnancy") ) saving(secondbirth_BPPS7.gph,replace)
sts test group7
sts test group7,wilcoxon
*Log lank : 0.1029
*KM Estimation for second childbirth（p value=0.1044, adjusted）

sts graph, by(bripregx7) ytitle("The probability of not having the second child") title("") xtitle("Month at risk from twelve months after first childbearing")  legend(position(6) cols(2) order(1 2) label(1 "Premarital Pregnancy (7 months)") label(2 "Other Pregnancy") ) saving(secondbirth_BPOB7.gph,replace)
sts test bripreg7
sts test bripreg7,wilcoxon
*Log lank :  0.0049
*KM Estimation for second childbirth（p value=0.0144, observed）

label define lmonthl2 0"Month at risk (ref: 1-6)"1"7-12"2"13-24"3"25-36"4"37-60"5"61-96"6"> 97",replace
label values lmonthcat2 lmonthl2
label define lmonthl4 0"Month at risk (ref: 1-6)"1"7-12"2"13-24"3"25-36"4"37-48"5"49-60"6"61-84"7"> 85",replace
label values lmonthcat4 lmonthl4
