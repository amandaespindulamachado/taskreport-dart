import 'package:test/test.dart';
import '../main.dart';

void main() {
  group('Conversão de tarefas', () {
    test('deve converter valores nulos e campos vazios corretamente', () {
      final tarefa = converterMapParaTarefa({
        'id': 10,
        'titulo': null,
        'responsavel': '',
        'status': null,
        'prioridade': '',
        'valor': null,
        'horas': null,
      });

      expect(tarefa.id, equals(10));
      expect(tarefa.titulo, equals('Sem título'));
      expect(tarefa.responsavel, equals('Não informado'));
      expect(tarefa.status, equals('sem status'));
      expect(tarefa.prioridade, equals('sem prioridade'));
      expect(tarefa.valor, equals(0.0));
      expect(tarefa.horas, equals(0));
    });
  });
}
