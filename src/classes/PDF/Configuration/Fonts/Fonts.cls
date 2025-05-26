block-level on error undo, throw.
using Progress.Lang.* from propath.
using classes.PDF.Configuration.* from propath.
using classes.PDF.Configuration.Fonts.* from propath.
using classes.PDF.Configuration.Fonts.Abstract.* from propath.

class classes.PDF.Configuration.Fonts.Fonts:
    def public property configurationInstance as Configuration no-undo get. protected set.
    
    def temp-table fonts
        field id as char
        field fontObject as object.
    
    
    constructor Fonts(pConfiguration as Configuration):
        assign configurationInstance = pConfiguration.
    end constructor.
    
    method public void load(pFontName as char):
    end method.
    
    method public void addFont(pName as char, pObject as Font):
    end method.
    
    method protected log positionFont(pName as char):
    end method.
end class.
