unit uPedidosDeVendaModel;

interface

uses Classes, generics.collections, uProdutoModel;


type
  TItemPedido = class

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
    goListaItensPedido: TList<TItemPedido>;

    constructor criar;
    destructor destruir;

    property nNumeroPedido: cardinal read fnNumeroPedido write fnNumeroPedido;
    property nDataEmissao: TDateTime read fnDataEmissao write fnDataEmissao;
    property nCodigoCliente: cardinal read fnCodigoCliente write fnCodigoCliente;

    function getValorTotal: real;
    function getItemPedidoByCodigoItemPedido(pnCodigo: integer): TItemPedido;
    function deleteItemPedidoByCodigoItemPedido(pnCodigo: integer): TItemPedido;
 end;

implementation

constructor TPedidosDeVendaModel.criar;
begin
  goListaItensPedido := TList<TItemPedido>.Create;
end;


function TPedidosDeVendaModel.getItemPedidoByCodigoItemPedido(
  pnCodigo: integer): TItemPedido;
var
  i: integer;
begin
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
  pnCodigo: integer): TItemPedido;
var
  i: integer;
begin
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

constructor TItemPedido.criar;
begin

end;

function TItemPedido.getValorTotal: real;
begin
  result := nValorUnitario * nQuantidade;
end;

end.
