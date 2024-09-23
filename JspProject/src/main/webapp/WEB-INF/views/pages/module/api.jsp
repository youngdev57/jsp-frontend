<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="api" class="guide-container">
    <t:information title="API Module" parentDir="Modules" />
    <t:callout description="Api 통신을 위한 모듈입니다." />
    <t:filePath dir1="resources" dir2="js" dir3="modules" dir4="api.module.js" />

    <div class="button-control-wrapper">
        <button type="button" onclick="handleLoad()">GET 요청</button>
        <button type="button" onclick="handleRegister()">POST 요청</button>
        <button type="button" onclick="handleUpdate()">PUT 요청</button>
        <button type="button" onclick="handleDelete()">DELETE 요청</button>
    </div>
</div>

<script>
    const REQUEST_URL = "/notices";

    const handleLoad = () => {
        console.log("[module/api.jsp] called by handleLoad.")

        Api.get(REQUEST_URL)
            .then(response => {
                const entities = response.data.data.list;
                console.log(entities);
            })
            .catch(error => handleServerErrorMessage(error));
    }

    const handleRegister = () => {
        console.log("[module/api.jsp] called by handleRegister.")

        const data = {
            title: "test-title",
            content: "test-content",
        };
        const json = new Blob([JSON.stringify(data)], { type: "application/json" });

        const formData = new FormData();
        formData.append("json", json);
        formData.append("htmlFile", generateHTMLFromEditor("test-content"), "api.html");

        Api.post(REQUEST_URL, formData, true)
            .then(response => console.log(response))
            .catch(error => handleServerErrorMessage(error));
    }

    const handleUpdate = () => {
        console.log("[module/api.jsp] called by handleUpdate.")

        const data = {
            title: "test-title",
            content: "test-content",
        };

        const json = new Blob([JSON.stringify(data)], { type: "application/json" });

        const formData = new FormData();
        formData.append("json", json);
        formData.append("htmlFile", generateHTMLFromEditor("test-content"), "api.html");
        formData.append("attachedFileList", null);

        Api.post(REQUEST_URL + "/31", formData, true)
            .then(response => console.log(response))
            .catch(error => handleServerErrorMessage(error));
    }

    const handleDelete = () => {
        console.log("[module/api.jsp] called by handleDelete.")

        Api.delete(REQUEST_URL + "/31")
            .then(response => console.log(response))
            .catch(error => handleServerErrorMessage(error));
    }
</script>