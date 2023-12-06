library(RCurl)

URL = 'https://www.ptt.cc/bbs/Gossiping/index.html'
curl = getCurlHandle()
curlSetOpt(cookie = "over18=1", followlocation = TRUE, curl = curl)