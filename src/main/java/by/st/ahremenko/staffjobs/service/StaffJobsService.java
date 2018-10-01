package by.st.ahremenko.staffjobs.service;

import by.st.ahremenko.staffjobs.service.exception.ServiceException;

public interface StaffJobsService {

	public boolean isDateValid(String pDate) throws ServiceException;
	
	public int getAge(String pDate) throws ServiceException;

	public int getDaysUntilBD(String pDate) throws ServiceException;
	
}