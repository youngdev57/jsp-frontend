<%@ tag description="custom certificates" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="includeHeader" %>

<c:if test="${includeHeader == true}">
    <div class="flex-center-vertical gap-10 form-header">
        <div style="width: 140px">자격 구분</div>
        <div style="width: 395px">자격증명</div>
        <div style="width: 395px">발행처/기관</div>
        <div style="width: 180px">취득연월</div>
        <div style="margin-left: 10px"></div>
    </div>
</c:if>
<div id="certificates" class="flex-column gap-10"></div>

<script>
    const initializeCertificates = () => {
        generateCertificate();
    }

    const setCertificates = (certificates = []) => {
        if (certificates.length === 0)
            return initializeCertificates();

        certificates.forEach((item, index) => {
            generateCertificate(index, certificates.length);
            const target = $("#certificates #" + index);
            target.find(".certificateType").val(getReversedCommonCode(item.certificateType));
            target.find(".certificateName").val(item.certificateName);
            target.find(".issuingAuthority").val(item.issuingAuthority);
            target.find(".issuedDate").val(item.issuedDate);
        })
    }

    const getCertificates = () => {
        const rows = $("#certificates div[data-type='row']");
        const certificates = [];
        rows.each(function () {
            const certificate = {
                certificateType: $(this).find(".certificateType") ? $(this).find(".certificateType").val() : "",
                certificateName: $(this).find(".certificateName") ? $(this).find(".certificateName").val() : "",
                issuingAuthority: $(this).find(".issuingAuthority") ? $(this).find(".issuingAuthority").val() : "",
                issuedDate: $(this).find(".issuedDate") ? $(this).find(".issuedDate").val() : "",
            }

            const isEmpty = Object.values(certificate).every(value => value === "");
            if (!isEmpty)
                certificates.push(certificate);
        })
        return certificates;
    }

    const getCertificateTypeElement = () => {
        let selectElement = `
            <select class="certificateType" style='width: 100%'>
                <option value="" selected>구분</option>
        `;
        for (const code in CertificateType)
            selectElement += `<option value="${'${code}'}">${'${CertificateType[code]}'}</option>`;
        selectElement += `
            </select>
        `;
        return selectElement;
    }

    const getCertificateRowElement = (rowIndex = -1, rowLength) => {
        let classificationElement = getCertificateTypeElement();

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
                    <label><input type="text" class="certificateName" placeholder="자격증명"></label>
                </div>
                <div style="width: 30%">
                    <label><input type="text" class="issuingAuthority" placeholder="발행처/기관"></label>
                </div>
                <div style="width: 20%">
                    <label><input type="text" class="issuedDate pointer" placeholder="합격년월" onfocus="(this.type='date')"></label>
                </div>
                <div class="btn-wrapper">
        `;
        rowElement += rowLength === 0 || rowLength > (rowIndex + 1)
            ? `<button class="delete-btn" onclick="deleteCertificateRow()"></button>`
            : `<button class="add-btn" onclick="addCertificateRow()"></button>`;
        rowElement += `
                </div>
            </div>
        `;

        return rowElement;
    }

    const generateCertificate = (rowIndex = -1, rowLength) => {
        const target = $("#certificates");

        const rowElement = getCertificateRowElement(rowIndex, rowLength);
        rowIndex ? target.append(rowElement) : target.html(rowElement);

        handleCertificateButtonEvents();
    }

    const sortCertificateOrder = () => {
        const container = $("#certificates");
        const children = container.children();

        children.each(function (index) {
            $(this).attr("data-order", index);
            const buttonWrapper = $(this).find(".btn-wrapper");

            const isLast = index === children.length - 1;
            const buttonElement = isLast && children.length < 10 ?
                `<button class="add-btn"></button>` : `<button class="delete-btn"></button>`;

            buttonWrapper.html(buttonElement);
        });

        handleCertificateButtonEvents();
    }

    const handleCertificateButtonEvents = () => {
        const addButton = $("#certificates .add-btn");
        const deleteButton = $("#certificates .delete-btn");

        if (addButton)
            addButton.on("click", function () {
                addCertificateRow(this);
            });

        if (deleteButton)
            deleteButton.on("click", function () {
                deleteCertificateRow(this);
            });
    }

    const deleteCertificateRow = (element) => {
        if (!element)
            return;

        const row = element.closest(`[data-type="row"]`);
        row.remove();

        sortCertificateOrder();
    }

    const addCertificateRow = () => {
        const container = $("#certificates");
        // const children = container.children();

        const rowElement = getCertificateRowElement();
        container.append(rowElement);

        sortCertificateOrder();
    }
</script>