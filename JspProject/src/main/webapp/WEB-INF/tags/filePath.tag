<%@ tag description="custom information" pageEncoding="UTF-8"%>
<%@ attribute name="dir1" %>
<%@ attribute name="dir2" %>
<%@ attribute name="dir3" %>
<%@ attribute name="dir4" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<div id="filePath" class="mt-20">
    <div class="breadcrumb">
        <div class="sub">📁 ${dir1}</div>
        <c:if test="${ not empty dir2 }">
            <div class="slash">/</div>
            <div class="sub">${dir2}</div>
        </c:if>
        <c:if test="${ not empty dir3 }">
            <div class="slash">/</div>
            <div class="sub">${dir3}</div>
        </c:if>
        <c:if test="${ not empty dir4 }">
            <div class="slash">/</div>
            <div class="sub">${dir4}</div>
        </c:if>
    </div>
</div>