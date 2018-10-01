<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<tiles:insertDefinition name="about">
	<tiles:putAttribute name="body">
        <div id="data">
             This is simple web-application can ask your date of birth and check your age only.
        </div>
    </tiles:putAttribute>
</tiles:insertDefinition>
