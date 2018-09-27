package by.st.ahremenko.bean;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateValidator {

    public static boolean isDateValid(String value, String datePattern) {

        if (value == null || datePattern == null || datePattern.length() <= 0) {
            return false;
        }

        
        SimpleDateFormat formatter = new SimpleDateFormat(datePattern);
        formatter.setLenient(false);

        try {
            formatter.parse(value);
        } catch (ParseException e) {
            return false;
        }
        return true;
    }

    public static Integer getAge(String value, String datePattern) {
        SimpleDateFormat format = new SimpleDateFormat();
        format.applyPattern(datePattern);
        try {
            Date userBD = format.parse(value);
            Calendar dob = Calendar.getInstance();
            Calendar today = Calendar.getInstance();
            dob.setTime(userBD);
            dob.add(Calendar.DAY_OF_MONTH, -1);
            int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);
            if (age<0) {
                return null;
            }
            if (today.get(Calendar.DAY_OF_YEAR) <= dob.get(Calendar.DAY_OF_YEAR)) {
                age--;
            }
            return age;
        } catch (Exception e) {
            // Something went wrong
        }
        return null;
    }
}
