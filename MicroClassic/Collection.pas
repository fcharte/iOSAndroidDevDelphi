unit Collection;

interface

type

TMyClass = class
  private
    FF2: String;
    FF1: Integer;
    procedure SetF1(const Value: Integer);
    procedure SetF2(const Value: String);
  public
    property F1 : Integer read FF1 write SetF1;
    property F2 : String read FF2 write SetF2;
end;

TCollection = class
private
  class var refInstance: TCollection;

  { TODO: Add class members to hold the objects in the collection }

  class constructor Create;
  class destructor  Destroy;

  constructor Create;

public
  class function getInstance: TCollection;
  class property Instance: TCollection read refInstance;
end;

implementation

uses System.SysUtils, System.Types, System.StrUtils;

class constructor TCollection.Create;
begin
  if refInstance = nil then
    refInstance := TCollection.Create;
end;

class destructor TCollection.Destroy;
begin
  refInstance.Free;
  refInstance := nil;
end;

constructor TCollection.Create;
begin
  inherited;
  if refInstance <> nil then
     raise Exception.Create(
      'No more object can be created from this class');
end;

class function TCollection.getInstance: TCollection;
begin
  result := refInstance;
end;

{type
TFuncComparator = reference to function(l1,l2: String): Boolean;

procedure Sort(items: TStringDynArray;
                 compareFunc: TFuncComparator);
var
  index, position: Integer;
  temp: String;
begin
  for index := Low(items)+1 to High(items) do
    begin
      temp := items[index];
      position := index - 1;
      while ((position >= Low(items)) and
           compareFunc(temp, items[position])) do
        begin
          items[position+1] := items[position];
          dec(position);
        end;
       items[position+1] := temp;
    end;
end;
 }

var
  MyCollection: TCollection;
  //months: TStringDynArray;

type
TSort<DataType> = class
type
  ArrayType = array of DataType;
  TFuncComparator = reference to
       function(l1,l2: DataType): Boolean;
  class procedure Sort(items: ArrayType;
                         compareFunc: TFuncComparator);
end;

TSortString = TSort<String>;
TSortInteger = TSort<Integer>;

class procedure TSort<DataType>.Sort(items: ArrayType;
                         compareFunc: TFuncComparator);
var
  index, position: Integer;
  temp: DataType;
begin
  for index := Low(items)+1 to High(items) do
    begin
      temp := items[index];
      position := index - 1;
      while ((position >= Low(items)) and
           compareFunc(temp, items[position])) do
        begin
          items[position+1] := items[position];
          dec(position);
        end;
       items[position+1] := temp;
    end;
end;

var

  months: TSortString.ArrayType;
  days: TSortInteger.ArrayType;

{ TMyClass }

procedure TMyClass.SetF1(const Value: Integer);
begin
  FF1 := Value;
end;

procedure TMyClass.SetF2(const Value: String);
begin
  FF2 := Value;
end;

initialization

begin

  SetLength(days, 10);
  SetLength(months, 12);
  // Introduce data into the arrays

//  months := SplitString('Jan,Feb,Mar,Apr,May,Jun,' +
//                       'Jul,Aug,Sep,Oct,Nov,Dec', ',');

  TSortInteger.Sort(days,
   function(l1, l2: Integer): Boolean
    begin
      result := l1 < l2;
    end);

  TSortString.Sort(months,
   function(l1, l2: String): Boolean
    begin
      result := l1 < l2;
    end);

//  Sort(months, function(l1, l2: String): Boolean
//    begin
//      if l1 < l2 then
//        result := true
//      else
//        result := false;
//    end);

  MyCollection := TCollection.refInstance;








end;

end.
