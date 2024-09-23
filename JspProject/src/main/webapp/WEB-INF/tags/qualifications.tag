<%@ tag description="custom qualifications" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="includeHeader" %>

<c:if test="${includeHeader == true}">
    <div class="flex-center-vertical gap-10 form-header">
        <div style="width: 140px">자격 구분</div>
        <div style="width: 395px">자격증명</div>
        <div style="width: 395px">발행처/기관</div>
        <div style="width: 180px">합격년월</div>
        <div style="margin-left: 10px"></div>
    </div>
</c:if>
<div id="qualifications" class="flex-column gap-10"></div>

<script>
    const initializeQualifications = () => {
        generateQualification();
    }

    const setQualifications = (qualifications = []) => {
        if (qualifications.length === 0)
            return initializeQualifications();

        qualifications.forEach((item, index) => {
            generateQualification(index, qualifications.length);
            const target = $("#qualifications #" + index);
            target.find(".qualificationClassification").val(getReversedCommonCode(item.qualificationClassification));
            target.find(".qualificationName").val(item.qualificationName);
            target.find(".issuingClassification").val(item.issuingClassification);
            target.find(".passYearMonthDay").val(item.passYearMonthDay);
        })
    }

    const getQualifications = () => {
        const rows = $("#qualifications div[data-type='row']");
        const qualifications = [];
        rows.each(function () {
            const qualification = {
                qualificationClassification: $(this).find(".qualificationClassification") ? $(this).find(".qualificationClassification").val() : "",
                qualificationName: $(this).find(".qualificationName") ? $(this).find(".qualificationName").val() : "",
                issuingClassification: $(this).find(".issuingClassification") ? $(this).find(".issuingClassification").val() : "",
                passYearMonthDay: $(this).find(".passYearMonthDay") ? $(this).find(".passYearMonthDay").val() : "",
            }

            const isEmpty = Object.values(qualification).every(value => value === "");
            if (!isEmpty)
                qualifications.push(qualification);
        })
        return qualifications;
    }

    const getQualificationClassificationElement = () => {
        const QualificationClassification = {
            "SEL01": "자격증",
            "SEL02": "면허증",
        }

        let selectElement = `
            <select class="qualificationClassification" style='width: 100%'>
                <option value="" selected>구분</option>
        `;
        for (const code in QualificationClassification)
            selectElement += `<option value="${'${code}'}">${'${QualificationClassification[code]}'}</option>`;
        selectElement += `
            </select>
        `;
        return selectElement;
    }

    const getQualificationRowElement = (rowIndex = -1, rowLength) => {
        let classificationElement = getQualificationClassificationElement();

        let rowElement = rowIndex > -1
            ? `<div id="${'${rowIndex}'}" class="flex-column gap-10" data-type="row">`
            : `<div class="flex-column gap-10" data-type="row">`;

        rowElement += `
            <div class="flex gap-10">
                <div style="width: 10%">
        `;
        rowElement += classificationElement;
        rowElement += `
                </div>
                <div style="width: 30%">
                    <label><input type="text" class="qualificationName" placeholder="자격증명"></label>
                </div>
                <div style="width: 30%">
                    <label><input type="text" class="issuingClassification" placeholder="발행처/기관"></label>
                </div>
                <div style="width: 20%">
                    <label><input type="text" class="passYearMonthDay pointer" placeholder="합격년월" onfocus="(this.type='date')"></label>
                </div>
                <div class="btn-wrapper">
        `;
        rowElement += rowLength === 0 || rowLength > (rowIndex + 1)
            ? `<button class="delete-btn" onclick="deleteQualificationRow()"></button>`
            : `<button class="add-btn" onclick="addQualificationRow()"></button>`;
        rowElement += `
                </div>
            </div>
        `;

        return rowElement;
    }

    const generateQualification = (rowIndex = -1, rowLength) => {
        const target = $("#qualifications");

        const rowElement = getQualificationRowElement(rowIndex, rowLength);
        rowIndex ? target.append(rowElement) : target.html(rowElement);

        handleQualificationButtonEvents();
    }

    const sortQualificationOrder = () => {
        const container = $("#qualifications");
        const children = container.children();

        children.each(function (index) {
            $(this).attr("data-order", index);
            const buttonWrapper = $(this).find(".btn-wrapper");

            const isLast = index === children.length - 1;
            const buttonElement = isLast && children.length < 10 ?
                `<button class="add-btn"></button>` : `<button class="delete-btn"></button>`;

            buttonWrapper.html(buttonElement);
        });

        handleQualificationButtonEvents();
    }

    const handleQualificationButtonEvents = () => {
        const addButton = $("#qualifications .add-btn");
        const deleteButton = $("#qualifications .delete-btn");

        if (addButton)
            addButton.on("click", function () {
                addQualificationRow(this);
            });

        if (deleteButton)
            deleteButton.on("click", function () {
                deleteQualificationRow(this);
            });
    }

    const deleteQualificationRow = (element) => {
        if (!element)
            return;

        const row = element.closest(`[data-type="row"]`);
        row.remove();

        sortQualificationOrder();
    }

    const addQualificationRow = () => {
        const container = $("#qualifications");
        // const children = container.children();

        const rowElement = getQualificationRowElement();
        container.append(rowElement);

        sortQualificationOrder();
    }
</script>