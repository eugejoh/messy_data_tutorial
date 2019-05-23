# Clean and Process -------------------------------------------------------
# Eugene Joh
# 2019-05-22

# Objectives:
# 1. show how to remove NAs using `area`
# 2. show how to convert types using `immune_status`
# 3. show how to split using `full_name`
# 4. show how to create binary category in `age`
# 5. show how to correct values/spelling in `area` and select only `Toronto`

# examples use `data1`


# 1. ----------------------------------------------------------------------
data1_v <- data1 %>% 
  dplyr::filter(!is.na(area))

# application 1: subset `data2` to only have observations with missing names

# 2. ----------------------------------------------------------------------
data1_v <- data1_v %>% 
  dplyr::mutate(immune_status_f = factor(immune_status))

# application 2: convert `age` in `data2` to an integer type

# 3. ----------------------------------------------------------------------
data1_v <- data1_v %>% 
  tidyr::separate(full_name, into = c("last_name", "first_name"), sep = ", ")

# application 3: split `area` into new `loc` and `city` variables

# 4. ----------------------------------------------------------------------
data1_v <- data1_v %>% 
  mutate(adult = ifelse(age <= 18, "Non-Adult", "Adult"))

# application 4: create binary categorical variable for "adult women" and "other"

# 5. ----------------------------------------------------------------------
data1_v <- data1_v %>% 
  mutate(loc = case_when(
    loc == "downton" ~ "Downtown",
    loc == "Etobioke" ~ "Etobicoke",
    TRUE ~ loc)) %>% 
  mutate(city = case_when(
    city == "mississauga" ~ "Mississauga",
    city == "oronto" | city == "Tornto" ~ "Toronto",
    TRUE ~ city
  )) %>% 
  filter(city == "Toronto")

# application 5: clean `sex` variable so values are either "Male" or "Female"


# Final Application -------------------------------------------------------
# Process the `serum_igm` variable...
# 1. Create new variables (numerator, denominator) for serum units (mg/dL)
# 2. Create new variable for serum IgM (numeric) value
# 3. Create threshold for high serum IgM

