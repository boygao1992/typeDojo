const log = require( './lib/log' )

const {
  //ADT
  Pair,
  State,
  // Helper
  assign,
} = require( 'crocks' )

const rando = () => State( s => {
  const seed = ( 1103515245 * s.seed + 12345 ) & 0x7fffffff
  const value = ( seed >> 16 ) / 0x7fff

  return Pair( value, assign( { seed }, s ) )
} )

log(
  rando()
  .chain( rando )
  .chain( rando )
  .runWith( { seed: 23 } )
)

// Could also be modeled as a Writer, where the Monoid on the right is Last Monoid
