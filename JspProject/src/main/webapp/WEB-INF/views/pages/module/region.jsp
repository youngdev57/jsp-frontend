<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="region" class="guide-container">
    <t:information title="Region" parentDir="Modules" />
    <t:callout description="지역 정보 데이터를 가공하는 모듈입니다." />
    <t:filePath dir1="resources" dir2="js" dir3="region.js" />

    <div class="button-control-wrapper">
        <button type="button" class="" data-type="small" onclick="generateSidos()">시/도 바인딩</button>
    </div>

    <div class="flex gap-20 mt-40">
        <div>
            <label for="sido"></label>
            <select id="sido" onchange="handleSelectSido()"></select>
        </div>
        <div>
            <label for="sigungu"></label>
            <select id="sigungu"></select>
        </div>
    </div>
</div>

<script>
    const generateSidos = () => {
        const sigunguElement = document.getElementById("sigungu");
        sigunguElement.innerHTML = "";

        const sidos = getSidos();
        const targetElement = document.getElementById("sido");
        let optionElement = `<option value="">시/도 선택</option>`;
        sidos.forEach(sido => {
            optionElement += `<option value="${'${sido.code}'}">${'${sido.name}'}</option>`;
        });
        targetElement.innerHTML = optionElement;
    }

    const handleSelectSido = () => {
        const selected = document.getElementById("sido").value;
        const sigungus = getSigungusBySidoCode(selected);

        const targetElement = document.getElementById("sigungu");
        let optionElement = `<option value="">시/군/구 선택</option>`;
        sigungus.forEach(sigungu => {
            optionElement += `<option value="${'${sigungu.code}'}">${'${sigungu.name}'}</option>`;
        });
        targetElement.innerHTML = optionElement;
    }
</script>