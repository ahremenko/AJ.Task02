package by.st.ahremenko.staffjobs.service;

import static org.junit.Assert.*;
import by.st.ahremenko.staffjobs.service.exception.ServiceException;
import org.junit.Test;

public class DateValidatorTest extends DateValidator {

	@Test
	public void stringChecker() throws ServiceException {
		assertTrue(DateValidator.isDateValid("30.09.2018"));
		assertTrue(DateValidator.isDateValid("30/09/2018"));
		assertTrue(DateValidator.isDateValid("2018-12-31"));
		assertTrue(DateValidator.isDateValid("30/09/18"));
		//assertTrue(!DateValidator.isDateValid("30:09:2018"));
		//assertTrue(!DateValidator.isDateValid("30092018"));
		//assertTrue(!(DateValidator.isDateValid("14.12.2018")));
	}

	@Test
	public void ageChecker() throws ServiceException {
		assertTrue((DateValidator.getAge("10.09.2000")==18));
		assertTrue(!(DateValidator.getAge("10.09.2000")==20));
	}

}