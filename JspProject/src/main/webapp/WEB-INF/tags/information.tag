<%@ tag description="custom information" pageEncoding="UTF-8"%>
<%@ attribute name="title" %>
<%@ attribute name="parentDir" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<div id="information">
    <div class="flex between">
        <h1 class="main">${title}</h1>
        <div class="breadcrumb">
            <div class="sub">🍞 Home</div>
            <div class="arrow"></div>
            <div class="sub">${parentDir}</div>
            <div class="arrow"></div>
            <div class="sub">${title}</div>
        </div>
    </div>
    <div class="line"></div>
</div>