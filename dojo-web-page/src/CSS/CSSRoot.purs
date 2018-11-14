module CSS.Root where

import Prelude

import CSS (CSS)
import CSS (backgroundColor, body, borderBox, boxSizing, display, inlineBlock, star) as CSS
import CSSUtils ((?), (&))
import CSSUtils (pair, byClass) as CSS
import Selectors as S
import Colors as Colors
import ClassNames as CN

root :: CSS
root = do
  CSS.star ? do
    CSS.boxSizing CSS.borderBox

  CSS.body ? do
    CSS.pair "font-family" "Consolas, monospace"

  S.charblock ? do
    CSS.display CSS.inlineBlock

  S.charblock & (CSS.byClass CN.keyCorrect) ? do
    CSS.backgroundColor Colors.robinsEggBlue

  S.charblock & (CSS.byClass CN.keyWrong) ? do
    CSS.backgroundColor Colors.monza
