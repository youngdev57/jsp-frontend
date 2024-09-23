class ModalModule {
    constructor() {
        this._modalId = "";
        this._modalTitle = "";
    }

    get modalId() {
        return "modal-" + this._modalId;
    }

    set modalId(value) {
        this._modalId = value;
    }

    get modalTitle() {
        return this._modalTitle;
    }

    set modalTitle(value) {
        this._modalTitle = value;
    }

    generateModalContainer = () => {
        let innerElement = `
            <div id="${this.modalId}">
                <div class="modal-popup">
                    <header>
                        <span>${this.modalTitle}</span>
                        <div class="modal-close"><i class="bx bx-x"></i></div>
                    </header>
                    <div class="modal-content"></div>
                </div>
            </div>
        `;

        $("body").append(innerElement);
    }

    initialize = (id = "", title = "") => {
        this.modalId = id;
        this.modalTitle = title;
        this.generateModalContainer();

        const modalPopup = this.getScopedSelector(".modal-popup");
        const openerButton = $(`#${this.modalId}.modal-button`);
        const closerButton = this.getScopedSelector(".modal-close");

        openerButton.on("click", () => {
            $("body").append("<div class='modal-block'></div>");
            modalPopup.toggleClass("show");
        });
        closerButton.on("click", () => {
            modalPopup.removeClass("show");
            $(".modal-block").remove();
        });
    }

    getScopedSelector = (target = "") => {
        return $(`#${this.modalId} ${target}`);
    }
}