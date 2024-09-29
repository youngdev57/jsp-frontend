<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="form" class="guide-container">
    <t:information title="Form" parentDir="common" />
    <t:callout description="프로젝트에 자주 이용되는 공통 Form 입니다." />

    <section class="mt-20">
        <%-- input --%>
        <div class="flex-column gap-20 mt-40">
            <h2 class="common-title">Form Input</h2>
            <div class="common-form-wrapper">
                <div>
                    <div class="column-header"><label for="single">단일 항목</label></div>
                    <div class="column-content flex-start">
                        <input id="single" type="text" placeholder="안내 제공 텍스트를 입력해 주세요.">
                        <p class="notice">※ 해당 입력창에 대한 안내말을 입력할 수 있습니다.</p>
                    </div>
                </div>
                <div class="multi-column-wrapper">
                    <div>
                        <div class="column-header"><label for="multi01">다중 항목1</label></div>
                        <div class="column-content">
                            <input id="multi01" type="date" placeholder="yyyy-MM-dd" data-field="true">
                        </div>
                    </div>
                    <div>
                        <div class="column-header"><label>다중 항목2</label></div>
                        <div class="column-content">
                            <label for="checkbox01">
                                <input id="checkbox01" type="checkbox" class="checkbox-group" />옵션1
                            </label>
                            <label for="checkbox02">
                                <input id="checkbox02" type="checkbox" class="checkbox-group" />옵션2
                            </label>
                        </div>
                    </div>
                </div>
                <div>
                    <div class="column-header"><label for="radioGroupText">라디오 버튼</label></div>
                    <div class="column-content gap-30">
                        <label class="flex gap-10 pd-0"><input id="radio01" type="radio" name="radioGroup" checked>선택1</label>
                        <label class="flex gap-10 pd-0"><input id="radio02" type="radio" name="radioGroup">선택2</label>
                        <label class="flex gap-10 pd-0"><input id="radio03" type="radio" name="radioGroup">기타</label>
                        <input id="radioGroupText" type="text">
                    </div>
                </div>
                <div>
                    <div class="column-header"><label for="select">선택 항목</label></div>
                    <div class="column-content">
                        <select id="select" data-field="true">
                            <option disabled selected style="display: none" value="">선택</option>
                            <option value="선택1">선택1</option>
                            <option value="선택2">선택2</option>
                        </select>
                    </div>
                </div>
                <div class="column-textarea-wrapper">
                    <div class="column-header"><label for="textarea">텍스트 상자</label></div>
                    <div class="column-content">
                        <textarea id="textarea" placeholder="텍스트 상자에 대한 도움말을 입력해 주세요."></textarea>
                    </div>
                </div>
            </div>
            <div class="common-form-button-wrapper">
                <button class="tertiary" onclick="resetFormInput()">되돌리기</button>
                <button class="primary" onclick="applyFormOutput()">적용하기</button>
            </div>
        </div>

        <%-- output --%>
        <div class="flex-column gap-20 mt-40">
            <h2 class="common-title">Form output</h2>
            <div class="common-form-wrapper">
                <div>
                    <div class="column-header">단일 항목</div>
                    <div class="column-content single">단일 항목 1에 관한 내용입니다.</div>
                </div>
                <div class="multi-column-wrapper">
                    <div>
                        <div class="column-header">다중 항목1</div>
                        <div class="column-content multi01">2024-01-01</div>
                    </div>
                    <div>
                        <div class="column-header">다중 항목2</div>
                        <div class="column-content checkboxes">옵션1</div>
                    </div>
                </div>
                <div>
                    <div class="column-header">라디오 버튼</div>
                    <div class="column-content radios">선택1</div>
                </div>
                <div>
                    <div class="column-header">선택 항목</div>
                    <div class="column-content select">선택</div>
                </div>
                <div class="column-textarea-wrapper">
                    <div class="column-header">텍스트 상자</div>
                    <div class="column-content textarea">
                        모든 국민은 근로의 의무를 진다. 국가는 근로의 의무의 내용과 조건을 민주주의원칙에 따라 법률로 정한다.
                        근로자는 근로조건의 향상을 위하여 자주적인 단결권·단체교섭권 및 단체행동권을 가진다.
                        대통령이 궐위된 때 또는 대통령 당선자가 사망하거나 판결 기타의 사유로 그 자격을 상실한 때에는 60일 이내에 후임자를 선거한다. <br><br>
                        대통령은 조국의 평화적 통일을 위한 성실한 의무를 진다. 제2항의 재판관중 3인은 국회에서 선출하는 자를, 3인은 대법원장이 지명하는 자를 임명한다.
                        이 헌법중 공무원의 임기 또는 중임제한에 관한 규정은 이 헌법에 의하여 그 공무원이 최초로 선출 또는 임명된 때로부터 적용한다.
                        탄핵결정은 공직으로부터 파면함에 그친다. 그러나, 이에 의하여 민사상이나 형사상의 책임이 면제되지는 아니한다.
                    </div>
                </div>
            </div>
            <div class="common-form-button-wrapper">
                <button class="tertiary" onclick="resetFormOutput()">되돌리기</button>
            </div>
        </div>
    </section>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        initializeForm();
    })

    const initializeForm = () => {
        resetFormInput();
        resetFormOutput();
    }

    const resetFormInput = () => {
        const targetIds = ["single", "multi01", "select", "textarea"];
        targetIds.forEach(elementId => document.getElementById(elementId).value = "");

        const checkboxes = document.querySelectorAll(".checkbox-group");
        [...checkboxes].forEach(checkbox => checkbox.checked = false);

        // TODO radio button
    }

    const resetFormOutput = () => {

    }

    const applyFormOutput = () => {
        const targetIds = ["single", "multi01", "select", "textarea"];
        targetIds.forEach(elementId => {
            const element = document.getElementById(elementId);
            const matched = document.querySelector('.' + elementId);
            matched.textContent = element.value || "";
        })

        const checkboxes = document.querySelectorAll(".checkbox-group");
        const checked = [...checkboxes].filter(checkbox => checkbox.checked);
        const labels = checked.map(checkbox => {
            const label = document.querySelector(`label[for="${'${checkbox.id}'}"]`);
            return label ? getPlainTextFromHTML(label.textContent).trim() : null;
        })

        const checkboxOutput = document.querySelector(".checkboxes");
        checkboxOutput.textContent = labels.join(", ");

        // TODO radio button
    }
</script>