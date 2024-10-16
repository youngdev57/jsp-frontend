<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="fileManager" class="guide-container">
    <t:information title="File Manager" parentDir="Modules" />
    <t:callout description="파일 매니저는 첨부파일 업로드를 간편하게 지원하는 기능을 가진 모듈입니다." />
    <t:filePath dir1="resources" dir2="js" dir3="modules" dir4="file-manager.module.js" />

    <div class="common-form-wrapper mt-20">
        <div>
            <div class="column-header">허용 파일 형식 변경</div>
            <div class="column-content">
                <label for="png"><input id="png" type="checkbox" checked />png</label>
                <label for="jpg"><input id="jpg" type="checkbox" checked />jpg</label>
                <label for="gif"><input id="gif" type="checkbox" checked />gif</label>
                <label for="pdf"><input id="pdf" type="checkbox" checked />pdf</label>
                <label for="zip"><input id="zip" type="checkbox" checked />zip</label>
            </div>
        </div>
        <div>
            <div class="column-header">업로드 개수 변경</div>
            <div class="column-content">
                <label class="flex gap-10 pd-0"><input id="file-1" type="radio" name="maxCount">1개</label>
                <label class="flex gap-10 pd-0"><input id="file-3" type="radio" name="maxCount">3개</label>
                <label class="flex gap-10 pd-0"><input id="file-5" type="radio" name="maxCount" checked>5개</label>
            </div>
        </div>
    </div>
    <div class="mt-40 file-manager-container"></div>
</div>

<script>
    let fileManager;

    document.addEventListener("DOMContentLoaded", function () {
        initializeFileManager();

        addEventChangeExtends();
        addEventChangeUpload();
    })

    const initializeFileManager = () => {
        const descriptions = [
            "허용된 파일 형식(png, jpg, gif, pdf, zip)만 업로드 가능합니다.",
            "최대 5개까지 업로드 가능합니다."
        ];

        fileManager = new FileManagerModule("file-manager");
        const fileManagerContainer = document.querySelector(".file-manager-container");
        fileManager.initialize(fileManagerContainer, descriptions);

        const accepts = ["png", "jpg", "gif", "pdf", "zip"];
        fileManager.setAcceptFileManager(accepts);

        fileManager.callbackChange = callbackChangeFile;
        fileManager.callbackRemove = callbackRemoveFile;
    }

    const addEventChangeExtends = () => {
        const checkboxes = document.querySelectorAll('#fileManager input[type="checkbox"]');

        checkboxes.forEach(checkbox => {
            checkbox.addEventListener("change", () => {
                const extendNames = [];

                const checkedItems = document.querySelectorAll('#fileManager input[type="checkbox"]:checked');
                checkedItems.forEach(item => extendNames.push(item.id));

                const isAcceptAll = checkedItems.length === 0;
                const description = isAcceptAll
                    ? "※ 모든 파일 형식으로 업로드 가능합니다."
                    : "※ 허용된 파일 형식(" + extendNames.join(", ") +  ")만 업로드 가능합니다.";
                const targetElement = document.querySelectorAll(".description > ul > li")[0] || "";
                targetElement.textContent = description;

                fileManager.setAcceptFileManager(extendNames);
            })
        })
    }

    const addEventChangeUpload = () => {
        const radios = document.querySelectorAll('#fileManager input[type="radio"]');
        radios.forEach(radio => {
            radio.addEventListener("change", () => {
                const selected = document.querySelector('[name="maxCount"]:checked');
                const maxCount = selected.id.replace("file-", "");

                fileManager.setMaxCount(+maxCount);

                const description = "※ 최대 " + maxCount + "개까지 업로드 가능합니다.";
                const targetElement = document.querySelectorAll(".description > ul > li")[1] || "";
                targetElement.textContent = description;
            })
        })
    }

    const callbackChangeFile = () => {
        console.log("[module/fileManager.jsp] 파일이 변경되었습니다.");
    }

    const callbackRemoveFile = () => {
        console.log("[module/fileManager.jsp] 파일이 삭제되었습니다.");
    }
</script>