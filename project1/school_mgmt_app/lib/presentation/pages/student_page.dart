import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/student_controller.dart';

class StudentPage extends StatelessWidget {
  final controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Fee Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // === Input Fields ===
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                  labelText: 'Student Name',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(16)))),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: controller.gradeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Grade',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
            ),
            Obx(() => CheckboxListTile(
                  value: controller.hasSiblings.value,
                  contentPadding: EdgeInsets.zero,
                  activeColor: Colors.green,
                  onChanged: (val) =>
                      controller.hasSiblings.value = val ?? false,
                  title: Text('Has Siblings'),
                )),
            Obx(() => CheckboxListTile(
                  activeColor: Colors.green,
                  value: controller.isTopPerformer.value,
                  onChanged: (val) =>
                      controller.isTopPerformer.value = val ?? false,
                  contentPadding: EdgeInsets.zero,
                  title: Text('Top Performer'),
                )),
            // === Due Date Selector ===
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Due Date: ',
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Text(
                        ' ${controller.selectedDueDate.toLocal().toString().split(' ')[0]}'),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDueDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (selectedDate != null &&
                            selectedDate != controller.selectedDueDate) {
                          controller.selectedDueDate = selectedDate;
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: controller.addStudent,
              child: Text(
                'Add Student',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(),

            // === Students List ===
            Expanded(
              child: Obx(() {
                if (controller.students.isEmpty) {
                  return Center(child: Text('No students added.'));
                }
                return ListView.builder(
                  itemCount: controller.students.length,
                  itemBuilder: (_, index) {
                    final s = controller.students[index];
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            'Name: ',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            ' ${s.name}',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Grade: ',
                                style: TextStyle(
                                    fontFamily: 'Afacad', fontSize: 14),
                              ),
                              Text(
                                '${s.grade}',
                                style: TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Due Date:',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                ' ${s.dueDate.toLocal().toString().split(' ')[0]}',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 124,
                        child: Column(
                          children: [
                            Text(
                              'Fee: \$${s.totalPaid.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                              ),
                            ),
                            if (s.hasSibling)
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.people,
                                      color: Colors.green,
                                      size: 14,
                                    ),
                                    Text(
                                      'Sibling Discount',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (s.isTopPerformer)
                              Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 14,
                                    ),
                                    Text(
                                      'Merit Discount',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
