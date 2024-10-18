<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="thumbnailManager" class="guide-container">
    <t:information title="Thumbnail Manager" parentDir="Modules" />
    <t:callout description="썸네일 매니저는 썸네일 업로드 및 미리보기 기능을 간편하게 지원하는 기능을 가진 모듈입니다." />
    <t:filePath dir1="resources" dir2="js" dir3="modules" dir4="thumbnail-manager.module.js" />

    <div class="common-form-wrapper mt-20">
        <div>
            <div class="column-header">허용 파일 형식 변경</div>
            <div class="column-content">
                <label for="png"><input id="png" type="checkbox" checked />png</label>
                <label for="jpg"><input id="jpg" type="checkbox" checked />jpg</label>
            </div>
        </div>
    </div>
    <div class="mt-40 thumbnail-manager-container"></div>
</div>

<script>
    let thumbnailManager;

    document.addEventListener("DOMContentLoaded", function () {
        initializeThumbnailManager();
    })

    const initializeThumbnailManager = () => {
        const descriptions = [ "허용된 파일 형식(png, jpg)만 업로드 가능합니다." ];

        thumbnailManager = new ThumbnailManagerModule("file-manager");
        const thumbnailManagerContainer = document.querySelector(".thumbnail-manager-container");
        thumbnailManager.initialize(thumbnailManagerContainer, descriptions);

        const accepts = ["png", "jpg"];
        thumbnailManager.setAcceptThumbnailManager(accepts);

        thumbnailManager.callbackChange = callbackChangeFile;
        thumbnailManager.callbackRemove = callbackRemoveFile;
    }

    const callbackChangeFile = () => {
        console.log("[module/thumbnailManager.jsp] 파일이 변경되었습니다.");
    }

    const callbackRemoveFile = () => {
        console.log("[module/thumbnailManager.jsp] 파일이 삭제되었습니다.");
    }
</script>