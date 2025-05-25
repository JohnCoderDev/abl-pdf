block-level on error undo, throw.
using Progress.Lang.* from propath.
using classes.PDF.Types.* from propath.
using classes.PDF.Components.CharacterSets.* from propath.

class classes.PDF.Types.ArrayType:
    def temp-table entries
        field entryObject as object
        field objectType as char.
        
    method public void add(pObject as StringType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.objectType = 'string'.    
    end method.
    
    method public void add(pObject as NumberType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.objectType = 'number'.    
    end method.
    
    method public void add(pObject as NameType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.objectType = 'name'.    
    end method.
    
    method public void add(pObject as ArrayType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.objectType = 'array'.    
    end method.
    
    method public void add(pObject as BooleanType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.objectType = 'boolean'.
    end method.        
    
    method public longchar toArray():
        def var stringObject as StringType no-undo.
        def var numberObject as NumberType no-undo.
        def var nameObject as NameType no-undo.
        def var arrayObject as ArrayType no-undo.
        def var booleanObject as BooleanType no-undo.
        def var dictionaryObject as DictionaryType no-undo.
        
        def var resultArray as longchar no-undo.
        
        for each entries no-lock:
            case entries.objectType:
                when 'string' then do:
                    assign stringObject = cast(entries.entryObject, StringType).
                    if stringObject:fromPointer then do:
                        assign resultArray = substitute('&1&2 ', resultArray, stringObject:toHexString()).
                    end.
                    else do:
                        assign resultArray = substitute('&1&2 ', resultArray, stringObject:toLiteralString()).
                    end.    
                end.
                
                when 'number' then do:
                    assign numberObject = cast(entries.entryObject, NumberType).
                    if numberObject:isReal() then do:
                        assign resultArray = substitute('&1&2 ', resultArray, numberObject:toReal()).
                    end.
                    else do:
                        assign resultArray = substitute('&1&2 ', resultArray, numberObject:toInteger()).
                    end.    
                end.
                
                when 'name' then do:
                    assign 
                        nameObject = cast(entries.entryObject, NameType)
                        resultArray = substitute('&1&2 ', resultArray, nameObject:toName()).
                end.
                
                when 'array' then do:
                    assign 
                        arrayObject = cast(entries.entryObject, ArrayType)
                        resultArray = substitute('&1&2 ', resultArray, arrayObject:toArray()).
                end.
                
                when 'boolean' then do:
                    assign 
                        booleanObject = cast(entries.entryObject, BooleanType)
                        resultArray = substitute('&1&2 ', resultArray, booleanObject:toBoolean()).
                end.
                
                when 'dictionary' then do:
                    assign 
                        dictionaryObject = cast(entries.entryObject, DictionaryType)
                        resultArray = substitute('&1&2 ', resultArray, dictionaryObject:toDictionary()).
                end.
            end case.
        end.
        if length(resultArray) > 0 then do:
            assign resultArray = substring(resultArray, 1, length(resultArray) - 1).
        end.
        return substitute('&1&2&3', DelimiterCharacters:LSB, resultArray, DelimiterCharacters:RSB).
    end method.
end class.
