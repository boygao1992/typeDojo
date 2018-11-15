module Colors where

import CSSUtils (safeFromHexString)
import Color (Color)

robinsEggBlue :: Color
robinsEggBlue = safeFromHexString "#00C9B6"

monza :: Color
monza = safeFromHexString "#C90014"

gray :: Color
gray = safeFromHexString "#828282"
