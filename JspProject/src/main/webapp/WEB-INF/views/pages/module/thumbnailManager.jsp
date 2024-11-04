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
        <div>
            <div class="column-header">데이터 바인딩</div>
            <div class="column-content">
                <button type="button" onclick="bindThumbnail()">바인딩</button>
            </div>
        </div>
    </div>
    <div class="mt-40 thumbnail-manager-container"></div>
</div>

<script>
    let thumbnailManager;

    document.addEventListener("DOMContentLoaded", function () {
        initializeThumbnailManager();
        addEventChangeExtends();
    })

    const initializeThumbnailManager = () => {
        const descriptions = [ "허용된 파일 형식(png, jpg)만 업로드 가능합니다." ];

        thumbnailManager = new ThumbnailManagerModule("thumbnail-manager");
        const thumbnailManagerContainer = document.querySelector(".thumbnail-manager-container");
        thumbnailManager.initialize(thumbnailManagerContainer, descriptions);

        const accepts = ["png", "jpg"];
        thumbnailManager.setAcceptThumbnailManager(accepts);

        thumbnailManager.callbackChange = callbackChangeFile;
        thumbnailManager.callbackRemove = callbackRemoveFile;
    }

    const addEventChangeExtends = () => {
        const checkboxes = document.querySelectorAll('#thumbnailManager input[type="checkbox"]');

        checkboxes.forEach(checkbox => {
            checkbox.addEventListener("change", () => {
                const extendNames = [];

                const checkedItems = document.querySelectorAll('#thumbnailManager input[type="checkbox"]:checked');
                checkedItems.forEach(item => extendNames.push(item.id));

                const isAcceptAll = checkedItems.length === 0;
                const description = isAcceptAll
                    ? "※ 모든 파일 형식으로 업로드 가능합니다."
                    : "※ 허용된 파일 형식(" + extendNames.join(", ") +  ")만 업로드 가능합니다.";
                const firstDescription = document.querySelector(".description > ul > li") || "";
                firstDescription.textContent = description;

                thumbnailManager.setAcceptThumbnailManager(extendNames);
            })
        })
    }

    const bindThumbnail = () => {
        const entity = {
            name: "테스트_썸네일.png",
            url: "https://tistory1.daumcdn.net/tistory/3580603/attach/9391cebe1d374f5c9b5d1f257b4aedf8" // 외부 URL
        }
        thumbnailManager.setOriginThumbnail(entity);
    }

    const callbackChangeFile = () => {
        console.log("[module/thumbnailManager.jsp] 파일이 변경되었습니다.");
    }

    const callbackRemoveFile = () => {
        console.log("[module/thumbnailManager.jsp] 파일이 삭제되었습니다.");
    }
</script>