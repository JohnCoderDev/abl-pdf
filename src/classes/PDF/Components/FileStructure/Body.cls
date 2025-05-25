block-level on error undo, throw.
using Progress.Lang.* from propath.
using classes.PDF.Components.* from propath.

class classes.PDF.Components.FileStructure.Body:
    def public property fileStructureInstance as FileStructure no-undo get. protected set.
    def public property lastId as int64 init 1 no-undo get. protected set.
    def public property currentGeneration as int64 no-undo get. protected set.
    
    def temp-table indirectObjects
        field id as int64
        field generation as int64
        field indirectObject as object
        index idx-id as primary unique id generation.
    
    constructor Body(pFileStructure as FileStructure):
        assign fileStructureInstance = pFileStructure.
    end constructor.
    
    method public void add(pObject as IndirectObject):
        do while positionObject(lastId, currentGeneration):
            for last indirectObjects no-lock:
                assign lastId = indirectObjects.id + 1.
            end.    
        end.
        create indirectObjects.
        assign
            pObject:id = lastId
            pObject:generation = currentGeneration
            indirectObjects.id = lastId
            indirectObjects.generation = currentGeneration
            indirectObjects.indirectObject = pObject.
    end method.
    
    method public void set(pObject as IndirectObject, pId as int64, pGeneration as int64):
        if not positionObject(pId, pGeneration) then do:
            create indirectObjects.
        end.
        assign
            pObject:id = pId
            pObject:generation = pGeneration
            indirectObjects.id = pId
            indirectObjects.generation = pGeneration
            indirectObjects.indirectObject = pObject.
    end method.
    
    method protected log positionObject(pId as int64, pGeneration as int64):
        find first indirectObjects 
            where indirectObjects.id = pId and indirectObjects.generation = pGeneration
            no-error.
        return avail indirectObjects.    
    end method.
    
    method public void writeBody():
        fileStructureInstance:PDFInstance:writer:output:putString(getBody()).
    end method.
    
    method public longchar getBody():
        def var resultBody as longchar no-undo.
        def var currentObject as IndirectObject no-undo.
        
        for each indirectObjects no-lock:
            assign 
                currentObject = cast(indirectObjects.indirectObject, IndirectObject)
                resultBody = substitute('&1&2', resultBody, currentObject:toIndirectObject()).
        end.    
        return resultBody.
    end method.
end class.
