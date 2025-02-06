#!/bin/bash
set -ex

pushd "${PREFIX}"/bin
  ln -s flang ${CHOST}-flang
  if [[ "${CBUILD}" != ${CHOST} ]]; then
    ln -s flang ${CBUILD}-flang
  fi
popd
