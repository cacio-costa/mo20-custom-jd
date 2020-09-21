import 'package:casadocodigoapp/components/centered_message.dart';
import 'package:casadocodigoapp/components/loading.dart';
import 'package:casadocodigoapp/dto/dashboard_input_dto.dart';
import 'package:casadocodigoapp/rest/dashboard_rest_client.dart';
import 'package:casadocodigoapp/screens/author_form.dart';
import 'package:casadocodigoapp/screens/author_list.dart';
import 'package:casadocodigoapp/screens/category_list.dart';
import 'package:casadocodigoapp/screens/product_list.dart';
import 'package:flutter/material.dart';

import 'book_list.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Cliente para recuperar os autores
  final DashboardRestClient dashboardRestClient = DashboardRestClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<DashboardInputDto>(
          future: dashboardRestClient.getDashboardStatistics(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Loading();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return CenteredMessage('Error on fetching statistics', icon: Icons.error);
                }

                DashboardInputDto dashboardDto = snapshot.data;
                return _showCards(dashboardDto, context);
                break;
            }

            return CenteredMessage('Unknown error!', icon: Icons.error);
          },
        ),
      ),
    );
  }

  void _showAuthorForm(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AuthorForm())).then((newAuthor) {
      // Só busca nova listagem na API se um novo autor foi salvo
      if (newAuthor != null) {
        setState(() {}); // Rebuild da tela após salvar autor
      }
    });
  }

  ListView _showCards(DashboardInputDto dashboardDto, BuildContext context) {
    return ListView(
      children: <Widget>[
        _StatisticCard(
          name: 'Authors',
          value: dashboardDto.authorCount,
          icon: Icons.person,
          color: Colors.green,
          onClick: () => _showList(AuthorList(), context),
        ),
        _StatisticCard(
          name: 'Books',
          value: dashboardDto.bookCount,
          icon: Icons.library_books,
          color: Colors.blue,
          onClick: () => _showList(BookList(), context),
        ),
        _StatisticCard(
          name: 'Categories',
          value: dashboardDto.categoryCount,
          icon: Icons.category,
          color: Colors.red,
          onClick: () => _showList(CategoryList(), context),
        ),
        _StatisticCard(
          name: 'Products',
          value: dashboardDto.productCount,
          icon: Icons.store,
          color: Colors.grey,
          onClick: () => _showList(ProductList(), context),
        ),
      ],
    );
  }

  void _showList(Widget listView, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => listView))
        .then((value) => setState(() {}));
  }
}

class _StatisticCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;
  final int value;
  final Color color;

  _StatisticCard({
    @required this.name,
    @required this.value,
    @required this.icon,
    @required this.color,
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            color: color,
            height: 100,
            width: 140,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Icon(
                        icon,
                        size: 24,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$value',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
