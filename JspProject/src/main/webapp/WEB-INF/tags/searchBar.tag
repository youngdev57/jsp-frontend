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

    $(document).keyup(function (event) {
        if (event.which === 13)
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
        const selectElement = $("#sel-searchColumn");
        options.forEach(option => {
            const selected = option.selected ? "selected" : "";
            const optionElement = `
                <option value="${'${option.value}'}" ${"${selected}"}>${'${option.text}'}</option>
            `;
            selectElement.append(optionElement);
        });
    }

    /**
     * 서치바의 select 들을 커스텀화하는 함수
     * @param selects
     * @param includeAll
     */
    const setCustomSearchSelect = (selects = [], includeAll = true) => {
        const wrapper = $(`#sec-${sectionId} .search-bar-wrapper`);
        selects.forEach(select => {
            const opened = `<select id="sel-${"${select.id}"}" data-type="small">`;
            let optionElements = includeAll ? `<option value="" selected>전체</option>` : "";
            select.options.forEach(option => {
                optionElements += `<option value="${"${option.value}"}">${"${option.text}"}</option>`;
            });
            const closed =`</select>`;
            wrapper.prepend(opened + optionElements + closed);
        });
    }

    /**
     * 서치바에 설정된 query parameter 값을 받아오는 함수
     * @returns {{searchColumn: (*|string|jQuery), searchKeyword: (*|string|jQuery)}}
     */
    const getSearchParameter = () => {
        const result = {};
        const searchSection = $(`#sec-${sectionId}`);
        result.searchKeyword = searchSection.find("#inp-search").val();

        const searchSelects = searchSection.find("select");
        searchSelects.each(function () {
            const property = $(this).attr("id").replaceAll("sel-", "");
            result[property] = $(this).val();
        });

        return result;
    }
</script>