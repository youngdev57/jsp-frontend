<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section>
    <h1>CK Editor</h1>
    <div id="ckEditor"></div>
    <div style="margin: 20px 0">
        <button onclick="getEditorContent('ck')" style="float: right">내용 가져오기</button>
    </div>
    <br>
    <h1>toast UI Editor</h1>
    <div id="toastEditor"></div>
    <div style="margin: 20px 0">
        <button onclick="getEditorContent('toast')" style="float: right">내용 가져오기</button>
    </div>
</section>

<script>
    let $editor = {
        ck: document.getElementById("ckEditor"),
        toast: document.getElementById("toastEditor")
    }

    const initializeEditor = () => {
        function handleError(error) {
            const issueURL = 'https://github.com/ckeditor/ckeditor5/issues';
            const message = `Report the following error on ${"${issueURL}"} with the build id "gk04h2aqjilr-nohdljl880ze" and the error stack trace:`;
            console.error(message);
            console.error(error);
        }

        _ckEditor
            .create($editor.ck)
            .then(editor => {
                $editor.ck = editor;
            })
            .catch(handleError);

        _toastEditor = new toastui.Editor({
            el: $editor.toast,
            height: "500px",
            initialEditType: "wysiwyg",
            initialValue: "",
            previewStyle: "vertical"
        })
    }

    const getEditorContent = (type = "") => {
        const content = type === "ck" ? $editor[type].getData() : _toastEditor.getHTML();
        openSuccess(type + "Editor", content);
    }

    function openSuccess(title = "", text = "") {
        _alert.fire({
            icon: "success",
            title: title,
            text: text
        });
    }

    initializeEditor();
</script>

<style>
    .ck-editor__editable {
        min-height: 300px;
    }
</style>