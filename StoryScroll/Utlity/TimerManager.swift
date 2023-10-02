import Foundation

import Foundation

class TimerManager {
    static let shared = TimerManager()
    private var timer: Timer?
    private(set) var elapsedTime: TimeInterval = 0
    private var startTime: TimeInterval = 0
    private var currentDay: Int = 0

    private let userDefaults = UserDefaults.standard
    private let elapsedTimeKey = "elapsedTime"

    var updateTimerCallback: ((TimeInterval) -> Void)?

    private init() {
        elapsedTime = userDefaults.double(forKey: elapsedTimeKey)
    }

    func startTimer() {
        startTime = Date().timeIntervalSince1970 - elapsedTime
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateElapsedTime()
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }

    private func updateElapsedTime() {
        let currentTime = Date().timeIntervalSince1970
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(timeIntervalSince1970: startTime), to: Date(timeIntervalSince1970: currentTime))

        if components.day != currentDay {
            // Day has changed, reset the timer
            startTime = currentTime
            currentDay = components.day ?? 0
        }

        elapsedTime = currentTime - startTime
        userDefaults.set(elapsedTime, forKey: elapsedTimeKey)
        updateTimerCallback?(elapsedTime)
    }
}
