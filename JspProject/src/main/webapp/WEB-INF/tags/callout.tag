<%@ tag description="custom callout" pageEncoding="UTF-8"%>
<%@ attribute name="emoji" %>
<%@ attribute name="description" %>
<%@ attribute name="color" %>

<div class="callout ${color}">
    <p>${not empty emoji ? emoji : '📌'}</p>
    <p>${description}</p>
</div>