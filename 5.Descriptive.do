*Drop person-year after the second birth
keep iduse pld15a ccnumttl bev2 bev3 ccnum2 ccnum1 cbirth1 cbirth2 cbirth3 birthcat1 birthcat2 birthcat3 length bripreg bripreg7 bripreg9 redu spedu cohort marcat marcohort marage type1 type1a type15a type2a jobssm1 jobssm1a jobssm15a jobssm2a lmonth div birthage1 birthage2
mark nomiss
markout nomiss type15a jobssm15a lmonth pld15a 
drop if nomiss == 0
*drop if length < cbirth1+12 is already done
drop if cbirth2 < length & ccnum2==1 & cbirth2 ~=.

*generate months categories
recode lmonth 1/12=1 13/24=2 25/36=3 37/60=4 61/96=5 97/258=6, gen(lmonthcat)
recode lmonth 1/6=0 7/12=1 13/24=2 25/36=3 37/60=4 61/96=5 97/258=6, gen(lmonthcat2)
recode lmonth 1/12=1 13/18=2 19/24=3 25/36=4 37/60=5 61/96=6 97/258=7, gen(lmonthcat3)
recode lmonth 1/6=0 7/12=1 13/24=2 25/36=3 37/48=4 49/60=5 61/84=6 85/258=7, gen(lmonthcat4)

*output descriptive stats when lmonth=1 and bripreg = 7
cd "/Users/fumiyau/Documents/GitHub/OrderMatters/Results/Descriptive"
quietly estpost tabulate redu bripreg7 if lmonth == 1, nototal
quietly esttab . using desc1.csv, replace cell(colpct(fmt(2))) unstack noobs
quietly estpost tabulate spedu bripreg7 if lmonth == 1, nototal
quietly esttab . using desc2.csv, replace cell(colpct(fmt(2))) unstack noobs
quietly estpost tabulate marcohort bripreg7 if lmonth == 1, nototal
quietly esttab . using desc3.csv, replace cell(colpct(fmt(2))) unstack noobs
quietly estpost tabulate marcat bripreg7 if lmonth == 1, nototal
quietly esttab . using desc4.csv, replace cell(colpct(fmt(2))) unstack noobs
quietly estpost tabulate type15a bripreg7 if lmonth == 1, nototal
quietly esttab . using desc5.csv, replace cell(colpct(fmt(2))) unstack noobs
quietly estpost tabulate jobssm15a bripreg7 if lmonth == 1, nototal
quietly esttab . using desc6.csv, replace cell(colpct(fmt(2))) unstack noobs
*quietly estpost tabulate cohort bripreg7 if lmonth == 1, nototal
*quietly esttab . using desc7.csv, replace cell(colpct(fmt(2))) unstack noobs
quietly estpost tabulate pld bripreg7 if lmonth == 1, nototal
quietly esttab . using desc8.csv, replace cell(colpct(fmt(2))) unstack noobs
*tabulate
for varlist bripreg7 redu spedu marcohort marcat type15a jobssm15a pld15a: tab X bripreg7 if lmonth == 1, chi
*descriptive stats
for varlist bripreg7 lmonthcat4 redu spedu marcohort marcat type15a jobssm15a pld15a div birthcat1: tabulate X, generate (Xdummy) 
quietly estpost tabstat bripreg7dummy1 bripreg7dummy2 lmonthcat4dummy1 lmonthcat4dummy2 lmonthcat4dummy3 lmonthcat4dummy4 lmonthcat4dummy5 lmonthcat4dummy6 lmonthcat4dummy7 lmonthcat4dummy8 redudummy1 redudummy2 redudummy3 redudummy4 spedudummy1 spedudummy2 spedudummy3 spedudummy4 spedudummy5 marcohortdummy1 marcohortdummy2 marcohortdummy3 marcohortdummy4 marcatdummy1 marcatdummy2 marcatdummy3 marcatdummy4 marcatdummy5 marcatdummy6 marcohortdummy1 marcohortdummy2 marcohortdummy3 marcohortdummy4 type15adummy1 type15adummy2 type15adummy3 type15adummy4 jobssm15adummy1 jobssm15adummy2 jobssm15adummy3 jobssm15adummy4 jobssm15adummy5 pld15adummy1 pld15adummy2 divdummy1 divdummy2 birthcat1dummy1 birthcat1dummy2 birthcat1dummy3 birthcat1dummy4 birthcat1dummy5 birthcat1dummy6, statistics(mean sd min max) columns(statistics) 
quietly esttab . using desc.csv, replace main(mean) aux(sd) wide nostar unstack noobs nonote label
*Recode for regression
recode marcat birthcat1 birthcat2 (4=0)
recode jobssm* type* (1=0)
recode redu spedu (2=0)
recode marcohort 3=0

