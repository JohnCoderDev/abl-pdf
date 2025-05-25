block-level on error undo, throw.
using classes.PDF.Components.* from propath.
using classes.PDF.Components.CharacterSets.* from propath.

class classes.PDF.Components.FileStructure.Trailer:
    def public property fileStructureInstance as FileStructure no-undo get. protected set.
    
    constructor Trailer(pFileStructure as FileStructure):
        assign fileStructureInstance = pFileStructure.
    end constructor.
    
    method public void writeTrailer():
    end method.
end class.
