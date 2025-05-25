block-level on error undo, throw.
using classes.PDF.Components.CharacterSets.* from propath.
using classes.PDF.Shared.Hex.* from propath.

class classes.PDF.Types.StringType:
    def public property string as longchar no-undo get. protected set.
    def public property fromPointer as log no-undo get. protected set.
    
    def public static property literalEscapeChars as char no-undo 
        get:
            return   chr(DelimiterCharacters:LP) + chr(DelimiterCharacters:RP)
                   + chr(DelimiterCharacters:RSOLIDUS).
        end.

    constructor StringType(pString as longchar):
        assign 
            string = pString
            fromPointer = false.
    end constructor.
    
    constructor StringType(pPointer as memptr):
        assign 
            string = get-string(pPointer, 1, get-size(pPointer))
            fromPointer = true.
    end constructor.
    
    method public longchar toLiteralString():
        def var i as int no-undo.
        def var currentChar as char no-undo.
        def var resultString as longchar no-undo.
        
        assign resultString = string.
        
        do i = 1 to length(literalEscapeChars):
            assign
                currentChar = substring(literalEscapeChars, i, 1)
                resultString = replace(resultString, currentChar, chr(DelimiterCharacters:RSOLIDUS) + currentChar).
        end.
        
        return substitute('&1&2&3', DelimiterCharacters:LP, resultString, DelimiterCharacters:RP).    
    end method.
    
    method public longchar toHexString():
        def var i as int no-undo.
        def var currentChar as char no-undo.
        def var hexedString as longchar no-undo.
        assign hexedString = HexString:getHexString(string).
        return substitute('&1&2&3', DelimiterCharacters:LTS, hexedString, DelimiterCharacters:GTS).    
    end method.
end class.
