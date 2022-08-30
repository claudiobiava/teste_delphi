unit uClienteDAO;


interface

uses FireDAC.Comp.Client,

FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf, Dialogs, SysUtils,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI;

type

  TClienteDAO = class

  private
    foFDConnection: TFDConnection;

  public

    constructor criar(poFDConnection: TFDConnection);
    function getClientes: TDataSource;

 end;


implementation

constructor TClienteDAO.criar(poFDConnection: TFDConnection);
begin
  self.foFDConnection := poFDConnection;
end;

function TClienteDAO.getClientes: TDataSource;
var
  oFDQuery: TFDQuery;
  oDataSource: TDataSource;
begin
   oFDQuery := TFDQuery.Create(nil);
   oFDQuery.Connection := self.foFDConnection;
   oFDQuery.Open('select * from cliente order by nome_cliente');

   oDataSource := TDataSource.Create(nil);
   oDataSource.DataSet := oFDQuery;
   result := oDataSource;
end;

end.
