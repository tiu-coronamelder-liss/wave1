* Encoding: UTF-8.
* This script produces output to check the data and outcomes in the report. 
* Open data.
GET
  FILE='C:\Surfdrive\Temp\L_CoronaMelder_wave1_3p.sav'.
DATASET NAME DataSet2 WINDOW=FRONT.

* Remove the 10 participants for which data was not complete.


* Get frequencies of demographics.
FREQUENCIES VARIABLES=geslacht leeftijd lftdcat burgstat sted nettocat oplmet
  /ORDER=ANALYSIS.


EXAMINE VARIABLES=geslacht leeftijd lftdcat burgstat sted nettocat oplmet BY Behavior_UTAUT
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.


