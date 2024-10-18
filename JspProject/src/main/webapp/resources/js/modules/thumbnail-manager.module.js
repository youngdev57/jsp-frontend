class ThumbnailManagerModule {
    constructor(id) {
        this._id = id;
        this._callbackChange = null;
        this._callbackRemove = null;
        this._thumbnail = null;
        this._rootElement = null;
        this._useTempFile = true;
    }

    get id() {
        return this._id;
    }

    get thumbnail() {
        return this._thumbnail;
    }

    set thumbnail(value) {
        this._thumbnail = value;
    }

    get rootElement() {
        return this._rootElement;
    }

    set rootElement(value) {
        this._rootElement = value;
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

    get useTempFile() {
        return this._useTempFile;
    }

    set useTempFile(value) {
        this._useTempFile = value;
    }

    /**
     * 썸네일매니저 초기화 함수
     * @param target
     * @param descriptions
     * @param fileOptions
     */
    initialize = (target, descriptions = [], fileOptions = {}) => {
        if (!this.id)
            throw new Error("invalid file-manager id.")

        target.innerHTML = this.makeFileContainer(descriptions, fileOptions);

        const thumbnailElement = document.getElementById(`thumbnail-${this.id}`);
        thumbnailElement.addEventListener("change", this.handleChangeFile);
        this.rootElement = document.getElementById(`thumbnail-manager-${this.id}`);
    }

    makeFileContainer = (descriptions, fileOptions = {
        disabled: "disabled"
    }) => {
        const { disabled } = fileOptions;

        let container = "";
        container += `
            <div id="thumbnail-manager-${this.id}" class="thumbnail-manager flex-column">
                <div class="flex gap-20">
                    <label for="thumbnail-${this.id}">파일 선택</label>
                    <input id="thumbnail-${this.id}" type="file" accept="" multiple ${disabled} />
                    <div class="thumbnail-container"></div>
                </div>
                <div class="description">
                    <ul>`;

        descriptions.forEach(description => {
            container += `<li>※ ${description}</li>`;
        })

        container += `
                    </ul>
                </div>
            </div>
        `;

        return container;
    }

    handleChangeFile = (changeEvent) => {
        let file = changeEvent.target.files[0];
        if (!file)
            return;

        let fileReader = new FileReader();
        fileReader.onload = (loadEvent) => {
            const container = this.rootElement.querySelector(".thumbnail-container");
            container.innerHTML = `
                <div class="thumbnail-wrapper">
                    <img src="${loadEvent.target.result}" alt="${file.name || ''} 이미지" />
                    <button type="button" class="btn-remove-attached"></button>
                    <div class="thumbnail-name ellipsis">${file.name || ''}</div>                
                </div>
            `;

            const buttonElement = this.rootElement.querySelectorAll(".btn-remove-attached");
            buttonElement.forEach(button => {
                button.addEventListener("click", this.handleRemoveAttachedFile);
            })
        }

        fileReader.readAsDataURL(file);

        this.thumbnail = file;

        if (this.callbackChange)
            this.callbackChange();
    }

    /**
     * 썸네일 제거 함수
     */
    handleRemoveAttachedFile = (e) => {
        let fileName = e.target.dataset.file || "";

        const container = this.rootElement.querySelector(".thumbnail-container");
        container.innerHTML = "";
        this.thumbnail = null;

        if (this.callbackRemove)
            this.callbackRemove();
    }

    /**
     * 원본 썸네일 세팅 함수
     * @param originThumbnail
     */
    setOriginThumbnail = (originThumbnail) => {
        if (!originThumbnail)
            return;

        this.thumbnail = originThumbnail;
        this.renderThumbnailViewer();
    }

    /**
     * 선택된 파일을 반환하는 함수
     */
    getSelectedThumbnail = () => {
        return this.thumbnail || null;
    }

    /**
     * 썸네일 미리보기 기능
     */
    renderThumbnailViewer = () => {
        let innerElement = "";

        innerElement += `
            <div class="thumbnail-wrapper">
                <img src="${this.thumbnail}" alt="이미지" />
                <button type="button" class="btn-remove-attached"></button>
            </div>
        `

        this.rootElement.querySelector(".thumbnail-container").innerHTML = innerElement;

        const buttonElement = this.rootElement.querySelectorAll(".btn-remove-attached");
        buttonElement.forEach(button => {
            button.addEventListener("click", this.handleRemoveAttachedFile);
        })
    }

    /**
     * 썸네일 매니저의 허용 확장자를 지정하는 함수
     * @param accepts
     */
    setAcceptThumbnailManager = (accepts = []) => {
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
                default:
                    list.push(accept);
            }
        })

        const acceptValue = list.join(", ");

        const targetElement = document.getElementById(`thumbnail-${this.id}`);
        targetElement.setAttribute("accept", acceptValue);
    }
}