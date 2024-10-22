/**
 * 에러 객체를 핸들링하는 함수
 * @param error
 */
function handleServerErrorMessage(error) {
    const unauthorized = error === "error/403";
    if (unauthorized)
        return location.href = "/login";

    let message = error.message ? error.message : error;
    alert(message);
    throw new Error(message);
}

/**
 필수 입력값을 요청하는 Alert를 표시하는 함수
 data-required="true" 속성으로 대상을 지정
 * @param selector
 */
function alertRequiredMessage(selector) {
    const actions = {
        SELECT: "선택",
        RADIO: "선택",
        DATE: "선택",
        TEXTAREA: "작성",
        CHECKBOX: "체크",
        FILE: "업로드",
        INPUT: "입력",
        NUMBER: "입력",
        TEL: "입력",
        EMAIL: "입력"
    }

    document.querySelectorAll(selector).forEach(function (element) {
        const founds = element.querySelectorAll('[data-required="true"]');
        for (const found of founds) {
            const label = element.querySelector(`label[for="${found.id}"]`).textContent || "";
            if (!label || found.value) continue;

            const target = {
                label: label,
                tagName: found.tagName.toUpperCase()
            };

            if (!target) return;

            alert(`${target.label}을(를) ${actions[target.tagName]}해 주세요.`);
            return;
        }
    });
}

/**
 * URL에 포함된 쿼리 파라미터를 JSON 객체 형식으로 반환하는 함수
 * @param url
 * @returns {{}}
 */
function convertQueryParameterToJson(url = "") {
    let parameter = url ? url : window.location.search;
    parameter = parameter.replace("?", "");
    const divided = parameter.split("&");

    const result = {};
    divided.forEach(element => {
        const key = element.split("=")[0];
        let value = element.split("=")[1];

        if (value === "true" || value === "false")
            value = JSON.parse(value);

        result[key] = value;
    });
    return result;
}

/**
 * data-field 기반으로 요청 데이터를 만들어주는 함수
 * @returns []
 */
function generateValidDataFromField() {
    const result = {};
    const fields = [];

    document.querySelectorAll(`[data-field="true"]`).forEach(field => {
        const { id, value, tagName } = field;
        const label = document.querySelector(`label[for="${id}"]`);
        const labelText = label ? label.innerText : null;

        fields.push({
            key: id || null,
            value: value || null,
            label: labelText,
            tagName: tagName || null
        });
    })

    const processed = {};
    fields.map(field => processed[field.key] = field.value);

    result.fields = fields;
    result.processed = processed;

    return result;
}

/**
 * 에디터 내용을 HTML File로 내보내기하는 함수
 * content param의 경우 getData()를 이용
 * @param content
 * @param fileName
 * @returns {File}
 */
function generateHTMLFromEditor(content = "", fileName = "") {
    const blob = new Blob([content], { type: "text/html" });
    return new File([blob], `${fileName}.html`, { type: "text/html" });
}

/**
 * HTML 데이터에서 text만 추출하는 함수
 * @param html
 * @returns {string}
 */
function getPlainTextFromHTML(html = "") {
    const parser = new DOMParser();
    const doc = parser.parseFromString(html, 'text/html');
    let allText = "";
    const textNodes = doc.createTreeWalker(doc.body, NodeFilter.SHOW_TEXT);
    while (textNode = textNodes.nextNode()) {
        allText += textNode.nodeValue.trim() + ' ';
    }
    return allText;
}

/**
 * 페이지 동작을 핸들링하는 함수
 */
function handleCurrentPage(action = "") {
    const ACTION_TYPE = {
        BACK: "back",
        RELOAD: "reload"
    }
    switch (action) {
        case ACTION_TYPE.BACK:
            return history.go(-1);
        case ACTION_TYPE.RELOAD:
            return history.go(0);
    }
}

/**
 * 공통 코드 기반으로 select option을 구성하는 함수
 * @param commonCode
 * @param textAll
 * @returns {*[]}
 */
function generateSelectOptions(commonCode, textAll = "") {
    const options = [];
    if (textAll)
        options.push({ value: "", text: textAll });
    for (const key in commonCode)
        options.push({ value: key, text: commonCode[key] });

    return options;
}

/**
 * 코드 값으로 공통 코드의 KEY를 찾는 함수
 * @param value
 * @returns {string}
 */
function getReversedCommonCode(value = "") {
    const commonCode = {
        ...LanguageType,
        ...CertificateType
    }

    let found = "";
    for (const commonCodeKey in commonCode) {
        if (commonCode[commonCodeKey] === value)
            found = commonCodeKey;
    }
    return found ? found : "";
}

/**
 * 권한이 필요한 파일을 다운로드하는 함수
 * @param fileName
 * @param downloadURL
 * @param requestParam
 * @param responseType
 * @returns {Promise<void>}
 */
async function downloadAuthorizedFile(fileName = "file", { downloadURL = "", requestParam, responseType}) {
    function checkIncludeExtension(fileName) {
        const regex = /\.[0-9a-z]+$/i;
        return regex.test(fileName);
    }

    if (!downloadURL)
        throw new Error("Cannot found download URL.");

    const response = await Api.get(downloadURL, requestParam, responseType);
    if (!response || !response.data)
        throw new Error("Fail download file.");

    let fullFileName = fileName;
    if (!checkIncludeExtension(fileName)) {
        const contentType = response.data.type;
        const extension = contentType.split("/")[1];
        fullFileName = extension ? `${fileName}.${extension}` : fileName;
    }

    const fileURL = URL.createObjectURL(response.data);
    const a = document.createElement("a");
    a.href = fileURL;
    a.download = fullFileName;
    document.body.appendChild(a);
    a.click();

    window.URL.revokeObjectURL(fileURL);
    document.body.removeChild(a);
}

/**
 * 핸드폰 번호 유효성 검사 및 변환 함수
 * @param number
 * @param delimiter
 * @returns {string|null}
 */
const convertMobileFormat = (number = "", delimiter = "-") => {
    const mobile1 = number.slice(0, 3);
    const mobile2 = number.slice(3, 7);
    const mobile3 = number.slice(7, 11);

    const phoneNumber = `${mobile1}-${mobile2}-${mobile3}`;
    const phoneNumberPattern = /^010-\d{4}-\d{4}$/;

    const isValid = phoneNumberPattern.test(phoneNumber);
    return isValid ? phoneNumber.replaceAll("-", delimiter) : null;
}

/**
 * 생년월일 변환 함수
 * @param birthday
 * @param delimiter
 * @returns {`${string}-${string}-${string}`}
 */
const convertBirthdayFormat = (birthday = "", delimiter = "-") => {
    const birthday1 = birthday.slice(0, 4);
    const birthday2 = birthday.slice(4, 6);
    const birthday3 = birthday.slice(6, 8);

    return `${birthday1}${delimiter}${birthday2}${delimiter}${birthday3}`;
}