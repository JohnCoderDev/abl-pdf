class classes.PDF.Components.CharacterSet.Sets.WhiteSpaceCharacters:
    def public static property NUL as int init 0x00 no-undo get. // NULL character
    def public static property HT  as int init 0x09 no-undo get. // HORIZONTAL TAB character
    def public static property LF  as int init 0x0a no-undo get. // LINE FEED character
    def public static property FF  as int init 0x0c no-undo get. // FORM FEED character
    def public static property CR  as int init 0x0d no-undo get. // CARRIAGE RETURN character
    def public static property SP  as int init 0x20 no-undo get. // SPACE character
    
    def public static property EOL as int no-undo get: return CR + (0xff + 1) * LF. end.
end class.
