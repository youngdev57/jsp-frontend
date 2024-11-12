<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="region" class="guide-container">
    <t:information title="Region" parentDir="Modules" />
    <t:callout description="지역 정보 데이터를 가공하는 모듈입니다." />
    <t:filePath dir1="resources" dir2="js" dir3="modules" dir4="region.module.js" />

    <div class="button-control-wrapper gap-20">
        <button type="button" onclick="generateSidos()">시/도 바인딩</button>
        <button type="button" onclick="getSelectedAddress()">가져오기</button>
        <p class="address-text" style="line-height: 60px"></p>
    </div>

    <div class="flex gap-20 mt-40" style="flex-wrap: wrap">
        <div>
            <label for="siDo">
                <select id="siDo">
                    <option value="">시/도 선택</option>
                </select>
            </label>
        </div>
        <div>
            <label for="siGunGu">
                <select id="siGunGu">
                    <option value="">시/군/구 선택</option>
                </select>
            </label>
        </div>
        <div>
            <label for="eupMyeonDong">
                <select id="eupMyeonDong">
                    <option value="">읍/면/동 선택</option>
                </select>
            </label>
        </div>
        <div>
            <label for="dongRi">
                <select id="dongRi">
                    <option value="">동/리 선택</option>
                </select>
            </label>
        </div>
    </div>
</div>

<script>
    let regionModule;

    document.addEventListener("DOMContentLoaded", function () {
        initializeRegionModule();
    })

    const initializeRegionModule = async () => {
        regionModule = new RegionModule();
        await regionModule.initialize();

        regionModule.siDoSelector = document.getElementById("siDo");
        regionModule.siGunGuSelector = document.getElementById("siGunGu");
        regionModule.eupMyeonDongSelector = document.getElementById("eupMyeonDong");
        regionModule.dongRiSelector = document.getElementById("dongRi");
    }

    const getSelectedAddress = () => {
        const address = regionModule.getFullAddressName();
        document.querySelector(".address-text").textContent = address.convertedName;
    }

    const generateSidos = () => {
        regionModule.loadSiDo();
    }
</script>