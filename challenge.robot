*** Settings ***
Library  Browser
Library  OperatingSystem

*** Variables ***
${URL}  https://rpachallenge.com
${CHALLENGE}  https://rpachallenge.com/assets/downloadFiles/challenge.xlsx
${OUTPUT_DIR}  ${CURDIR}/output

*** Test Cases ***
Download challenge.xlsx
  New Context  acceptDownloads=True
  New Page  ${URL}
  Download  ${CHALLENGE}  saveAs=${OUTPUT_DIR}/challenge.xlsx
  File Should Exist  ${OUTPUT_DIR}/challenge.xlsx
  Close Browser
