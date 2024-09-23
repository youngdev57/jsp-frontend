<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="grid" class="guide-container">
    <t:information title="Grid" parentDir="Common" />
    <t:callout description="프로젝트에 자주 이용되는 공통 Grid 입니다." />

    <section class="mt-20">
        <%-- input --%>
        <div class="flex-column gap-20 mt-40">
            <h2 class="common-title">Grid input</h2>
            <t:qualifications />
        </div>

        <div class="button-control-wrapper">
            <button type="button" class="" data-type="small" onclick="applyGrid()">적용하기</button>
        </div>

        <%-- output --%>
        <div class="flex-column gap-20 mt-40">
            <h2 class="common-title">Grid output</h2>
            <div class="common-grid-wrapper">
                <div class="grid-header">
                    <p>제목1</p>
                    <p>제목2</p>
                    <p>제목3</p>
                    <p>제목4</p>
                </div>
                <div class="grid-row-wrapper">
                    <div class="grid-row">
                        <p>제목1에 관한 내용입니다.</p>
                        <p>제목2에 관한 내용입니다.</p>
                        <p>제목3에 관한 내용입니다.</p>
                        <p>제목4에 관한 내용입니다.</p>
                    </div>
                    <div class="grid-row">
                        <p>제목1에 관한 내용입니다.</p>
                        <p>제목2에 관한 내용입니다.</p>
                        <p>제목3에 관한 내용입니다.</p>
                        <p>제목4에 관한 내용입니다.</p>
                    </div>
                    <div class="grid-row">
                        <p>제목1에 관한 내용입니다.</p>
                        <p>제목2에 관한 내용입니다.</p>
                        <p>제목3에 관한 내용입니다.</p>
                        <p>제목4에 관한 내용입니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        initializeQualifications();
    })

    const applyGrid = () => {
        console.log("[module/api.jsp] called by handleLoad.")
    }
</script>