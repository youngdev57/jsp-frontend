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
        $(".pager-header").empty();
        $(".pager-indicator").empty();
        this.loader = null;
    }

    initialize() {
        this.clear();
        const indicatorElement = $(".pager-indicator");

        let indicators = ``;
        // this.calculateRange(this.currentPage);

        // if (this.currentPage - 1 > 4) {
            indicators += this.switchButton(IndicatorButtonType.FIRST, {
                isActive: !this.isFirstPage
            });
            indicators += this.switchButton(IndicatorButtonType.PREV, {
                isActive: !this.isFirstPage
            });
        // }

        const endIndex = Math.min(this.totalPages, this.maxNumber);
        // for (let index = this.minNumber; index <= endIndex; index ++) {
        for (let index = this.minNumber; index <= this.minNumber + 9; index ++) {
            indicators += index <= this.totalPages
                ? this.switchButton(IndicatorButtonType.INDEX, { index: index })
                : this.switchButton(IndicatorButtonType.INDEX, { index: index, isOverPage: true });
        }

        // const lastPageBlockNumber =
        //     this.totalPages % 5 === 0
        //         ? this.totalPages - 4
        //         : this.totalPages - (this.totalPages % 5) + 1;

        // if (lastPageBlockNumber > this.currentPage) {
            indicators += this.switchButton(IndicatorButtonType.NEXT, {
                isActive: !this.isLastPage
            });
            indicators += this.switchButton(IndicatorButtonType.LAST, {
                isActive: !this.isLastPage
            });
        // }

        if (this.actionIndicator) {
            const opened = `<div class="pager-button-wrapper">`;
            const closed = `</div>`;
            indicators += opened + this.actionIndicator.join() + closed;
        }

        indicatorElement.empty();
        indicatorElement.append(indicators);
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

        const pagerInfoElement = target ? target : $(".pager-info");
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

        pagerInfoElement.html(countInfoElement + selectElement);

        if (customElements && customElements.length > 0) {
            const target = $("#select-countPerPage");
            customElements.forEach(item => {
                item.position === "before"
                    ? target.before(item.element)
                    : target.after(item.element);
            })
        }
    }

    setPagerLoader(loader) {
        this.loader = loader;
    }

    setPagerHeader(headers= [], sortingItems = [], headerWidths = []) {
        const headerElement = $(".pager-header");
        headerElement.empty();

        const sortingIndexes = sortingItems ? sortingItems.map(item => item.index) : null;
        headers.forEach((header, index) => {
            const isSortColumn = sortingIndexes ? sortingIndexes.includes(index) : false;
            if (isSortColumn) {
                const found = sortingItems.find(item => item.index === index);
                if (found) {
                    const propertyName = found.propertyName || "";
                    const direction = propertyName === this.sortInfo.sortColumn
                        ? this.sortInfo.sortDirection : "";
                    return headerElement.append(`<th class="sortable ${direction}" data-property="${propertyName}">${header || ""}</th>`);
                }
            }
            let widthStyle = "";
            if (headerWidths)
                widthStyle = "width: " + (headerWidths[index] ? headerWidths[index] : "auto");

            headerElement.append(`<th style="${widthStyle}">${header || ""}</th>`);
        });
        $("th.sortable").on("click", (event) => this.handleSortHeader($(event.currentTarget)));
    }

    handleSortHeader(target) {
        if (!target)
            return;

        const ORDER_TYPE = {
            ASC: "asc",
            DESC: "desc"
        }

        const currentClass = target.attr("class").replace("sortable", "").trim();
        this.sortInfo.sortColumn = target.data("property");
        switch (currentClass) {
            case ORDER_TYPE.ASC:
                target.removeClass(ORDER_TYPE.ASC);
                this.sortInfo.sortDirection = "";
                break;
            case ORDER_TYPE.DESC:
                target.removeClass(ORDER_TYPE.DESC);
                target.addClass(ORDER_TYPE.ASC);
                this.sortInfo.sortDirection = ORDER_TYPE.ASC;
                break;
            default:
                target.addClass(ORDER_TYPE.DESC);
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
        const indicatorElement = $(".pager-indicator");
        const $prevButton = indicatorElement.find(".prev");
        const $nextButton = indicatorElement.find(".next");
        const $firstButton = indicatorElement.find(".first");
        const $lastButton = indicatorElement.find(".last");
        const $otherIndicator = indicatorElement.find(".indicator");

        if ($firstButton.length > 0 && this.currentPage !== 1) {
            // $prevButton.click(e => this.loader(this.minNumber - 1));
            $prevButton.click(e => this.loader(this.prePage));
            $firstButton.click(e => this.loader(1));
        }
        if ($lastButton.length > 0 && this.currentPage !== this.totalPages) {
            // $nextButton.click(e => this.loader(this.maxNumber + 1));
            $nextButton.click(e => this.loader(this.nextPage));
            $lastButton.click(e => this.loader(this.totalPages));
        }
        $otherIndicator.click(e => {
            const targetPage = +e.target.innerText;
            if (this.currentPage !== targetPage)
                this.loader(+e.target.innerText);
        });
    }
}