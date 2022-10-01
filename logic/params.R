root <- 'https://news.google.com'

#TOP STORIES -HEADLINES
headlines <- '/rss/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRFZxYUdjU0FtVnVHZ0pWVXlnQVAB?'

#WORLD:
world <- '/rss/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx1YlY4U0FtVnVHZ0pWVXlnQVAB?'

#BUSINESS
biz.latest <- '/rss/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx6TVdZU0FtVnVHZ0pWVXlnQVAB?'
biz.section <- '/rss/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx6TVdZU0FtVnVHZ0pWVXlnQVAB/sections/'
ecoID <- 'CAQiSENCQVNNQW9JTDIwdk1EbHpNV1lTQW1WdUdnSlZVeUlQQ0FRYUN3b0pMMjB2TUdkbWNITXpLZ3NTQ1M5dEx6Qm5abkJ6TXlnQSoqCAAqJggKIiBDQkFTRWdvSUwyMHZNRGx6TVdZU0FtVnVHZ0pWVXlnQVABUAE?'
marketID <- 'CAQiXENCQVNQd29JTDIwdk1EbHpNV1lTQW1WdUdnSlZVeUlQQ0FRYUN3b0pMMjB2TURsNU5IQnRLaG9LR0FvVVRVRlNTMFZVVTE5VFJVTlVTVTlPWDA1QlRVVWdBU2dBKioIAComCAoiIENCQVNFZ29JTDIwdk1EbHpNV1lTQW1WdUdnSlZVeWdBUAFQAQ?'
jobsID <- 'QQW9JTDIwdk1EbHpNV1lTQW1WdUdnSlZVeUlQQ0FRYUN3b0pMMjB2TURGMGNYSnJLaGNLRlFvUlNrOUNVMTlUUlVOVVNVOU9YMDVCVFVVZ0FTZ0EqKggAKiYICiIgQ0JBU0Vnb0lMMjB2TURsek1XWVNBbVZ1R2dKVlV5Z0FQAVAB?'
perFinID <- 'CAQiSENCQVNNQW9JTDIwdk1EbHpNV1lTQW1WdUdnSlZVeUlQQ0FRYUN3b0pMMjB2TURGNU5tTnhLZ3NTQ1M5dEx6QXhlVFpqY1NnQSoqCAAqJggKIiBDQkFTRWdvSUwyMHZNRGx6TVdZU0FtVnVHZ0pWVXlnQVABUAE?'
entrep <- 'CAQiRkNCQVNMZ29JTDIwdk1EbHpNV1lTQW1WdUdnSlZVeUlPQ0FRYUNnb0lMMjB2TURKdWQzRXFDaElJTDIwdk1ESnVkM0VvQUEqKggAKiYICiIgQ0JBU0Vnb0lMMjB2TURsek1XWVNBbVZ1R2dKVlV5Z0FQAVAB?'


guide <- data.frame(
  category_ = c('headlines', 'world', 'business.latest', 'business.economy', 'business.market', 'business.jobs', 'business.personal_finance', 'business.entrepreneurship'),
  root_ = rep(root, 8),
  section_ = c(rep('', 3), rep(biz.section, 5)),
  path_ = c(headlines, world, biz.latest, ecoID, marketID, jobsID, perFinID, entrep)
  
)
countryCode <- read.csv('../data/countryCode.csv', stringsAsFactors = F)