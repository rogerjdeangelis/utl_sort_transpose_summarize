# utl_sort_transpose_summarize

    ```  /* T1007040 SAS-L Using proc report to create a dataset for analysis (using across)  ```
    ```    ```
    ```     WORKING CODE  ```
    ```       WPS/SAS (It looks like WPS works, however I could not do a complete test because of 100 rec limit)  ```
    ```    ```
    ```       REPORT  ```
    ```    ```
    ```        proc report data=have nowd missing out=want(rename=(_c4_=_1993 _c5_=_1994));  ```
    ```         cols country region division year,actual yr1993_1994;  ```
    ```            define country   /group;  ```
    ```            define region    /group;  ```
    ```            define division  /group;  ```
    ```            define year      / across nozero;  ```
    ```            define actual    /sum '';  ```
    ```            define yr1993_1994 /computed 'yr1993_1994';  ```
    ```         compute yr1993_1994;  ```
    ```            yr1993_1994= _c4_ + _c5_;  ```
    ```         endcomp;  ```
    ```         break after region/summarize;  ```
    ```        run;quit;  ```
    ```    ```
    ```       CORRESP  ```
    ```    ```
    ```        SAS  ```
    ```           WPS through this ERROR: DIMENS=1 is too large for a 1 by 2 contingency table.  ```
    ```    ```
    ```        Proc Corresp Data=have Observed dimens=1  cross=row;  ```
    ```         by country region;  ```
    ```         Tables division , year;  ```
    ```         weight actual;  ```
    ```    ```
    ```  Proc report can combine 'proc sort', 'proc summary' and 'proc transpose' in  ```
    ```  one 'proc report'. For some situations 'stackodsoutput' on 'proc means/summary' can rowwise variables.  ```
    ```    ```
    ```  Using 'proc report' dataset output can reducing the possibility of being painted into a corner.  ```
    ```  This makes your analyses more flexible.  ```
    ```  I try to avoid a final report using across variables,  ```
    ```  because acroos variables are difficult to do complex formulas on(ie format cells and identify columns).  ```
    ```    ```
    ```  In the past I have used 'proc corresp to summarize data for analysis and  ```
    ```  reporting, but 'proc report' is more flexible.  ```
    ```  Report does require a minimal knowledge about your data while 'corresp' does not.  ```
    ```    ```
    ```  Unlike 'proc tabulate' the 'proc report' output dataset does honor  ```
    ```  the 'printed' output.  ```
    ```    ```
    ```    ```
    ```    ```
    ```  HAVE  ```
    ```  ===  ```
    ```    ```
    ```     SASHEL.PRDSAVE  ```
    ```    ```
    ```     Up to 40 obs WORK.HAVE total obs=1,440  ```
    ```    ```
    ```      Obs    COUNTRY    REGION    DIVISION    YEAR    ACTUAL  ```
    ```    ```
    ```        1    CANADA      EAST     CONSUMER    1993        5  ```
    ```        2    CANADA      EAST     CONSUMER    1993      164  ```
    ```        3    CANADA      EAST     CONSUMER    1993      422  ```
    ```        4    CANADA      EAST     CONSUMER    1993      424  ```
    ```        5    CANADA      EAST     CONSUMER    1993      854  ```
    ```        6    CANADA      EAST     CONSUMER    1993      168  ```
    ```        7    CANADA      EAST     CONSUMER    1993        8  ```
    ```        8    CANADA      EAST     CONSUMER    1993      748  ```
    ```        9    CANADA      EAST     CONSUMER    1993      682  ```
    ```       10    CANADA      EAST     CONSUMER    1993      300  ```
    ```       11    CANADA      EAST     CONSUMER    1993      672  ```
    ```       12    CANADA      EAST     CONSUMER    1993      894  ```
    ```       13    CANADA      EAST     CONSUMER    1993      284  ```
    ```       14    CANADA      EAST     CONSUMER    1993      705  ```
    ```    ```
    ```    ```
    ```    ```
    ```  WANT  ```
    ```  ====  ```
    ```    ```
    ```    PROC REPORT  (ods output is the same output as out= on proc report statement_  ```
    ```    ===========  ```
    ```    ```
    ```    Up to 40 obs from want total obs=18  ```
    ```    ```
    ```                                                               YR1993_  ```
    ```    Obs    COUNTRY    REGION    DIVISION     _1993    _1994      1994     _BREAK_  ```
    ```    ```
    ```      1    CANADA      EAST     CONSUMER     29474    30222      59696  ```
    ```      2    CANADA      EAST     EDUCATION    34656    33133      67789  ```
    ```      3    CANADA      EAST                  64130    63355     127485    REGION  ```
    ```    ```
    ```      4    CANADA      WEST     CONSUMER     26751    31537      58288  ```
    ```      5    CANADA      WEST     EDUCATION    30139    31078      61217  ```
    ```      6    CANADA      WEST                  56890    62615     119505    REGION  ```
    ```      7    GERMANY     EAST     CONSUMER     31248    29038      60286  ```
    ```      8    GERMANY     EAST     EDUCATION    31924    32337      64261  ```
    ```      9    GERMANY     EAST                  63172    61375     124547    REGION  ```
    ```    ```
    ```    PROC CORRESP  ```
    ```    ============  ```
    ```    ```
    ```    Up to 40 obs WORK.XPOCOR total obs=18  ```
    ```    ```
    ```    Obs    COUNTRY    REGION    TYPE         _1993    _1994      SUM  ```
    ```    ```
    ```      1    CANADA      EAST     CONSUMER     29474    30222     59696  ```
    ```      2    CANADA      EAST     EDUCATION    34656    33133     67789  ```
    ```      3    CANADA      EAST     Sum          64130    63355    127485  ```
    ```    ```
    ```      4    CANADA      WEST     CONSUMER     26751    31537     58288  ```
    ```      5    CANADA      WEST     EDUCATION    30139    31078     61217  ```
    ```      6    CANADA      WEST     Sum          56890    62615    119505  ```
    ```      ....  ```
    ```    ```
    ```    ```
    ```  *                _              _       _  ```
    ```   _ __ ___   __ _| | _____    __| | __ _| |_ __ _  ```
    ```  | '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |  ```
    ```  | | | | | | (_| |   <  __/ | (_| | (_| | || (_| |  ```
    ```  |_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|  ```
    ```  ;  ```
    ```    ```
    ```  proc sort data=sashelp.prdsale(  ```
    ```     keep=  ```
    ```         country  ```
    ```         region  ```
    ```         division  ```
    ```         year  ```
    ```         actual)  ```
    ```    out=have;  ```
    ```    by country region division year;  ```
    ```    format _all_;  ```
    ```    informat _all_;  ```
    ```  run;quit;  ```
    ```    ```
    ```  *                                                                _  ```
    ```  __      ___ __  ___   ___  __ _ ___    _ __ ___ _ __   ___  _ __| |_  ```
    ```  \ \ /\ / / '_ \/ __| / __|/ _` / __|  | '__/ _ \ '_ \ / _ \| '__| __|  ```
    ```   \ V  V /| |_) \__ \ \__ \ (_| \__ \  | | |  __/ |_) | (_) | |  | |_  ```
    ```    \_/\_/ | .__/|___/ |___/\__,_|___/  |_|  \___| .__/ \___/|_|   \__|  ```
    ```           |_|                                   |_|  ```
    ```  ;  ```
    ```    ```
    ```    ```
    ```  %utl_submit_wps64('  ```
    ```  libname wrk sas7bdat "%sysfunc(pathname(work))";  ```
    ```  proc report data=wrk.have nowd missing out=want(rename=(_c4_=_1993 _c5_=_1994));  ```
    ```  cols country region division year,actual yr1993_1994;  ```
    ```  define country   /group;  ```
    ```  define region    /group;  ```
    ```  define division  /group;  ```
    ```  define year      / across nozero;  ```
    ```  define actual    /sum "";  ```
    ```  define yr1993_1994 /computed "yr1993_1994";  ```
    ```  compute yr1993_1994;  ```
    ```     yr1993_1994= _c4_ + _c5_;  ```
    ```  endcomp;  ```
    ```  break after region/summarize;  ```
    ```  run;quit;  ```
    ```  ');  ```
    ```    ```
    ```    ```
    ```  *  ```
    ```   ___  __ _ ___    ___ ___  _ __ _ __ ___  ___ _ __  ```
    ```  / __|/ _` / __|  / __/ _ \| '__| '__/ _ \/ __| '_ \  ```
    ```  \__ \ (_| \__ \ | (_| (_) | |  | | |  __/\__ \ |_) |  ```
    ```  |___/\__,_|___/  \___\___/|_|  |_|  \___||___/ .__/  ```
    ```  ;  ```
    ```    ```
    ```    ```
    ```  Ods Exclude All;  ```
    ```  Ods Output Observed=xpocor(Rename=Label=type);  ```
    ```  Proc Corresp Data=have Observed dimens=1  cross=row;  ```
    ```  by country region;  ```
    ```     Tables division , year;  ```
    ```     weight actual;  ```
    ```  Run;quit;  ```
    ```  Ods Select All;  ```
    ```    ```
