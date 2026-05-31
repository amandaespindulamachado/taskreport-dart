// ==========================================
// CLASSES (RF13, RF14)
// ==========================================

// Classe Base
class ItemTrabalho {
  int id;
  String titulo;

  ItemTrabalho({
    required this.id,
    required this.titulo,
  });

  void exibirResumo() {
    print('Item ID: $id - Título: $titulo');
  }
}

// Classe Filha
class Tarefa extends ItemTrabalho {
  // Encapsulamento (RF14): atributos privados com _
  String _responsavel;
  String _status;
  String _prioridade;
  double _valor;
  int _horas;

  // Getters para acessar os privados
  String get responsavel => _responsavel;
  String get status => _status;
  String get prioridade => _prioridade;
  double get valor => _valor;
  int get horas => _horas;

  Tarefa({
    required int id,
    required String titulo,
    required String responsavel,
    required String status,
    required String prioridade,
    required double valor,
    required int horas,
  })  : _responsavel = responsavel,
        _status = status,
        _prioridade = prioridade,
        _valor = valor,
        _horas = horas,
        super(id: id, titulo: titulo); // Herança

  @override // Polimorfismo (RF13)
  void exibirResumo() {
    print('ID: $id');
    print('Título: $titulo');
    print('Responsável: $_responsavel');
    print('Status: $_status');
    print('Prioridade: $_prioridade');
    print('Valor: R\$ $_valor');
    print('Horas: $_horas');
    print('-------------------------');
  }
}

// ==========================================
// DADOS SIMULADOS (RF02)
// ==========================================
final List<Map<String, dynamic>> dadosTarefas = [
  {
    'id': 1,
    'titulo': ' Corrigir bug login ',
    'responsavel': 'Ana',
    'status': 'concluída',
    'prioridade': 'alta',
    'valor': 'R\$ 120,00',
    'horas': '2',
  },
  {
    'id': 2,
    'titulo': 'Criar tela de perfil',
    'responsavel': ' Bruno ',
    'status': 'em andamento',
    'prioridade': 'media',
    'valor': 'R\$ 250,50',
    'horas': '5',
  },
  {
    'id': 3,
    'titulo': null,
    'responsavel': 'Carla',
    'status': 'pendente',
    'prioridade': 'baixa',
    'valor': 'R\$ 80,00',
    'horas': null,
  },
  {
    'id': 4,
    'titulo': 'Ajustar navegação',
    'responsavel': null,
    'status': 'concluída',
    'prioridade': 'alta',
    'valor': 'R\$ 150,75',
    'horas': '3',
  },
  {
    'id': 5,
    'titulo': 'Revisar regras de negócio',
    'responsavel': 'Daniel',
    'status': 'cancelada',
    'prioridade': 'media',
    'valor': 'R\$ 0,00',
    'horas': '0',
  },
  {
    'id': 6,
    'titulo': 'Implementar validação de dados',
    'responsavel': 'Eduarda',
    'status': 'concluída',
    'prioridade': 'alta',
    'valor': 'R\$ 200,00',
    'horas': '4',
  },
  {
    'id': 7,
    'titulo': 'Organizar documentação',
    'responsavel': 'Felipe',
    'status': 'pendente',
    'prioridade': 'baixa',
    'valor': 'R\$ 90,00',
    'horas': '2',
  },
];

// ==========================================
// FUNÇÕES DE CONVERSÃO (RF01, RF03, RF04, RF05)
// ==========================================

Tarefa converterMapParaTarefa(Map<String, dynamic> item) {
  // RF03: Remover espaços (trim)
  String tituloLimpo = (item['titulo'] ?? '').toString().trim();
  String responsavelLimpo = (item['responsavel'] ?? '').toString().trim();
  String statusLimpo = (item['status'] ?? '').toString().trim();
  String prioridadeLimpa = (item['prioridade'] ?? '').toString().trim();

  // RF02: Tratar nulos
  if (tituloLimpo.isEmpty) tituloLimpo = "Sem título";
  if (responsavelLimpo.isEmpty) responsavelLimpo = "Não informado";
  if (statusLimpo.isEmpty) statusLimpo = "sem status";
  if (prioridadeLimpa.isEmpty) prioridadeLimpa = "sem prioridade";

  // RF04 e RF05
  double valorConvertido = converterValor(item['valor']);
  int horasConvertidas = converterHoras(item['horas']);

  return Tarefa(
    id: item['id'] ?? 0,
    titulo: tituloLimpo,
    responsavel: responsavelLimpo,
    status: statusLimpo,
    prioridade: prioridadeLimpa,
    valor: valorConvertido,
    horas: horasConvertidas,
  );
}

double converterValor(dynamic valor) {
  if (valor == null) return 0.0;
  String valorTexto = valor.toString();
  valorTexto = valorTexto.replaceAll('R\$', '');
  valorTexto = valorTexto.replaceAll(' ', '');
  valorTexto = valorTexto.replaceAll('.', ''); // Remove milhar
  valorTexto = valorTexto.replaceAll(',', '.'); // Ajusta decimal
  return double.tryParse(valorTexto) ?? 0.0;
}

int converterHoras(dynamic horas) {
  if (horas == null) return 0;
  return int.tryParse(horas.toString()) ?? 0;
}

// ==========================================
// MAIN (Execução)
// ==========================================

void main() {
  // RF01: Transformar mapas em objetos
  List<Tarefa> listaTarefas = dadosTarefas.map((item) => converterMapParaTarefa(item)).toList();
  print("=== RELATÓRIO FINAL DE TAREFAS ===\n");

  // RF06: Exibir todas as tarefas convertidas
  print("Tarefas convertidas:");
  for (var t in listaTarefas) {
    t.exibirResumo();
  }

  // RF07: Filtrar
  var concluidas = listaTarefas.where((t) => t.status == 'concluída').toList();
  var pendentes = listaTarefas.where((t) => t.status == 'pendente').toList();
  var andamento = listaTarefas.where((t) => t.status == 'em andamento').toList();
  var canceladas = listaTarefas.where((t) => t.status == 'cancelada').toList();

  print("Total de tarefas analisadas: ${listaTarefas.length}");
  print("Tarefas concluídas: ${concluidas.length}");
  print("Tarefas pendentes: ${pendentes.length}");
  print("Tarefas em andamento: ${andamento.length}");
  print("Tarefas canceladas: ${canceladas.length}\n");

  // RF08: Somar valores concluídas
  double totalConcluidas = concluidas.fold(0.0, (soma, tarefa) => soma + tarefa.valor);
  print("Valor total das concluídas: R\$ ${totalConcluidas.toStringAsFixed(2)}");

  // RF09: Média pendentes
  if (pendentes.isNotEmpty) {
    double somaPendentes = pendentes.fold(0.0, (soma, t) => soma + t.valor);
    double mediaPendentes = somaPendentes / pendentes.length;
    print("Média de valor das pendentes: R\$ ${mediaPendentes.toStringAsFixed(2)}");
  } else {
    print("Não existem tarefas pendentes para calcular média.");
  }

  // RF10: Horas por status
  int horasConcluidas = concluidas.fold(0, (soma, t) => soma + t.horas);
  print("Total de horas concluídas: $horasConcluidas\n");

  // RF12: Set (Status únicos)
  Set<String> statusUnicos = listaTarefas.map((t) => t.status).toSet();
  print("Status encontrados:");
  for (var status in statusUnicos) {
    print(status);
  }
  print("");

  // RF11: Dados incompletos (ampliado)
  print("Tarefas com dados incompletos:");
  bool temIncompletos = false;
  for (var original in dadosTarefas) {
    List<String> problemas = [];
    if (original['titulo'] == null || original['titulo'].toString().trim().isEmpty) {
      problemas.add("título ausente");
    }
    if (original['horas'] == null || original['horas'].toString().trim().isEmpty) {
      problemas.add("horas ausentes");
    }
    if (original['responsavel'] == null || original['responsavel'].toString().trim().isEmpty) {
      problemas.add("responsável ausente");
    }
    if (original['status'] == null || original['status'].toString().trim().isEmpty) {
      problemas.add("status ausente");
    }
    if (original['prioridade'] == null || original['prioridade'].toString().trim().isEmpty) {
      problemas.add("prioridade ausente");
    }

    // Detectar valor ausente ou inválido: se null -> ausente; se contém dígito !=0 e conversão dá 0.0 -> inválido
    if (original['valor'] == null) {
      problemas.add("valor ausente");
    } else {
      double vConv = converterValor(original['valor']);
      String vStr = original['valor'].toString();
      if (vConv == 0.0 && RegExp(r'[1-9]').hasMatch(vStr)) {
        problemas.add("valor inválido");
      }
    }

    if (problemas.isNotEmpty) {
      print("- ID ${original['id']}: ${problemas.join(' ou ')}");
      temIncompletos = true;
    }
  }
  if (!temIncompletos) {
    print("Nenhuma tarefa com dados incompletos encontrada.");
  }
}