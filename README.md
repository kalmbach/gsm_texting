# gsm_texting

GSM-7 is a character encoding standard which packs the most commonly used 
letters and symbols in many languages into 7 bits each for usage on GSM networks.  
As SMS messages are transmitted 140 8-bit octets at a time, GSM-7 encoded SMS 
messages can carry up to 160 characters.

Unfortunately, GSM-7 is not a supported character encoding in many text editors. 
Even setting encoding to ASCII (or US_ASCII, or UTF-8) will not guarantee that 
text you write will be limited to GSM-7.

If you are writing in an editor with Unicode support you'll need to be particularly
careful. Text editors designed for writing might automatically add angled smart 
quotes, non-standard spaces, or punctuation which looks similar to GSM-7 but is a 
different Unicode character.

When messages include 1 or more non-GSM characters they will be limited to 70 
characters as Unicode chars require 16 bits each.

This lib will transliterate your text to GSM-7 compatible chars so you can send
as much characters as possible into a single SMS segment.

Resources:
https://en.wikipedia.org/wiki/GSM_03.38
https://www.twilio.com/docs/glossary/what-is-gsm-7-character-encoding
https://www.twilio.com/docs/sms/services/smart-encoding-char-list
