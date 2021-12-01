## code to prepare `interventions` dataset goes here
interventions <- function(
  which = c(
    "all",
    "national",
    "act",
    "nsw",
    "nt",
    "qld",
    "sa",
    "tas",
    "vic",
    "wa"
  ),
  end_dates = FALSE,
  exclude_after = NA
) {
  
  which <- match.arg(which)
  
  act_interventions <- tibble::tribble(
    ~date, ~state,
    "2021-08-13", "ACT" # lockdown from 1700 12/08/2021 https://twitter.com/ACTHealth/status/1425652154526621700?s=20
  )
  
  nsw_interventions <- tibble::tribble(
    ~date, ~state,
    "2021-06-25", "NSW", # stay-at-home order for 4 LGAs from 11.59 PM 24th, extended to all greater sydney +++ from 11.59 PM 25th. 
    "2021-07-18", "NSW", # increased restrictions from midnight 17th https://www.nsw.gov.au/media-releases/restrictions-to-further-limit-spread-of-covid-19-delta-strain
    "2021-08-15", "NSW" # increase to state-wide lockdown 5 PM 2021/08/14 https://twitter.com/NSWHealth/status/1426735650384998400?s=20
  )
  
  nt_interventions <- tibble::tribble(
    ~date, ~state,
    "2021-06-27", "NT", # https://coronavirus.nt.gov.au/updates/items/2021-06-27-covid-19-update-lockdown-restrictions-in-place
    "2021-08-16", "NT" # in place from midday the 16th https://coronavirus.nt.gov.au/updates/items/2021-08-16-lockdown-restrictions-in-place
  )
  
  qld_interventions <- tibble::tribble(
    ~date, ~state,
    "2021-01-09", "QLD",
    "2021-03-29", "QLD",
    "2021-06-29", "QLD", # starts 6 PM on 29th https://www.qld.gov.au/health/conditions/health-alerts/coronavirus-covid-19/current-status/public-health-directions/restrictions-in-qld-update
    "2021-08-01", "QLD" # starts 4 PM 31st July https://www.qld.gov.au/health/conditions/health-alerts/coronavirus-covid-19/current-status/public-health-directions/restrictions-impacted-areas
  )
  
  sa_interventions <- tibble::tribble(
    ~date, ~state,
    "2020-11-19", "SA",
    "2021-07-21", "SA" # lockdown, starts 6pm on the 20th, https://www.sahealth.sa.gov.au/wps/wcm/connect/public+content/sa+health+internet/about+us/news+and+media/all+media+releases/covid-19+update+20+july+2021
  )
  
  tas_interventions <- tibble::tribble(
    ~date, ~state,
    "2021-10-16", "TAS" # https://www.premier.tas.gov.au/covid-19_updates/press_confernce_-_15_october_2021
  )
  
  vic_interventions <- tibble::tribble(
    ~date, ~state,
    "2020-07-01", "VIC",
    "2020-07-08", "VIC",
    "2020-08-02", "VIC",
    "2021-02-13", "VIC",
    "2021-05-28", "VIC",
    "2021-07-16", "VIC", # lockdown, 5 days from 11:59 the 15th, then extended https://www.dhhs.vic.gov.au/coronavirus-update-victoria-15-july-2021
    "2021-08-06", "VIC" # lockdown from 20:00 2021/08/05 
  )
  
  wa_interventions <- tibble::tribble(
    ~date, ~state,
    "2021-01-31", "WA",
    "2021-04-24", "WA",
    "2021-06-29", "WA" # https://www.wa.gov.au/government/announcements/4-day-lockdown-introduced-perth-and-peel
  )
  
  
  national_interventions <- expand_grid(
    date = c("2020-03-16", "2020-03-24", "2020-03-29"),
    state = c("ACT", "NSW", "NT", "QLD", "SA", "TAS", "VIC", "WA")
  )
  
  
  if(end_dates){
    
    act_interventions <-  act_interventions %>%
      bind_rows(
        tibble::tribble(
          ~date, ~state,
          "2021-10-15", "ACT" # lockdown end 11:59 PM 2021/10/14 https://twitter.com/ACTHealth/status/1447778422755708933?s=20
        )
      )
    
    nsw_interventions <-  nsw_interventions %>%
      bind_rows(
        tibble::tribble(
          ~date, ~state,
          "2021-10-11", "NSW" # https://www.nsw.gov.au/media-releases/ready-set-go-nsw-prepares-to-re-open
        )
      )
    
    nt_interventions <-  nt_interventions %>%
      bind_rows(
        tibble::tribble(
          ~date, ~state,
          "2021-07-02", "NT", # https://coronavirus.nt.gov.au/updates/items/2021-06-28-covid-19-update-nt
          "2021-08-20", "NT" # lifted from 2021/08/19 1200 https://coronavirus.nt.gov.au/updates/items/2021-08-19-lockdown,-restrictions-and-border-entry-requirements
        )
      )
    
    qld_interventions <-  qld_interventions %>%
      bind_rows(
        tibble::tribble(
          ~date, ~state,
          "2021-01-12", "QLD",
          "2021-04-01", "QLD",
          "2021-07-04", "QLD", # Lifted 6 PM 3rd July https://www.qld.gov.au/health/conditions/health-alerts/coronavirus-covid-19/current-status/public-health-directions/restrictions-impacted-areas
          "2021-08-09", "QLD" # lifted 4 PM 8th Aug https://www.qld.gov.au/health/conditions/health-alerts/coronavirus-covid-19/current-status/public-health-directions/restrictions-in-qld-update
        )
      )
    
    sa_interventions <-  sa_interventions %>%
      bind_rows(
        tibble::tribble(
          ~date, ~state,
          "2020-11-22", "SA",
          "2021-07-28", "SA" # restrictions eased from 28th https://www.sahealth.sa.gov.au/wps/wcm/connect/public+content/sa+health+internet/about+us/news+and+media/all+media+releases/covid-19+update+28+july+2021
        )
      )
    
    tas_interventions <-  tas_interventions %>%
      bind_rows(
        tibble::tribble(
          ~date, ~state,
          "2021-10-19", "TAS" # https://www.premier.tas.gov.au/covid-19_updates/press_confernce_-_15_october_2021
        )
      )
    
    vic_interventions <-  vic_interventions %>%
      bind_rows(
        tibble::tribble(
          ~date, ~state,
          "2021-02-18", "VIC",
          "2021-06-11", "VIC",
          "2021-07-28", "VIC", # lockdown lifted 11.59 PM 2021/07/27 https://www.premier.vic.gov.au/lockdown-lifted-across-victoria
          "2021-10-22", "VIC" # lockdown lifted 11.59 PM 2021/10/21
        )
      )
    
    wa_interventions <-  wa_interventions %>%
      bind_rows(
        tibble::tribble(
          ~date, ~state,
          "2021-02-05", "WA",
          "2021-04-27", "WA",
          "2021-07-03", "WA" # https://www.wa.gov.au/government/announcements/end-of-lockdown-perth-and-peel-1201am-saturday-3-july
        )
      )
  }
  
  interventions <- switch(
    which,
    national = national_interventions %>%
      filter(state == "ACT") %>%
      mutate(state = "all"),
    act = act_interventions,
    nsw = nsw_interventions,
    nt  = nt_interventions,
    qld = qld_interventions,
    sa  = sa_interventions,
    tas = tas_interventions,
    vic = vic_interventions,
    wa =  wa_interventions,
    all = bind_rows(
      national_interventions,
      act_interventions,
      nsw_interventions,
      nt_interventions,
      qld_interventions,
      sa_interventions,
      tas_interventions,
      vic_interventions,
      wa_interventions,
    )
  ) %>%
    mutate(
      date = as.Date(date),
      state = factor(state)
    ) %>% 
    arrange(state, date)
  
  if(!is.na(exclude_after)){
    
    interventions <- interventions %>%
      filter(date <= as.Date(exclude_after))
  }
  
  return(interventions)
}

interventions <- interventions()

usethis::use_data(interventions, overwrite = TRUE)
