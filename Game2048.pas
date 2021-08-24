program Game65536;
Uses Crt;
type
  location=array[1..2]of byte;
var
  brick:array[1..6,1..6]of byte;
  x,y,i,j:byte;
  key:char;
  score:longword;
function power(a:byte):word;
var
  i:byte;
begin
  power:=1;
  for i:=1 to a do power:=power*2;
end;
function juzhong(a:longword):string;
var
  l:byte;
begin
  str(a,juzhong);
  l:=length(juzhong);
  while l<5 do
  begin
    juzhong:=' '+juzhong+' ';
    l:=length(juzhong);
  end;
end;
procedure print;
begin
  gotoxy(10,2);
  textbackground(Black);
  write(juzhong(score));
  for y:=1 to 6 do
  for x:=1 to 6 do
  begin
    case brick[x,y] of
    0:textbackground(White);
    1,2:textbackground(Yellow);
    3,4:textbackground(5);
    5,6:textbackground(Red);
    7,8:textbackground(3);
    9,10:textbackground(Blue);
    11,12:textbackground(Green);
    end;
    window(x*7-6,y*3+2,x*7-1,y*3+4);clrscr;
    window(1,1,80,25);
    if brick[x,y]>0 then begin
      gotoxy(x*7-6,y*3+3);
      write(juzhong(power(brick[x,y])));
    end;
  end;
end;
procedure createmap;
begin
  textbackground(White);clrscr;
  window(1,1,7,3);textbackground(Yellow);clrscr;
  gotoxy(2,2);textcolor(White);write(2048);
  window(9,1,15,2);textbackground(Black);clrscr;
  gotoxy(2,1);write('Score');
  window(1,4,42,4);clrscr;
  for x:=1 to 6 do
  begin
    window(7*x,5,7*x,22);
    clrscr;
  end;
  window(1,23,42,23);clrscr;
  window(1,1,80,25);
  print;
end;
procedure appear;
var
  empty:array[1..36]of location;
begin
  fillchar(empty,sizeof(location),0);
  i:=0;
  for y:=1 to 6 do
  for x:=1 to 6 do
  if brick[x,y]=0 then
  begin
    inc(i);
    empty[i][1]:=x;
    empty[i][2]:=y;
  end;
  j:=random(i)+1;
  brick[empty[j][1],empty[j][2]]:=random(2)+1;
end;
procedure moveup;
var
  x,y,i:byte;
begin
  for x:=1 to 6 do
  begin
    i:=0;
    repeat
      inc(i);
      if brick[x,i]=0 then
      for y:=i+1 to 6 do if brick[x,y]>0 then
      begin
        brick[x,i]:=brick[x,y];
        brick[x,y]:=0;
        break;
      end;
      if brick[x,i]=0 then break;
      for y:=i+1 to 6 do
      if brick[x,y]=brick[x,i]then
      begin
        inc(brick[x,i]);
        score:=score+power(brick[x,i]);
        brick[x,y]:=0;
        break;
      end else if brick[x,y]>0 then break;
    until(i>=6);
  end;
end;
procedure movedown;
var
  x,y,i:byte;
begin
  for x:=1 to 6 do
  begin
    i:=7;
    repeat
      dec(i);
      if brick[x,i]=0 then
      for y:=i-1 downto 1 do if brick[x,y]>0 then
      begin
        brick[x,i]:=brick[x,y];
        brick[x,y]:=0;
        break;
      end;
      if brick[x,i]=0 then break;
      for y:=i-1 downto 1 do
      if brick[x,y]=brick[x,i]then
      begin
        inc(brick[x,i]);
        score:=score+power(brick[x,i]);
        brick[x,y]:=0;
        break;
      end else if brick[x,y]>0 then break;
    until(i<=1);
  end;
end;
procedure moveright;
var
  x,y,i:byte;
begin
  for y:=1 to 6 do
  begin
    i:=7;
    repeat
      dec(i);
      if brick[i,y]=0 then
      for x:=i-1 downto 1 do if brick[x,y]>0 then
      begin
        brick[i,y]:=brick[x,y];
        brick[x,y]:=0;
        break;
      end;
      if brick[i,y]=0 then break;
      for x:=i-1 downto 1 do
      if brick[x,y]=brick[i,y]then
      begin
        inc(brick[i,y]);
        score:=score+power(brick[i,y]);
        brick[x,y]:=0;
        break;
      end else if brick[x,y]>0 then break;
    until(i<=1);
  end;
end;
procedure moveleft;
var
  x,y,i:byte;
begin
  for y:=1 to 6 do
  begin
    i:=0;
    repeat
      inc(i);
      if brick[i,y]=0 then
      for x:=i+1 to 6 do if brick[x,y]>0 then
      begin
        brick[i,y]:=brick[x,y];
        brick[x,y]:=0;
        break;
      end;
      if brick[i,y]=0 then break;
      for x:=i+1 to 6 do
      if brick[x,y]=brick[i,y]then
      begin
        inc(brick[i,y]);
        score:=score+power(brick[i,y]);
        brick[x,y]:=0;
        break;
      end else if brick[x,y]>0 then break;
    until(i>=6);
  end;
end;
function checkdie:boolean;
var
  x,y:byte;
begin
  for x:=1 to 6 do
  for y:=1 to 5 do
  if brick[x,y]=brick[x,y+1] then exit(false);
  for y:=1 to 6 do
  for x:=1 to 5 do
  if brick[x,y]=brick[x+1,y] then exit(false);
  exit(true);
end;
function effect(direction:byte):boolean;//方向：1上2下3左4右
var
   x,y,i:byte;
begin
  case direction of
  1:for x:=1 to 6 do
    begin
      for y:=1 to 5 do
      if brick[x,y]=0 then
      for i:=y+1 to 6 do if brick[x,i]>0 then exit(true);
      for y:=1 to 5 do
      if(brick[x,y]=brick[x,y+1])and(brick[x,y]>0)then exit(true);
    end;
  2:for x:=1 to 6 do
    begin
      for y:=6 downto 2 do
      if brick[x,y]=0 then
      for i:=y-1 downto 1 do if brick[x,i]>0 then exit(true);
      for y:=6 downto 2 do
      if(brick[x,y]=brick[x,y-1])and(brick[x,y]>0)then exit(true);
    end;
  3:for y:=1 to 6 do
    begin
      for x:=1 to 5 do
      if brick[x,y]=0 then
      for i:=x+1 to 6 do if brick[i,y]>0 then exit(true);
      for x:=1 to 5 do
      if(brick[x,y]=brick[x+1,y])and(brick[x,y]>0)then exit(true);
    end;
  4:for y:=1 to 6 do
    begin
      for x:=6 downto 2 do
      if brick[x,y]=0 then
      for i:=x-1 downto 1 do if brick[i,y]>0 then exit(true);
      for x:=6 downto 2 do
      if(brick[x,y]=brick[x-1,y])and(brick[x,y]>0)then exit(true);
    end;
  end;
  exit(false);
end;
begin
  randomize;
  cursoroff;
  fillchar(brick,sizeof(brick),0);
  createmap;
  score:=0;
  appear;appear;
  print;
  repeat
    while not keypressed do;
    key:=readkey;
    case ord(key)of
    27:halt;
    72:if effect(1)then moveup else continue;
    80:if effect(2)then movedown else continue;
    75:if effect(3)then moveleft else continue;
    77:if effect(4)then moveright else continue;
    end;
    print;
    delay(100);
    appear;
    print;
    if i=1 then
    if checkdie then begin
      delay(1000);
      textbackground(White);clrscr;
      textcolor(Black);
      gotoxy(27,10);write('Game Over');
      gotoxy(25,11);write('score ',score);
      gotoxy(23,12);write('Press Enter to exit...');
      readln;
      halt;
    end;
  until false;
end.

