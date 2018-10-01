package by.st.ahremenko.staffjobs.controller;

import by.st.ahremenko.staffjobs.service.StaffJobsService;
import by.st.ahremenko.staffjobs.service.exception.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import org.apache.log4j.Logger;


@Controller
@RequestMapping("/")
public class LoginCommand {

    @Value("${build.version}")
    public String projectVersion;

    @Autowired
    private StaffJobsService staffJobsService;

    private static final Logger logger = Logger.getLogger(LoginCommand.class);

    @RequestMapping(path = {"/checkAge", "/"})
    public String goToCheckAge(@RequestParam(value = "birthday", required = false) String enteredDate, Model model){
        logger.info("Show /checkAge...");
        StringBuffer msg = new StringBuffer(500 );
        try {
            if ( "".equals(enteredDate) || enteredDate== null) throw new ServiceException("");
            if (staffJobsService.isDateValid(enteredDate)) {
                msg.append("Entered date: " + enteredDate);
                msg.append(" You are " + staffJobsService.getAge(enteredDate) + " years old. ");
                msg.append("There is " + staffJobsService.getDaysUntilBD(enteredDate) + " days before your next birthday.");
                model.addAttribute("messageText", msg.toString());
            } else {
                model.addAttribute("errorMessage", "Unsupported date format" );
            }
        } catch (ServiceException e) {
                model.addAttribute("errorMessage", e.getMessage() );
        } finally {
                model.addAttribute("footerText", "Current date: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss.SSS")) + ". App version " + projectVersion + ".");
        }
        return "check-age";
    }

    @RequestMapping("/about")
    public String goToAboutPage(Model model) {
        logger.info("Show /about...");
        model.addAttribute("footerText", "Current date: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss.SSS")) + ". App version " + projectVersion + ".");
        return "about";
    }
}