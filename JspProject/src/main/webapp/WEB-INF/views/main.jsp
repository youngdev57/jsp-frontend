<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>youngdev</title>

    <%-- libs --%>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.11.10/dayjs.min.js"></script>

    <%-- sweetalert --%>
<%--    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.7/dist/sweetalert2.min.css" rel="stylesheet">--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.7/dist/sweetalert2.all.min.js"></script>--%>

    <%-- jquery --%>
    <link rel="stylesheet" href="${path}/resources/libs/jquery/jquery-ui.min.css" />
    <script src="${path}/resources/libs/jquery/jquery-3.7.0.min.js"></script>
    <script src="${path}/resources/libs/jquery/jquery-ui.min.js"></script>

    <%-- common --%>
    <link rel="stylesheet" href="${path}/resources/css/reset.css"/>
    <link rel="stylesheet" href="${path}/resources/css/global.css"/>
    <script src="${path}/resources/js/constants.js"></script>
    <script src="${path}/resources/js/region.js"></script>
    <script src="${path}/resources/js/modules/api.module.js"></script>
    <script src="${path}/resources/js/modules/util.module.js"></script>
    <script src="${path}/resources/js/modules/pager.module.js"></script>

    <link rel="stylesheet" href="${path}/resources/css/pages/modal.css">
    <link rel="stylesheet" href="${path}/resources/css/pages/sidebar.css">
    <link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" rel="stylesheet">

    <%-- ckeditor5 --%>
<%--    <script src="${path}/resources/libs/ckeditor/ckeditor.js"></script>--%>

    <script>
        const Api = new ApiModule();
        const Pager = new PagerModule();
        // const Editor = ClassicEditor;

        // const _alert = Swal;
        // const _ckEditor = ClassicEditor;
        // let _toastEditor;
    </script>
</head>
<body>
<div class="sidebar">
    <div class="logo-details">
        <span class="logo-name">YOUNGDEV57</span>
    </div>
    <ul class="nav-links">
        <li>
            <a href="${path}/main">
                <i class="bx bx-grid-alt"></i>
                <span class="link-name">Dashboard</span>
            </a>
        </li>
        <li>
            <div class="icon-link">
                <a href="#">
                    <i class="bx bx-grid-alt"></i>
                    <span class="link-name">Modules</span>
                </a>
                <i class="bx bxs-chevron-down arrow"></i>
            </div>
            <ul class="sub-menu">
                <li><a href="${path}/modules/api">Api</a></li>
                <li><a href="${path}/modules/pager">Pager</a></li>
                <li><a href="${path}/modules/region">Region</a></li>
            </ul>
        </li>
        <li>
            <div class="icon-link">
                <a href="#">
                    <i class="bx bx-grid-alt"></i>
                    <span class="link-name">Tags</span>
                </a>
                <i class="bx bxs-chevron-down arrow"></i>
            </div>
            <ul class="sub-menu">
                <li><a href="${path}/tags/fileManager">File Manager</a></li>
            </ul>
        </li>
        <li>
            <div class="icon-link">
                <a href="#">
                    <i class="bx bx-grid-alt"></i>
                    <span class="link-name">Common</span>
                </a>
                <i class="bx bxs-chevron-down arrow"></i>
            </div>
            <ul class="sub-menu">
                <li><a href="${path}/common/form">Form</a></li>
                <li><a href="${path}/common/grid">Grid</a></li>
                <li><a href="${path}/common/ui">UI</a></li>
                <li><a href="${path}/common/util">Utils</a></li>
            </ul>
        </li>
        <li>
            <div class="icon-link">
                <a href="#">
                    <i class="bx bx-grid-alt"></i>
                    <span class="link-name">Templates</span>
                </a>
                <i class="bx bxs-chevron-down arrow"></i>
            </div>
            <ul class="sub-menu">
<%--                <li><a href="${path}/template/page">Form</a></li>--%>
                <li><a href="#">Form</a></li>
            </ul>
        </li>
<%--        <li>--%>
<%--            <div class="icon-link">--%>
<%--                <a href="#">--%>
<%--                    <i class="bx bx-book"></i>--%>
<%--                    <span class="link-name">Libraries</span>--%>
<%--                </a>--%>
<%--                <i class="bx bxs-chevron-down arrow"></i>--%>
<%--            </div>--%>
<%--            <ul class="sub-menu">--%>
<%--                <li><a href="${path}/libraries/alert">Alert</a></li>--%>
<%--                <li><a href="${path}/libraries/editor">Editor</a></li>--%>
<%--                <li><a href="${path}/libraries/grid">Grid</a></li>--%>
<%--                <li><a href="${path}/libraries/chart">Chart</a></li>--%>
<%--                <li><a href="${path}/libraries/calendar">Calendar</a></li>--%>
<%--            </ul>--%>
<%--        </li>--%>
    </ul>
</div>
<section id="main" class="home-section">
    <div class="home-content" style="padding-right: 20px">
        <i class="bx bx-menu"></i>
        <div class="flex-center-vertical gap-20"></div>
    </div>
    <article class="admin-main-container">
        <jsp:include page="${page}" />
    </article>
</section>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        let arrow = document.querySelectorAll(".arrow");

        for (let index = 0; index < arrow.length; index ++) {
            arrow[index].addEventListener("click", e => {
                let arrowParent = e.target.parentElement.parentElement;
                arrowParent.classList.toggle("showMenu");
            });
        }

        let sidebar = document.querySelector(".sidebar");
        let sidebarBtn = document.querySelector(".bx-menu");

        sidebarBtn.addEventListener("click", () => sidebar.classList.toggle("close"));
    });
</script>
</body>
</html>