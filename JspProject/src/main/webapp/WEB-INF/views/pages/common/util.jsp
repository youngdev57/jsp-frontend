<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<div id="util" class="guide-container">
    <t:information title="Util" parentDir="Common" />
    <t:callout description="프로젝트에 자주 이용되는 Util 함수 모음입니다." />
    <t:filePath dir1="resources" dir2="js" dir3="modules" dir4="util.module.js" />

    <h5 class="mt-40">📋 목차</h5>
    <div class="index">
        <a class="link" href="#alertRequiredMessage">alertRequiredMessage()</a>
        <a class="link" href="#convertQueryParameterToJson">convertQueryParameterToJson()</a>
        <a class="link" href="#generateValidDataFromField">generateValidDataFromField()</a>
        <a class="link" href="#generateHTMLFromEditor">generateHTMLFromEditor()</a>
        <a class="link" href="#getPlainTextFromHTML">getPlainTextFromHTML()</a>
        <a class="link" href="#handleCurrentPage">handleCurrentPage()</a>
        <a class="link" href="#generateSelectOptions">generateSelectOptions()</a>
        <a class="link" href="#getReversedCommonCode">getReversedCommonCode()</a>
        <a class="link" href="#downloadAuthorizedFile">downloadAuthorizedFile()</a>
        <a class="link" href="#convertMobileFormat">convertMobileFormat()</a>
        <a class="link" href="#convertBirthdayFormat">convertBirthdayFormat()</a>
    </div>

    <section class="mt-20">
        <h4 id="alertRequiredMessage" class="sub-title">alertRequiredMessage()</h4>
        <div id="alertRequiredMessageContent" class="sub-content mg-0">
            <t:callout emoji="📝" description="필수 입력값 요청 Alert를 표시하는 함수" color="transparent" />
            <ul class="description-wrapper">
                <li>다양한 입력 형태(input, select, textarea 등...)에 따라 적절한 메세지를 출력합니다.</li>
                <li>· <span class="incd">data-required="true"</span> 속성으로 대상을 지정합니다.</li>
                <li><b>실행</b></li>
                <li>
                    <div class="common-form-wrapper">
                        <div>
                            <div class="column-header"><label for="textFruits">입력 예시</label></div>
                            <div class="column-content">
                                <input id="textFruits" type="text" placeholder="아무 과일을 입력해 주세요." data-required="true" />
                            </div>
                        </div>
                        <div>
                            <div class="column-header"><label for="selectFruits">선택 예시</label></div>
                            <div class="column-content">
                                <select id="selectFruits" data-required="true">
                                    <option value="">선택</option>
                                    <option value="apple">사과</option>
                                    <option value="orange">오렌지</option>
                                </select>
                            </div>
                        </div>
                        <div>
                            <div class="column-header">실행</div>
                            <div class="column-content">
                                <button type="button" class="secondary" onclick="alertRequiredMessage('#alertRequiredMessageContent')">함수 실행</button>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <h4 id="convertQueryParameterToJson" class="sub-title">convertQueryParameterToJson()</h4>
        <div class="sub-content mg-0">
            <t:callout emoji="📝" description="URL에 포함된 쿼리 파라미터를 JSON 객체 형식으로 반환하는 함수" color="transparent" />
            <ul class="description-wrapper">
                <li><b>URL 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p>/utils?key=name&value=youngdev&isBoolean=true</p>
                    </div>
                </li>
                <li><b>반환 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">return</span> {</p>
                        <p class="tab1"><span class="key">key</span>: "name",</p>
                        <p class="tab1"><span class="key">value</span>: "youngdev",</p>
                        <p class="tab1"><span class="key">isBoolean</span>: <span class="boolean">true</span> <span class="comment">// boolean의 경우 형변환을 지원합니다.</span></p>
                        <p>}</p>
                    </div>
                </li>
            </ul>
        </div>
        <h4 id="generateValidDataFromField" class="sub-title">generateValidDataFromField()</h4>
        <div class="sub-content mg-0">
            <t:callout emoji="📝" description="data-field 기반으로 요청 데이터를 만들어주는 함수" color="transparent" />
            <ul class="description-wrapper">
                <li>
                    해당 함수는 <span class="incd">data-field="true"</span> 속성을 가진 <b>모든 요소를 찾아</b> 가공한 뒤 다루기 쉬운 데이터로 반환하며,
                    반환 데이터 중 <span class="incd">fields</span>의 <span class="incd">label</span>과 <span class="incd">tagName</span>값으로 <span class="incd">alertRequiredMessage()</span> 함수를 호출합니다.</li>
                <li><b>입력 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p>&lt;div&gt;</p>
                        <p class="tab1">&lt;label for="name"&gt;이름&lt;/label&gt;</p>
                        <p class="tab1">&lt;input id="name" type="text" value="youngdev" <span class="key">data-field="true"</span> /&gt</p>
                        <p>&lt;/div&gt;</p>
                        <p>&lt;div&gt;</p>
                        <p class="tab1">&lt;label for="age"&gt;나이&lt;/label&gt;</p>
                        <p class="tab1">&lt;input id="age" type="number" value="28" <span class="key">data-field="true"</span> /&gt</p>
                        <p>&lt;/div&gt;</p>
                    </div>
                </li>
                <li><b>반환 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">return</span> {</p>
                        <p class="tab1"><span class="key">fields</span>: [{</p>
                        <p class="tab2"><span class="key">key</span>: "name",</p>
                        <p class="tab2"><span class="key">value</span>: "youngdev",</p>
                        <p class="tab2"><span class="key">label</span>: "이름",</p>
                        <p class="tab2"><span class="key">tagName</span>: "INPUT"</p>
                        <p class="tab1">}, ...],</p>
                        <p class="tab1"><span class="key">processed</span>: {</p>
                        <p class="tab2"><span class="key">name</span>: "youngdev",  <span class="comment">// id 속성과 매핑됩니다.</span></p>
                        <p class="tab2"><span class="key">age</span>: 28</p>
                        <p class="tab1">}</p>
                        <p>}</p>
                    </div>
                </li>
            </ul>
        </div>
        <h4 id="generateHTMLFromEditor" class="sub-title">generateHTMLFromEditor()</h4>
        <div class="sub-content mg-0">
            <t:callout emoji="📝" description="에디터 내용을 HTML File로 내보내기하는 함수" color="transparent" />
            <ul class="description-wrapper">
                <li><b>사용 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">const</span> formData = <span class="key">new</span> FormData();</p>
                        <p><span class="keyword">const</span> file = <span class="func">generateHTMLFromEditor</span>(editor.getData());</p>
                        <p>formData.<span class="func">append</span>("file", file);</p>
                    </div>
                </li>
            </ul>
        </div>
        <h4 id="getPlainTextFromHTML" class="sub-title">getPlainTextFromHTML()</h4>
        <div class="sub-content mg-0">
            <t:callout emoji="📝" description="HTML 데이터에서 text만 추출하는 함수" color="transparent" />
            <ul class="description-wrapper">
                <li><b>사용 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="func">getPlainTextFromHTML</span>(editor.getData()); <span class="comment">// &lt;p&gt;Hello world.&lt;/p&gt;</span></p>
                    </div>
                </li>
                <li><b>반환 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">return</span> "Hello world.";</p>
                    </div>
                </li>
                <li><b>실행</b></li>
                <li>
                    <div class="common-form-wrapper">
                        <div>
                            <div class="column-header"><label for="textHtml">입력 예시</label></div>
                            <div class="column-content">
                                <input id="textHtml" type="text" value="<p class='info'>Hello world.</p>" placeholder="HTML 코드를 입력해 주세요." />
                            </div>
                        </div>
                        <div>
                            <div class="column-header">실행</div>
                            <div class="column-content">
                                <button type="button" class="secondary" onclick="convertTextHtmlToPlain()">함수 실행</button>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <h4 id="handleCurrentPage" class="sub-title">handleCurrentPage()</h4>
        <div class="sub-content mg-0">
            <t:callout emoji="📝" description="페이지 동작을 핸들링하는 함수" color="transparent" />
            <ul class="description-wrapper">
                <li><b>사용 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p>&lt;button onclick="<span class="func">handleCurrentPage</span>('back')"&gt;뒤로가기&lt;/button&gt;"</p>
                    </div>
                </li>
            </ul>
        </div>
        <h4 id="generateSelectOptions" class="sub-title">generateSelectOptions()</h4>
        <div class="sub-content mg-0">
            <t:callout emoji="📝" description="공통 코드 기반으로 select option을 구성하는 함수" color="transparent" />
            <ul class="description-wrapper">
                <li>해당 함수는 동적으로 <span class="incd">select</span> 태그의 <span class="incd">option</span>들을 구성할 수 있게 도와주는 함수입니다.</li>
                <li><b>HTML 구성</b></li>
                <li>
                    <div class="code-snippet">
                        <p>&lt;div&gt;</p>
                        <p class="tab1">&lt;label for="languageType"&gt;언어&lt;/label&gt;</p>
                        <p class="tab1">&lt;select id="languageType"&gt;&lt;/select&gt;</p>
                        <p>&lt;/div&gt;</p>
                    </div>
                </li>
                <li><b>사용 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">const</span> <span class="func">generateLanguageTypeOptions</span> = () => {</p>
                        <p class="tab2"><span class="keyword">const</span> targetElement = <span class="key">$</span>("#languageType");</p>
                        <p class="tab2"><span class="keyword">let</span> optionElements = '';</p>
                        <p class="tab2"><span class="keyword">const</span> options = <span class="func">generateSelectOptions</span>(LanguageType, "언어 선택");</p>
                        <p class="tab2">options.<span class="key">map</span>(option => optionElements +=</p>
                        <p class="tab3">`&lt;option value=&quot;${"${option.value}"}&quot;&gt;${"${option.text}"}&lt;/option&gt;`);</p>
                        <br>
                        <p class="tab2">targetElement.<span class="func">append</span>(optionElements);</p>
                        <p>}</p>
                    </div>
                </li>
                <li><b>반환 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">return</span> [</p>
                        <p class="tab1">{</p>
                        <p class="tab2"><span class="keyword">text</span>: "언어 선택",</p>
                        <p class="tab2"><span class="keyword">value</span>: ""</p>
                        <p class="tab1">}, {</p>
                        <p class="tab2"><span class="keyword">text</span>: "javascript",</p>
                        <p class="tab2"><span class="keyword">value</span>: "자바스크립트"</p>
                        <p class="tab1">}, ...</p>
                        <p>]</p>
                    </div>
                </li>
                <li><b>실행</b></li>
                <li>
                    <div class="common-form-wrapper">
                        <div>
                            <div class="column-header"><label for="languageType">선택</label></div>
                            <div class="column-content">
                                <select id="languageType"></select>
                            </div>
                        </div>
                        <div>
                            <div class="column-header">실행</div>
                            <div class="column-content">
                                <button type="button" class="secondary" onclick="generateLanguageTypeOptions()">함수 실행</button>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <h4 id="getReversedCommonCode" class="sub-title">getReversedCommonCode()</h4>
        <div class="sub-content mg-0">
            <t:callout emoji="📝" description="코드 값으로 공통 코드의 KEY를 찾는 함수" color="transparent" />
            <ul class="description-wrapper">
                <li>해당 함수는 공통 코드의 <span class="incd">value</span> 값으로 <span class="incd">key</span>를 찾는 함수입니다.</li>
                <li>서버에서 응답한 데이터가 키 값이 아닌 코드 값을 가지고 있을 때 주로 이용합니다. </li>
                <li><b>사용 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">const</span> selected = <span class="func">getReversedCommonCode</span>(entity.languageType); <span class="comment">// java</span></p>
                        <p><span class="key">$</span>("input#languageType").<span class="func">prop</span>("checked", true);</p>
                    </div>
                </li>
            </ul>
        </div>
        <h4 id="downloadAuthorizedFile" class="sub-title">downloadAuthorizedFile()</h4>
        <div class="sub-content mg-0">
            <t:callout emoji="📝" description="권한이 필요한 파일을 다운로드하는 함수" color="transparent" />
            <ul class="description-wrapper">
                <li><b>사용 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">const</span> handleDownload = () => {</p>
                        <p class="tab1"><span class="keyword">const</span> downloadUrl = &#x60;/users/$&#123;entityId&#125;/files&#x60;;</p>
                        <p class="tab1"><span class="keyword">const</span> requestData = {</p>
                        <p class="tab2"><span class="key">downloadUrl:</span> downloadUrl,</p>
                        <p class="tab2"><span class="key">responseType:</span> "blob"</p>
                        <p class="tab1">}</p>
                        <br>
                        <p class="tab1"><span class="func">downloadAuthorizedFile</span>(originEntity.fileName, requestData);</p>
                        <p>}</p>
                    </div>
                </li>
            </ul>
        </div>
        <h4 id="convertMobileFormat" class="sub-title">convertMobileFormat()</h4>
        <div class="sub-content mg-0">
            <t:callout emoji="📝" description="핸드폰 번호 유효성 검사 및 변환 함수" color="transparent" />
            <ul class="description-wrapper">
                <li><b>입력 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">const</span> mobile = <span class="func">convertMobileFormat</span>("01012345678", "-");</p>
                    </div>
                </li>
                <li><b>반환 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">return</span> "010-1234-5678";</p>
                    </div>
                </li>
                <li><b>실행</b></li>
                <li>
                    <div class="common-form-wrapper">
                        <div>
                            <div class="column-header"><label for="mobile">입력 예시</label></div>
                            <div class="column-content">
                                <input id="mobile" type="text" placeholder="010-0000-0000" value="01012345678" />
                            </div>
                        </div>
                        <div>
                            <div class="column-header">반환 예시</div>
                            <div class="column-content mobile"></div>
                        </div>
                        <div>
                            <div class="column-header">실행</div>
                            <div class="column-content">
                                <button type="button" class="secondary" onclick="convertMobile()">함수 실행</button>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <h4 id="convertBirthdayFormat" class="sub-title">convertBirthdayFormat()</h4>
        <div class="sub-content mg-0">
            <t:callout emoji="📝" description="생년월일 변환 함수" color="transparent" />
            <ul class="description-wrapper">
                <li><b>입력 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">const</span> birthday = <span class="func">convertBirthdayFormat</span>("19970507", "/");</p>
                    </div>
                </li>
                <li><b>반환 예시</b></li>
                <li>
                    <div class="code-snippet">
                        <p><span class="keyword">return</span> "1997/05/07";</p>
                    </div>
                </li>
            </ul>
        </div>
    </section>
</div>

<script>
    const message = {
        notValidValue: "유효하지 않은 값입니다."
    }

    document.addEventListener("DOMContentLoaded", function () {

    })

    const generateLanguageTypeOptions = () => {
        const targetElement = document.getElementById("languageType");
        let optionElements = '';
        const options = generateSelectOptions(LanguageType, "언어 선택");
        options.map(option =>
            optionElements += `<option value="${"${option.value}"}">${"${option.text}"}</option>`);

        targetElement.innerHTML = optionElements;
    }
    
    const convertTextHtmlToPlain = () => {
        const targetElement = document.getElementById("textHtml");
        const htmlText = targetElement.value;
        targetElement.value = getPlainTextFromHTML(htmlText);
    }

    const convertMobile = () => {
        const target = document.getElementById("mobile");
        const outputTarget = document.querySelector(".mobile");
        const converted = convertMobileFormat(target.value);

        outputTarget.textContent = converted ? converted : message.notValidValue;
    }
</script>