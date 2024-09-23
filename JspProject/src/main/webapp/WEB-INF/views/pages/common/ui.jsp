<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="ui" class="guide-container">
    <t:information title="UI" parentDir="Common" />
    <t:callout description="global.css 기반의 공통 UI 모음입니다." />

    <section class="mt-40">
        <%-- Color Chips --%>
        <h4 class="sub-title">Color Chip</h4>
        <div class="sub-content">
            <div class="flex">
                <div class="color-chip-wrapper">
                    <div class="color-chip" style="background: var(--primary)"></div>
                    <div class="flex-column evenly">
                        <h5 class="text-title">main-color</h5>
                        <div class="text-primary">#4164A7</div>
                        <div>--primary</div>
                    </div>
                </div>
            </div>
            <div class="flex">
                <div class="color-chip-wrapper">
                    <div class="color-chip" style="background: var(--secondary)"></div>
                    <div class="flex-column evenly">
                        <h5 class="text-title">sub1-color</h5>
                        <div>#4B5968</div>
                        <div>--secondary</div>
                    </div>
                </div>
                <div class="color-chip-wrapper">
                    <div class="color-chip" style="background: var(--secondary-blue)"></div>
                    <div class="flex-column evenly">
                        <h5 class="text-title">sub2-color</h5>
                        <div>#C8D9E2</div>
                        <div>--secondary-blue</div>
                    </div>
                </div>
                <div class="color-chip-wrapper">
                    <div class="color-chip" style="background: var(--secondary-grey)"></div>
                    <div class="flex-column evenly">
                        <h5 class="text-title">sub3-color</h5>
                        <div>#F5F6F8</div>
                        <div>--secondary-grey</div>
                    </div>
                </div>
            </div>
            <div class="flex">
                <div class="color-chip-wrapper">
                    <div class="color-chip" style="background: var(--danger)"></div>
                    <div class="flex-column evenly">
                        <h5 class="text-title">danger-color</h5>
                        <div>#D05050</div>
                        <div>--danger</div>
                    </div>
                </div>
                <div class="color-chip-wrapper">
                    <div class="color-chip" style="background: var(--warning)"></div>
                    <div class="flex-column evenly">
                        <h5 class="text-title">warning-color</h5>
                        <div>#FFF0BD</div>
                        <div>--warning</div>
                    </div>
                </div>
            </div>
            <div class="flex">
                <div class="color-chip-wrapper">
                    <div class="color-chip" style="background: var(--black)"></div>
                    <div class="flex-column evenly">
                        <h5 class="text-title">title-color</h5>
                        <div>#222222</div>
                        <div>--black</div>
                    </div>
                </div>
                <div class="color-chip-wrapper">
                    <div class="color-chip" style="background: var(--text)"></div>
                    <div class="flex-column evenly">
                        <h5 class="text-title">body-color</h5>
                        <div>#666666</div>
                        <div>--text</div>
                    </div>
                </div>
                <div class="color-chip-wrapper">
                    <div class="color-chip" style="background: var(--border)"></div>
                    <div class="flex-column evenly">
                        <h5 class="text-title">border-color</h5>
                        <div>#DDDDDD</div>
                        <div>--border</div>
                    </div>
                </div>
            </div>
        </div>

        <%-- Fonts --%>
        <h4 class="sub-title">Font</h4>
        <div class="sub-content">
            <h1>h1 / Pretendard /  2.5rem(40px) / Bold(700)</h1>
            <h2>h2 / Pretendard /  2rem(32px) / Semi-bold(600)</h2>
            <h3>h3 / Pretendard /  1.75rem(28px) / Semi-bold(600)</h3>
            <h4>h4 / Pretendard /  1.5rem(24px) / Medium(500)</h4>
            <h5>h5 / Pretendard /  1.25rem(20px) / Medium(500)</h5>
        </div>

        <%-- Text --%>
        <h4 class="sub-title">Text Style</h4>
        <div class="sub-content">
            <p class="caution">p.caution _ 공개하지 아니한 회의내용의 공표에 관하여는 법률이 정하는 바에 의한다.</p>
            <p class="notice">p.notice _ 공개하지 아니한 회의내용의 공표에 관하여는 법률이 정하는 바에 의한다.</p>
            <p class="safety">p.safety _ 공개하지 아니한 회의내용의 공표에 관하여는 법률이 정하는 바에 의한다.</p>
            <p class="info">p.info _ 공개하지 아니한 회의내용의 공표에 관하여는 법률이 정하는 바에 의한다.</p>
            <a href="#" class="link">a.link _ 공개하지 아니한 회의내용의 공표에 관하여는 법률이 정하는 바에 의한다.</a>
            <p class="info">span.inline-code _ <span class="inline-code">&lt;span class=&quot;inline-code&quot;&gt;youngdev&lt;/span&gt;</span></p>
        </div>

        <%-- Border --%>
        <h4 class="sub-title">Border</h4>
        <div class="sub-content">
            hr.light
            <hr class="light" />
            hr
            <hr />
            hr.dash
            <hr class="dash" />
            hr.bold
            <hr class="bold" />
        </div>

        <%-- Button --%>
        <h4 class="sub-title">Button</h4>
        <div class="sub-content">
            <div class="flex gap-20">
                <button class="primary">버튼1</button>
                <button class="secondary">버튼2</button>
                <button class="tertiary">버튼3</button>
                <button class="danger">버튼4</button>
            </div>
        </div>

        <%-- Input --%>
        <h4 class="sub-title">Input</h4>
        <div class="sub-content">
            <div class="flex-column gap-30">
                <div class="flex-center-vertical gap-30" style="height: 50px">
                    <label>
                        <input type="text" placeholder="youngdev@naver.com">
                    </label>
                    <label>
                        <input type="text" value="youngdev@naver.com (Disabled)" disabled>
                    </label>
                </div>
                <div class="flex-center-vertical gap-30" style="height: 50px">
                    <select id="select">
                        <option disabled selected style="display: none">전체 선택</option>
                        <option value="select01">선택1</option>
                        <option value="select02">선택2</option>
                    </select>
                    <select id="select" disabled>
                        <option disabled selected style="display: none">전체 선택 (Disabled)</option>
                        <option value="select01">선택1</option>
                        <option value="select02">선택2</option>
                    </select>
                </div>
                <div class="flex-center-vertical gap-30" style="height: 50px">
                    <label class="flex gap-10 pd-0" style="width: 120px">
                        <input id="radio01" type="radio" name="radioGroup" checked>선택1
                    </label>
                    <label class="flex gap-10 pd-0" style="width: 120px">
                        <input id="radio02" type="radio" name="radioGroup">선택2
                    </label>
                    <label class="flex gap-10 pd-0" style="width: auto">
                        <input id="radio03" type="radio" name="radioGroup" disabled>선택3 (Disabled)
                    </label>
                </div>
                <div class="flex-center-vertical gap-30">
                    <label for="checkbox01" style="width: 120px">
                        <input id="checkbox01" type="checkbox" checked />옵션1
                    </label>
                    <label for="checkbox02" style="width: 120px">
                        <input id="checkbox02" type="checkbox" />옵션2
                    </label>
                    <label for="checkbox03" style="width: auto">
                        <input id="checkbox03" type="checkbox" disabled />옵션3 (Disabled)
                    </label>
                </div>
            </div>
        </div>

        <%-- Shadow --%>
        <h4 class="sub-title">Shadow</h4>
        <div class="sub-content">
            <div class="flex gap-30">
                <div class="shadow-chip" style="box-shadow: var(--shadow-light)"></div>
                <div class="shadow-chip" style="box-shadow: 0 8px 24px 0 rgba(140, 149, 159, 0.2)"></div>
                <div class="shadow-chip" style="box-shadow: var(--shadow-blue)"></div>
            </div>
        </div>

        <%-- Modal --%>
        <h4 class="sub-title">Modal</h4>
        <div class="sub-content">
            <button>모달 열기</button>
        </div>

        <%-- Code Snippet Style --%>
        <h4 class="sub-title">Code Snippet Style</h4>
        <div class="sub-content">
            <div class="code-snippet">
                <p><span class="keyword">const</span> handleLoadProfile = () => {</p>
                <p class="tab1"><span class="keyword">const</span> <span class="key">requestUrl</span> = &#x60;/users/$&#123;entity.entityId&#125;/profile&#x60;;</p>
                <p class="tab1"><span class="keyword">const</span> <span class="key">requestData</span> = { ... };</p>
                <br>
                <p class="tab1"><span class="keyword">Api</span>.<span class="func">get</span>(requestUrl, requestData)</p>
                <p class="tab2">.<span class="func">then</span>(response => console.<span class="func">log</span>(response))</p>
                <p class="tab2">.<span class="func">catch</span>(error => <span class="func">handleServerErrorMessage</span>(error));</p>
                <p>}</p>
            </div>
        </div>
    </section>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {

    })
</script>