<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="fileManager" class="guide-container">
    <t:information title="File Manager" parentDir="tag" />
    <t:callout description="파일 매니저는 첨부파일 업로드를 간편하게 지원하는 기능입니다." />
    <t:filePath dir1="WEB-INF" dir2="tags" dir3="fileManager.tag" />

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
    <div class="mt-40">
        <t:fileManager id="fileManager"
                       description1="허용된 파일 형식(png, jpg, gif, pdf, zip)만 업로드 가능합니다."
                       description2="최대 5개까지 업로드 가능합니다." />
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const accepts = ["png", "jpg", "gif", "pdf", "zip"];
        setAcceptFileManager(accepts);

        setChangeFileCallback(callbackChangeFile);
        setRemoveFileCallback(callbackRemoveFile);

        addEventChangeExtends();
        addEventChangeUpload();
    })

    const addEventChangeExtends = () => {
        $('#fileManager input[type="checkbox"]').change(function () {
            const extendNames = [];
            $('#fileManager input[type="checkbox"]:checked').each(function () {
                extendNames.push($(this).attr("id"));
            })
            const description = "허용된 파일 형식(" + extendNames.join(", ") +  ")만 업로드 가능합니다.";
            $(".description1").text(description);

            setAcceptFileManager(extendNames);
        })
    }

    const addEventChangeUpload = () => {
        $('#fileManager input[type="radio"]').change(function () {
            const maxCount = $('[name="maxCount"]:checked').attr("id").replace("file-", "");
            setMaxFileCount(maxCount);

            const description = "최대 " + maxCount + "개까지 업로드 가능합니다.";
            $(".description2").text(description);
        })
    }

    const callbackChangeFile = () => {
        console.log("[tag/fileManager.jsp] 파일이 변경되었습니다.");
    }

    const callbackRemoveFile = () => {
        console.log("[tag/fileManager.jsp] 파일이 삭제되었습니다.");
    }
</script>