unit uPedidosDeVendaDAO;


interface

uses FireDAC.Comp.Client,

FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf, Dialogs, SysUtils,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,  uPedidosDeVendaModel,
  FireDAC.Comp.UI;

type

  TPedidosDeVendaDAO = class

  private
    foFDConnection: TFDConnection;

  public

    constructor criar(poFDConnection: TFDConnection);
    function persistirPedidosDeVendas(poPedidosDeVendaModel: TPedidosDeVendaModel): boolean;
    function excluirPedidosDeVendas(
      poPedidosDeVendaModel: TPedidosDeVendaModel): boolean;
    function getPedidosDeVendasByNumeroPedido(
      pnNumeroPedido: cardinal): TPedidosDeVendaModel;

 end;


implementation

constructor TPedidosDeVendaDAO.criar(poFDConnection: TFDConnection);
begin
  self.foFDConnection := poFDConnection;
end;


function TPedidosDeVendaDAO.persistirPedidosDeVendas(poPedidosDeVendaModel: TPedidosDeVendaModel): boolean;
var
  oFDQuery: TFDQuery;
  i: integer;
begin
  oFDQuery := TFDQuery.Create(nil);

  try
    foFDConnection.StartTransaction();
    oFDQuery.Connection := self.foFDConnection;

    oFDQuery.SQL.Text :=
      'insert into pedido (data_emissao, codigo_cliente, valor_total) '+
      'values (NOW(), :codigo_cliente, :valor_total)';
    oFDQuery.ParamByName('codigo_cliente').AsInteger := poPedidosDeVendaModel.nCodigoCliente;
    oFDQuery.ParamByName('valor_total').AsFloat := poPedidosDeVendaModel.getValorTotal();
    oFDQuery.ExecSQL();

    for i := 0 to poPedidosDeVendaModel.goListaItensPedido.Count-1 do
    begin
      oFDQuery.SQL.Text :=
        'insert into pedido_item (numero_pedido, codigo_produto, quantidade, valor_unitario, valor_total) ' +
        'values (' +
        '(SELECT auto_increment FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = ''wk'' AND TABLE_NAME = ''pedido''), ' +
        ':codigo_produto, :quantidade, :valor_unitario, :valor_total)';
//      oFDQuery.ParamByName('numero_pedido').AsInteger := poPedidosDeVendaModel.nNumeroPedido;
      oFDQuery.ParamByName('codigo_produto').AsInteger := poPedidosDeVendaModel.goListaItensPedido[i].oProduto.nCodigo;
      oFDQuery.ParamByName('quantidade').AsInteger := poPedidosDeVendaModel.goListaItensPedido[i].nQuantidade;
      oFDQuery.ParamByName('valor_unitario').AsFloat := poPedidosDeVendaModel.goListaItensPedido[i].nValorUnitario;
      oFDQuery.ParamByName('valor_total').AsFloat := poPedidosDeVendaModel.goListaItensPedido[i].getValorTotal();
      oFDQuery.ExecSQL();
    end;


    foFDConnection.Commit();
    oFDQuery.Free();

    result := true;

  except
    result := false;
    foFDConnection.Rollback();
    Showmessage('Falha ao gravar os dados!');
  end;


end;

function TPedidosDeVendaDAO.excluirPedidosDeVendas(poPedidosDeVendaModel: TPedidosDeVendaModel): boolean;
var
  oFDQuery: TFDQuery;
begin
  oFDQuery := TFDQuery.Create(nil);

  try
    foFDConnection.StartTransaction();
    oFDQuery.Connection := self.foFDConnection;

    oFDQuery.ExecSQL(
      'delete from pedido_item where numero_pedido = ' +
      IntToStr(poPedidosDeVendaModel.nNumeroPedido));

    oFDQuery.ExecSQL(
      'delete from pedido where numero_pedido = ' +
      IntToStr(poPedidosDeVendaModel.nNumeroPedido));

    foFDConnection.Commit();

    oFDQuery.Free();
    result := true;

  except
    result := false;
    foFDConnection.Rollback();
    Showmessage('Falha ao gravar os dados!');
  end;


end;

function TPedidosDeVendaDAO.getPedidosDeVendasByNumeroPedido(pnNumeroPedido: cardinal): TPedidosDeVendaModel;
var
  oFDQuery: TFDQuery;
begin
  result := nil;
  oFDQuery := TFDQuery.Create(nil);
  oFDQuery.Connection := self.foFDConnection;
  oFDQuery.SQL.Text := 'select * from pedido where numero_pedido = :numero_pedido';
  oFDQuery.ParamByName('numero_pedido').AsInteger := pnNumeroPedido;
  oFDQuery.Open();

  if oFDQuery.RecordCount = 1 then
  begin
    result := TPedidosDeVendaModel.criar();
    result.nNumeroPedido := pnNumeroPedido;
  end;


  oFDQuery.Free()


end;

end.

