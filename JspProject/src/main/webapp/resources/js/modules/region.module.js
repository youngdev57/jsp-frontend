class RegionModule {
    constructor() {
        this._regionData = [];
        this._siDoSelector = null;
        this._siGunGuSelector = null;
        this._eupMyeonDongSelector = null;
        this._dongRiSelector = null;

        this._TYPE_KOR = {
            SIDO: "시/도",
            SIGUNGU: "시/군/구",
            EUPMYEONDONG: "읍/면/동",
            DONGRI: "동/리"
        }
    }

    get regionData() {
        return this._regionData;
    }

    set regionData(value) {
        this._regionData = value;
    }

    get TYPE_KOR() {
        return this._TYPE_KOR;
    }

    get siDoSelector() {
        return this._siDoSelector;
    }

    get siGunGuSelector() {
        return this._siGunGuSelector;
    }

    get eupMyeonDongSelector() {
        return this._eupMyeonDongSelector;
    }

    get dongRiSelector() {
        return this._dongRiSelector;
    }

    set siDoSelector(value) {
        this._siDoSelector = value;
        this._siDoSelector.addEventListener("change", this.updateSiGunGu);
        this._addChangeListener(this._siDoSelector, this.updateSiGunGu.bind(this));
    }

    set siGunGuSelector(value) {
        this._siGunGuSelector = value;
        this._siDoSelector.addEventListener("change", this.updateSiGunGu);
        this._addChangeListener(this._siGunGuSelector, this.updateEupMyeonDong.bind(this));
    }

    set eupMyeonDongSelector(value) {
        this._eupMyeonDongSelector = value;
        this._siDoSelector.addEventListener("change", this.updateEupMyeonDong);
        this._addChangeListener(this._eupMyeonDongSelector, this.updateDongRi.bind(this));
    }

    set dongRiSelector(value) {
        this._dongRiSelector = value;
    }

    _addChangeListener(element, handler) {
        if (element) {
            element.removeEventListener("change", handler);
            element.addEventListener("change", handler);
        }
    }

    /**
     * 모듈 초기화 함수
     */
    initialize = async () => {
        this.regionData = await this.loadRegionJsonData();
    }

    /**
     * 지역 JSON DATA 가져오는 함수
     * @returns {Promise<any|null>}
     */
    loadRegionJsonData = async () => {
        try {
            const response = await fetch("../../../../resources/js/config/region.json");
            return await response.json();
        } catch (error) {
            console.error(error);
            return null;
        }
    }

    populateSelectOptions = (targetSelect, items, selectedText = "") => {
        if (!targetSelect)
            return;

        targetSelect.innerHTML = `<option value="">${selectedText} 선택</option>`;
        items.forEach(item => {
            const option = document.createElement("option");
            option.value = item.fullCode;
            option.textContent = item.name;
            targetSelect.appendChild(option);
        });
    }

    loadSiDo = () => {
        this.populateSelectOptions(this.siDoSelector, this.regionData, this.TYPE_KOR.SIDO);
    }

    updateSiGunGu = () => {
        const siDoCode = this.siDoSelector.value;
        if (!siDoCode)
            return;

        const siDo = this.regionData.find(region => region.fullCode === siDoCode);
        if (siDo && siDo.children) {
            this.populateSelectOptions(this.siGunGuSelector, siDo.children, this.TYPE_KOR.SIGUNGU);
            this.eupMyeonDongSelector.innerHTML = `<option value="">${this.TYPE_KOR.EUPMYEONDONG} 선택</option>`;
            if (this.dongRiSelector)
                this.dongRiSelector.innerHTML = `<option value="">${this.TYPE_KOR.DONGRI} 선택</option>`;
        }
    }

    updateEupMyeonDong = () => {
        const siGunGuCode = this.siGunGuSelector.value;
        if (!siGunGuCode)
            return;

        const siDo = this.regionData.find(region =>
            region.children.some(siGunGu => siGunGu.fullCode === siGunGuCode)
        );
        const siGunGu = siDo.children.find(item => item.fullCode === siGunGuCode);
        if (siGunGu && siGunGu.children) {
            this.populateSelectOptions(this.eupMyeonDongSelector, siGunGu.children, this.TYPE_KOR.EUPMYEONDONG);
            if (this.dongRiSelector)
                this.dongRiSelector.innerHTML = `<option value="">${this.TYPE_KOR.DONGRI} 선택</option>`;
        }
    }

    updateDongRi = () => {
        const eupMyeonDongCode = this.eupMyeonDongSelector.value;
        if (!eupMyeonDongCode)
            return;

        const siDo = this.regionData.find(region =>
            region.children.some(siGunGu =>
                siGunGu.children.some(eupMyeonDong => eupMyeonDong.fullCode === eupMyeonDongCode)
            )
        );
        const siGunGu = siDo.children.find(siGunGu =>
            siGunGu.children.some(eupMyeonDong => eupMyeonDong.fullCode === eupMyeonDongCode)
        );
        const eupMyeonDong = siGunGu.children.find(item => item.fullCode === eupMyeonDongCode);
        if (eupMyeonDong && eupMyeonDong.children)
            this.populateSelectOptions(this.dongRiSelector, eupMyeonDong.children, this.TYPE_KOR.DONGRI);
    }

    getNameByFullCode(fullCode) {
        const findName = (data, code) => {
            for (const item of data) {
                if (item.fullCode === code)
                    return item.name;

                if (item.children && item.children.length > 0) {
                    const name = findName(item.children, code);
                    if (name)
                        return name;
                }
            }
            return null;
        };

        return findName(this._regionData, fullCode);
    }

    getFullAddressName = () => {
        const addressNames = [];

        const siDoName = this.getNameByFullCode(this.siDoSelector.value);
        if (siDoName)
            addressNames.push(siDoName);

        const siGunGuName = this.getNameByFullCode(this.siGunGuSelector.value);
        if (siGunGuName)
            addressNames.push(siGunGuName);

        const eupMyeonDongName = this.getNameByFullCode(this.eupMyeonDongSelector.value);
        if (eupMyeonDongName)
            addressNames.push(eupMyeonDongName);

        if (this.dongRiSelector) {
            const dongRiName = this.getNameByFullCode(this.dongRiSelector.value);
            if (dongRiName)
                addressNames.push(dongRiName);
        }

        return {
            addressNames: addressNames,
            convertedName: addressNames.join(" ")
        };
    }
}