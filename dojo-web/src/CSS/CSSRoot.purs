module CSS.Root where

import Prelude

import CSS (CSS)
import CSS (backgroundColor, body, borderBox, boxSizing, display, inlineBlock, star) as CSS
import CSSUtils ((?))
import CSSUtils (pair) as CSS
import Selectors as S
import Colors as Colors

root :: CSS
root = do
  CSS.star ? do
    CSS.boxSizing CSS.borderBox

  CSS.body ? do
    CSS.pair "font-family" "Consolas, monospace"

  S.charblock ? do
    CSS.display CSS.inlineBlock
    CSS.backgroundColor Colors.robinsEggBlue
