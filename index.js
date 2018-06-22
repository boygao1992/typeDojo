const log = require( './lib/log' )
const fs = require( 'fs' )
const moment = require( 'moment' )
const randomize = require( 'randomatic' )

const {
  // ADT
  Async,
  Async: { fromNode },
  // Helper
  constant,
  curry,
  identity,
  // Pointfree
  bimap,
} = require( 'crocks' )

const R = require( 'ramda' )

/* Config */
const DOJO_LENGTH = 500
const DOJO_PATTERN = '0!'
const DOJO_WORDS_PER_LINE = 50

// data :: IO => String
const date = moment()
  .format()

// createFilename :: String -> String
const createFilename = name =>
  './dojo/' + name + '.txt'

// getRandomString :: IO => String -> Int -> String
const getRandomString = curry(
  ( pattern, length ) => randomize( pattern, length )
)
// getDojo :: _ -> String
const getDojo = () =>
  getRandomString( DOJO_PATTERN, DOJO_LENGTH )

// wrapText :: Int -> String -> String
const wrapText = curry(
  ( wordsPerLine, str ) =>
  R.reduce(
    ( xs, x ) => xs.length % wordsPerLine ? ( xs + x ) : ( xs + '\r\n\r\n' + x ),
    '',
    str
  )
)

// wrapDojo :: String -> String
const wrapDojo = wrapText( DOJO_WORDS_PER_LINE )

// writeFile :: IO
const writeFile = fromNode( fs.writeFile )

// writeFileAsync :: Options -> String -> String -> Async Error b
const writeFileAsync = curry(
  ( options, path, data ) =>
  writeFile( path, data, options )
)

// writeTextFile :: String -> Async Error String
const writeTextFile = writeFileAsync( 'utf-8' )

// Async fork reflection
const fork = a => a.fork(
  log.bind( null, 'rej' ),
  log.bind( null, 'res' )
)

fork( writeTextFile( createFilename( date ), wrapDojo( getDojo() ) ) )
