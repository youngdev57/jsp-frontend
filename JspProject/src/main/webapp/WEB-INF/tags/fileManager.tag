<%@ tag description="custom file manager" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="id" %>
<%@ attribute name="disabled" %>
<%@ attribute name="useDescription" %>
<%@ attribute name="description1" %>
<%@ attribute name="description2" %>

<div class="file-manager flex-column">
    <div class="flex-center gap-20">
        <label for="file-${id}">파일 업로드 <span class="file-count">(0/5)</span></label>
        <input id="file-${id}" type="file" accept="" multiple ${disabled} onchange="handleChangeFiles()"/>
        <div class="description">
            <ul>
                <li class="description1">${description1}</li>
                <c:if test="${not empty description2}">
                    <li class="description2">${description2}</li>
                </c:if>
            </ul>
        </div>
    </div>
    <div class="selected-wrapper flex-column gap-10"></div>
</div>

<script>
    let callbackChange;
    let callbackRemove;
    let maxFileCount = 5;
    let files = [];

    const handleRemoveAttachedFile = (uniqueKey = "") => {
        const target = $(`[data-eid="${'${uniqueKey}'}"]`);
        if (target) {
            const foundIndex = files.findIndex(file => file.key === uniqueKey);
            if (foundIndex > -1)
                files.splice(foundIndex, 1);

            target.remove();
        }

        $(".file-count").text("(" + files.length + "/" + maxFileCount + ")");

        if (callbackRemove)
            callbackRemove();
    }

    const setChangeFileCallback = (callback) => {
        callbackChange = callback;
    }

    const setRemoveFileCallback = (callback) => {
        callbackRemove = callback;
    }

    const setMaxFileCount = (count = 5) => {
        maxFileCount = count;
    }

    const convertFileSize = (bytes) => {
        const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
        if (bytes === 0)
            return '0 Bytes';

        const index = Math.floor(Math.log(bytes) / Math.log(1024));
        return parseFloat((bytes / Math.pow(1024, index)).toFixed(2)) + ' ' + sizes[index];
    }

    const generateUniqueId = () => {
        const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        let result = "";
        for (let index = 0; index < 6; index ++)
            result += chars.charAt(Math.floor(Math.random() * chars.length));

        return result;
    }

    const handleChangeFiles = () => {
        const newFiles = Array.from($("#file-${id}")[0].files);
        if ((files.length + newFiles.length) > maxFileCount)
            return alert("최대 " + maxFileCount + "개까지 등록 가능합니다.");

        files = files.concat(newFiles);

        let innerElement = "";

        files.forEach(file => {
            const uniqueKey = generateUniqueId();
            const fileName = `${"${file.name}"} (${"${convertFileSize(file.size)}"})`
            innerElement += `
                <div data-eid="${'${uniqueKey}'}" style="position: relative">
                    <div class="file-icon"></div>
                    <input class="uploaded-file-name" value="${'${fileName}'}" disabled />
                    <button type="button" class="btn-remove-attached" onclick="handleRemoveAttachedFile('${'${uniqueKey}'}')"></button>
                </div>
            `;

            file.key = uniqueKey;
        })

        $(".selected-wrapper").html(innerElement);
        $(".file-count").text("(" + files.length + "/" + maxFileCount + ")");

        if (callbackChange)
            callbackChange();
    }

    const setFileName = (value = "") => {
        $(".uploaded-file-name").val(value);
    }

    const getSelectedFiles = () => {
        const targetElement = $("#file-${id}").get(0);
        return [...targetElement.files];
    }

    /**
     * 파일매니저의 허용 확장자를 지정하는 함수
     * @param accepts
     */
    const setAcceptFileManager = (accepts = []) => {
        const list = [];
        accepts.forEach(accept => {
            switch (accept) {
                case "jpg":
                case "jpeg":
                    list.push("image/jpeg");
                    list.push("image/vnd.sealedmedia.softseal.jpg");
                    break;
                case "gif":
                    list.push("image/gif");
                    break;
                case "png":
                    list.push("image/png");
                    break;
                case "pdf":
                    list.push("application/pdf");
                    break;
                case "xls":
                    list.push(".xlsx, .xls, application/haansoftxlsx, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel, application/vnd.msexcel");
                    break;
                case "txt":
                    list.push("text/plain");
                    break;
                case "ppt":
                    list.push("vnd.sealed.ppt");
                    break;
                case "xml":
                    list.push("application/xml");
                    break;
                case "zip":
                    list.push("application/zip");
                    break;
                default:
                    list.push(accept);
            }
        })

        const acceptValue = list.join(", ");
        const targetElement = $("#file-${id}");
        targetElement.attr("accept", acceptValue);
    }
</script>