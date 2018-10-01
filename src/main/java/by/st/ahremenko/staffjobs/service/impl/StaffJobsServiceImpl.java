package by.st.ahremenko.staffjobs.service.impl;

import by.st.ahremenko.staffjobs.service.StaffJobsService;
import by.st.ahremenko.staffjobs.service.exception.ServiceException;
import by.st.ahremenko.staffjobs.service.DateValidator;
import org.springframework.stereotype.Service;
import org.apache.log4j.Logger;


@Service
public class StaffJobsServiceImpl implements StaffJobsService {

    private static final Logger logger = Logger.getLogger(StaffJobsServiceImpl.class);

    @Override
    public boolean isDateValid(String pDate) throws ServiceException {
        return DateValidator.isDateValid(pDate);
    }

    @Override
    public int getAge(String pDate) throws ServiceException{
        return DateValidator.getAge(pDate);
    }

    @Override
    public int getDaysUntilBD(String pDate) throws ServiceException{
        return DateValidator.getDaysUntilBD(pDate);
    }


}
