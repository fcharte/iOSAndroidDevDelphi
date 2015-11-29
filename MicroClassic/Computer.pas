unit Computer;

interface

uses
  Collectible;

type
  TBitsComputer = (bits8, bits16, bits32);

  TComputer = class(TCollectible)
  private
    Fmanufacturer: String;
    Fmodel: String;
    Fbits: TBitsComputer;
    FRAM: SmallInt;
    FROM: SmallInt;
    Fworks: Boolean;

  public
    constructor Create(name: String);

    property Manufacturer: String read Fmanufacturer write Fmanufacturer;
    property Model: String read Fmodel write Fmodel;
    property Bits: TBitsComputer read Fbits write Fbits;
    property RAM: SmallInt read FRAM write FRAM;
    property ROM: SmallInt read FROM write FROM;
    property ItWorks: Boolean read Fworks write Fworks;
  end;

implementation

constructor TComputer.Create(name: String);
begin
  inherited Create(name);

  Fbits  := bits8;
  FRAM   := 64;
  FROM   := 32;
  Fworks := True;
end;

end.
