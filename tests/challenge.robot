*** Settings ***
Library  Browser
Library  OperatingSystem
Library  ExcelLibrary

*** Variables ***
${URL}  https://rpachallenge.com
${CHALLENGE}  https://rpachallenge.com/assets/downloadFiles/challenge.xlsx
${OUTPUT_DIR}  ${CURDIR}/output
${CHALLENGE_XLSX}  ${OUTPUT_DIR}/challenge.xlsx

*** Test Cases ***
Download challenge.xlsx
  New Context  acceptDownloads=True
  New Page  ${URL}
  Download  ${CHALLENGE}  saveAs=${CHALLENGE_XLSX}
  File Should Exist  ${CHALLENGE_XLSX}
  Close Browser

Extract data from challenge.xlsx and fill it in
  Open Excel Document  filename=${CHALLENGE_XLSX}  doc_id=doc
  ${titles}=           Read Excel Row  row_num=1  max_num=7  sheet_name=Sheet1
  ${first_name}=       Read Excel Column  col_num=1  row_offset=1  max_num=10  sheet_name=Sheet1
  ${last_name}=        Read Excel Column  col_num=2  row_offset=1  max_num=10  sheet_name=Sheet1
  ${company_name}=     Read Excel Column  col_num=3  row_offset=1  max_num=10  sheet_name=Sheet1
  ${role_in_company}=  Read Excel Column  col_num=4  row_offset=1  max_num=10  sheet_name=Sheet1
  ${address}=          Read Excel Column  col_num=5  row_offset=1  max_num=10  sheet_name=Sheet1
  ${email}=            Read Excel Column  col_num=6  row_offset=1  max_num=10  sheet_name=Sheet1
  ${phone_number}=     Read Excel Column  col_num=7  row_offset=1  max_num=10  sheet_name=Sheet1
  Close All Excel Documents

  New Persistent Context  headless=No  slowMo=1
  New Page    ${URL}
  Fill Text   //input[@ng-reflect-name="labelFirstName"]    ${first_name[0]}
  Fill Text   //input[@ng-reflect-name="labelLastName"]     ${last_name[0]}
  Fill Text   //input[@ng-reflect-name="labelCompanyName"]  ${company_name[0]}
  Fill Text   //input[@ng-reflect-name="labelRole"]         ${role_in_company[0]}
  Fill Text   //input[@ng-reflect-name="labelAddress"]      ${address[0]}
  Fill Text   //input[@ng-reflect-name="labelEmail"]        ${email[0]}
  Fill Text   //input[@ng-reflect-name="labelPhone"]        ${phone_number[0]}
  ${submit}=  Get Element By Role  BUTTON  name=Submit
  Click       ${submit}
  Close Browser
