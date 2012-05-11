program twolists;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ListMod;

var InputFile1, InputFile2, OutputFile : textfile;
    List1, List2, List3 : TList;
    q : TPElem;
    St : string;

Function SumOfAllElements(a : TList) : integer;
// sum of all elements of lists
var PEl : TPElem;
begin
  result:=0;
  PEl:=a.PLast;
  while PEl<>nil do begin
    result:=result+1;
    PEl:=PEl^.PPrev;
  end;
end;

Function CombineTwoLists(q1,q2 : TList) : TList;
// combine 2 lists
begin
  if (q1.PFirst=nil) and (q2.PFirst=nil) then exit;
  if q1.PFirst=nil then result:=q2 else
  if q2.PFirst=nil then result:=q1 else begin
    q1.PLast^.PNext:=q2.PFirst;
    q2.PFirst^.PPrev:=q1.PLast;
    Result.PFirst:=q1.PFirst;
    Result.PLast:=q2.PLast;
  end;
end;

procedure SortingByShell (var a: TList);
// shell sorting using list
var i,j,k,step : Integer;
    N   : Integer;
    tmp : TData;
begin
  N:=SumOfAllElements(a);
  step:=N div 2;
  while step>=1 do begin
    k:=step;
    for i:=k+1 to N do begin
      tmp:=GetIndexByUk(a, i)^.Data; j:=i-k;
       while (j>0) and (tmp<GetIndexByUk(a, j)^.Data) do begin
         GetIndexByUk(a, j+k)^.Data:=GetIndexByUk(a, j)^.Data; j:=j-k
       end;
       GetIndexByUk(a, j+k)^.Data:=tmp
     end;
     step:=3*step div 5;
  end;
end;

begin
  //ctreating 1st file
  Assign(InputFile1,'1');
  Reset(InputFile1);
  while not eof(InputFile1) do
  begin
    Readln(InputFile1,St);
    new(q);
    q^.Data:=StrToInt(St);
    AddL(List1,q);
  end;
  CloseFile(InputFile1);
  //ctreating 2nd file
  Assign(InputFile2,'2');
  Reset(InputFile2);
  while not eof(InputFile2) do
  begin
    Readln(InputFile2,St);
    new(q);
    q^.Data:=StrToInt(St);
    AddL(List2,q);
  end;
  CloseFile(InputFile2);
  //result of sorg and combining
  Assign(OutputFile,'3');
  Rewrite(OutputFile);
  List3:=CombineTwoLists(List1,List2);
  SortingByShell(List3);
  q:=List3.PFirst;
  while q<>nil do begin
    writeln(OutputFile,q^.Data);
    q:=q^.PNext;
  end;
  ListDelete(List3);
  CloseFile(OutputFile);
end.
