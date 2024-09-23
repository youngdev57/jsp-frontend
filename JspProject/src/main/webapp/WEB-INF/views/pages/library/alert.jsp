<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section>
    <h1>SweetAlert</h1>
    <br>
    <button class="btn btn-primary m-2" id="alert-start">Alert</button>
    <button class="btn btn-secondary m-2" id="alert-confirm">Confirm Alert</button>
    <button class="btn btn-success m-2" id="alert-prompt">Prompt Alert</button>
    <button class="btn btn-danger m-2" id="alert-toast">Toast Alert</button>
    <button class="btn btn-warning m-2" id="alert-ajax">Ajax Alert (Github)</button>
</section>

<script>
    $(document).ready(function () {
        $("#alert-start").on("click", function () {
            _alert.fire({
                icon: "success",
                title: "완료되었습니다.",
                text: "이곳은 내용이 나타나는 곳입니다.",
            });
        });

        $("#alert-confirm").on("click", function () {
            _alert.fire({
                title: "게시물을 삭제하시겠습니까?",
                text: "삭제된 게시물은 휴지통에서 확인하실 수 있습니다.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "삭제",
                cancelButtonText: "취소",
                reverseButtons: true

            }).then(result => {
                if (result.isConfirmed) {
                    _alert.fire(
                        "삭제가 완료되었습니다.",
                        "삭제된 게시물은 휴지통에서 확인하실 수 있습니다.",
                        "success"
                    )
                }
            })
        });


        $("#alert-prompt").on("click", function () {
            (async () => {
                const { value: getName } = await _alert.fire({
                    title: "엑셀 다운로드",
                    text: "다운로드 사유를 입력해주세요.",
                    input: "text",
                    inputPlaceholder: "사유 입력하기"
                })

                if (getName) {
                    _alert.fire(getName)
                }
            })()
        });


        $("#alert-toast").on("click", function () {
            const Toast = _alert.mixin({
                toast: true,
                position: "center-center",
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true,
                didOpen: (toast) => {
                    toast.addEventListener("mouseenter", _alert.stopTimer)
                    toast.addEventListener("mouseleave", _alert.resumeTimer)
                }
            })

            Toast.fire({
                icon: "success",
                title: "삭제가 정상적으로 실행 되었습니다."
            })
        });


        $("#alert-ajax").on("click", function () {
            _alert.fire({
                title: "Submit your Github username",
                input: "text",
                inputAttributes: {
                    autocapitalize: "off"
                },
                showCancelButton: true,
                confirmButtonText: "Look up",
                showLoaderOnConfirm: true,
                preConfirm: login => {
                    return fetch(`//api.github.com/users/` + login)
                        .then(response => {
                            if (!response.ok)
                                throw new Error(response.statusText);

                            return response.json()
                        })
                        .catch(error => {
                            const errorMessage = `Request failed: ` + error;
                            _alert.showValidationMessage(errorMessage);
                        })
                },
                allowOutsideClick: () => !_alert.isLoading()
            }).then(result => {
                if (!result.isConfirmed)
                    return;

                const logined = result.value.login;
                _alert.fire({
                    title: logined + `'s avatar`,
                    imageUrl: result.value.avatar_url
                })
            })
        });
    })
</script>