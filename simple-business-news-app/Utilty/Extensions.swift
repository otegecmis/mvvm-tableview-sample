import UIKit

extension String {
    func convertToDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd.MM.yyyy HH:mm zzz"
            outputFormatter.locale = Locale(identifier: "tr_TR")
            outputFormatter.timeZone = TimeZone.current
            
            return outputFormatter.string(from: date)
        }
        return "00.00.0000 00:00 GMT+3"
    }
}
