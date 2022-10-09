get.feed <- function(url = url_, cat = NULL) {
  
  feed <- tidyRSS::tidyfeed(url)
  
  #fix, transform and expand nested descptions
  doc <- read_xml(url)
  
  desc <-
    doc %>%
      xml_find_all('//description') %>%
      xml_contents() %>%
      xml_text() %>%
      .[- 1]
  
  #add enchor marker to split nested description items.
  txt <-
    desc %>%
      str_replace_all(., '</font>', ' :: </font>') %>%
      str_remove_all('(<([^>]+)>)')
  
  #include hidden individual nested article links from href attr.
  link <-
    desc %>%
      stringr::str_extract_all('http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+')
  
  res_ <-
    feed %>%
      mutate(
        txt           = txt,
        link          = link,
        item_category = cat
      ) %>%
      group_by(item_title) %>%
      mutate(
        txt_split = stringr::str_split(txt, '\\s::\\s')
      ) %>%
      unnest(cols = c('txt_split', 'link')) %>%
      ungroup() %>%
      mutate(
        text      = str_extract(txt_split, '.+?(?=&nbsp;&nbsp;)'),
        publisher = str_remove(txt_split, '.*(&nbsp;&nbsp;)')
      ) %>%
      dplyr::filter(! grepl('on Google News', publisher), text != '') %>%
      select(- c(feed_description, feed_web_master, feed_generator, item_title, item_description, txt, txt_split))
  
  return(res_)
  
}