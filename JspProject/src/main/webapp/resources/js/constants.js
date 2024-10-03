
function getConstantMenuInfo(mainKey = "") {
    const mainMenu = {
        menu1: "메뉴1",
        menu2: "메뉴2",
    };
    const subMenu = {
        menu1: [
            {
                menuKey: "",
                displayName: "",
                url: "/menu1/child1"
            }
        ],
        menu2: [
            {
                menuKey: "",
                displayName: "",
                url: "/menu2/child1"
            },
            {
                menuKey: "",
                displayName: "",
                url: "/menu2/child2"
            }
        ]
    };

    return mainKey ? {
            mainMenuName: mainMenu[mainKey],
            subs: subMenu[mainKey] ? subMenu[mainKey] : []
        } : {
            mainMenu: mainMenu,
            subMenu: subMenu
        };
}

/**
 * pagination button types
 */
const IndicatorButtonType = {
    FIRST: "first",
    LAST: "last",
    PREV: "prev",
    NEXT: "next",
    INDEX: "index",
};

/**
 * common code for test
 */
const LanguageType = {
    javascript: "자바스크립트",
    java: "자바",
    python: "파이썬"
}
const CertificateType = {
    "CERT-01": "자격증",
    "CERT-02": "면허증"
}