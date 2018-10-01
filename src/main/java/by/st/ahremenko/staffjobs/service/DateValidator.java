package by.st.ahremenko.staffjobs.service;

import by.st.ahremenko.staffjobs.service.exception.ServiceException;
import org.apache.log4j.Logger;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateValidator {
    public static String[] validPatterns = {"dd.MM.yyyy","dd/MM/yyyy","dd-MM-yyyy","dd/mm/yy","yyyy-MM-dd"};
    private static String validDatePattern;
    private static final Logger logger = Logger.getLogger(DateValidator.class);

    public static boolean isDateValid(String value) {

        if (value == null )
            return false;
        String validDatePattern = getValidDatePattern(value);
        if ( validDatePattern == null ) {
            return false;
        }
        return true;
    }

    private static String getValidDatePattern (String value) {
        // returns valid pattern which may be used for convert string to date
        SimpleDateFormat formatter = new SimpleDateFormat();
        for (int i=0; i<validPatterns.length;i++) {
            try {
                formatter.applyPattern(validPatterns[i]);
                formatter.setLenient(false);
                formatter.parse(value);
                validDatePattern = validPatterns[i];
            } catch (ParseException e) {
                // nothing to do
            }
        }
        return validDatePattern;
    }

    public static Integer getAge(String value) throws ServiceException {
        // returns age in years (calculates ceil number of years between sysdate and value
        validDatePattern = getValidDatePattern(value);
        SimpleDateFormat formatter = new SimpleDateFormat(validDatePattern);
        if (validDatePattern == null) throw new ServiceException("String cannot be converted to date");
        try {
            Date userBD = formatter.parse(value);
            Calendar dob = Calendar.getInstance();
            Calendar today = Calendar.getInstance();
            dob.setTime(userBD);
            if (dob.get(Calendar.YEAR) < 1900) dob.add(Calendar.YEAR, 1900);
            dob.add(Calendar.DAY_OF_MONTH, -1);
            int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);
            if (age<0) {
                throw new ServiceException("The date cannot be more than today");
            }
            if (today.get(Calendar.DAY_OF_YEAR) <= dob.get(Calendar.DAY_OF_YEAR)) {
                age--;
            }
            return age;
        } catch (Exception e) {
            // Something went wrong
            throw new ServiceException(e.getMessage());
        }
    }

    public static Integer getDaysUntilBD(String value) throws ServiceException {
        // returns age in years (calculates ceil number of years between sysdate and value
        SimpleDateFormat format = new SimpleDateFormat();
        validDatePattern = getValidDatePattern(value);
        format.applyPattern(validDatePattern);
        logger.info("For " + value + " pattern: " + validDatePattern);
        if (validDatePattern == null) throw new ServiceException("String cannot be converted to date");
        try {
            Date userBD = format.parse(value);
            Calendar dob = Calendar.getInstance();
            Calendar today = Calendar.getInstance();
            int age = getAge(value);
            dob.setTime(userBD);
            if (dob.get(Calendar.YEAR) < 1900) dob.add(Calendar.YEAR, 1900);
            dob.add(Calendar.YEAR, age + 1);
            //logger.info("Last BD was: " + dob.get(Calendar.DAY_OF_MONTH) + "." + dob.get(Calendar.MONTH) + "." + dob.get(Calendar.YEAR));
            long milliseconds = dob.getTimeInMillis() - today.getTimeInMillis();
            int daysBeforeNextBD = (int) (milliseconds / (24 * 60 * 60 * 1000));
            return daysBeforeNextBD;
        } catch (Exception e) {
            // Something went wrong
            throw new ServiceException(e.getMessage());
        }
    }

}
