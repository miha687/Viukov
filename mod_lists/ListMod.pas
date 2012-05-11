unit ListMod;

{$APPTYPE CONSOLE}

interface

uses  SysUtils;

  type
  TInfo   = string;
  PElement = ^TElement;
  TElement=record
    Info: TInfo;
    Next: PElement;
    index: integer;
  end;
    Tlist = record
    head, cur, tail: PElement;
    end;

  procedure list_create(var Plist: tlist);                // создание списка
  procedure list_insert(var plist: tlist; s: string);     // вставка в список
  procedure list_show(var Plist: tlist);                  // отображение списка
  procedure list_add(var Plist: tlist);                   // добавление элемента в список
  procedure list_delete(var Plist: tlist);                // удаление элемента из списка
  procedure list_save(var Plist: tlist);                  // сохранение данных из списка
  procedure list_sort(var Plist: tlist);                  // сортировка по длине строки
  procedure list_index(var Plist: tlist; ind: integer);   // перенос указателя на элементов с заданным индексом
  procedure list_element(var Plist: tlist);               // отображение индекса указанного элемента

implementation

procedure list_index(var plist: tlist; ind: integer);
begin
  plist.cur:=plist.head;
  while plist.cur.index<ind do plist.cur:=(plist.cur)^.Next;
end;

procedure list_create(var plist:tlist);
begin
  new(plist.cur);
  plist.cur.index:=1;
  plist.cur.next:=nil;
  plist.head:=plist.cur;
  plist.tail:=plist.cur;
end;

procedure list_insert(var plist: tlist; s: string);
begin
  if s<>'' then
  begin
    if plist.head.info='' then
    begin
      (Plist.cur)^.Info:=s;
      plist.head:=plist.cur;
      (Plist.cur)^.Next:=nil;
    end
    else
    begin
      New(Plist.cur);
      (Plist.cur)^.Info:=s;
      plist.cur.index:=plist.tail.index+1;
      (Plist.cur).Next:=nil;
      (Plist.tail)^.Next:=(Plist.cur);
      Plist.tail:=Plist.cur;
    end;
  end;
end;

procedure list_show(var plist:tlist);
begin
  begin
    if not(plist.head=nil) then
    begin
    Plist.cur:=Plist.head;
    writeln;
    begin
    while Plist.cur<>nil do
    begin
      writeln ((Plist.cur)^.info, ' ');
      Plist.cur:=(Plist.cur)^.next;
    end;
    end
    end
    else
    begin
      writeln;
      writeln('Spisok pust!');
    end;
  end;
end;

procedure list_add(var plist: tlist);
var
NewEl, el: string;
poisk: boolean;
q: Pelement;
begin
    writeln;
    writeln('element?');
    readln(NewEl);
    if plist.head=nil then
    begin
      New(Plist.cur);
      (Plist.cur)^.Info:=newel;
      (Plist.cur).Next:=nil;
      plist.cur.index:=1;
      Plist.head:=(Plist.cur);
      plist.tail:=plist.cur;
      writeln;
      writeln('Gotovo!');
    end
    else
    begin
    writeln('Pered kakim elementom?');
    readln (EL);
    Plist.cur:=Plist.head;
    poisk:=false;
    while ((Plist.cur)<>nil) and not(poisk) do
    begin
      if (Plist.cur)^.info=el then poisk:=true
      else
        Plist.cur:=(Plist.cur)^.next;
    end;
    if poisk then
    begin
      new(q);
      q^.Info:=(Plist.cur)^.info;
      (Plist.cur)^.info:=newel;
      q^.Next:=(Plist.cur)^.Next;
      (Plist.cur)^.next:=q;
      q.index:=plist.cur.index;
      if plist.cur=plist.tail then plist.tail:=q;
      while plist.cur.next<>nil do
      begin
        plist.cur.next.index:=plist.cur.next.index+1;
        plist.cur:=plist.cur.next;
      end;
      writeln;
      writeln('Gotovo!');
    end
    else begin writeln; writeln ('Net takogo elementa'); end;
    end;
end;

procedure list_delete (var plist:tlist);
var el: string;
poisk, poisk1, poisk2: boolean;
q: Pelement;
tmpind: integer;
begin
    if not(plist.head=nil)  then
    begin
      writeln;
      writeln ('Kakoi element?');
      readln (el);
      Plist.cur:=Plist.head;
      poisk:=false;
      poisk1:=false;
      poisk2:=false;
      if (Plist.head).info=el then poisk1:=true;
      if (plist.tail).info=el then poisk2:=true;
      while ((Plist.cur)^.Next<>nil) and not(poisk) and not(poisk1) and not(poisk2) do
      begin
        if ((Plist.cur)^.next)^.info=el then poisk:=true
        else
        Plist.cur:=(Plist.cur)^.next;
      end;
      if poisk then // udalenie ukazannogo elementa
      begin
        if plist.cur.Next.index<>(plist.tail.index-1) then
        begin
          q:=(Plist.cur)^.next;
          tmpind:=1;
          list_index(plist, (plist.tail.index-tmpind));
          plist.cur.Next.index:=plist.cur.index;
          repeat
          begin
            plist.cur:=plist.head;
            list_index (plist, plist.tail.index-tmpind);
            plist.cur.Next.index:=plist.cur.index;
            tmpind:=tmpind+1;
          end;
          until (plist.tail.index-tmpind)=q.index-1;
          list_index (plist, q.index-1);
          (Plist.cur)^.Next:=q^.Next;
          Dispose(q);
          writeln;
          writeln('Gotovo!');
        end
        else
        begin
          q:=plist.cur.next;
          plist.cur.Next:=plist.tail;
          plist.tail.index:=q.index;
          dispose(q);
          writeln;
          writeln('Gotovo!');
        end;
      end
      else
      begin
        if poisk1 then  // udalenie pervogo elementa v spiske
        begin
          q:=plist.head;
          if plist.head.next<>nil then
          begin
            plist.cur:=plist.head;
            repeat
            begin
              plist.cur:=plist.cur.Next;
              if plist.cur<>nil then plist.cur.index:=plist.cur.index-1;
            end;
            until plist.cur=nil;
            plist.head:=q.next;
            dispose(q);
          end
          else
          begin
            q:=plist.head;
            plist.head:=nil;
            dispose(q);
          end;
          writeln;
          writeln('Gotovo!');
        end
        else
        if poisk2 then // óudalenie poslednego elementa v spiske
        begin
          list_index(plist, plist.tail.index-1);
          q:=plist.cur.Next;
          plist.tail:=plist.cur;
          plist.tail.next:=nil;
          dispose(q);
          writeln;
          writeln('Gotovo!');
        end
        else
        if not(poisk1) and not(poisk2) then
        begin
          writeln;
          writeln ('Net takogo elementa!');
        end;
      end;
    end
    else
    begin
      writeln;
      writeln('Spisok pust');
    end;
end;

procedure list_element (var plist:tlist);
var el: string;
poisk: boolean;
begin
if not(plist.head=nil) then
  begin
    writeln;
    writeln ('Kakoi element?');
    readln (el);
    Plist.cur:=Plist.head;
    poisk:=false;
    if (Plist.cur)^.info=el then poisk:=true;
    while ((Plist.cur)<>nil) and not(poisk) do
    if (Plist.cur)^.Info=el then poisk:=true
    else
    Plist.cur:=(Plist.cur)^.Next;
    if poisk then
    begin
      writeln;
      writeln ('Poriadkovii nomer elementa= ', plist.cur.index)
    end
    else
    begin
      writeln;
      writeln ('Net takogo elementa');
    end;
  end
  else
  begin
    writeln;
    writeln('Spisok pust!');
  end;
end;

procedure list_save( var plist:tlist);
var f1: textfile;
s1: string;
begin
    AssignFile (f1, 'itog.txt');
    erase(f1);
    rewrite(f1);
    Plist.cur:=Plist.head;
    if not(plist.head=nil) then
    while (Plist.cur)<>nil do
    begin
      s1:=((Plist.cur)^.Info);
      writeln (f1, s1);
      Plist.cur:=(Plist.cur)^.Next;
    end;
    closefile (f1);
    writeln;
    writeln('Gotovo!');
end;

procedure list_sort (var plist:tlist);
var i, j: integer;
key: string;
begin
    plist.cur:=plist.head;
    if (plist.cur<>nil) and (not(plist.head=nil))
    then
    begin
      for i:= 2 to plist.tail.index do
      begin
        list_index(plist, i);
        key:=(plist.cur)^.Info;
        j:=i-1;
        list_index(plist, j);
        while (j>0) and (length(plist.cur^.info)>length(key)) do
        begin
          list_index(plist, j);
          (plist.cur)^.Next^.info := (plist.cur)^.Info;
          j:=j-1;
          list_index(Plist, j);
        end;
        if j=0 then plist.cur.info:=key
        else
        (plist.cur)^.Next^.info := key;
      end;
      writeln;
      writeln ('Gotovo!');
    end
    else
    begin
     writeln;
     writeln('Spisok pust!');
    end;
end;

end.
