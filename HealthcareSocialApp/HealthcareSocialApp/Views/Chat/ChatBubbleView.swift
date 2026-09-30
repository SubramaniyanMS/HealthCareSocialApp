import SwiftUI

struct ChatBubbleView: View {

    let message: ChatMessage

    private var isUser: Bool { message.role == .user }

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {

            if isUser { Spacer(minLength: 50) }

            if !isUser {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "#0077b6") ?? .blue,
                                         Color(hex: "#00b4d8") ?? .cyan],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 32, height: 32)
                    Image(systemName: "stethoscope")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }

            VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .font(.body)
                    .foregroundStyle(isUser ? .white : .primary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        isUser
                        ? AnyShapeStyle(LinearGradient(
                            colors: [Color(hex: "#0077b6") ?? .blue,
                                     Color(hex: "#023e8a") ?? .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                        : AnyShapeStyle(Color(.secondarySystemBackground))
                    )
                    .clipShape(
                        BubbleShape(isUser: isUser)
                    )
                    .shadow(color: .black.opacity(0.06), radius: 3, y: 1)

                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }

            if !isUser { Spacer(minLength: 50) }
        }
    }
}

// MARK: - Custom bubble shape

struct BubbleShape: Shape {

    let isUser: Bool
    private let radius: CGFloat = 18

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let tl = CGPoint(x: rect.minX, y: rect.minY)
        let tr = CGPoint(x: rect.maxX, y: rect.minY)
        let br = CGPoint(x: rect.maxX, y: rect.maxY)
        let bl = CGPoint(x: rect.minX, y: rect.maxY)

        let smallRadius: CGFloat = 4

        if isUser {
            path.move(to: CGPoint(x: tl.x + radius, y: tl.y))
            path.addLine(to: CGPoint(x: tr.x - radius, y: tr.y))
            path.addQuadCurve(to: CGPoint(x: tr.x, y: tr.y + radius), control: tr)
            path.addLine(to: CGPoint(x: br.x, y: br.y - smallRadius))
            path.addQuadCurve(to: CGPoint(x: br.x - smallRadius, y: br.y), control: br)
            path.addLine(to: CGPoint(x: bl.x + radius, y: bl.y))
            path.addQuadCurve(to: CGPoint(x: bl.x, y: bl.y - radius), control: bl)
            path.addLine(to: CGPoint(x: tl.x, y: tl.y + radius))
            path.addQuadCurve(to: CGPoint(x: tl.x + radius, y: tl.y), control: tl)
        } else {
            path.move(to: CGPoint(x: tl.x + radius, y: tl.y))
            path.addLine(to: CGPoint(x: tr.x - radius, y: tr.y))
            path.addQuadCurve(to: CGPoint(x: tr.x, y: tr.y + radius), control: tr)
            path.addLine(to: CGPoint(x: br.x, y: br.y - radius))
            path.addQuadCurve(to: CGPoint(x: br.x - radius, y: br.y), control: br)
            path.addLine(to: CGPoint(x: bl.x + smallRadius, y: bl.y))
            path.addQuadCurve(to: CGPoint(x: bl.x, y: bl.y - smallRadius), control: bl)
            path.addLine(to: CGPoint(x: tl.x, y: tl.y + radius))
            path.addQuadCurve(to: CGPoint(x: tl.x + radius, y: tl.y), control: tl)
        }

        path.closeSubpath()
        return path
    }
}

// MARK: - Typing indicator bubble

struct TypingIndicatorView: View {

    @State private var animate = false

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "#0077b6") ?? .blue,
                                     Color(hex: "#00b4d8") ?? .cyan],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 32, height: 32)
                Image(systemName: "stethoscope")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
            }

            HStack(spacing: 5) {
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(Color.secondary)
                        .frame(width: 8, height: 8)
                        .scaleEffect(animate ? 1.2 : 0.8)
                        .animation(
                            .easeInOut(duration: 0.5)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.15),
                            value: animate
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 18))

            Spacer(minLength: 50)
        }
        .onAppear { animate = true }
    }
}
