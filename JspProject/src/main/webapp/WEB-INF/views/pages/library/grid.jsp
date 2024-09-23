<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section>
    <h1>Grid</h1>
    <br>

    <div id="sample-grid"></div>
</section>

<script>
    // $(document).ready(function () {
    //     const gridModule = new GridModule("sample-grid");
    //
    //     const columns = [
    //         { header: "아이디", name: "id", align: "center"},
    //         { header: "사용자명", name: "firstName", align: "center"},
    //         { header: "나이", name: "age", align: "center"},
    //         { header: "이메일", name: "email", align: "center"},
    //         { header: "휴대폰번호", name: "phone", align: "center"},
    //         { header: "생일", name: "birthDate", align: "center"}
    //     ];
    //
    //     const getList = () => {
    //         fetch("http://dummyjson.com/users")
    //             .then(response => response.json())
    //             .then(response => {
    //                 const listData = response.users;
    //
    //                 $("#sample-grid").empty();
    //                 gridModule.initialize({columnOption: columns, perPageCount: +10});
    //                 gridModule.grid.resetData(listData);
    //             });
    //     }
    //
    //     getList();
    // })
</script>