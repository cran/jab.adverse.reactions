# Vaccine/Experimental Gene Therapy Adverse Events

install.load::load_package("tm", "stringi", "bracer", "mgsub", "qdapRegex", "stringr", "data.table", "xmlconvert", "jsonlite", "anytime", "rbibutils", "cffr")


# APPENDIX 1. LIST OF ADVERSE EVENTS OF SPECIAL INTEREST from the Pfizer document

# The following code was used to create the modified strings used in the strings_to_remove character vector

expand_braces("Page {30..38}")

# [1] "Page 30" "Page 31" "Page 32" "Page 33" "Page 34" "Page 35" "Page 36"
# [8] "Page 37" "Page 38"

expand_braces("Page {1..9}")

# [1] "Page 1" "Page 2" "Page 3" "Page 4" "Page 5" "Page 6" "Page 7" "Page 8"
# [9] "Page 9"

expand_braces("FDA-CBER-2021-5683-00000{83..91}")

# [1] "FDA-CBER-2021-5683-0000083" "FDA-CBER-2021-5683-0000084"
# [3] "FDA-CBER-2021-5683-0000085" "FDA-CBER-2021-5683-0000086"
# [5] "FDA-CBER-2021-5683-0000087" "FDA-CBER-2021-5683-0000088"
# [7] "FDA-CBER-2021-5683-0000089" "FDA-CBER-2021-5683-0000090"
# [9] "FDA-CBER-2021-5683-0000091"



# collection of strings to remove from the Pfizer document
strings_to_remove <- c('CONFIDENTIAL', 'FDA-CBER-2021-5683-0000088', '\"', 'BNT162b2', '5.3.6 Cumulative Analysis of Post-authorization Adverse Event Reports', 'Page 30', 'Page 31', 'Page 32', 'Page 33', 'Page 34', 'Page 35', 'Page 36', 'Page 37', 'Page 38', 'Page 1', 'Page 2', 'Page 3', 'Page 4', 'Page 5', 'Page 6', 'Page 7', 'Page 8', 'Page 9', 'FDA-CBER-2021-5683-0000083', 'FDA-CBER-2021-5683-0000084', 'FDA-CBER-2021-5683-0000085', 'FDA-CBER-2021-5683-0000086', 'FDA-CBER-2021-5683-0000087', 'FDA-CBER-2021-5683-0000088', 'FDA-CBER-2021-5683-0000089', 'FDA-CBER-2021-5683-0000090', 'FDA-CBER-2021-5683-0000091', 'APPENDIX 1. LIST OF ADVERSE EVENTS OF SPECIAL INTEREST')

# Source 1 begins
read <- readPDF(control = list(text = "-layout"))

document <- Corpus(URISource("./inst/pdf/5.3.6-postmarketing-experience.pdf"), readerControl = list(reader = read))
# Source 1 ends

jab_adverse_reactions_doc <- content(document[[1]])

# capture the last 9 pages (those of interest only)
jab_adverse_reactions1 <- jab_adverse_reactions_doc[30:38]

# str_flatten based on a space
jab_adverse_reactions2 <- str_flatten(jab_adverse_reactions1, " ")

# replace all new line characters (\n with a space
jab_adverse_reactions3 <- stri_replace_all_fixed(jab_adverse_reactions2, "\n", " ")

# remove the white space
jab_adverse_reactions4 <- rm_white(jab_adverse_reactions3)

# split the strings on the semicolon (;)
jab_adverse_reactions5 <- stri_split_fixed(jab_adverse_reactions4, ";")

# remove the set of strings
jab_adverse_reactions6 <- lapply(jab_adverse_reactions5, mgsub, strings_to_remove, rep("", length(strings_to_remove)))

# flatten the list
jab_adverse_reactions7 <- unlist(jab_adverse_reactions6)

# replace the period (.) followed by a space with nothing
jab_adverse_reactions8 <- stri_replace_all_fixed(jab_adverse_reactions7, ". ", "")

# replace the dash (-) followed by a space with a dash
jab_adverse_reactions9 <- stri_replace_all_fixed(jab_adverse_reactions8, "- ", "-")

# remove the space between the H and the rest of the text
jab_adverse_reactions10 <- stri_replace_all_fixed(jab_adverse_reactions9, "H ypocalcaemic", "Hypocalcaemic")

# remove the specific substring from the overall string
jab_adverse_reactions11 <- gsub("090177e196ea1800\\Approved\\Approved On: 30-Apr-2021 09:26 (GMT)", "", jab_adverse_reactions10, fixed = TRUE)

# remove the white space
jab_adverse_reactions12 <- rm_white(jab_adverse_reactions11)



# the sorted adverse events from the Wilson article
wilson_article <- c("Adenopathy", "Anaphylaxis", "Arthralgia", "Cardiac collapse", "Coma", "Death", "Encephalitis", "Multiple neuritis", "Myelitis", "Paralysis of the serratus magnus and other muscles", "Urticaria")



## In order to make it easier to have a simplified set of keywords to search for in the VAERS and other vaccine reporting database systems, the adverse events with a "/" or an extended description for the adverse events have been modified in the same individual data set. Thus, there exists both the complex and the simplified adverse event in the individual data sets.

# sorted adverse events from the Dr. Anderson presentation
anderson_presentation <- sort(c("Acute disseminated encephalomyelitis", "Acute myocardial infarction", "Anaphylaxis", "Arthritis and arthralgia/joint pain", "Autoimmune disease", "Convulsions/seizures", "Deaths", "Disseminated intravascular coagulation", "Encephalitis/myelitis/encephalomyelitis/meningoencephalitis/meningitis/encepholapathy", "Guillain-Barré syndrome", "Kawasaki disease", "Multisystem Inflammatory Syndrome in Children", "Myocarditis/pericarditis", "Narcolepsy and cataplexy", "Non-anaphylactic allergic reactions", "Other acute demyelinating diseases", "Pregnancy and birth outcomes", "Stroke", "Thrombocytopenia", "Transverse myelitis", "Vaccine enhanced disease", "Venous thromboembolism", "Encephalitis", "Myelitis", "Encephalomyelitis", "Meningoencephalitis", "Meningitis", "Encepholapathy"))

# In order to avoid warnings from CRAN about the UTF-8 character
anderson_presentation_for_R <- sort(c("Acute disseminated encephalomyelitis", "Acute myocardial infarction", "Anaphylaxis", "Arthritis and arthralgia/joint pain", "Autoimmune disease", "Convulsions/seizures", "Deaths", "Disseminated intravascular coagulation", "Encephalitis/myelitis/encephalomyelitis/meningoencephalitis/meningitis/encepholapathy", stri_enc_toascii("Guillain-Barré syndrome"), "Kawasaki disease", "Multisystem Inflammatory Syndrome in Children", "Myocarditis/pericarditis", "Narcolepsy and cataplexy", "Non-anaphylactic allergic reactions", "Other acute demyelinating diseases", "Pregnancy and birth outcomes", "Stroke", "Thrombocytopenia", "Transverse myelitis", "Vaccine enhanced disease", "Venous thromboembolism", "Encephalitis", "Myelitis", "Encephalomyelitis", "Meningoencephalitis", "Meningitis", "Encepholapathy"))



# the sorted adverse events from the Iyengar article
iyengar_article <- sort(c("Anaphylactic symptoms", "Cyanosis", "Death (if the Anaphylactic symptoms are not properly and effectively treated)", "Respiration difficulties", "(Serum) Shock", "Urticaria", "Death", "Shock")) 



# the sorted adverse events from the Yerushalmi article
yerushalmi_article <- sort(c("Fever", "Cutaneous eruption", "Arthralgia/Arthritis", "Gastrointestinal disturbances", "Lymphadenopathy", "Proteinuria", "Arthralgia", "Arthritis"))


# the sorted adverse events from the Williams article
williams_article <- sort(c("Local redness at the site of injection", "Anaphylactic reaction (The earliest symptoms of severe and dangerous anaphylactic reactions may be sweating, a feeling of heat throughout the body, a generalized pruritus, or an urticarial rash rapidly becoming generalized; an irritating cough, dyspnoea and wheeziness, a choking sensation, substernal oppression, or a feeling of constriction in the chest; retching or vomiting with cramp-like pains in the abdomen, sometimes diarrhoea, occasionally severe abdominal distension; and/or headache, giddiness, or sudden unconsciousness, in some cases followed by convulsions; while acute circulatory collapse and death may occur rapidly. The pulse is at first of good volume, slow and bounding, but in the dangerously ill patient it becomes rapid, weak, and thready, and there is a marked fall in blood pressure.)", "Serum sickness (They consist of fever, skin eruptions {Angioneurotic oedema [albumin or possibly blood in the urine], Morbilliform type of rash, Scarlatiniform type of rash, Urticarial weals}, glandular enlargement, and arthritis, often in this order. In the more severe reactions there may be difficulty in swallowing and a feeling of a heavy lump behind the sternum, while cramp-like abdominal pains, with or without diarrhoea or vomiting or both, are also not uncommon and may last for several days. Stiffness of the joints, especially after use, and an urticarial type of skin reaction after pressure may persist for weeks and sometimes for many months. One of my own patients, six months after his penicillin reaction, still developed pain and swelling of the feet and ankles after a brisk walk, and was unable to use his hands for heavy manual work. Neurological complications are rare but of special interest. The commonest is an affection of the brachial plexus or part of the brachial plexus, resulting in a scapulo-humeral paralysis. The patient often complains of neuritic pains in the shoulder regions, and these are followed fairly rapidly by a flaccid paralysis with the usual tenderness and hyper-aesthesia. Recovery usually occurs within six months.)", "Skin redness", "Anaphylactic reaction", "Sweating", "Heated body", "Generalized pruritus", "Urticarial rash", "Irritating cough", "Dyspnoea", "Wheeziness", "Choking sensation", "Substernal oppression", "Feeling of constriction in the chest", "Retching", "Vomiting with cramp-like pains in the abdomen", "Diarrhoea", "Severe abdominal distension", "Headache", "Giddiness", "Sudden unconsciousness", "Convulsions", "Acute circulatory collapse", "Death", "Pulse becomes rapid, weak, and thready, and there is a marked fall in blood pressure", "Serum sickness", "Fever", "Skin eruptions", "Angioneurotic oedema", "Morbilliform type of rash", "Scarlatiniform type of rash", "Urticarial weals", "Albumin or possibly blood in the urine", "Glandular enlargement", "Arthritis", "Difficulty in swallowing", "Feeling of a heavy lump behind the sternum", "Cramp-like abdominal pains, with or without diarrhoea or vomiting or both", "Stiffness of the joints", "Pain and swelling of the feet and ankles", "Neurological complications", "Affection of the brachial plexus or part of the brachial plexus", "Scapulo-humeral paralysis", "Neuritic pains in the shoulder regions", "Flaccid paralysis with the usual tenderness and hyper-aesthesia"))


# source title
source_title <- c(rep("5.3.6 Cumulative Analysis of Post-Authorization Adverse Event Reports of PF-07302048 (BNT162B2) Received Through 28-Feb-2021 Report", length(jab_adverse_reactions12)), rep("Neuritis and Multiple Neuritis Following Serum Therapy", length(wilson_article)), rep("US Food and Drug Administration (FDA): Vaccines and Related Biological Products Advisory Committee October 22, 2020 Meeting Presentation", length(anderson_presentation)), rep("Serum Shock and Serum Reaction", length(iyengar_article)), rep("Serum Sickness-like Reactions", length(yerushalmi_article)), rep("Serum and Anaphylactic Reactions", length(williams_article)))

# source author
source_author <- c(rep("Worldwide Safety Pfizer", length(jab_adverse_reactions12)), rep("George Wilson, M.D. and Samuel B. Hadden, M.D.", length(wilson_article)), rep("Steve Anderson, PhD, MPP", length(anderson_presentation)), rep("K. G. Iyengar", length(iyengar_article)), rep("Joseph Yerushalmi, MD; Alex Zvulunov, MD; and Sima Halevy, MD", length(yerushalmi_article)), rep("D. A. Williams, M.D., M.Sc., F.R.C.P.", length(williams_article)))

# source date
source_date <- c(rep("30-Apr-2021", length(jab_adverse_reactions12)), rep("January 9, 1932", length(wilson_article)), rep("October 22, 2020", length(anderson_presentation)), rep("May 1943", length(iyengar_article)), rep("May 2002", length(yerushalmi_article)), rep("June 18, 1955", length(williams_article)))

# source additional information
source_add_info <- c(rep("pages 30-38; Document was released as part of a Freedom of Information Act (FOIA) lawsuit against the United States Food and Drug Administration (FDA) filed by the Public Health and Medical Professionals for Transparency non-profit organization", length(jab_adverse_reactions12)), rep("'JAMA'. 1932; 98(2), pages 123-125", length(wilson_article)), rep("page 17; Document was Recovered with the Internet Archive: Wayback Machine", length(anderson_presentation)), rep("'The Indian Medical Gazette', May, 1943, pages 249-250", length(iyengar_article)), rep("'Cutis', Volume 69, May 2002, pages 395-397", length(yerushalmi_article)), rep("'British Medical Journal: Emergencies in General Practice', 1952, 1, 4928, 1469-1471", length(williams_article)))

# source URL
source_url <- c(rep("https://phmpt.org/wp-content/uploads/2021/11/5.3.6-postmarketing-experience.pdf", length(jab_adverse_reactions12)), rep("https://jamanetwork.com/journals/jama/article-abstract/1153665", length(wilson_article)), rep("https://web.archive.org/web/20201126033341/https://www.fda.gov/media/143557/download", length(anderson_presentation)), rep("https://web.archive.org/web/20200207182423/http://europepmc.org/backend/ptpmcrender.fcgi?accid=PMC5158424&blobtype=pdf", length(iyengar_article)), rep("https://web.archive.org/web/20200321001112/http://www.gums.ac.ir/Upload/Modules/Contents/asset68/069050395.pdf", length(yerushalmi_article)), rep("https://www.bmj.com/content/1/4928/1469 and https://web.archive.org/web/20200209180050/http://europepmc.org/backend/ptpmcrender.fcgi?accid=PMC2062273&blobtype=pdf", length(williams_article)))



# create a data.table merging the 3 data sets and the additional identifying information
jab_adverse_reactions <- data.table(`Possible Vaccine Adverse Events` = c(jab_adverse_reactions12, wilson_article, anderson_presentation_for_R, iyengar_article, yerushalmi_article, williams_article), `Source Title` = source_title, `Source Author` = source_author, `Source Date` = source_date, `Source Additional Information` = source_add_info, `Source URL` = source_url)

# create a data.table merging the 3 data sets and the additional identifying information
jab_adverse_reactions_public <- data.table(`Possible Vaccine Adverse Events` = c(jab_adverse_reactions12, wilson_article, anderson_presentation, iyengar_article, yerushalmi_article, williams_article), `Source Title` = source_title, `Source Author` = source_author, `Source Date` = source_date, `Source Additional Information` = source_add_info, `Source URL` = source_url)

# format the dates
# choose the column name
column_choosing <- "Source Date"

for (col in column_choosing)
set(jab_adverse_reactions, j = col, value =  anydate(jab_adverse_reactions[[col]]))


for (col in column_choosing)
set(jab_adverse_reactions_public, j = col, value =  anydate(jab_adverse_reactions_public[[col]]))


# create a XML document from the data.table & write it to file
jab_adverse_reactions_xml <- df_to_xml(jab_adverse_reactions_public, xml.file = "./inst/public/jab_adverse_reactions.xml")

# create a JSON document from the data.table
jab_adverse_reactions_json <- toJSON(jab_adverse_reactions_public)

# write the JSON document to file
write_json(jab_adverse_reactions_json, path = "./inst/public/jab_adverse_reactions.json")

# write the table as a CSV (for access for non-R users)
fwrite(jab_adverse_reactions_public, file = "./inst/public/jab_adverse_reactions.csv")

# save as a .RData file
save(jab_adverse_reactions, file = "./data/jab_adverse_reactions.RData")




# read in the References stored in a JabRef database
bib <- readBib("./inst/references/Data_References.bib")

# create the cff object
jab_adverse_reactions_citation <- cff_create()

# convert the bibentry object to a cff object (for a proper citation)
bib_to_cff <- cff_parse_citation(bib)

# produce the reference keys from the bibentry object
refkeys <- list(references = bib_to_cff)

# Write the package citation as a .cff file
cff_write(jab_adverse_reactions_citation, keys = refkeys)

# Write the package citation
toBibtex(cff_to_bibtex("CITATION.cff"))




# Sources

# Source 1
# https://www.charlesbordet.com/en/extract-pdf/ | How to Extract and Clean Data From PDF Files in R By Charles Bordet

# Source 2
# https://stackoverflow.com/questions/25707647/merge-multiple-spaces-to-single-space-remove-trailing-leading-spaces | r - Merge Multiple spaces to single space; remove trailing/leading spaces - Stack Overflow, answered By Tyler Rinker on Sep 29 2014

# Source 3
# https://stackoverflow.com/questions/2098368/concatenate-a-vector-of-strings-character | r - Concatenate a vector of strings/character - Stack Overflow, answered By LMc on Oct 22 2021 and edited By LMc on Dec 1 2021




# References

# Reference 1
# Worldwide Safety Pfizer, 5.3.6 Cumulative Analysis of Post-Authorization Adverse Event Reports of PF-07302048 (BNT162B2) Received Through 28-Feb-2021 Report, pages 30-38. https://phmpt.org/wp-content/uploads/2021/11/5.3.6-postmarketing-experience.pdf

# Reference 2
# George Wilson, M.D. and Samuel B. Hadden, M.D., "Neuritis and Multiple Neuritis Following Serum Therapy", *JAMA*. 1932;98(2):123-125, January 9, 1932. https://jamanetwork.com/journals/jama/article-abstract/1153665. Also archived at https://archive.vn/Nw4nq.

# Reference 3
# Steve Anderson, PhD, MPP, US Food and Drug Administration (FDA): Vaccines and Related Biological Products Advisory Committee October 22, 2020 Meeting Presentation, page 17. https://www.fda.gov/media/143557/download {Please Note: The document is no longer available from the original URL, but it is archived at Recovered with the Internet Archive: Wayback Machine [Recovered with the Internet Archive: Wayback Machine]}

# Reference 4
# K. G. Iyengar, "Serum Shock and Serum Reaction", *The Indian Medical Gazette*, May, 1943, pages 249-250, https://web.archive.org/web/20200207182423/http://europepmc.org/backend/ptpmcrender.fcgi?accid=PMC5158424&blobtype=pdf

# Reference 5
# Joseph Yerushalmi, MD; Alex Zvulunov, MD; and Sima Halevy, MD, "Serum Sickness-like Reactions", *Cutis*, Volume 69, May 2002, pages 395-397, https://web.archive.org/web/20200321001112/http://www.gums.ac.ir/Upload/Modules/Contents/asset68/069050395.pdf

# Reference 6
# D. A. Williams, M.D., M.Sc., F.R.C.P., "Serum and Anaphylactic Reactions", *British Medical Journal: Emergencies in General Practice*, 1952, 1, 4928, 1469-1471, https://www.bmj.com/content/1/4928/1469 and https://web.archive.org/web/20200209180050/http://europepmc.org/backend/ptpmcrender.fcgi?accid=PMC2062273&blobtype=pdf
