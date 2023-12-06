library(RCurl)


# over18 = 1 的時候，不須點擊 「已滿18歲」便可進入網站 
URL = 'https://www.ptt.cc/bbs/Gossiping/index.html'
curl = getCurlHandle()
curlSetOpt(cookie = "over18=1", followlocation = TRUE, curl = curl)

html_character = getURL(URL, curl = curl)

website = read_html(html_character)
needed_html = website %>% html_nodes("a")
needed_txt = needed_html %>% html_text()
needed_txt

library(RCurl)
library(rvest)

my_table = matrix("", nrow = 10, ncol = 2)
colnames(my_table) = c("Title", "url")

URL = 'https://www.ptt.cc/bbs/Gossiping/index.html'
curl = getCurlHandle()
curlSetOpt(cookie = "over18=1", followlocation = TRUE, curl = curl)

current_id = 1

for (i in 1:10) {
  
  html_character = getURL(URL, curl = curl)
  website = read_html(html_character)
  
  needed_html = website %>% html_nodes("a")
  needed_txt = needed_html %>% html_text()
  intrested_pos = which(grepl("[新聞]", needed_txt, fixed = TRUE) & !grepl("Re: ", needed_txt, fixed = TRUE))
  
  if (length(intrested_pos) > 0) {
    
    for (j in intrested_pos) {
      
      if (current_id <= 10) {
        my_table[current_id, 1] = needed_txt[j]
        my_table[current_id, 2] = needed_html[j] %>% html_attr("href")
      }
      
      current_id = current_id + 1
      
    }
    
  }
  
  if (current_id > 10) {
    break
  }
  
  next_page = website %>% html_nodes("a") %>% .[8] %>% html_attr("href")
  URL = paste0("https://www.ptt.cc", next_page, sep = "")
  
}

my_table

