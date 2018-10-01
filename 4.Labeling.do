/*Labeling*/
label values type typel
label variable type   "Job status (ref: Standard)"
label variable bripreg   "Premarital pregnancy"
label variable bripreg7   "Premarital pregnancy"
label variable bripreg9   "Premarital pregnancy"
label values bripreg bripregl
label define edul 0"Educational attainment (ref: high school)"1"Junior high school"2"High school"3"Junior/two year colleges"4"University and more"6"Unknown"  , replace
label define eduls 0"Spouse's Educational attainment (ref: high school)"1"Junior high school"2"High school"3"Junior/two year colleges"4"University and more"6"Unknown"  , replace
label define cohortl 0"Birth cohort (ref: 1966-1970)"1"1966-1970" 2"1971-1975" 3"1976-1980",replace
label define marcatl 0"Age at first marriage (ref: 29-31)"1"16-22"2"23-25"3"26-28"4"29-31"5"32-34"6"> 35",replace
label define birthcatl1 0"Age at first birth (ref: 29-31)"1"16-22"2"23-25"3"26-28"4"29-31"5"32-34"6"> 35",replace
label define birthcatl2 0"Age at second birth (ref: 29-31)"1"16-22"2"23-25"3"26-28"4"29-31"5"32-34"6"> 35",replace
label define birthcatl3 0"Age at third birth (ref: 29-31)"1"16-22"2"23-25"3"26-28"4"29-31"5"32-34"6"> 35",replace
label define marcohortl 0"Year at marriage" 1"1985-1994" 2"1995-1999" 3"2000-2004" 4"2005-2009"
label define typel 0"Employment status at first job (ref: Standard)"1"Standard"2"Non-standard"3"Self-employed"4"Non-employed",replace
label define jobl 0"Occupation at first job (ref: Upper non-manual)"1"Upper non-manual"2"Lower non-manual"3"Upper manual"4"Lower manual"5"Non-employed",replace
label define typel15 0"Employment status 18 months ago (ref: Standard)"1"Standard"2"Non-standard"3"Self-employed"4"Non-employed",replace
label define jobl15 0"Occupation  18 months ago (ref: Upper non-manual)"1"Upper non-manual"2"Lower non-manual"3"Upper manual"4"Lower manual"5"Non-employed",replace

label values redu edul
label values spedu eduls
label values cohort cohortl
label values marcat marcatl
label values type1 typel
label values jobssm1 jobl
label values type15a typel15
label values jobssm15a jobl15
label values birthcat1 birthcatl1
label values birthcat2 birthcatl2
label values birthcat3 birthcatl3
label values marcohort marcohortl
label variable div   "Divorced"
label variable redu   "Respondent's educatinal attainment (ref: junior high)"
label variable spedu   "Spouse's educatinal attainment (ref: junior high)"
label variable cohort   "Birth cohort (ref: 1966-1970)"
label variable marcat   "Age at marriage (ref: 29-31)"
label variable lmonth   "Month at risk"
label variable birthage1   "Age at first birth"
label variable birthage2   "Age at second birth"
label variable pld15a   "Leaving parental home"
