class ApiModule {
    axios;
    baseURL;
    commonHeader;
    contentType;

    constructor() {
        this.baseURL = window.location.origin + "/api/integrate";
        this.commonHeader = {
            "Content-Type": "application/json",
            "Authorization": ""
        };
        this.contentType = {
            JSON: "application/json",
            FORM: "multipart/form-data"
        }
    }

    setAxiosInstance(responseType = "json") {
        this.axios = axios.create({
            baseURL: this.baseURL,
            headers: this.commonHeader,
            responseType: responseType
        });
    }

    setAuthorization(value) {
        this.commonHeader["Authorization"] = value ? value : this.getAccessToken();
    }

    setAccessToken(token) {
        token
            ? localStorage.setItem("accessToken", token)
            : localStorage.removeItem("accessToken");
    }

    getAccessToken() {
        return localStorage.getItem("accessToken");
    }

    setContentType(isFormData = false) {
        this.commonHeader["Content-Type"] = isFormData
            ? this.contentType.FORM
            : this.contentType.JSON;
    }

    async get(requestURL, requestParam, responseType, retries = 3) {
        function wait(ms = 500) {
            return new Promise(resolve => setTimeout(resolve, ms));
        }

        this.setAuthorization();
        this.setContentType();
        this.setAxiosInstance(responseType);
        return await this.axios
            .get(requestURL, { params: requestParam })
            .then(response => this.handleSuccess(response))
            .catch(async error => {
                alert(error)
                const isAdmin = location.pathname.includes("admin");
                if (isAdmin && error.status === 403 && retries > 0) {
                    await wait();
                    return this.get(requestURL, requestParam, responseType, retries - 1);
                } else {
                    this.handleError(error);
                }
            });
    }

    async post(requestURL, requestParam, isFormData = false) {
        this.setAuthorization();
        this.setContentType(isFormData);
        this.setAxiosInstance();
        return await this.axios
            .post(requestURL, requestParam)
            .then(this.handleSuccess)
            .catch(this.handleError);
    }

    async put(requestURL, requestParam, isFormData = false) {
        this.setAuthorization();
        this.setContentType(isFormData);
        this.setAxiosInstance();
        return await this.axios
            .put(requestURL, requestParam)
            .then(this.handleSuccess)
            .catch(this.handleError);
    }

    async delete(requestURL) {
        this.setAuthorization();
        this.setContentType();
        this.setAxiosInstance();
        return await this.axios
            .delete(requestURL)
            .then(this.handleSuccess)
            .catch(this.handleError);
    }

    /**
     * 공통 성공 핸들러
     * @param response
     * @returns {*}
     */
    handleSuccess = (response) => {
        const token = response.headers.authorization ? response.headers.authorization : null;
        this.setAccessToken(token);
        return response;
    };

    /**
     * 공통 에러 핸들러
     * @param error
     */
    handleError = (error) => {
        const { data } = error.response;
        throw data;
    };
}
