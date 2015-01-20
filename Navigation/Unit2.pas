unit Unit2;

interface

type
  TManufacturingYear = 1900..2100;

{$SCOPEDENUMS ON}
  TMunchiesCategory = (Snacks = 5, Crunchies = 8, Smoothies = 10);
{$SCOPEDENUMS OFF}

type
  TMonth = (Jan, Feb, Mar, Apr, May, Jun,
            Jul, Aug, Sep, Oct, Nov, Dec);

  TContent = (Analysis, Listing, Practical);
  TPubYear = 1970..1995;


  TBitsComputer = (bo8 = 8, bo16 = 16, bo32 = 32);
  TComputer = record
    name         : String;
    year         : TPubYear;
    manufacturer : String;
    model        : String;
    bits         : TBitsComputer;
    RAM          : SmallInt;
    ROM          : SmallInt;
    itWorks      : Boolean;
  end;

var
  magazine: array[TPubYear, TMonth, 1..500] of TContent;
  numIssues, numPages: Integer;
//  collection: array of array of TContent;


var
  aMunchCategory: TMunchiesCategory;
  manufactured: TManufacturingYear;
  aInt: Integer;

  collection: array of TComputer;
  numComputers: Integer;

implementation

{$R+}

var
  aComputer: TComputer;

type
  TConnection = (USB, SDCard, TV, Headphones, DockStation);
var
  connectors: set of TConnection;
  graphics: set of (sprites, scroll, fonts);
  TVoutput: Boolean;


  initialization
begin

  connectors := [USB, Headphones];
  connectors := connectors + [TV];

  TVoutput := TV in connectors;

  // Set the number of computers in the collection
  numComputers := 75;
  SetLength(collection, numComputers);

  with collection[0] do
  begin
    name := 'Atari 400';
    year := 1979;
    manufacturer := 'Atari';
    bits := bo8;
    RAM := 48;
  end;

   aComputer.name := 'Sinclair ZX Spectrum';




  numIssues := 48;
  numPages := 64;

  //SetLength(collection, numIssues, numPages);
  Length(collection);

  //collection[0, 0] := TContent.Analysis;

  magazine[1982, TMonth.Jan, 10] := TContent.Listing;

  aInt := 1880;
  //manufactured := aInt;

  aMunchCategory := TMunchiesCategory.Snacks;
end;

end.
