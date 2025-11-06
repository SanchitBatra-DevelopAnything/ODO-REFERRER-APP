import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:odo_sales_executive/providers/auth.dart';
import 'package:odo_sales_executive/providers/member.dart';

class Members extends StatefulWidget {
  const Members({super.key});

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  bool _isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final referrer = authProvider.loggedInReferrer;
        final referrerId = referrer?['id'];

        if (referrerId != null) {
          Provider.of<MembersProvider>(
            context,
            listen: false,
          ).fetchMyMembers(referrerId);
        }
      });

      _isFirstTime = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final membersProvider = Provider.of<MembersProvider>(context);
    final members = membersProvider.membersForMe; // List<String>

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
      drawer : Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
  decoration: const BoxDecoration(
    color: Color(0xFF2C2455),
  ),
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12), // Optional: rounded corners
          child: Image.asset(
            'assets/logo.jpeg',
            height: 80,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "ODO Sales Executive",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
),

          const ListTile(
            leading: Icon(Icons.person),
            title: Text("My Profile"),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          ),
        ],
      ),),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "My Referrals (${members.length})",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF2C2455),
        ),
        body: membersProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              ) // ✅ Loading state
            : members.isEmpty
            ? const Center(child: Text("No members found!"))
            : ListView.separated(
                itemCount: members.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final memberName = members[index]; // ✅ string
                  return ListTile(
                    title: Text(
                      memberName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: const Icon(Icons.person),
                  );
                },
              ),
      ),
    );
  }
}
