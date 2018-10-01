<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<tiles:insertDefinition name="check-age">
    <tiles:putAttribute name="body">
        <div id="data">
            <form action="checkAge" method="get">
                <h2><spring:message code="label.are_you_18"/></h2> <!-- spring:message code="label.are_you_18"/ -->
                <br>
                Your BirthDay: <input type="text" name="birthday" placeholder="DD.MM.YYYY" />
                <input type="submit" value=" <spring:message code="button.send" />"/>
                <br>
                    ${messageText}
                <div id="error">${errorMessage}</div>
                <br>
            </form>
        </div>
    </tiles:putAttribute>
</tiles:insertDefinition>




