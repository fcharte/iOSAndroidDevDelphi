unit Collectible;

interface

uses
  FMX.Graphics; { Unit containing TBitmap type definition }

type
  TLaunchYear    = 1965 .. 1995;
  TConsState     =    0 .. 100;

TCollectible = class abstract
  private
    Fname        : String;
    Fyear        : TLaunchYear;
    Fstate       : TConsState;
    Fdescription : String;
    Fpictures    : array of TBitmap;
    nPictures    : Integer;

    { Methods for internal use }
    procedure setName(name: String);
    function  getPicture(Index: Integer): TBitmap;
    procedure extendPictures;

  public
    { There is only a constructor. It needs the name of the item }
    constructor Create(name: String);

    property Name: String read Fname write setName;
    { Access to the remainder data items in the object }
    property Year : TLaunchYear read Fyear write Fyear;
    property State : TConsState read Fstate write Fstate;
    property Description : String read Fdescription write Fdescription;
    property NumPictures : Integer read nPictures;

    procedure addPicture(picture: TBitmap);
    function hasPictures: Boolean;
    property Picture[I: Integer] : TBitmap read getPicture;
end;

implementation

const INI_NUM_PICTURES = 1;

{ The constructor needs the name of the object, and
  initializes the essential data members }
constructor TCollectible.Create(name: String);
begin
  setName(name);
  SetLength(Fpictures, INI_NUM_PICTURES);
  nPictures := 0;
end;

function TCollectible.hasPictures;
begin
  Result := nPictures > 0;
end;

{ Method for modifying the Name property }
procedure TCollectible.setName(name: String);
begin
  Fname := name;
end;

{ Provides access to the pictures in the object }
function TCollectible.getPicture(Index: Integer): TBitmap;
begin
  if Index < nPictures then
    Result := Fpictures[Index]
  else
    Result := nil;
end;

{ Add a new picture to the list of pictures }
procedure TCollectible.addPicture(picture: TBitmap);
begin
  if nPictures = Length(Fpictures) then
    extendPictures;

  Fpictures[nPictures] := picture;
  inc(nPictures);
end;

{ Extend the array doubling its size }
procedure TCollectible.extendPictures;
begin
  SetLength(Fpictures, Length(Fpictures) * 2);
end;
end.
