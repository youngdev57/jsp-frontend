<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="grid" class="guide-container">
    <t:information title="Grid" parentDir="Common" />
    <t:callout description="프로젝트에 자주 이용되는 공통 Grid 입니다." />

    <section class="mt-20">
        <%-- input --%>
        <div class="flex-column gap-20 mt-40">
            <h2 class="common-title">Grid input</h2>
            <t:certificates />
        </div>

        <div class="common-form-button-wrapper">
            <button type="button" class="tertiary" onclick="clearGridInput()">되돌리기</button>
            <button type="button" class="primary" onclick="applyGridOutput()">적용하기</button>
        </div>

        <%-- output --%>
        <div class="flex-column gap-20 mt-40">
            <h2 class="common-title">Grid output</h2>
            <div class="common-grid-wrapper">
                <div class="grid-header">
                    <p>제목1</p>
                    <p>제목2</p>
                    <p>제목3</p>
                    <p>제목4</p>
                </div>
                <div class="grid-row-wrapper"></div>
            </div>
        </div>

        <div class="common-form-button-wrapper">
            <button type="button" class="tertiary" onclick="initializeGridOutput()">되돌리기</button>
        </div>
    </section>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        initializeCertificates();
        initializeGridOutput();
    })

    const applyGridOutput = () => {
        const targetElement = document.querySelector(".grid-row-wrapper");
        let innerContent = "";

        const certificates = getCertificates();
        // TODO need unique key
        certificates.forEach(certificate => {
            innerContent += `
                <div class="grid-row">
                    <p>${'${CertificateType[certificate.certificateType] || ""}'}</p>
                    <p>${'${certificate.certificateName || ""}'}</p>
                    <p>${'${certificate.issuingAuthority || ""}'}</p>
                    <p>${'${certificate.issuedDate || ""}'}</p>
                </div>
            `;
        })

        targetElement.innerHTML = innerContent;
    }
    
    const initializeGridOutput = () => {
        const targetElement = document.querySelector(".grid-row-wrapper");
        targetElement.innerHTML = `
            <div class="grid-row">
                <p>제목1에 관한 내용입니다.</p>
                <p>제목2에 관한 내용입니다.</p>
                <p>제목3에 관한 내용입니다.</p>
                <p>제목4에 관한 내용입니다.</p>
            </div>
            <div class="grid-row">
                <p>제목1에 관한 내용입니다.</p>
                <p>제목2에 관한 내용입니다.</p>
                <p>제목3에 관한 내용입니다.</p>
                <p>제목4에 관한 내용입니다.</p>
            </div>
            <div class="grid-row">
                <p>제목1에 관한 내용입니다.</p>
                <p>제목2에 관한 내용입니다.</p>
                <p>제목3에 관한 내용입니다.</p>
                <p>제목4에 관한 내용입니다.</p>
            </div>
        `;
    }

    const clearGridInput = () => {
        const targetElement = document.getElementById("certificates");
        targetElement.innerHTML = "";
        initializeCertificates();
    }
</script>