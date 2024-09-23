<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="pager" class="guide-container">
    <t:information title="Pager Module" parentDir="Modules" />
    <t:callout description="목록 페이지네이션 및 검색 옵션 자동화를 위한 모듈입니다." />
    <t:filePath dir1="resources" dir2="js" dir3="modules" dir4="pager.module.js" />

    <div class="button-control-wrapper">
        <button type="button" class="guide" data-type="small" onclick="handleLoad()">목록 요청</button>
    </div>
    <t:searchBar sectionId="manageSystemNoticeList" className="mt-20" />

    <section class="pager-wrapper">
        <table>
            <thead>
                <tr class="pager-header"></tr>
            </thead>
            <tbody class="pager-content"></tbody>
        </table>
        <div class="pager-indicator"></div>
    </section>
</div>

<script>
    const REUQEST_URL = "/notices";

    const message = {
        confirmDeleteNotice: "게시글을 삭제하시겠습니까?",
        checkDeleteNotice: "삭제하려는 항목을 체크해 주세요."
    }

    document.addEventListener("DOMContentLoaded", function () {
        const searchOptions = [
            { value: "title", text: "제목" },
            { value: "writer", text: "작성자" }
        ]
        initializeSearchBar(handleLoad, searchOptions);
        handleAddInnerButton();
    });

    const handleAddInnerButton = () => {
        const buttonElement = `
            <button data-type="small" onclick="handleDeleteChecked()">선택 삭제</button>
        `;
        $("#sec-button").html(buttonElement);
    }

    const handleLoad = (pageIndex = 1) => {
        console.log("[module/api.jsp] called by handleLoad.")

        const requestParam = {
            sortColumn: "",
            sortDirection: "",
            pageNum: pageIndex,
            pageSize: 10,
            ...getSearchParameter()
        }

        Api.get(REQUEST_URL, requestParam)
            .then(response => {
                const actionButton = `
                    <a href="/notices/form">
                        <button data-type="small">게시글 등록</button>
                    </a>
                `;
                Pager.setPagerInformation(response, null, [actionButton]);
                Pager.initialize();
                Pager.setPagerLoader(handleLoad);

                const checkAll = `<input type="checkbox" data-type="all" />`;
                const headers = [checkAll, "번호", "제목", "작성일시", "수정일시", "작성자", "조회수", ""];
                Pager.setPagerHeader(headers);

                const entities = response.data.data.list;
                const contentElement = $(".pager-content");
                contentElement.empty();

                entities.forEach(entity => {
                    const detailPageUrl = `/${'${REQUEST_URL}'}/${'${entity.id}'}`;
                    
                    const checkEach = `<input id="${"chk-${entity.id}"}" type="checkbox" data-type="each" data-eid="${"${entity.id}"}" />`;
                    let childElement = `<tr id="${"row-${entity.id}"}"><td>${"${checkEach}"}</td><td>${"${entity.no}"}</td>`;
                    childElement +=`
                            <td class="ellipsis title">
                                <a href="${'${detailPageUrl}'}" title="${"${entity.title}"}">
                                    ${"${entity.title || ''}"}
                                </a>
                            </td>
                            <td>${"${entity.writeDate || ''}"}</td>
                            <td>${"${entity.modifyDate || ''}"}</td>
                            <td>${"${'관리자'}"}</td>
                            <td>${"${entity.views || 0}"}</td>
                            <td class="action-button-wrapper">
                                <button data-type="small" onclick="handleToggleContextMenu(${"${entity.id}"})">···</button>
                                <div class="context-menu">
                                    <a href="${'${detailPageUrl}'}">조회</a>
                                    <a href="${'${detailPageUrl}'}/update">수정</a>
                                    <a onclick="handleDeleteEntity(${"${entity.id}"})">삭제</a>
                                </div>
                            </td>
                        </tr>
                    `;

                    contentElement.append(childElement);
                });

                const checkedAll = $(`input[data-type="all"]`);
                checkedAll.on("click", function () {
                    toggleCheckedAll($(this));
                });
            })
            .catch(error => handleServerErrorMessage(error));
    }

    const toggleCheckedAll = (target) => {
        const isChecked = target.prop("checked");
        const checkboxes = $(`input[data-type="each"]`);
        checkboxes.prop("checked", isChecked);
    }

    const handleDeleteEntity = (entityId = -1) => {
        if (!confirm(message.confirmDeleteNotice))
            return;

        Api.delete(REQUEST_URL + "/" + entityId)
            .then(response => handleLoad())
            .catch(error => handleServerErrorMessage(error));
    }

    const handleDeleteEntitys = (entityIds = []) => {
        if (entityIds.length === 0)
            return alert(message.checkDeleteNotice);

        if (!confirm(message.confirmDeleteNotice))
            return;

        function processDeletes(REQUEST_URLs) {
            const promises = REQUEST_URLs.map(REQUEST_URL => Api.delete(REQUEST_URL));
            return Promise.all(promises);
        }

        const REQUEST_URLs = entityIds.map(entityId => REQUEST_URL + "/" + entityId);
        processDeletes(REQUEST_URLs)
            .then(response => handleLoad())
            .catch(error => handleServerErrorMessage(error));
    }

    const handleDeleteChecked = () => {
        const checkboxes = $(`input[data-type="each"]`);
        const entityIds = [];
        checkboxes.each(function () {
            if ($(this).prop("checked"))
                entityIds.push($(this).data("eid"));
        });

        handleDeleteEntitys(entityIds);
    }

    const handleToggleContextMenu = (entityId = -1) => {
        const contextMenu = $("tr#row-" + entityId + " .context-menu");
        $(".pager-content tr").each(function () {
            const rowEntityId = $(this).attr("id").replace("row-", "");
            if (entityId !== parseInt(rowEntityId))
                $(this).find(".context-menu").css("display", "none");
        });

        const isDisplayed = contextMenu.css("display") === "flex";
        contextMenu.css("display", isDisplayed ? "none" : "flex");
    }
</script>