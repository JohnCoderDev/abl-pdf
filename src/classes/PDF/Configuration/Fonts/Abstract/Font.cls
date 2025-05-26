block-level on error undo, throw.
using classes.PDF.Components.* from propath.
using classes.PDF.Types.* from propath.

class classes.PDF.Configuration.Fonts.Abstract.Font abstract:
    def public abstract property name as char no-undo get. set.
    def public property type as char init 'Font' no-undo get. set.
    def public property subtype as char init 'Type1' no-undo get. set.
    def public abstract property baseFont as char no-undo get. set.
    
    method public IndirectObject toIndirectObject():
        def var resultObject as IndirectObject no-undo.
        def var auxiliaryDict as DictionaryType no-undo.
        assign 
            auxiliaryDict = new DictionaryType()
            resultObject = new IndirectObject().
        
        auxiliaryDict:add('Type', new NameType(this-object:type)).
        auxiliaryDict:add('Subtype', new NameType(this-object:subtype)).
        auxiliaryDict:add('BaseFont', new NameType(this-object:baseFont)).
        resultObject:add(auxiliaryDict).
        return resultObject.
    end method.
end class.
