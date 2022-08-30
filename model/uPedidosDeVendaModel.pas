unit uPedidosDeVendaModel;

interface

uses Classes, generics.collections, uProdutoModel;


type
  TItemPedidoModel = class

  private
    foProduto: TProdutoModel;
    fnCodigoItemPedido,
    fnQuantidade: cardinal;
    fnValorUnitario: real;

  public
    property oProduto: TProdutoModel read foProduto write foProduto;
    property nQuantidade: cardinal read fnQuantidade write fnQuantidade;
    property nCodigoItemPedido: cardinal read fnCodigoItemPedido write fnCodigoItemPedido;
    property nValorUnitario: real read fnValorUnitario write fnValorUnitario;

    constructor criar;
    function getValorTotal: real;

  end;

type

  TPedidosDeVendaModel = class

  private
    fnCodigoCliente,
    fnNumeroPedido: cardinal;
    fnDataEmissao: TDateTime;


  public
    goListaItensPedido: TList<TItemPedidoModel>;

    constructor criar;
    destructor destruir;

    property nNumeroPedido: cardinal read fnNumeroPedido write fnNumeroPedido;
    property nDataEmissao: TDateTime read fnDataEmissao write fnDataEmissao;
    property nCodigoCliente: cardinal read fnCodigoCliente write fnCodigoCliente;

    function getValorTotal: real;
    function getItemPedidoByCodigoItemPedido(pnCodigo: cardinal): TItemPedidoModel;
    function deleteItemPedidoByCodigoItemPedido(pnCodigo: cardinal): TItemPedidoModel;
 end;

implementation

constructor TPedidosDeVendaModel.criar;
begin
  goListaItensPedido := TList<TItemPedidoModel>.Create;
  fnNumeroPedido := 0;
end;

function TPedidosDeVendaModel.getItemPedidoByCodigoItemPedido(
  pnCodigo: cardinal): TItemPedidoModel;
var
  i: integer;
begin
  result := nil;
  for i := 0 to goListaItensPedido.Count-1 do
  begin
    if goListaItensPedido[i].fnCodigoItemPedido = pnCodigo then
    begin
      result := goListaItensPedido[i];
      exit;
    end;
  end;
end;

function TPedidosDeVendaModel.deleteItemPedidoByCodigoItemPedido(
  pnCodigo: cardinal): TItemPedidoModel;
var
  i: integer;
begin
  result := nil;
  for i := 0 to goListaItensPedido.Count-1 do
  begin
    if goListaItensPedido[i].fnCodigoItemPedido = pnCodigo then
    begin
      break;
    end;
  end;
  goListaItensPedido.Delete(i);
end;

destructor TPedidosDeVendaModel.destruir;
var
  i: integer;
begin
  for i := 0 to goListaItensPedido.Count-1 do
  begin
    goListaItensPedido[i].Free;
  end;
  goListaItensPedido.Free;
end;

function TPedidosDeVendaModel.getValorTotal: real;
var
  i: integer;
begin
  result := 0;
  for i := 0 to goListaItensPedido.Count-1 do
  begin
    result := result + goListaItensPedido[i].getValorTotal();
  end;
end;

{ TItemPedido }

constructor TItemPedidoModel.criar;
begin

end;

function TItemPedidoModel.getValorTotal: real;
begin
  result := nValorUnitario * nQuantidade;
end;

end.
