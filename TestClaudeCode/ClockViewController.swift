import UIKit
import SnapKit

class ClockViewController: UIViewController {
    
    private let digitalTimeLabel = UILabel()
    private let analogClockView = AnalogClockView()
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTimer()
        updateDigitalTime()
        analogClockView.startClock()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
        analogClockView.stopClock()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "时钟"
        
        digitalTimeLabel.textAlignment = .center
        digitalTimeLabel.font = .boldSystemFont(ofSize: 48)
        digitalTimeLabel.textColor = .label
        
        view.addSubview(digitalTimeLabel)
        view.addSubview(analogClockView)
    }
    
    private func setupConstraints() {
        digitalTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        analogClockView.snp.makeConstraints { make in
            make.top.equalTo(digitalTimeLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(300)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateDigitalTime()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateDigitalTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        digitalTimeLabel.text = formatter.string(from: Date())
    }
}