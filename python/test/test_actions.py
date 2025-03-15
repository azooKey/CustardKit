from source.json import to_json
from source.actions import *
import unittest
import sys
import json
from pathlib import Path
sys.path.append(str(Path('__file__').resolve().parent))


class TestActions(unittest.TestCase):
    """test class of actions.py
    """

    def test_InputAction(self):
        """test method for InputAction
        """
        actual = to_json(InputAction("hoge😊√異"))
        expected_json = {
            "type": "input",
            "text": "hoge😊√異"
        }
        self.assertEqual(expected_json, actual)

    def test_ReplaceLastCharactersAction(self):
        """test method for ReplaceLastCharactersAction
        """
        actual = to_json(ReplaceLastCharactersAction(
            {"あ": "ぁ", "か": "が", "😆": "😭"}))
        expected_json = {
            "type": "replace_last_characters",
            "table": {"あ": "ぁ", "か": "が", "😆": "😭"}
        }
        self.assertEqual(expected_json, actual)

    def test_TransliterateAction(self):
        """test method for Transliterate
        """
        actual = to_json(TransliterateAction(
            kana=KanaTransliteration.hiragana))
        expected_json = {
            "type": "transliterate",
            "kana": "hiragana"
        }
        self.assertEqual(expected_json, actual)

    def test_MoveTabAction(self):
        """test method for MoveTabAction
        """
        actual = to_json(MoveTabAction(
            tab_type=TabType.custom, text="flick_greek"))
        expected_json = {
            "type": "move_tab",
            "tab_type": TabType.custom,
            "identifier": "flick_greek"
        }
        self.assertEqual(expected_json, actual)

        actual = to_json(MoveTabAction(
            tab_type=TabType.system, text="flick_kutoten"))
        expected_json = {
            "type": "move_tab",
            "tab_type": TabType.system,
            "identifier": "flick_kutoten"
        }
        self.assertEqual(expected_json, actual)

    def test_MoveCursorAction(self):
        """test method for MoveCursorAction
        """
        actual = to_json(MoveCursorAction(3))
        expected_json = {
            "type": "move_cursor",
            "count": 3
        }
        self.assertEqual(expected_json, actual)

        actual = to_json(MoveCursorAction(-2))
        expected_json = {
            "type": "move_cursor",
            "count": -2
        }
        self.assertEqual(expected_json, actual)

    def test_LaunchApplicationAction(self):
        """test method for LaunchApplicationAction
        """
        actual = to_json(LaunchApplicationAction(
            "shortcuts", "run_shortcut?name=take_picture"))
        expected_json = {
            "type": "launch_application",
            "scheme_type": "shortcuts",
            "target": "run_shortcut?name=take_picture"
        }
        self.assertEqual(expected_json, actual)

    def test_SmartMoveCursorAction(self):
        """test method for SmartMoveCursorAction
        """
        actual = to_json(SmartMoveCursorAction(ScanDirection.forward, targets=[
            "!", "?", ".", ",", ":", ";"]))
        expected_json = {
            "type": "smart_move_cursor",
            "direction": ScanDirection.forward,
            "targets": ["!", "?", ".", ",", ":", ";"]
        }
        self.assertEqual(expected_json, actual)

    def test_SelectCandidateAction(self):
        """test method for SelectCandidateAction
        """
        actual = to_json(SelectCandidateAction("first"))
        expected_json = {
            "type": "select_candidate",
            "selection": {"type": "first"}
        }
        self.assertEqual(expected_json, actual)
        actual = to_json(SelectCandidateAction("exact", 5))
        expected_json = {
            "type": "select_candidate",
            "selection": {"type": "exact", "value": 5}
        }
        self.assertEqual(expected_json, actual)

    def test_DeleteAction(self):
        """test method for DeleteAction
        """
        actual = to_json(DeleteAction(12))
        expected_json = {
            "type": "delete",
            "count": 12,
        }
        self.assertEqual(expected_json, actual)

        actual = to_json(DeleteAction(-4))
        expected_json = {
            "type": "delete",
            "count": -4,
        }
        self.assertEqual(expected_json, actual)

    def test_SmartDeleteAction(self):
        """test method for SmartDeleteAction
        """
        actual = to_json(SmartDeleteAction(ScanDirection.forward, targets=[
            "!", "?", ".", ",", ":", ";"]))
        expected_json = {
            "type": "smart_delete",
            "direction": ScanDirection.forward,
            "targets": ["!", "?", ".", ",", ":", ";"]
        }
        self.assertEqual(expected_json, actual)

    def test_NoArgumentsAction(self):
        """test method for actions without arguments
        """
        actual = to_json(ReplaceDefaultAction())
        expected_json = {
            "type": "replace_default",
        }
        self.assertEqual(expected_json, actual)

        actual = to_json(SmartDeleteDefaultAction())
        expected_json = {
            "type": "smart_delete_default",
        }
        self.assertEqual(expected_json, actual)

        actual = to_json(EnableResizingModeAction())
        expected_json = {
            "type": "enable_resizing_mode",
        }
        self.assertEqual(expected_json, actual)

        actual = to_json(ToggleCursorBarAction())
        expected_json = {
            "type": "toggle_cursor_bar",
        }
        self.assertEqual(expected_json, actual)

        actual = to_json(ToggleTabBarAction())
        expected_json = {
            "type": "toggle_tab_bar",
        }
        self.assertEqual(expected_json, actual)

        actual = to_json(ToggleCapsLockStateAction())
        expected_json = {
            "type": "toggle_caps_lock_state",
        }
        self.assertEqual(expected_json, actual)

        actual = to_json(DismissKeyboardAction())
        expected_json = {
            "type": "dismiss_keyboard",
        }
        self.assertEqual(expected_json, actual)

        actual = to_json(PasteAction())
        expected_json = {
            "type": "paste",
        }
        self.assertEqual(expected_json, actual)

    def test_LongpressAction(self):
        """test method for LongpressAction
        """

        input = InputAction("happy")
        delete = DeleteAction(-1)
        smart_move_cursor = SmartMoveCursorAction(
            ScanDirection.backward, targets=["0"])
        dismiss_keyboard = DismissKeyboardAction()
        action = LongpressAction(start=[input, delete], repeat=[
                                 smart_move_cursor, dismiss_keyboard])

        expected_json = {
            "start": [to_json(input), to_json(delete)],
            "repeat": [to_json(smart_move_cursor), to_json(dismiss_keyboard)]
        }

        self.assertEqual(expected_json, to_json(action))

    def test_ScanDirection(self):
        """test method for ScanDirection
        """
        actual = json.dumps(ScanDirection.backward)
        self.assertEqual("\"backward\"", actual)

        actual = json.dumps(ScanDirection.forward)
        self.assertEqual("\"forward\"", actual)

    def test_TabType(self):
        """test method for TabType
        """
        actual = json.dumps(TabType.system)
        self.assertEqual("\"system\"", actual)

        actual = json.dumps(TabType.custom)
        self.assertEqual("\"custom\"", actual)


if __name__ == "__main__":
    unittest.main()
