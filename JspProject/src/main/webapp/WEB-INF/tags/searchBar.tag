<%@ tag description="custom search bar" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="sectionId" required="true" %>
<%@ attribute name="className" %>
<%@ attribute name="hideAllColumn" %>
<%@ attribute name="hide" %>

<section id="sec-${sectionId}" class="gap-20 flex between ${className}" style="${hide == true ? 'display: none' : ''}">
    <div id="sec-button" class="flex-center-vertical"></div>
    <div class="flex gap-10 search-bar-wrapper">
        <select id="sel-searchColumn" data-type="small">
            <c:if test="${ empty hideAllColumn || hideAllColumn == false }">
                <option value="all" selected>전체</option>
            </c:if>
        </select>
        <div class="flex gap-10">
            <input id="inp-search" type="text" placeholder="검색어를 입력해 주세요." data-type="small" style="width: 320px" />
            <button id="btn-search" class="primary-adm" data-type="small" onclick="handleSearch()">검색</button>
        </div>
    </div>
</section>

<script>
    let handleSearch;

    document.addEventListener("keyup", function(e) {
        if (e.key === "Enter")
            handleSearch();
    });

    /**
     * 서치바 초기화 함수
     * @param loader
     * @param options
     */
    const initializeSearchBar = (loader, options = []) => {
        handleSearch = loader;
        setSearchSelectOptions(options);
    }

    /**
     * 서치바의 select 옵션들을 커스텀화하는 함수
     * @param options
     */
    const setSearchSelectOptions = (options = []) => {
        const selectElement = document.getElementById("sel-searchColumn");
        let optionElements = "";
        options.forEach(option => {
            const selected = option.selected ? "selected" : "";
            optionElements += `
                <option value="${'${option.value}'}" ${"${selected}"}>${'${option.text}'}</option>
            `;
        });
        selectElement.innerHTML = optionElements;
    }

    /**
     * 서치바의 select 들을 커스텀화하는 함수
     * @param selects
     * @param includeAll
     */
    const setCustomSearchSelect = (selects = [], includeAll = true) => {
        const wrapper = document.querySelector(`#sec-${sectionId} .search-bar-wrapper`);
        selects.forEach(select => {
            const opened = `<select id="sel-${"${select.id}"}" data-type="small">`;
            let optionElements = includeAll ? `<option value="" selected>전체</option>` : "";
            select.options.forEach(option => {
                optionElements += `<option value="${"${option.value}"}">${"${option.text}"}</option>`;
            });
            const closed =`</select>`;
            wrapper.prepend(opened + optionElements + closed); // TODO 구조 변경 후 제이쿼리 걷어내기 필요
        });
    }

    /**
     * 서치바에 설정된 query parameter 값을 받아오는 함수
     * @returns {{}}
     */
    const getSearchParameter = () => {
        const result = {};

        const searchSection = document.getElementById(`sec-${sectionId}`);

        const searchInput = searchSection.querySelector("#inp-search");
        result.searchKeyword = searchInput ? searchInput.value : "";

        const searchSelects = searchSection.querySelectorAll("select");
        searchSelects.forEach(select => {
            const property = select.id.replace("sel-", "");
            result[property] = select.value;
        });

        return result;
    }
</script>