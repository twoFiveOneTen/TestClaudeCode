import UIKit

class AnalogClockView: UIView {
    
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    func startClock() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.setNeedsDisplay()
        }
    }
    
    func stopClock() {
        timer?.invalidate()
        timer = nil
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 - 20
        
        drawClockFace(context: context, center: center, radius: radius)
        
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let second = calendar.component(.second, from: now)
        
        drawHands(context: context, center: center, radius: radius, time: TimeComponents(hour: hour, minute: minute, second: second))
    }
    
    private func drawClockFace(context: CGContext, center: CGPoint, radius: CGFloat) {
        context.setFillColor(UIColor.systemBackground.cgColor)
        context.fillEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
        
        context.setStrokeColor(UIColor.label.cgColor)
        context.setLineWidth(2)
        context.strokeEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
        
        for i in 0..<12 {
            let angle = Double(i) * .pi / 6 - .pi / 2
            let hourMarkLength: CGFloat = 20
            let startRadius = radius - hourMarkLength
            
            let startX = center.x + cos(angle) * startRadius
            let startY = center.y + sin(angle) * startRadius
            let endX = center.x + cos(angle) * radius
            let endY = center.y + sin(angle) * radius
            
            context.setStrokeColor(UIColor.label.cgColor)
            context.setLineWidth(3)
            context.move(to: CGPoint(x: startX, y: startY))
            context.addLine(to: CGPoint(x: endX, y: endY))
            context.strokePath()
            
            let numberRadius = radius - 35
            let numberX = center.x + cos(angle) * numberRadius
            let numberY = center.y + sin(angle) * numberRadius
            
            let hourNumber = i == 0 ? 12 : i
            let numberString = "\(hourNumber)"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 18),
                .foregroundColor: UIColor.label
            ]
            let attributedString = NSAttributedString(string: numberString, attributes: attributes)
            let stringSize = attributedString.size()
            
            let drawRect = CGRect(
                x: numberX - stringSize.width / 2,
                y: numberY - stringSize.height / 2,
                width: stringSize.width,
                height: stringSize.height
            )
            attributedString.draw(in: drawRect)
        }
        
        for i in 0..<60 where i % 5 != 0 {
            let angle = Double(i) * .pi / 30 - .pi / 2
            let minuteMarkLength: CGFloat = 8
            let startRadius = radius - minuteMarkLength
            
            let startX = center.x + cos(angle) * startRadius
            let startY = center.y + sin(angle) * startRadius
            let endX = center.x + cos(angle) * radius
            let endY = center.y + sin(angle) * radius
            
            context.setStrokeColor(UIColor.secondaryLabel.cgColor)
            context.setLineWidth(1)
            context.move(to: CGPoint(x: startX, y: startY))
            context.addLine(to: CGPoint(x: endX, y: endY))
            context.strokePath()
        }
    }
    
    private struct TimeComponents {
        let hour: Int
        let minute: Int
        let second: Int
    }
    
    private func drawHands(context: CGContext, center: CGPoint, radius: CGFloat, time: TimeComponents) {
        let hourAngle = Double(time.hour % 12) * .pi / 6 + Double(time.minute) * .pi / 360 - .pi / 2
        let minuteAngle = Double(time.minute) * .pi / 30 + Double(time.second) * .pi / 1800 - .pi / 2
        let secondAngle = Double(time.second) * .pi / 30 - .pi / 2
        
        let hourHandLength = radius * 0.5
        let minuteHandLength = radius * 0.7
        let secondHandLength = radius * 0.9
        
        drawHand(context: context, center: center, angle: hourAngle, length: hourHandLength, style: (width: 6, color: UIColor.label.cgColor))
        drawHand(context: context, center: center, angle: minuteAngle, length: minuteHandLength, style: (width: 4, color: UIColor.label.cgColor))
        drawHand(context: context, center: center, angle: secondAngle, length: secondHandLength, style: (width: 2, color: UIColor.systemRed.cgColor))
        
        context.setFillColor(UIColor.label.cgColor)
        context.fillEllipse(in: CGRect(x: center.x - 5, y: center.y - 5, width: 10, height: 10))
    }
    
    private func drawHand(context: CGContext, center: CGPoint, angle: Double, length: CGFloat, style: (width: CGFloat, color: CGColor)) {
        let endX = center.x + cos(angle) * length
        let endY = center.y + sin(angle) * length
        
        context.setStrokeColor(style.color)
        context.setLineWidth(style.width)
        context.setLineCap(.round)
        context.move(to: center)
        context.addLine(to: CGPoint(x: endX, y: endY))
        context.strokePath()
    }
}