package com.jsptest.service;

import com.jsptest.utils.StringUtils;
import org.springframework.stereotype.Service;

@Service
public class MyService {
    public String convertPageName(String pageName) {
        return StringUtils.convertToCamelCase(pageName);
    }
}
