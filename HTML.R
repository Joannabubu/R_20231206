#擷取網頁資訊
URL = "https://reg.ntuh.gov.tw/EmgInfoBoard/NTUHEmgInfo.aspx"

txt = scan(URL, what = "character", encoding = "UTF-8", quiet = TRUE)

head(txt, 15)

#透過 paste 將換行的字串轉為一個常字串
txt_new = paste(txt, sep = "", collapse = " ")
TITLE.pos = gregexpr("<title>.*</title>", txt_new)

#擷取資訊 (頭跟尾的位置)
start.TITLE.pos = TITLE.pos[[1]][1]
end.TITLE.pos = start.TITLE.pos + attr(TITLE.pos[[1]], "match.length")[1] - 1

TITLE.word = substr(txt_new, start.TITLE.pos, end.TITLE.pos)

TITLE.word