<html>
<body>
<h2>Are you 18+?</h2>
<br>
<form action="loginPage/checkAge" method="get">
    Your BirthDay: <input type="text" name="birthday" placeholder="DD.MM.YYYY" />
    <input type="submit" value="Sure!"/>
</form>
<br>
${message}
<br>
<a href="/loginPage/about">About</a>
<br>
<img src="${pageContext.request.contextPath}/resources/images/logo.jpg"/>
<br>
${footerText}
<br>
${versionText}
</body>
</html>