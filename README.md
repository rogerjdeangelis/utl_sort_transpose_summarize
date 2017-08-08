# utl_sort_transpose_summarize

    ```  How to the sort, transpose and summarize in one procedure (proc report - across)  ```
    ```    ```
    ```     WORKING CODE  ```
    ```    ```
    ```       WPS/SAS  (It looks like WPS works, however I could not do a complete test because of 100 rec limit)  ```
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
