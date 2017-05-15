    /*begin set price of rental in transactions table*/ 
   SELECT rentalDate
   INTO rentStart
   FROM Transactions
   WHERE rental_ID=NEW.rental_ID;
   
    SELECT dueDate
   INTO rentEnd
   FROM Transactions
   WHERE rental_ID=NEW.rental_ID; 
   
   SET endYear = (rentEnd%20000000) DIV 10000; 
   SET startYear = (rentStart%20000000) DIV 10000;
   
   SET endMonths = ((rentEnd%20000000)%10000) DIV 100 ; /*months since beginning of year*/
   SET startMonths = ((rentStart%20000000)%10000) DIV 100; /*months since beginning of year*/
   
   SET endYear = 365*endYear; /*days since 2000*/
   SET startYear = 365*startYear;/*days since 2000*/
   
   SET endDays = (((rentEnd%20000000)%10000))%100 ; /*days since beginning of month*/
   SET startDays = (((rentStart%20000000)%10000))%100 ;/*days since beginning of month*/
   
  
    CASE endMonths
		WHEN 1 THEN SET rentEnd=endDays+endYear;
		WHEN 2 THEN SET rentEnd=31+endDays+endYear;
		WHEN 3 THEN SET rentEnd=59+endDays+endYear;
		WHEN 4 THEN SET rentEnd=90+endDays+endYear;
        WHEN 5 THEN SET rentEnd=120+endDays+endYear;
        WHEN 6 THEN SET rentEnd=151+endDays+endYear;
        WHEN 7 THEN SET rentEnd=181+endDays+endYear;
        WHEN 8 THEN SET rentEnd=212+endDays+endYear;
        WHEN 9 THEN SET rentEnd=243+endDays+endYear;
        WHEN 10 THEN SET rentEnd=273+endDays+endYear;
        WHEN 11 THEN SET rentEnd=304+endDays+endYear;
        WHEN 12 THEN SET rentEnd=334+endDays+endYear;
	END CASE;
    
     CASE startMonths
		WHEN 1 THEN SET rentStart=startDays+startYear;
		WHEN 2 THEN SET rentStart=31+startDays+startYear;
		WHEN 3 THEN SET rentStart=59+startDays+startYear;
		WHEN 4 THEN SET rentStart=90+startDays+startYear;
        WHEN 5 THEN SET rentStart=120+startDays+startYear;
        WHEN 6 THEN SET rentStart=151+startDays+startYear;
        WHEN 7 THEN SET rentStart=181+startDays+startYear;
        WHEN 8 THEN SET rentStart=212+startDays+startYear;
        WHEN 9 THEN SET rentStart=243+startDays+startYear;
        WHEN 10 THEN SET rentStart=273+startDays+startYear;
        WHEN 11 THEN SET rentStart=304+startDays+startYear;
        WHEN 12 THEN SET rentStart=334+startDays+startYear;
	END CASE;
  
SET rentalPeriod = rentEnd - rentStart;
   
   UPDATE Transactions
   SET totalPrice = rentSubtot*rentalPeriod
   WHERE rental_ID = new.rental_ID;
   