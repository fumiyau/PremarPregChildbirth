*Do files for data analysis is prepared according to the definition of bridal pregnancy
*Propensity score matching

*Output the results of logit models
qui logit bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a i.pld15a if lmonth==1
est sto logit
cd "/Users/fumiyau/Documents/GitHub/OrderMatters/Results/PrppensityScore"
esttab logit using logitbeforemathching7.csv, wide se scalar(N chi2 df_m ll aic r2_p) star(# 0.1 * 0.05 ** 0.01 *** 0.001) b(3)  replace label  noomitted title(Determinants of second childbirth (left: adjusted right: observed))

*Propensity score matching
*Nearest neibor within caliper 0.1, 1-1 match
set seed 1000
generate x=uniform()
sort x
psmatch2 bripreg7 i.redu i.spedu i.marcohort i.marcat i.type15a i.jobssm15a i.pld15a if lmonth==1 , logit caliper(0.1) noreplacement descending
pstest,both
sort _id 
gen match=iduse[_n1]
gen treat=iduse if _nn==1
list id match treat if treat ~=.

qui tabout match using desc15a7.csv, replace style(csv)
gen cont =.   
qui for num 7 12 19 22 35 52 56 79 92 106 124 127 133 140 163 175 184 188 192 208 211 250 257 270 291 296 303 321 324 348 405 434 441 447 449 471 485 511 538 563 571 587 604 619 621 639 647 652 678 709 738 742 745 753 770 784 789 792 796 811 817 823 825 841 842 847 857 868 877 904 910 931 934 948 953 960 967 1006 1018 1038 1044 1054 1077 1096 1146 1192 1200 1203 1204 1214 1231 1233 1237 1270 1279 1298 1301 1314 1318 1356 1361 1363 1364 1388 1391 1402 1404 1449 1467 1490 1502 1506 1518 1523 1529 1530 1533 1541 1561 1568 1578 1585 1605 1610 1618 1621 1625 1628 1632 1633 1652 1669 1683 1687 1690 1697 1717 1727 1737 1754 1788 1794 1805 1826 1827 1846 1853 1892 1942 1952 1953 1957 1964 1986 1989 2001 2026 2031 2044 2051 2055 2068 2092 2095 2099 2105 2128 2138 2146 2154 2158 2160 2167 2176 2193 2198 2208 2215 2225 2274 2297 2298 2305 2314 2327 2358 2365 2372 2388 2398 2428 2441 2454 2459 2460 2463 2475 2476 2479 2484 2487 2507 2510 2511 2525 2527 2539 2540 2544 2546 2552 2562 2595 2622 2651 2658 2662 2673 2679 2693 2694 2702 2711: replace cont=iduse if iduse==X

bysort iduse: egen treated = max(treat)

gen group7=.
*treated 1 controlled 2
replace group7 = 1 if treated ~=.
replace group7 = 2 if cont ~=.

*Exploring Unmatched cases（group7==.)
quietly estpost tabstat bripreg7dummy1 bripreg7dummy2 lmonthcat4dummy1 lmonthcat4dummy2 lmonthcat4dummy3 lmonthcat4dummy4 lmonthcat4dummy5 lmonthcat4dummy6 lmonthcat4dummy7 lmonthcat4dummy8 redudummy1 redudummy2 redudummy3 redudummy4 spedudummy1 spedudummy2 spedudummy3 spedudummy4 spedudummy5 marcohortdummy1 marcohortdummy2 marcohortdummy3 marcohortdummy4 marcatdummy1 marcatdummy2 marcatdummy3 marcatdummy4 marcatdummy5 marcatdummy6 marcohortdummy1 marcohortdummy2 marcohortdummy3 marcohortdummy4 type15adummy1 type15adummy2 type15adummy3 type15adummy4 jobssm15adummy1 jobssm15adummy2 jobssm15adummy3 jobssm15adummy4 jobssm15adummy5 pld15adummy1 pld15adummy2 divdummy1 divdummy2 birthcat1dummy1 birthcat1dummy2 birthcat1dummy3 birthcat1dummy4 birthcat1dummy5 birthcat1dummy6 if group7~=. & lmonth == 1, statistics(mean sd min max) columns(statistics) 
quietly esttab . using descMatched.csv, replace main(mean) aux(sd) wide nostar unstack noobs nonote label

quietly estpost tabstat bripreg7dummy1 bripreg7dummy2 lmonthcat4dummy1 lmonthcat4dummy2 lmonthcat4dummy3 lmonthcat4dummy4 lmonthcat4dummy5 lmonthcat4dummy6 lmonthcat4dummy7 lmonthcat4dummy8 redudummy1 redudummy2 redudummy3 redudummy4 spedudummy1 spedudummy2 spedudummy3 spedudummy4 spedudummy5 marcohortdummy1 marcohortdummy2 marcohortdummy3 marcohortdummy4 marcatdummy1 marcatdummy2 marcatdummy3 marcatdummy4 marcatdummy5 marcatdummy6 marcohortdummy1 marcohortdummy2 marcohortdummy3 marcohortdummy4 type15adummy1 type15adummy2 type15adummy3 type15adummy4 jobssm15adummy1 jobssm15adummy2 jobssm15adummy3 jobssm15adummy4 jobssm15adummy5 pld15adummy1 pld15adummy2 divdummy1 divdummy2 birthcat1dummy1 birthcat1dummy2 birthcat1dummy3 birthcat1dummy4 birthcat1dummy5 birthcat1dummy6 if group7==. & lmonth == 1, statistics(mean sd min max) columns(statistics) 
quietly esttab . using descUnmatched.csv, replace main(mean) aux(sd) wide nostar unstack noobs nonote label
