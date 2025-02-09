import UIKit

extension UITableViewController {
    func convertDate(dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd.MM.yyyy HH:mm zzz"
            outputFormatter.locale = Locale(identifier: "tr_TR")
            outputFormatter.timeZone = TimeZone.current
            
            let formattedDate = outputFormatter.string(from: date)
            return formattedDate
        } else {
            return "00.00.0000 00:00 GMT+3"
        }
    }
}
