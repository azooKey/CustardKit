import ArgumentParser
import Foundation

@main
struct Samples: ParsableCommand {
    @Argument(help: "The sample to run.")
    var sample: String

    func run() throws {
        try! FileManager.default.createDirectory(atPath: "results", withIntermediateDirectories: true)
        switch sample {
        case "cuneiforms":
            makeCuneiforms()
        case "flick_greek":
            makeFlickGreek()
        case "hieroglyphs":
            makeHieroglyphsTab()
        case "interesting_layout":
            makeInterestingLayout()
        case "md_keyboard":
            makeMarkdownKeyboardTab()
        case "number_font":
            makeNumberFontTab()
        case "tex_board":
            makeTexBoard()
        default:
            fatalError("Unknown sample name: \(sample)")
        }
    }
}
