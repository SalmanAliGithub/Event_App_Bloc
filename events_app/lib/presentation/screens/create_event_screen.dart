import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/event_bloc/event_bloc.dart';
import '../../bloc/event_bloc/event_event.dart';
import '../../models/event_model.dart';
import '../../utils/notification_utils.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});
  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _maxBookingController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add a New Event',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _eventNameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _eventDateController,
                decoration: const InputDecoration(
                  labelText: 'Event Date',
                  hintText: 'YYYY-MM-DD',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      DateTime.tryParse(value) == null) {
                    return 'Please enter a valid date in YYYY-MM-DD format';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _maxBookingController,
                decoration: const InputDecoration(labelText: 'Max Booking'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Event Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Event Description'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      DateTime? parsedDate = DateTime.tryParse(_eventDateController.text);
      if (parsedDate == null) {
        NotificationUtils.showSnackBar(
            context, 'Invalid date format. Please use YYYY-MM-DD format.',
            isError: true);
        return;
      }
      BlocProvider.of<EventBloc>(context).add(CreateEvent(Event(
        id: 0, // id is ignored in creation, set by the backend or database
        eventName: _eventNameController.text,
        eventDate: parsedDate,
        maxBooking: int.parse(_maxBookingController.text),
        location: _locationController.text,
        description: _descriptionController.text,
      )));
      Navigator.of(context).pop(); // Close the dialog
      NotificationUtils.showSnackBar(context, 'Event added successfully!',
          isError: false);
    }
  }
}
