block-level on error undo, throw.
using classes.PDF.Shared.Binary.Abstract.* from propath.

class classes.PDF.Shared.Binary.Output.Memory inherits BinaryOutput:
    def protected property pointer as memptr no-undo get. protected set.
    def protected property pointerEnd as int64 no-undo get. protected set.
    def protected property initialSize as int64 init 1024 no-undo get. protected set.
    
    constructor Memory():
        reset().
    end constructor.
    
    method public override void putByte(pByte as int):
        this-object:putByte(pByte, pointerEnd + 1).
    end method.
    
    method public override void putShort(pShort as int):
        putShort(pShort, pointerEnd + 1).
    end method.
    
    method public override void putInt(pInt as int64):
        putInt(pInt, pointerEnd + 1).
    end method.
    
    method public override void putInt64(pInt as int64):
        putInt64(pInt, pointerEnd + 1).
    end method.
    
    method public override void putString(pString as longchar):
        putString(pString, pointerEnd + 1).
    end method.
    
    method public override void putNull():
        putNull(pointerEnd + 1).
    end method.
    
    method public override void putByte(pByte as int, pPosition as int64):
        allocatePointer(pPosition, 1).
        put-byte(pointer, pPosition) = pByte.
        updatePointerEnd(pPosition, 1).
    end method.
    
    method public override void putShort(pShort as int, pPosition as int64):
        allocatePointer(pPosition, 2).
        put-short(pointer, pPosition) = pShort.
        updatePointerEnd(pPosition, 2).
    end method.
    
    method public override void putInt(pInt as int64, pPosition as int64):
        allocatePointer(pPosition, 4).
        put-long(pointer, pPosition) = pInt.
        updatePointerEnd(pPosition, 4).
    end method.
    
    method public override void putInt64(pInt as int64, pPosition as int64):
        allocatePointer(pPosition, 8).
        put-int64(pointer, pPosition) = pInt.
        updatePointerEnd(pPosition, 8).
    end method.
    
    method public override void putString(pString as longchar, pPosition as int64):
        def var stringLength as int64 no-undo.
        assign stringLength = length(pString).
        allocatePointer(pPosition, stringLength).
        put-string(pointer, pPosition, stringLength) = pString.
        updatePointerEnd(pPosition, stringLength).
    end method.
    
    method public override void putNull(pPosition as int64):
        this-object:putByte(0, pPosition).
    end method.
    
    method public override void putNull(pCount as int64, pPosition as int64):
        def var i as int64 no-undo.
        do i = 1 to pCount:
            putNull(pPosition +  i - 1).
        end.
    end method.
    
    method public override void appendFile(pPath as char).
        appendFile(pPath, pointerEnd + 1).
    end method.
    
    method public override void appendFile(pPath as char, pPosition as int64):
        def var filePointer as memptr no-undo.
        copy-lob from file pPath to filePointer.
        appendPointer(filePointer, pPosition).
    end method.
    
    method public override void appendPointer(pPointer as memptr):
        appendPointer(pPointer, pointerEnd + 1).
    end method.
    
    method public override void appendPointer(pPointer as memptr, pPosition as int64):
        def var i as int64 no-undo.
        def var pointerSize as int64 no-undo.
        assign pointerSize = get-size(pPointer).
        allocatePointer(pPosition, pointerSize).
        do i = 1 to pointerSize:
            put-byte(pointer, pPosition + i - 1) = get-byte(pPointer, i).
        end.
        updatePointerEnd(pPosition, pointerSize).
    end method.
    
    method protected void updatePointerEnd(pStart as int64, pSize as int64).
        if pStart > pointerEnd then do:
            assign pointerEnd = pStart.
        end.
        assign pointerEnd = pointerEnd + pSize.
    end method.
    
    method protected void allocatePointer(pStart as int64, pSize as int64).
        if pStart + pSize > get-size(pointer) then do:
            def var newPointer as memptr no-undo.
            def var newSize as int64 no-undo.
            def var i as int no-undo.
            
            assign newSize = get-size(pointer) * 2.
            do while newSize < get-size(pointer):
                newSize = newSize * 2.
            end.
            
            assign set-size(newPointer) = newSize.
            
            do i = 1 to get-size(pointer):
                put-byte(newPointer, i) = get-byte(pointer, i).
            end.
            assign pointer = newPointer.
        end.
    end method.
    
    method public void reset():
        assign
            set-size(pointer) = 0
            set-size(pointer) = initialSize.    
    end method.
    
    method public memptr getPointer():
        def var resultPointer as memptr no-undo.
        def var i as int64 no-undo.
        assign set-size(resultPointer) = pointerEnd.
        do i = 1 to pointerEnd:
            put-byte(resultPointer, i) = get-byte(pointer, i).
        end.
        return resultPointer.
    end method.
    
    destructor Memory():
        assign set-size(pointer) = 0.
    end destructor.
end class.
