package com.jsptest.utils;

public class StringUtils {
    public static String convertToCamelCase(String pageName) {
        String[] parts = pageName.split("-");
        StringBuilder converted = new StringBuilder(parts[0]);
        for (int i = 1; i < parts.length; i ++) {
            converted.append(parts[i].substring(0, 1).toUpperCase());
            converted.append(parts[i].substring(1).toLowerCase());
        }
        return converted.toString();
    }
}