unit uFPedidosDeVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, udm,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.Mask,
  Vcl.Imaging.pngimage, uProdutoModel, uPedidosDeVendaModel;

type
  TFPedidosDeVenda = class(TForm)
    dsClientes: TDataSource;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    DBLookupComboBoxCliente: TDBLookupComboBox;
    Label1: TLabel;
    btnInserirProduto: TButton;
    edtCodigoProduto: TLabeledEdit;
    edtQuantideProduto: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtValorUnitarioProduto: TEdit;
    Image1: TImage;
    Label4: TLabel;
    Splitter1: TSplitter;
    btnGravarPedido: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure btnInserirProdutoClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
  private
    goProdutoModel: TProdutoModel;
    goPedidosDeVendaModel: TPedidosDeVendaModel;
  public
    { Public declarations }
  end;

var
  FPedidosDeVenda: TFPedidosDeVenda;

implementation

uses
  uClienteDAO, uProdutoDAO, uClienteModel, uPedidosDeVendaDAO;

{$R *.dfm}

procedure TFPedidosDeVenda.btnGravarPedidoClick(Sender: TObject);
var
  oPedidosDeVendaDAO: TPedidosDeVendaDAO;
begin
  if DBLookupComboBoxCliente.Text = '' then
  begin
     DBLookupComboBoxCliente.SetFocus;
     ShowMessage('Selecione um cliente!');
  end
  else
  begin
    oPedidosDeVendaDAO := TPedidosDeVendaDAO.criar(dm.FDConnection1);
    goPedidosDeVendaModel.nCodigoCliente := DBLookupComboBoxCliente.ListSource.DataSet.FieldByName('codigo_cliente').AsInteger;
    oPedidosDeVendaDAO.persistirPedidosDeVendas(goPedidosDeVendaModel);
  end;

end;

procedure TFPedidosDeVenda.btnInserirProdutoClick(Sender: TObject);
begin
  if goProdutoModel = nil then
  begin
     edtCodigoProduto.SetFocus();
     ShowMessage('C�digo do Produto n�o encontrado!');
  end
  else
  if StrToFloatDef(edtValorUnitarioProduto.text, 0) = 0 then
  begin
     edtValorUnitarioProduto.SetFocus();
     ShowMessage('Valor Unit�rio deve ser maior que zero!');
  end;

end;

procedure TFPedidosDeVenda.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', ',']) then
  begin
     Key := #0;
  end
  else
  if (Key = ',') and (Pos(Key, edtValorUnitarioProduto.Text) > 0) then
  begin
    Key := #0;
  end;
end;

procedure TFPedidosDeVenda.edtCodigoProdutoExit(Sender: TObject);
var
  oProdutoDAO: TProdutoDAO;
begin
  oProdutoDAO := TProdutoDAO.criar(dm.FDConnection1);
  goProdutoModel := oProdutoDAO.getProdutoByCodigoProduto(StrToIntDef( edtCodigoProduto.Text, -1));
  oProdutoDAO.destroy();

  if goProdutoModel = nil then
    ShowMessage('C�digo do Produto n�o encontrado: ' + edtCodigoProduto.Text)
  else
  begin
     edtValorUnitarioProduto.Text := FloatToStr(goProdutoModel.nPrecoVenda);
  end;

end;

procedure TFPedidosDeVenda.FormCreate(Sender: TObject);
var
  oClienteDAO: TClienteDAO;
begin
  goPedidosDeVendaModel := TPedidosDeVendaModel.criar();
  goProdutoModel := nil;
  oClienteDAO := TClienteDAO.criar(dm.FDConnection1);
  DBLookupComboBoxCliente.ListSource :=  oClienteDAO.getClientes();
  oClienteDAO.destroy();
end;

end.
