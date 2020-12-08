* Encoding: UTF-8.
* This script produces output to check the data and outcomes in the report. 
* Open data.
GET
  FILE='C:\Surfdrive\Temp\L_CoronaMelder_wave1_3p.sav'.
DATASET NAME DataSet2 WINDOW=FRONT.

* Remove the 10 participants for which data was not complete.
USE ALL.
COMPUTE filter_$=( ~ SYSMIS(duur)).
VARIABLE LABELS filter_$ ' ~ SYSMIS(duur) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Create new variable user status to check the R script. 
* Check user status finegrained.
compute user_status_intention = 1. 
if (Behavior_UTAUT = 1) user_status_intention = 1.
if((Behavior_UTAUT =3) & ((BI1a_UTAUT = 1) | (BI1a_UTAUT = 2) | (BI1a_UTAUT = 3))) user_status_intention = 2.
if (Behavior_UTAUT =3) & ((BI1a_UTAUT = 4)) user_status_intention = 3.
if (Behavior_UTAUT =3) & ((BI1a_UTAUT = 5) | (BI1a_UTAUT = 6) | (BI1a_UTAUT = 7)) user_status_intention = 4.
if (Behavior_UTAUT =4) user_status_intention = 5.
execute.

value labels user_status_intention 
1 'Gebruiker'
2 'Nooit gebruikt en niet van plan'
3 'Nooit gebruikt en neutraal'
4 'Nooit gebruikt en wel van plan'
5 'Voormalig gebruiker'.
execute.

* Demographics.
FREQUENCIES VARIABLES=geslacht lftdcat sted belbezig burgstat nettocat oplmet woonvorm Riskgroup_contact
  /ORDER=ANALYSIS.

* Health motivation.
FREQUENCIES VARIABLES=CoronaInfectionSelf CoronaInfectionSelfTest CoronaInfectionSelfTest_1 CoronaInfectionSelfTest_2 
 /ORDER=ANALYSIS.

FREQUENCIES VARIABLES= HBM_PSus_self1 HBM_PSev_other2 
 /ORDER=ANALYSIS.

* Adherence general behavioral measures.
FREQUENCIES VARIABLES= Intention_AdherenceGeneralMeasures_quarantaine Behavior_AdherenceGeneralMeasures_handwashing Corona_complaints Behavior_AdherenceGeneralMeasures_quarantaine
 /ORDER=ANALYSIS.

* Conspiracy theories and trust government.
FREQUENCIES VARIABLES= Beliefs_Conspiracy2 Beliefs_TrustGovernment
 /ORDER=ANALYSIS.

* Awareness.
FREQUENCIES VARIABLES= Awareness
 /ORDER=ANALYSIS.

* Use and intention. 
FREQUENCIES VARIABLES= Behavior_UTAUT BI1a_UTAUT BI1b_UTAUT
 /ORDER=ANALYSIS.

* Use and intention. 
FREQUENCIES VARIABLES= Behavior_UTAUT BI1b_UTAUT
 /ORDER=ANALYSIS.

* CheckBI1a_UTAUT for only never users.  
USE ALL.
COMPUTE filter_$=( ~ SYSMIS(duur)  & (Behavior_UTAUT = 3)).
VARIABLE LABELS filter_$ ' ~ SYSMIS(duur)  & (Behavior_UTAUT = 3) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

FREQUENCIES VARIABLES= Behavior_UTAUT BI1a_UTAUT 
 /ORDER=ANALYSIS.

* For all checks with users vs non users: select only the current and never users and split by  Behavior_UTAUT.
USE ALL.
COMPUTE filter_$=( ~ SYSMIS(duur)  & (Behavior_UTAUT ~= 2)).
VARIABLE LABELS filter_$ ' ~ SYSMIS(duur)  & (Behavior_UTAUT ~= 2) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

CROSSTABS
  /TABLES=geslacht lftdcat sted belbezig burgstat nettocat oplmet woonvorm Riskgroup_contact BY Behavior_UTAUT
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

* Check user status health motivation / suscep / severity.
CROSSTABS
  /TABLES=HBM_PSus_self1 HBM_PSus_other2 BY Behavior_UTAUT
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

* Check user status adherence to general measures. 
CROSSTABS
  /TABLES= Intention_AdherenceGeneralMeasures_handwashing Behavior_AdherenceGeneralMeasures_avoidbusyplaces BY Behavior_UTAUT
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

* Check user status general statements conspiracy trust. 
CROSSTABS
  /TABLES= Beliefs_Conspiracy2 Beliefs_TrustGovernment BY Behavior_UTAUT
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

* Use all 1900 again. 
USE ALL.
COMPUTE filter_$=( ~ SYSMIS(duur)).
VARIABLE LABELS filter_$ ' ~ SYSMIS(duur) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
CROSSTABS
  /TABLES= Beliefs_Conspiracy2 Beliefs_TrustGovernment BY user_status_intention 
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

* Expected use and value of the CoronaMelder.
FREQUENCIES VARIABLES= PE1_UTAUT Beliefs_ResponseefficasyOther
 /ORDER=ANALYSIS.
CROSSTABS
  /TABLES= PE1_UTAUT BY Behavior_UTAUT
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES= PE1_UTAUT BY user_status_intention 
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

* Expected use and value of the CoronaMelder.
FREQUENCIES VARIABLES= PE1_UTAUT Beliefs_ResponseefficasyOther
 /ORDER=ANALYSIS.
CROSSTABS
  /TABLES= PE1_UTAUT BY Behavior_UTAUT
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES= PE1_UTAUT BY user_status_intention 
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

* Adequacy of technology and societal effects.
FREQUENCIES VARIABLES= Beliefs_technologyperformance Beliefs_benefiteconomic
 /ORDER=ANALYSIS.
CROSSTABS
  /TABLES= Beliefs_technologyperformance Beliefs_benefiteconomic BY Behavior_UTAUT
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES= Beliefs_technologyperformance Beliefs_benefiteconomic BY user_status_intention 
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

* Self efficacy and effort expectancy. 
* Check EE vars for only non users.
USE ALL.
COMPUTE filter_$=( ~ SYSMIS(duur)  & (Behavior_UTAUT = 3)).
VARIABLE LABELS filter_$ ' ~ SYSMIS(duur)  & (Behavior_UTAUT = 3) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

FREQUENCIES VARIABLES= EE1b_UTAUT EE1b_UTAUT EE2b_UTAUT
 /ORDER=ANALYSIS.

* Check EE for only users.
USE ALL.
COMPUTE filter_$=( ~ SYSMIS(duur)  & (Behavior_UTAUT = 1)).
VARIABLE LABELS filter_$ ' ~ SYSMIS(duur)  & (Behavior_UTAUT = 3) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

FREQUENCIES VARIABLES= EE1a_UTAUT EE2a_UTAUT EE1b_UTAUT EE2b_UTAUT
 /ORDER=ANALYSIS.

* SElf efficasy.
* Use all 1900 again. 
USE ALL.
COMPUTE filter_$=( ~ SYSMIS(duur)).
VARIABLE LABELS filter_$ ' ~ SYSMIS(duur) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES= HBM_selfefficacy_CoronaMelder
 /ORDER=ANALYSIS.

* Tech related barriers. 
* Use all 1900 again. 
USE ALL.
COMPUTE filter_$=( ~ SYSMIS(duur)).
VARIABLE LABELS filter_$ ' ~ SYSMIS(duur) (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
FREQUENCIES VARIABLES=  FC1_UTAUT FC2_UTAUT HBM_barriers_CoronaMelder
 /ORDER=ANALYSIS.

CROSSTABS
  /TABLES= FC1_UTAUT FC2_UTAUT HBM_barriers_CoronaMelder BY Behavior_UTAUT
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES= FC1_UTAUT FC2_UTAUT HBM_barriers_CoronaMelder BY user_status_intention 
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW COLUMN 
  /COUNT ROUND CELL.

* 
