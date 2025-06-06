block-level on error undo, throw.
using Progress.Lang.* from propath.
using classes.PDF.Types.* from propath.
using classes.PDF.Components.* from propath.
using classes.PDF.Components.CharacterSets.* from propath.

class classes.PDF.Types.DictionaryType:
    def public static property leftOpen as char no-undo
        get:
            return chr(DelimiterCharacters:LTS) + chr(DelimiterCharacters:LTS).
        end.
        
    def public static property rightClose as char no-undo
        get:
            return chr(DelimiterCharacters:GTS) + chr(DelimiterCharacters:GTS).
        end.
        
    def temp-table entries
        field nameString as char
        field entryValue as object
        field valueType as char.
    
    method public void add(pKey as char, pNumber as int64):
        this-object:add(pKey, new NumberType(pNumber)).
    end method.
    
    method public void add(pKey as char, pNumber as dec):
        this-object:add(pKey, new NumberType(pNumber)).
    end method.
    
    method public void add(pKey as char, pLogical as log):
        this-object:add(pKey, new BooleanType(pLogical)).
    end method.
    
    method public void add(pKey as NameType, pNumber as int64):
        this-object:add(pKey, new NumberType(pNumber)).
    end method.
    
    method public void add(pKey as NameType, pNumber as dec):
        this-object:add(pKey, new NumberType(pNumber)).
    end method.
    
    method public void add(pKey as NameType, pLogical as log):
        this-object:add(pKey, new BooleanType(pLogical)).
    end method.
    
    method public void add(pKey as char, pObject as NameType):
        this-object:add(new NameType(pKey), pObject).
    end method.
    
    method public void add(pKey as char, pObject as NumberType):
        this-object:add(new NameType(pKey), pObject).
    end method.
    
    method public void add(pKey as char, pObject as BooleanType):
        this-object:add(new NameType(pKey), pObject).
    end method.
    
    method public void add(pKey as char, pObject as ArrayType):
        this-object:add(new NameType(pKey), pObject).
    end method.
    
    method public void add(pKey as char, pObject as StringType):
        this-object:add(new NameType(pKey), pObject).
    end method.
    
    method public void add(pKey as char, pObject as DictionaryType):
        this-object:add(new NameType(pKey), pObject).
    end method.
    
    method public void add(pKey as char, pObject as StreamType):
        this-object:add(new NameType(pKey), pObject).
    end method.
    
    method public void add(pKey as char, pObject as NullObjectType):
        this-object:add(new NameType(pKey), pObject).
    end method.
    
    method public void add(pKey as char, pObject as IndirectObject):
        this-object:add(new NameType(pKey), pObject).
    end method.
    
    method public void add(pKey as NameType, pObject as NameType):
        if not positionKey(pKey) then 
            create entries.
        assign
            entries.entryValue = pObject
            entries.nameString = pKey:toName()
            entries.valueType = 'name'.
    end method.
    
    method public void add(pKey as NameType, pObject as NumberType):
        if not positionKey(pKey) then 
            create entries.
        assign
            entries.entryValue = pObject
            entries.nameString = pKey:toName()
            entries.valueType = 'number'.
    end method.
    
    method public void add(pKey as NameType, pObject as StringType):
        if not positionKey(pKey) then 
            create entries.
        assign
            entries.entryValue = pObject
            entries.nameString = pKey:toName()
            entries.valueType = 'string'.
    end method.
    
    method public void add(pKey as NameType, pObject as BooleanType):
        if not positionKey(pKey) then 
            create entries.
        assign
            entries.entryValue = pObject
            entries.nameString = pKey:toName()
            entries.valueType = 'boolean'.
    end method.
    
    method public void add(pKey as NameType, pObject as DictionaryType):
        if not positionKey(pKey) then 
            create entries.
        assign
            entries.entryValue = pObject
            entries.nameString = pKey:toName()
            entries.valueType = 'dictionary'.
    end method.
    
    method public void add(pKey as NameType, pObject as ArrayType):
        if not positionKey(pKey) then 
            create entries.
        assign
            
            entries.entryValue = pObject
            entries.nameString = pKey:toName()
            entries.valueType = 'array'.
    end method.
    
    method public void add(pKey as NameType, pObject as StreamType):
        if not positionKey(pKey) then 
            create entries.
        assign
            entries.entryValue = pObject
            entries.nameString = pKey:toName()
            entries.valueType = 'stream'.
    end method.
    
    method public void add(pKey as NameType, pObject as NullObjectType):
        if not positionKey(pKey) then 
            create entries.
        assign
            entries.entryValue = pObject
            entries.nameString = pKey:toName()
            entries.valueType = 'null'.
    end method.
    
    method public void add(pKey as NameType, pObject as IndirectObject):
        if not positionKey(pKey) then 
            create entries.
        assign
            entries.entryValue = pObject
            entries.nameString = pKey:toName()
            entries.valueType = 'indirect'.
    end method.
    
    method public object get(pKey as char):
        if positionKey(pKey) then do:
            return entries.entryValue.
        end.
    end method.
    
    method public object get(pKey as NameType):
        if positionKey(pKey) then do:
            return entries.entryValue.
        end.
    end method.
    
    method public longchar toDictionary():
        def var stringObject as StringType no-undo.
        def var numberObject as NumberType no-undo.
        def var nameObject as NameType no-undo.
        def var arrayObject as ArrayType no-undo.
        def var booleanObject as BooleanType no-undo.
        def var dictionaryObject as DictionaryType no-undo.
        def var streamObject as StreamType no-undo.
        def var nullObject as NullObjectType no-undo.
        def var indirectObject as IndirectObject no-undo.
        def var resultDictionary as longchar no-undo.
        
        for each entries no-lock:
            case entries.valueType:
                when 'string' then do:
                    assign stringObject = cast(entries.entryValue, StringType).
                    if stringObject:fromPointer then do:
                        assign resultDictionary = substitute('&1&2 &3 ', resultDictionary, entries.nameString, stringObject:toHexString()).
                    end.
                    else do:
                        assign resultDictionary = substitute('&1&2 &3 ', resultDictionary, entries.nameString, stringObject:toLiteralString()).
                    end.    
                end.
                
                when 'number' then do:
                    assign numberObject = cast(entries.entryValue, NumberType).
                    if numberObject:isReal() then do:
                        assign resultDictionary = substitute('&1&2 &3 ', resultDictionary, entries.nameString, numberObject:toReal()).
                    end.
                    else do:
                        assign resultDictionary = substitute('&1&2 &3 ', resultDictionary, entries.nameString, numberObject:toInteger()).
                    end.    
                end.
                
                when 'name' then do:
                    assign 
                        nameObject = cast(entries.entryValue, NameType)
                        resultDictionary = substitute('&1&2 &3 ', resultDictionary, entries.nameString, nameObject:toName()).
                end.
                
                when 'array' then do:
                    assign 
                        arrayObject = cast(entries.entryValue, ArrayType)
                        resultDictionary = substitute('&1&2 &3 ', resultDictionary, entries.nameString, arrayObject:toArray()).
                end.
                
                when 'boolean' then do:
                    assign 
                        booleanObject = cast(entries.entryValue, BooleanType)
                        resultDictionary = substitute('&1&2 &3 ', resultDictionary, entries.nameString, booleanObject:toBoolean()).
                end.
                
                when 'dictionary' then do:
                    assign 
                        dictionaryObject = cast(entries.entryValue, DictionaryType)
                        resultDictionary = substitute('&1&2 &3 ', resultDictionary, entries.nameString, dictionaryObject:toDictionary()).
                end.
                
                when 'stream' then do:
                    assign 
                        streamObject = cast(entries.entryValue, StreamType)
                        resultDictionary = substitute('&1&2 &3 ', resultDictionary, entries.nameString, streamObject:toStream()).
                end.
                
                when 'null' then do:
                    assign 
                        nullObject = cast(entries.entryValue, NullObjectType)
                        resultDictionary = substitute('&1&2 &3 ', resultDictionary, entries.nameString, nullObject:toNull()).
                end.
                
                when 'indirect' then do:
                    assign 
                        indirectObject = cast(entries.entryValue, IndirectObject)
                        resultDictionary = substitute('&1&2 &3 ', resultDictionary, entries.nameString, indirectObject:getReference()).
                end.
            end case.
        end.
        
        if length(resultDictionary) > 0 then do:
            assign resultDictionary = substring(resultDictionary, 1, length(resultDictionary) - 1).
        end.    
        return substitute('&1&2&3', leftOpen, resultDictionary, rightClose).
    end method.
    
    method protected log positionKey(pKey as char):
        return positionKey(new NameType(pKey)).
    end method.
    
    method protected log positionKey(pKey as NameType):
        def var nameString as char no-undo.
        assign nameString = pKey:toName().
        find first entries
            where entries.nameString = nameString
            no-error.
        return avail entries.    
    end method.
end class.
