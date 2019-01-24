*** Variables ***
${N11_URL}  https://www.n11.com/
${signInLinkN11}  xpath=//a[@title="Giriş Yap"]
${userMail}  testrobotpy@gmail.com
${userPassword}  q1w2e3r4
${emailInput}  id=email
${passwordInput}  id=password
${loginButton}  id=loginButton
${searchInput}  id=searchData
${searchButton}  xpath=//a[@title="ARA"]
${searchKeyText}  xpath=//div[@class="resultText "]/h1
${secondPage}  xpath=//div[@class="pagination"]/a[2]
${currentPage}  xpath=//div[@class="pagination"]/a[@class="active "]
${thirdProductFacIcon}  xpath=//li[3]//span[@title="Favorilere ekle"]
${thirdProductId}  xpath=//li[3]//div[@class="columnContent "]
${myAccount}  xpath=//div[@class="myAccount"]
${favoriteList}  xpath=//a[@title="İstek Listem / Favorilerim"]
${favoriteLink}  xpath=//h4[@class="listItemTitle"]
${favoriteProductId}  xpath=//div[@id="view"]//div[@class="columnContent adBg"]
${favoriteDeleteLink}  xpath=//span[@class="deleteProFromFavorites"]
${favoriteDeleteMessage}  xpath=//span[@class="message"]
${favoriteDeleteMessageOkButton}  xpath=//span[@class="btn btnBlack confirm"]

