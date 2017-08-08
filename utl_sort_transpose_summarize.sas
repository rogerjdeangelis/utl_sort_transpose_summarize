
*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|
;

proc sort data=sashelp.prdsale(
   keep=
       country
       region
       division
       year
       actual)
  out=have;
  by country region division year;
  format _all_;
  informat _all_;
run;quit;

*                                                                _
__      ___ __  ___   ___  __ _ ___    _ __ ___ _ __   ___  _ __| |_
\ \ /\ / / '_ \/ __| / __|/ _` / __|  | '__/ _ \ '_ \ / _ \| '__| __|
 \ V  V /| |_) \__ \ \__ \ (_| \__ \  | | |  __/ |_) | (_) | |  | |_
  \_/\_/ | .__/|___/ |___/\__,_|___/  |_|  \___| .__/ \___/|_|   \__|
         |_|                                   |_|
;


%utl_submit_wps64('
libname wrk sas7bdat "%sysfunc(pathname(work))";
proc report data=wrk.have nowd missing out=want(rename=(_c4_=_1993 _c5_=_1994));
cols country region division year,actual yr1993_1994;
define country   /group;
define region    /group;
define division  /group;
define year      / across nozero;
define actual    /sum "";
define yr1993_1994 /computed "yr1993_1994";
compute yr1993_1994;
   yr1993_1994= _c4_ + _c5_;
endcomp;
break after region/summarize;
run;quit;
');


*
 ___  __ _ ___    ___ ___  _ __ _ __ ___  ___ _ __
/ __|/ _` / __|  / __/ _ \| '__| '__/ _ \/ __| '_ \
\__ \ (_| \__ \ | (_| (_) | |  | | |  __/\__ \ |_) |
|___/\__,_|___/  \___\___/|_|  |_|  \___||___/ .__/
;


Ods Exclude All;
Ods Output Observed=xpocor(Rename=Label=type);
Proc Corresp Data=have Observed dimens=1  cross=row;
by country region;
   Tables division , year;
   weight actual;
Run;quit;
Ods Select All;



