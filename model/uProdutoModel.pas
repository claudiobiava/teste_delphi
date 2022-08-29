unit uProdutoModel;

interface

type

  TProdutoModel = class

  private
    fnCodigo: cardinal;
    fsDescricao: string;
    fnPrecoVenda: real;

  public
    constructor criar;

    property sDescricao: string read fsDescricao write fsDescricao;
    property nPrecoVenda: real read fnPrecoVenda write fnPrecoVenda;
    property nCodigo: cardinal read fnCodigo write fnCodigo;

 end;

implementation

constructor TProdutoModel.criar;
begin
  fnPrecoVenda := 0;
end;


end.
