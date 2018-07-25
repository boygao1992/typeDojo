const log = require( './lib/log' )

const {
  //ADT
  Pair,
  State,
  // Maybe
  option,
  prop,
  // State
  State: {
    modify,
    get,
  },
  // Helper
  assign,
  chain,
  map,
  // Combinator
  compose,
  constant,
} = require( 'crocks' )

// const rando = () => State( s => {
//   const seed = ( 1103515245 * s.seed + 12345 ) & 0x7fffffff
//   const value = ( seed >> 16 ) / 0x7fff

//   return Pair( value, assign( { seed }, s ) )
// } )

// log(
//   rando()
//   .chain( rando )
//   .chain( rando )
//   .runWith( { seed: 23 } )
// )

// Could also be modeled as a Writer, where the Monoid on the right is Last Monoid

const pluckSeed =
  def => compose(
    option( def ),
    prop( 'seed' )
  )

const rando = x => {
  const seed = ( 1103515245 * x + 12345 ) & 0x7fffffff
  const value = ( seed >>> 16 ) / 0x7fff

  return compose(
    map( constant( value ) ),
    modify,
    assign
  )( { seed } )
}

const pullRandom =
  compose(
    chain( rando ),
    get,
    pluckSeed
  )

const seed = 73

log(
  State.of( seed )
  .chain( pullRandom )
  .chain( pullRandom )
  .runWith( {} )
)
