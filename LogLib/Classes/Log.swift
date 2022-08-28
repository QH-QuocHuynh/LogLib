//
//  Log.swift
//  LogLib
//
//  Created by Quoc Huynh on 28/08/2022.
//

import Foundation

public enum LogDateFormatter: String {
    case dd_MM_HH_mm_ss = "dd/MM HH:mm:ss"
}

public enum Log {
    static var dateFormatter = LogDateFormatter.dd_MM_HH_mm_ss

    public enum State {
        case info
        case success
        case warning
        case error
        case todo
        case url
    }

    private struct Context {
        private let file: String
        private let function: String
        private let line: Int
        private let showHierarchy: Bool

        init(file: String, function: String, line: Int, showHierarchy: Bool) {
            self.file = file
            self.function = function
            self.line = line
            self.showHierarchy = showHierarchy
        }

        var description: String {
            guard showHierarchy else { return "" }

            let fileString: NSString = NSString(string: file)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Log.dateFormatter.rawValue
            let content = """
                [\(dateFormatter.string(from: Foundation.Date()))] [\(fileString.lastPathComponent) -> \(function), line:\(line)]
                """
            if Thread.isMainThread {
                return """
                ======================================================
                [M] \(content)
                ====================================================== \n
                """
            } else {
                return """
                ========================================================
                [!=M] \(content)
                ======================================================== \n
                """
            }
        }
    }

    public static func out(state: State, msg: String, showHierarchy: Bool = false, _ file: String = #file, function: String = #function, line: Int = #line) {

        let context = Context(file: file, function: function, line: line, showHierarchy: showHierarchy)

        switch state {
        case .info:
            log("ℹ️ Info:", msg, context: context)
        case .success:
            log("✅ Success:", msg, context: context)
        case .warning:
            log("⚠️ Warning:", msg, context: context)
        case .error:
            log("❗️ Error:", msg, context: context)
        case .todo:
            log("✏️ Todo:", msg, context: context)
        case .url:
            log("🌏 URL:", msg, context: context)
        }
    }

    private static func log(_ emoji: String, _ msg: String, context: Context) {
        // To enable Loggers only in Debug mode:
        // 1. Go to Buld Settings -> Other C Flags
        // 2. Enter `-D DEBUG` fot the Debug flag
        // 3. Celebrate. Your Loggers will not print in Release, thus saving on memory
        #if DEBUG
            Swift.print(context.description + emoji + " " + msg)
        #endif
    }
}
