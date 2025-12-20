/// - キーに指定するラベル
/// - labels on the key
public enum CustardKeyLabelStyle: Codable, Equatable, Hashable, Sendable {
    case text(String)
    case systemImage(String)
    case mainAndSub(String, String)
}

public extension CustardKeyLabelStyle {
    private enum CodingKeys: CodingKey {
        case text
        case system_image
        case type
        case main
        case sub
    }

    private enum ValueType: String, Codable {
        case text
        case system_image
        case main_and_sub
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .text(value):
            try container.encode(value, forKey: .text)
        case let .systemImage(value):
            try container.encode(value, forKey: .system_image)
        case let .mainAndSub(main, sub):
            try container.encode(ValueType.main_and_sub, forKey: .type)
            try container.encode(main, forKey: .main)
            try container.encode(sub, forKey: .sub)
        }
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // "type"が見つかった場合
        if let type = try? container.decode(ValueType.self, forKey: .type) {
            switch type {
            case .text:
                let value = try container.decode(
                    String.self,
                    forKey: .text
                )
                self = .text(value)
            case .system_image:
                let value = try container.decode(
                    String.self,
                    forKey: .system_image
                )
                self = .systemImage(value)
            case .main_and_sub:
                let main = try container.decode(
                    String.self,
                    forKey: .main
                )
                let sub = try container.decode(
                    String.self,
                    forKey: .sub
                )
                self = .mainAndSub(main, sub)
            }
            return
        }

        // それ以外の場合(old cases)
        guard container.allKeys.count == 1, let key = container.allKeys.first else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode CustardKeyLabelStyle."
                )
            )
        }
        switch key {
        case .text:
            let value = try container.decode(
                String.self,
                forKey: .text
            )
            self = .text(value)
        case .system_image:
            let value = try container.decode(
                String.self,
                forKey: .system_image
            )
            self = .systemImage(value)
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode CustardKeyLabelStyle."
                )
            )
        }
    }
}
