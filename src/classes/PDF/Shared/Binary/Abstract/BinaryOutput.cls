
class classes.PDF.Shared.Binary.Abstract.BinaryOutput abstract:
    method public abstract void putByte(pByte as int).
    method public abstract void putShort(pShort as int).
    method public abstract void putInt(pLong as int64).
    method public abstract void putInt64(pInt as int64).
    method public abstract void putString(pString as longchar).
    method public abstract void putNull().
    method public abstract void appendPointer(pPointer as memptr).
    method public abstract void appendFile(pPath as char).
    
    
    method public abstract void putByte(pByte as int, pPosition as int64).
    method public abstract void putShort(pShort as int, pPosition as int64).
    method public abstract void putInt(pInt as int64, pPosition as int64).
    method public abstract void putInt64(pInt as int64, pPosition as int64).
    method public abstract void putString(pString as longchar, pPosition as int64).
    method public abstract void putNull(pPosition as int64).
    method public abstract void putNull(pCount as int64, pPosition as int64).
    method public abstract void appendPointer(pPointer as memptr, pPosition as int64).
    method public abstract void appendFile(pPath as char, pPosition as int64).
    
    method public abstract memptr getPointer().
end class.
