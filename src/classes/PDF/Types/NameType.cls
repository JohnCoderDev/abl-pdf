block-level on error undo, throw.
using classes.PDF.Components.CharacterSets.* from propath.
using classes.PDF.Shared.Hex.* from propath.

class classes.PDF.Types.NameType:
    def public property name as char no-undo get. protected set.
    
    constructor NameType(pName as char):
        assign name = pName.
    end method.
    
    method public char toName():
        def var resultName as char no-undo.
        def var currentChar as char no-undo.
        def var i as int no-undo.
        
        do i = 1 to length(name):
            assign currentChar = substring(name, i, 1).
            if isNull(currentChar) then next.
            if not isInsideRange(currentChar) then do:
               assign currentChar = substitute('#&1', HexString:getHexChar(currentChar)).
            end.
            assign resultName = resultName + currentChar.
        end.
        return substitute('&1&2', DelimiterCharacters:SOLIDUS, resultName).
    end method.
    
    method protected log isNull(pChar as char):
        return asc(pChar) = 0x00.
    end method.
    
    method protected log isInsideRange(pChar as char):
        def var asciiNumber as int no-undo.
        assign asciiNumber = asc(pChar).
        return asciiNumber >= 0x21 and asciiNumber <= 0x7e.
    end method.
end class.
