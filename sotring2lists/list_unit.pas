unit ListMod;

interface

type
  TData = Integer;
  TPElem = ^TElem;
  TElem = record
    Data : TData;
    PNext : TPElem;
    PPrev : TPElem;
  end;
   TList = record
    PFirst : TPElem;
    PLast : TPElem;
  end;

procedure AddLast(var aList : TList; const aPElem : TPElem);
// vstavka v konec
procedure AddFirst(var aList : TList;const  aPElem : TPElem);
// vstavka v nachalo
procedure ListDelete(var aList : TList);
// ochistka spiska
function DelElementByIndex(var aList : TList; var aPElem : TPElem) : boolean ;
// udalenie elementa po ukazatelu
function FindElement(const aList : TList; const aData : TData) : TPElem;
// poisk elementa
procedure InsertByUk(var aList : TList; const aPBase, aPElem : TPElem);
// vstavka po ukazatelu
function GetIndexByUk(const aList : TList; const aI : Integer) : TPElem;
// perenos ukazatelya na nyzhnui index

implementation

procedure AddLast(var aList : TList; const aPElem : TPElem);
begin
  if aPElem = nil then Exit;
  aPElem^.PNext := nil;
  aPElem^.PPrev := nil;
  if aList.PFirst = nil then begin
    aList.PFirst := aPElem;
    aList.PLast := aPElem;
  end
  else begin
    aList.PLast^.PNext := aPElem;
    aPElem^.PPrev := aList.PLast;
    aList.PLast := aPElem;
  end;
end;

procedure AddFirst(var aList : TList;const  aPElem : TPElem);
begin
  if aPElem = nil then Exit;
  aPElem^.PNext := nil;
  aPElem^.PPrev := nil;
  if aList.PFirst = nil then begin
    aList.PFirst := aPElem;
    aList.PLast := aPElem;
  end else begin
    aPElem^.PNext := aList.PFirst;
    aList.PFirst^.PPrev := aPElem;
    aList.PFirst := aPElem;
  end;
end;

procedure ListDelete(var aList : TList);
var
  PNext, PDel : TPElem;
begin
  if aList.PFirst = nil then Exit;
  PNext := aList.PFirst;
  while PNext <> nil do begin
    PDel := PNext;
    PNext := PNext^.PNext;
    Dispose(PDel);
  end;
  aList.PFirst := nil;
  aList.PLast := nil;
end;

function DelElementByIndex(var aList : TList; var aPElem : TPElem) : boolean ;
begin
  Result := False;
  if aPElem = nil then Exit;
  if aPElem = aList.PFirst then begin
    aList.PFirst := aPElem^.PNext;
    if aList.PFirst = nil then
      aList.PLast := nil
    else
      aList.PFirst^.PPrev := nil;
  end else if aPElem = aList.PLast then begin
    aList.PLast := aPElem^.PPrev;
    if aList.PLast = nil then
      aList.PFirst := nil
    else
      aList.PLast^.PNext := nil;
  end else begin
    aPElem^.PPrev^.PNext := aPElem^.PNext;
    aPElem^.PNext^.PPrev := aPElem^.PPrev;
  end;
  Dispose(aPElem);
  aPElem := nil;
  Result := True;
end;

function GetIndexByUk(const aList : TList; const aI : Integer) : TPElem;
var
  i : Integer;
  PNext : TPElem;
begin
  Result := nil;
  i := 1;
  PNext := aList.PFirst;
  while (i <= aI) and (PNext <> nil) do begin
    if i = aI then begin
      Result := PNext;
      Break;
    end;
    Inc(i);
    PNext := PNext^.PNext;
  end;
end;

function FindElement(const aList : TList; const aData : TData) : TPElem;
var
  PNext : TPElem;
begin
  Result := nil;

  PNext := aList.PFirst;
  while PNext <> nil do begin
    if PNext^.Data = aData then begin
      Result := PNext;
      Break;
    end;
    PNext := PNext^.PNext;
  end;
end;

procedure InsertByUk(var aList : TList; const aPBase, aPElem : TPElem);
begin
  if aPElem = nil then Exit;

  if (aList.PFirst = nil) or (aPBase = nil) or (aPBase = aList.PFirst) then begin
    AddF(aList, aPElem);
  end else begin
    aPElem^.PPrev := aPBase^.PPrev;
    aPElem^.PNext := aPBase;
    aPBase^.PPrev := aPElem;
    aPElem^.PPrev^.PNext := aPElem;
  end;
end;

end.
