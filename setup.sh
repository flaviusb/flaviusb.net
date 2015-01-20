#!/bin/bash
cabal sandbox delete
cabal sandbox init
cabal configure
cabal install --only-dependencies
