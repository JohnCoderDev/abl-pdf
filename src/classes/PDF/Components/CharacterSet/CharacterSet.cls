block-level on error undo, throw.
using classes.PDF.Components.CharacterSet.Sets.* from propath.

class classes.PDF.Components.CharacterSet.CharacterSet:
    def public static property whiteSpace as WhiteSpaceCharacters no-undo get.
    def public static property delimiter  as DelimiterCharacters  no-undo get.
end class.
