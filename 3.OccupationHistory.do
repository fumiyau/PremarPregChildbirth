*This syntax is checked by the author (Fumiya Uchikoshi), but based on the file shared by Ryota Mugiyama
/* Employement dummy*/
gen jobstst2 = 0
recode jobstst2 0=1 if jobst1 <= length & length <= joben1 & joben1 ~=. & jobst1 ~=. 
recode jobstst2 0=1 if jobst2 <= length & length <= joben2 & joben2 ~=. & jobst2 ~=.
recode jobstst2 0=1 if jobst3 <= length & length <= joben3 & joben3 ~=. & jobst3 ~=.
recode jobstst2 0=1 if jobst4 <= length & length <= joben4 & joben4 ~=. & jobst4 ~=.
recode jobstst2 0=1 if jobst5 <= length & length <= joben5 & joben5 ~=. & jobst5 ~=.
recode jobstst2 0=1 if jobst6 <= length & length <= joben6 & joben6 ~=. & jobst6 ~=.
recode jobstst2 0=1 if jobst7 <= length & length <= joben7 & joben7 ~=. & jobst7 ~=.
recode jobstst2 0=1 if jobst8 <= length & length <= joben8 & joben8 ~=. & jobst8 ~=.
recode jobstst2 0=1 if jobst9 <= length & length <= joben9 & joben9 ~=. & jobst9 ~=.

/*Tenure*/
bysort id: gen tenure1 = length - jobst1 + 1 if jobstst2 == 1 & joben1 >= length & jobst1 <= length & joben1 ~=. & jobst1 ~=. 
bysort id: gen tenure2 = length - jobst2  if jobstst2 == 1 & joben2 >= length & jobst2 < length & joben2 ~=. & jobst2 ~=. 
bysort id: gen tenure3 = length - jobst3  if jobstst2 == 1 & joben3 >= length & jobst3 < length & joben3 ~=. & jobst3 ~=. 
bysort id: gen tenure4 = length - jobst4  if jobstst2 == 1 & joben4 >= length & jobst4 < length & joben4 ~=. & jobst4 ~=. 
bysort id: gen tenure5 = length - jobst5  if jobstst2 == 1 & joben5 >= length & jobst5 < length & joben5 ~=. & jobst5 ~=. 
bysort id: gen tenure6 = length - jobst6  if jobstst2 == 1 & joben6 >= length & jobst6 < length & joben6 ~=. & jobst6 ~=. 
bysort id: gen tenure7 = length - jobst7  if jobstst2 == 1 & joben7 >= length & jobst7 < length & joben7 ~=. & jobst7 ~=. 
bysort id: gen tenure8 = length - jobst8  if jobstst2 == 1 & joben8 >= length & jobst8 < length & joben8 ~=. & jobst8 ~=. 
bysort id: gen tenure9 = length - jobst9  if jobstst2 == 1 & joben9 >= length & jobst9 < length & joben9 ~=. & jobst9 ~=. 

gen tenure = .
replace tenure = tenure1 if jobstst2 == 1 & joben1 >= length & jobst1 <= length & joben1 ~=. & jobst1 ~=.  
replace tenure = tenure2 if jobstst2 == 1 & joben2 >= length & jobst2 < length  & joben2 ~=. & jobst2 ~=. 
replace tenure = tenure3 if jobstst2 == 1 & joben3 >= length & jobst3 < length  & joben3 ~=. & jobst3 ~=. 
replace tenure = tenure4 if jobstst2 == 1 & joben4 >= length & jobst4 < length  & joben4 ~=. & jobst4 ~=. 
replace tenure = tenure5 if jobstst2 == 1 & joben5 >= length & jobst5 < length  & joben5 ~=. & jobst5 ~=. 
replace tenure = tenure6 if jobstst2 == 1 & joben6 >= length & jobst6 < length  & joben6 ~=. & jobst6 ~=. 
replace tenure = tenure7 if jobstst2 == 1 & joben7 >= length & jobst7 < length  & joben7 ~=. & jobst7 ~=. 
replace tenure = tenure8 if jobstst2 == 1 & joben8 >= length & jobst8 < length  & joben8 ~=. & jobst8 ~=. 
replace tenure = tenure9 if jobstst2 == 1 & joben9 >= length & jobst9 < length  & joben9 ~=. & jobst9 ~=. 
 
/*Tenure categories*/
gen tencat = tenure 
recode tencat 1/12=1 13/36=2 37/60 = 3 61/120=4 121/311=5
recode tencat .=1
*Employment status
gen type = 0
replace type = type1 if jobstst2 == 1 & jobst1 <= length & length <= joben1
replace type = type2 if jobstst2 == 1 & jobst2 < length & length <= joben2
replace type = type3 if jobstst2 == 1 & jobst3 < length & length <= joben3
replace type = type4 if jobstst2 == 1 & jobst4 < length & length <= joben4
replace type = type5 if jobstst2 == 1 & jobst5 < length & length <= joben5
replace type = type6 if jobstst2 == 1 & jobst6 < length & length <= joben6
replace type = type7 if jobstst2 == 1 & jobst7 < length & length <= joben7
replace type = type8 if jobstst2 == 1 & jobst8 < length & length <= joben8
replace type = type9 if jobstst2 == 1 & jobst9 < length & length <= joben9 
*Occupation
gen jobssm = 0
replace jobssm = jobssm1 if jobstst2 == 1 & jobst1 <= length & length <= joben1
replace jobssm = jobssm2 if jobstst2 == 1 & jobst2 < length & length <= joben2
replace jobssm = jobssm3 if jobstst2 == 1 & jobst3 < length & length <= joben3
replace jobssm = jobssm4 if jobstst2 == 1 & jobst4 < length & length <= joben4
replace jobssm = jobssm5 if jobstst2 == 1 & jobst5 < length & length <= joben5
replace jobssm = jobssm6 if jobstst2 == 1 & jobst6 < length & length <= joben6
replace jobssm = jobssm7 if jobstst2 == 1 & jobst7 < length & length <= joben7
replace jobssm = jobssm8 if jobstst2 == 1 & jobst8 < length & length <= joben8
replace jobssm = jobssm9 if jobstst2 == 1 & jobst9 < length & length <= joben9 

recode type (1/2=1) (3/5=2) (6/7=3) (0=4)
