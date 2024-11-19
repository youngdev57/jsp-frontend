class PagerModule {
    pager;
    loader;
    currentPage;
    totalPages;
    sizePerPage;
    totalCount;
    minNumber;
    maxNumber;
    actionIndicator;

    constructor() {
        this.pager = null;
        this.loader = null;
        this.currentPage = 1;
        this.totalPages = 1;
        this.sizePerPage = 10;
        this.totalCount = 0;
        this.isFirstPage = null;
        this.isLastPage = null;
        this.actionIndicator = null;
        this.prePage = null;
        this.nextPage = null;
        this.sortInfo = {
            sortColumn: "",
            sortDirection: ""
        };
    }

    clear() {
        const pagerHeader = document.querySelector(".pager-header");
        const pagerIndicator = document.querySelector(".pager-indicator");

        if (pagerHeader)
            pagerHeader.innerHTML = "";
        if (pagerIndicator)
            pagerIndicator.innerHTML = "";

        this.loader = null;
    }

    initialize() {
        this.clear();
        const indicatorElement = document.querySelector(".pager-indicator");

        let indicators = ``;
        indicators += this.switchButton(IndicatorButtonType.FIRST, {
            isActive: !this.isFirstPage
        });
        indicators += this.switchButton(IndicatorButtonType.PREV, {
            isActive: !this.isFirstPage
        });

        for (let index = this.minNumber; index <= this.minNumber + 9; index ++) {
            indicators += index <= this.totalPages
                ? this.switchButton(IndicatorButtonType.INDEX, { index: index })
                : this.switchButton(IndicatorButtonType.INDEX, { index: index, isOverPage: true });
        }

        indicators += this.switchButton(IndicatorButtonType.NEXT, {
            isActive: !this.isLastPage
        });
        indicators += this.switchButton(IndicatorButtonType.LAST, {
            isActive: !this.isLastPage
        });

        if (this.actionIndicator) {
            const opened = `<div class="pager-button-wrapper">`;
            const closed = `</div>`;
            indicators += opened + this.actionIndicator.join() + closed;
        }

        if (indicatorElement) {
            indicatorElement.innerHTML = "";
            indicatorElement.insertAdjacentHTML("beforeend", indicators);
        }

        this.setIndicatorEvent();
    }

    setPagerInformation(response, options = {}) {
        const { target, actionIndicator, customElements } = options;
        const pagerInformation = response.data.data;
        this.currentPage = pagerInformation.pageNum || 1;
        this.totalPages = pagerInformation.pages || 1;
        this.sizePerPage = pagerInformation.pageSize || 10;
        this.totalCount = pagerInformation.total || 0;
        this.isFirstPage = pagerInformation.isFirstPage || false;
        this.isLastPage = pagerInformation.isLastPage || false;
        this.prePage = pagerInformation.prePage;
        this.nextPage = pagerInformation.nextPage;
        this.minNumber = 1;
        this.maxNumber = 5;
        this.actionIndicator = actionIndicator;

        const pagerInfoElement = target || document.querySelector(".pager-info");
        const countInfoElement = `
            <div class="count-info">
                전체 <b>${this.totalCount}건</b> | 현재 페이지 <b>${this.currentPage}</b>/${this.totalPages}
            </div>
        `;

        let selectElement = "";
        if (options.hideCountPerPage !== true) {
            const countPerPages = options.countPerPages ? options.countPerPages : [10, 20, 50];
            let countPerPageElement = `<select id="select-countPerPage">`;
            countPerPages.forEach((page, index) => {
                countPerPageElement += `<option value="${page}">${page}건씩 보기</option>`;
            })
            countPerPageElement += `</select>`;

            selectElement += "<div class='flex gap-10'>";
            selectElement += countPerPageElement;
            selectElement += "</div>";
        }

        if (pagerInfoElement)
            pagerInfoElement.innerHTML = countInfoElement + selectElement;


        if (customElements && customElements.length > 0) {
            const targetSelect = document.getElementById("select-countPerPage");
            customElements.forEach(item => {
                const element = document.createElement("div");
                element.innerHTML = item.element;
                if (targetSelect) {
                    if (item.position === "before")
                        targetSelect.parentElement.insertBefore(element.firstChild, targetSelect);
                    else
                        targetSelect.parentElement.insertBefore(element.firstChild, targetSelect.nextSibling);
                }
            });
        }
    }

    setPagerLoader(loader) {
        this.loader = loader;
    }

    setPagerHeader(headers= [], sortingItems = [], headerWidths = []) {
        const headerElement = document.querySelector(".pager-header");
        if (!headerElement)
            return;

        headerElement.innerHTML = "";

        const sortingIndexes = sortingItems ? sortingItems.map(item => item.index) : null;
        headers.forEach((header, index) => {
            const isSortColumn = sortingIndexes ? sortingIndexes.includes(index) : false;
            const th = document.createElement("th");

            if (isSortColumn) {
                const found = sortingItems.find(item => item.index === index);
                if (found) {
                    const propertyName = found.propertyName || "";
                    const direction = propertyName === this.sortInfo.sortColumn
                        ? this.sortInfo.sortDirection
                        : "";

                    th.className = `sortable ${direction}`;
                    th.setAttribute("data-property", propertyName);
                    th.innerHTML = header || "";
                    headerElement.appendChild(th);
                    return;
                }
            }

            th.style.width = headerWidths && headerWidths[index] ? headerWidths[index] : "auto";

            th.innerHTML = header || "";
            headerElement.appendChild(th);
        });

        const sortableHeaders = headerElement.querySelectorAll("th.sortable");
        sortableHeaders.forEach(th => {
            th.addEventListener("click", event => this.handleSortHeader(event.currentTarget));
        });
    }

    handleSortHeader(target) {
        if (!target)
            return;

        const ORDER_TYPE = {
            ASC: "asc",
            DESC: "desc"
        }

        const currentClass = target.className.replace("sortable", "").trim();
        this.sortInfo.sortColumn = target.getAttribute("data-property");
        switch (currentClass) {
            case ORDER_TYPE.ASC:
                target.classList.remove(ORDER_TYPE.ASC);
                this.sortInfo.sortDirection = "";
                break;
            case ORDER_TYPE.DESC:
                target.classList.remove(ORDER_TYPE.DESC);
                target.classList.add(ORDER_TYPE.ASC);
                this.sortInfo.sortDirection = ORDER_TYPE.ASC;
                break;
            default:
                target.classList.add(ORDER_TYPE.DESC);
                this.sortInfo.sortDirection = ORDER_TYPE.DESC;
        }

        this.loader();
    }

    getPagerSortInfo() {
        return this.sortInfo;
    }

    switchButton(type, option) {
        switch (type) {
            case IndicatorButtonType.FIRST:
            case IndicatorButtonType.LAST:
            case IndicatorButtonType.PREV:
            case IndicatorButtonType.NEXT:
                return this.createControlIndicatorElements(type, option);
            default:
                return this.createIndicatorElements("indicator " + option.index, option);
        }
    }

    createIndicatorElements(action, option) {
        let className = `${action}${this.currentPage === option.index ? " active" : ""}`;
        className += option.isOverPage ? " over" : "";
        return `<button data-type="${action}" class="${className}">${option.index || ''}</button>`;
    }

    createControlIndicatorElements(action, option) {
        let className = `${action}${this.currentPage === option.index ? " active" : ""}`;
        className += option.isActive ? " on" : "";
        return `<button data-type="${action}" class="${className}">${option.index || ''}</button>`;
    }

    calculateRange(input) {
        let startNumber = Math.floor((input - 1) / 5) * 5 + 1;
        this.minNumber = startNumber;
        this.maxNumber = startNumber + 4;
    }

    setIndicatorEvent() {
        const indicatorElement = document.querySelector(".pager-indicator");
        const prevButton = indicatorElement.querySelector(".prev");
        const nextButton = indicatorElement.querySelector(".next");
        const firstButton = indicatorElement.querySelector(".first");
        const lastButton = indicatorElement.querySelector(".last");
        const otherIndicators = indicatorElement.querySelectorAll(".indicator");

        if (firstButton.length > 0 && this.currentPage !== 1) {
            prevButton?.addEventListener("click", () => this.loader(this.prePage));
            firstButton.addEventListener("click", () => this.loader(1));
        }
        if (lastButton.length > 0 && this.currentPage !== this.totalPages) {
            nextButton?.addEventListener("click", () => this.loader(this.nextPage));
            lastButton.addEventListener("click", () => this.loader(this.totalPages));
        }

        otherIndicators.forEach(indicator => {
            indicator.addEventListener("click", e => {
                const targetPage = parseInt(e.target.innerText, 10);
                if (this.currentPage !== targetPage)
                    this.loader(targetPage);
            });
        });
    }
}