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


