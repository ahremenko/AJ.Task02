package by.st.ahremenko.command;

import by.st.ahremenko.bean.DateValidator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;



@Controller
@RequestMapping("/")
public class LoginCommand {

    @Value("${build.version}")
    public String projectVersion;

    @RequestMapping("loginPage/checkAge")
    public String execute(@RequestParam(value = "birthday", required = false) String enteredDate, Model model){
        StringBuffer msg = new StringBuffer(200 );

        if (DateValidator.isDateValid(enteredDate,"dd.MM.yyyy")) {
            msg.append("You are " + DateValidator.getAge(enteredDate,"dd.MM.yyyy") + "years old.");
        }
        else if (DateValidator.isDateValid(enteredDate,"yyyy-MM-dd")) {
            msg.append("You are " + DateValidator.getAge(enteredDate,"yyyy-MM-dd") + " years old.");
        }
        else {
            msg.append("Valid formats is: dd.MM.yyyy or yyyy-MM-dd!");
        }
        model.addAttribute("message", msg.toString());
        model.addAttribute("footerText", "Current date: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss.SSS")) );
        model.addAttribute("versionText", "Version:" + projectVersion );
        return "check-age";
    }

    @RequestMapping("loginPage/about")
    public String goToAboutPage(Model model) {

          model.addAttribute("versionText", "Version:" + projectVersion );
        return "about";
    }
}