import Foundation

/// - インターフェースのキーのスタイルです
/// - style of keys
package enum LegacyCustardInterfaceStyle: String, Codable, Sendable {
    /// - フリック可能なキー
    /// - flickable keys
    case tenkeyStyle = "tenkey_style"

    /// - 長押しで他の文字を選べるキー
    /// - keys with variations
    case pcStyle = "pc_style"
}
