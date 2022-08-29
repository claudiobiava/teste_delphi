unit uClienteModel;

interface

type

  TClienteModel = class

  private
    fnCodigo: cardinal;

    fsNome,
    fsCidade,
    fsUF: string;
  public
    constructor criar;

    property sNome: string read fsNome write fsNome;
    property sCidade: string read fsCidade write fsCidade;
    property sUF: string read fsUF write fsUF;
    property nCodigo: cardinal read fnCodigo write fnCodigo;

 end;

implementation

constructor TClienteModel.criar;
begin
  fsNome := '';
end;


end.
