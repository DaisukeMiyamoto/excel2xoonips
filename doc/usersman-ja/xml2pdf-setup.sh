#!/bin/sh

DOC_BASE_DIR="`dirname $0`"

DOCUMENT=${DOC_BASE_DIR}/src/document.xml

CONFIG_INI="${DOC_BASE_DIR}/config.ini"
LINT=${DOC_BASE_DIR}/docbook-lint.sh
MAKE_TITLEPAGE=${DOC_BASE_DIR}/make-titlepage.sh
TEMP_DIR=${DOC_BASE_DIR}/temp

if test -f ${CONFIG_INI}; then
  eval `cat ${CONFIG_INI}`
  export SGML_CATALOG_FILES
  export XSL_STYLESHEETS_DIR
  export XSL_STYLESHEETS_DIR_WIN32
fi
if test -z "${SGML_CATALOG_FILES}"; then
  echo "Error: set SGML_CATALOG_FILES environment variable"
  exit 1;
fi
if test -z "${XSL_STYLESHEETS_DIR}/xhtml/chunk.xsl"; then
  echo "Error: set XSL_STYLESHEETS_DIR environment variable"
  exit 1;
fi

"${LINT}" "${DOCUMENT}"
RETVAL=$?
if [ ${RETVAL} -ne 0 ]; then
  echo "Error: ${LINT} error"
  exit 1;
fi

"${MAKE_TITLEPAGE}"
RETVAL=$?
if [ ${RETVAL} -ne 0 ]; then
  echo "Error: ${MAKE_TITLEPAGE} error"
  exit 1;
fi

sed -e "s+@XSL_STYLESHEETS_DIR_WIN32@+${XSL_STYLESHEETS_DIR_WIN32}+g" ${DOC_BASE_DIR}/xsl/axf.xsl.in > ${TEMP_DIR}/axf.xsl

rm -f ${TEMP_DIR}/images
ln -s ../src/images ${TEMP_DIR}
xmllint --xinclude --postvalid --catalogs ${DOCUMENT} > "${TEMP_DIR}/document.xml"

exit 0
