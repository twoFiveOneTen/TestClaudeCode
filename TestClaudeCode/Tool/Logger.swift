//
//  Logger.swift
//  TestClaudeCode
//
//  Created by zhangkangkang on 2025/8/5.
//


class Logger {
    
    static func log(completion: () -> String) {
#if DEBUG
        let logStr = completion()
        print(logStr)
#endif
    }
    
}
