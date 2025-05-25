block-level on error undo, throw.
using Progress.Lang.* from propath.
using classes.PDF.Types.* from propath. 

class classes.PDF.Components.IndirectObject:
    def public property id as int64 no-undo get. set.
    def public property generation as int64 no-undo get. set.
    def public property startObjectIndicator as char init 'obj' no-undo get.
    def public property endObjectIndicator as char init 'endobj' no-undo get.
    
    def temp-table entries
        field entryObject as object
        field entryType as char.
    
    method public void add(pString as longchar):
        this-object:add(new StringType(pString)).
    end method.
    
    method public void add(pNumber as int64):
        this-object:add(new NumberType(pNumber)).
    end method.
    
    method public void add(pNumber as dec):
        this-object:add(new NumberType(pNumber)).
    end method.
    
    method public void add(pLog as log):
        this-object:add(new BooleanType(pLog)).
    end method.
    
    method public void add(pObject as StringType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.entryType = 'string'.
    end method.
    
    method public void add(pObject as NumberType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.entryType = 'number'.
    end method.
    
    method public void add(pObject as BooleanType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.entryType = 'boolean'.
    end method.
    
    method public void add(pObject as ArrayType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.entryType = 'array'.
    end method.
    
    method public void add(pObject as NullObjectType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.entryType = 'null'.
    end method.
    
    method public void add(pObject as DictionaryType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.entryType = 'dictionary'.
    end method.
    
    method public void add(pObject as StreamType):
        create entries.
        assign
            entries.entryObject = pObject
            entries.entryType = 'stream'.
    end method.
    
    method public longchar toIndirectObject():
        def var stringObject as StringType no-undo.
        def var numberObject as NumberType no-undo.
        def var nameObject as NameType no-undo.
        def var arrayObject as ArrayType no-undo.
        def var booleanObject as BooleanType no-undo.
        def var dictionaryObject as DictionaryType no-undo.
        def var nullObject as NullObjectType no-undo.
        def var streamObject as StreamType no-undo.
        
        def var resultObject as longchar no-undo.
        
        for each entries no-lock:
            case entries.entryType:
                when 'string' then do:
                    assign stringObject = cast(entries.entryObject, StringType).
                    if stringObject:fromPointer then do:
                        assign resultObject = substitute('&1&2', resultObject, stringObject:toHexString()).
                    end.
                    else do:
                        assign resultObject = substitute('&1&2', resultObject, stringObject:toLiteralString()).
                    end.    
                end.
                
                when 'number' then do:
                    assign numberObject = cast(entries.entryObject, NumberType).
                    if numberObject:isReal() then do:
                        assign resultObject = substitute('&1&2', resultObject, numberObject:toReal()).
                    end.
                    else do:
                        assign resultObject = substitute('&1&2', resultObject, numberObject:toInteger()).
                    end.    
                end.
                
                when 'name' then do:
                    assign 
                        nameObject = cast(entries.entryObject, NameType)
                        resultObject = substitute('&1&2', resultObject, nameObject:toName()).
                end.
                
                when 'array' then do:
                    assign 
                        arrayObject = cast(entries.entryObject, ArrayType)
                        resultObject = substitute('&1&2', resultObject, arrayObject:toArray()).
                end.
                
                when 'boolean' then do:
                    assign 
                        booleanObject = cast(entries.entryObject, BooleanType)
                        resultObject = substitute('&1&2', resultObject, booleanObject:toBoolean()).
                end.
                
                when 'dictionary' then do:
                    assign 
                        dictionaryObject = cast(entries.entryObject, DictionaryType)
                        resultObject = substitute('&1&2', resultObject, dictionaryObject:toDictionary()).
                end.
                
                when 'stream' then do:
                    assign
                        streamObject = cast(entries.entryObject, StreamType)
                        resultObject = substitute('&1&2', resultObject, streamObject:toStream()).
                end.
                
                when 'null' then do:
                    assign 
                        nullObject = cast(entries.entryObject, NullObjectType)
                        resultObject = substitute('&1&2', resultObject, nullObject:toNull()).
                end.
            end case.
        end.
        
        if length(resultObject) > 0 then do:
            assign resultObject = substring(resultObject, 1, length(resultObject) - 1).
        end.    
        return substitute('&1&2&3', startObjectIndicator, resultObject, endObjectIndicator).
    end method.
    
    method public char getReference():
        return substitute('&1 &2 R', id, generation).
    end method.
end class.
