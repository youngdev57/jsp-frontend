class FileManagerModule {
    constructor(id) {
        this._id = id;
        this._callbackChange = null;
        this._callbackRemove = null;
        this._files = [];
        this._rootElement = null;
        this._maxCount = 5;
    }

    get id() {
        return this._id;
    }

    get files() {
        return this._files;
    }

    set files(value) {
        this._files = value;
    }

    get rootElement() {
        return this._rootElement;
    }

    set rootElement(value) {
        this._rootElement = value;
    }

    get maxCount() {
        return this._maxCount;
    }

    set maxCount(value) {
        this._maxCount = value;
    }

    get callbackChange() {
        return this._callbackChange;
    }

    set callbackChange(value) {
        this._callbackChange = value;
    }

    get callbackRemove() {
        return this._callbackRemove;
    }

    set callbackRemove(value) {
        this._callbackRemove = value;
    }

    /**
     * 파일매니저 초기화 함수
     * @param target
     * @param descriptions
     * @param fileOptions
     */
    initialize = (target, descriptions = [], fileOptions = {}) => {
        if (!this.id)
            throw new Error("invalid file-manager id.")

        target.innerHTML = this.makeFileContainer(descriptions, fileOptions);

        const fileElement = document.getElementById(`file-${this.id}`);
        fileElement.addEventListener("change", this.handleChangeFiles);
        this.rootElement = document.getElementById(`file-manager-${this.id}`);
    }

    makeFileContainer = (descriptions, fileOptions = {
        disabled: "disabled"
    }) => {
        const { disabled } = fileOptions;

        let container = "";
        container += `
            <div id="file-manager-${this.id}" class="file-manager flex-column">
                <div class="flex gap-20" style="align-items: center">
                    <label for="file-${this.id}">파일 첨부하기 <span class="file-count">(0/5)</span></label>
                    <input id="file-${this.id}" type="file" accept="" multiple ${disabled} />
                    <div class="description">
                        <ul>`;

        descriptions.forEach(description => {
            container += `<li>※ ${description}</li>`;
        })

        container += `
                        </ul>
                    </div>
                </div>
                <div class="selected-wrapper flex-column gap-10"></div>
            </div>
        `;

        return container;
    }

    handleChangeFiles = () => {
        const target = document.getElementById(`file-${this.id}`);
        const newFiles = Array.from(target.files);

        if ((this.files.length + newFiles.length) > this.maxCount)
            return alert(`최대 ${this.maxCount}까지 등록 가능합니다.`);

        this.files = this.files.concat(newFiles);
        this.renderFileList();

        if (this.callbackChange)
            this.callbackChange();
    }

    /**
     * 목록 내 파일 제거 함수
     */
    handleRemoveAttachedFile = (e) => {
        let fileName = e.target.dataset.file || "";

        const target = this.rootElement.querySelector(`[data-name="${fileName}"]`).closest("div");
        if (target) {
            const foundIndex = this.files.findIndex(file => file.name === fileName);
            if (foundIndex > -1)
                this.files.splice(foundIndex, 1);

            target.remove();
        }

        const fileCount = this.rootElement.querySelector(".file-count");
        fileCount.textContent = `(${this.files.length}/${this.maxCount})`;

        if (this.callbackRemove)
            this.callbackRemove();
    }

    /**
     * 원본 파일 세팅 함수
     * @param originFiles
     */
    setOriginFiles = (originFiles = []) => {
        if (originFiles.length === 0)
            return;

        this.files = originFiles.map(file => {
            return {
                name: file.fileName,
                id: file.fileNo
            }
        })

        this.renderFileList();
    }

    /**
     * API 요구사항에 맞춘 파일 리스트를 반환하는 함수
     * @returns {{newFiles: *[], originFiles: *[]}}
     */
    getProcessedFiles = () => {
        const processed = {
            originFiles: [],
            newFiles: []
        };

        this.files.forEach(file => {
            const isOriginFile = file.id && file.id > 0;
            isOriginFile ? processed.originFiles.push(file.id) : processed.newFiles.push(file);
        })

        return processed;
    }

    /**
     * 파일 배열 기반으로 목록 요소를 생성하는 함수
     */
    renderFileList = () => {
        function getReadableFileSizeString(fileSizeInBytes) {
            let i = -1;
            const byteUnits = [' kB', ' MB', ' GB', ' TB', 'PB', 'EB', 'ZB', 'YB'];
            do {
                fileSizeInBytes /= 1024;
                i ++;
            } while (fileSizeInBytes > 1024);

            return Math.max(fileSizeInBytes, 0.1).toFixed(1) + byteUnits[i];
        }

        let innerElement = "";

        this.files.forEach(file => {
            innerElement += `
                <div class="file-item-container" data-name="${file.name}">
                    <div class="file-name flex gap-20"><span>💾</span>${file.name}</div>
                    <div class="flex gap-20">
                        <div class="file-size">${getReadableFileSizeString(file.size)}</div>
                        <button type="button" class="btn-remove-attached" data-file="${file.name}"></button>
                    </div>
                </div>
            `
        })

        this.rootElement.querySelector(".selected-wrapper").innerHTML = innerElement;
        this.rootElement.querySelector(".file-count").textContent = `(${this.files.length}/${this.maxCount})`;

        const buttonElement = document.querySelectorAll(".btn-remove-attached");
        buttonElement.forEach(button => {
            button.addEventListener("click", this.handleRemoveAttachedFile);
        })
    }

    /**
     * 첨부파일 최대 개수 설정
     * @param maxCount
     */
    setMaxCount = (maxCount = 5) => {
        this.maxCount = maxCount;
        this.rootElement.querySelector(".file-count").textContent = `(${this.files.length}/${this.maxCount})`;
    }

    /**
     * 파일매니저의 허용 확장자를 지정하는 함수
     * @param accepts
     */
    setAcceptFileManager = (accepts = []) => {
        const list = [];
        accepts.forEach(accept => {
            switch (accept) {
                case "jpg":
                case "jpeg":
                    list.push("image/jpeg");
                    break;
                case "gif":
                    list.push("image/gif");
                    break;
                case "png":
                    list.push("image/png");
                    break;
                case "pdf":
                    list.push("application/pdf");
                    break;
                case "excel":
                    list.push(".xlsx, .xls, application/haansoftxlsx, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel, application/vnd.msexcel");
                    break;
                case "txt":
                    list.push("text/plain");
                    break;
                case "ppt":
                    list.push("vnd.sealed.ppt, application/vnd.ms-powerpoint, application/vnd.openxmlformats-officedocument.presentationml.presentation");
                    break;
                case "xml":
                    list.push("application/xml, text/xml");
                    break;
                case "zip":
                    list.push("application/zip");
                    break;
                case "hwp":
                    list.push("application/x-hwp");
                    break;
                default:
                    list.push(accept);
            }
        })

        const acceptValue = list.join(", ");

        const targetElement = document.getElementById(`file-${this.id}`);
        targetElement.setAttribute("accept", acceptValue);
    }
}