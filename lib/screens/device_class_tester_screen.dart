import 'package:flutter/material.dart';
import 'package:lumin_application/Classes/consumption_device.dart';
import 'package:lumin_application/Classes/device.dart';
import 'package:lumin_application/Classes/device_factory.dart';
import 'package:lumin_application/Classes/observer.dart';
import 'package:lumin_application/Classes/production_device.dart';

class DeviceClassTesterScreen extends StatefulWidget {
  const DeviceClassTesterScreen({super.key});

  @override
  State<DeviceClassTesterScreen> createState() => _DeviceClassTesterScreenState();
}

class _DeviceClassTesterScreenState extends State<DeviceClassTesterScreen> {
  final DeviceFactory _factory = DeviceFactory();
  final _DeviceObserverLogger _observer = _DeviceObserverLogger();

  final List<Device> _devices = [];
  final List<String> _logs = [];

  void _createConsumptionDevice() {
    final id = _devices.length + 1;
    final device = _factory.createDevice(
      name: 'AC Unit $id',
      type: 'consumption',
      deviceId: id,
      userId: 1,
      initialKwh: 0,
      powerRating: 1.8,
    );

    device.attach(_observer);
    setState(() {
      _devices.add(device);
      _logs.add('Created consumption device: ${device.getDeviceInfo()}');
    });
  }

  void _createProductionDevice() {
    final id = _devices.length + 1;
    final device = _factory.createDevice(
      name: 'Solar Panel $id',
      type: 'production',
      deviceId: id,
      userId: 1,
      initialKwh: 0,
    );

    device.attach(_observer);
    setState(() {
      _devices.add(device);
      _logs.add('Created production device: ${device.getDeviceInfo()}');
    });
  }

  void _collectReading() {
    if (_devices.isEmpty) {
      setState(() {
        _logs.add('No devices available. Create one first.');
      });
      return;
    }

    final device = _devices.last;
    final reading = (_observer.updateCount + 1) * 0.75;

    device.collectSensorData(reading);

    setState(() {
      _logs.add(
        'Collected reading ${reading.toStringAsFixed(2)} kWh '
        'for ${device.deviceName}. Total readings: ${device.sensorReadings.length}',
      );
      _logs.add('Observer updates: ${_observer.updateCount}');
    });
  }

  void _renameLastDevice() {
    if (_devices.isEmpty) {
      setState(() {
        _logs.add('No devices available to rename.');
      });
      return;
    }

    final device = _devices.last;
    final newName = '${device.deviceName} (Updated)';
    device.updateDeviceInfo(newName);

    setState(() {
      _logs.add('Renamed last device to: $newName');
      _logs.add('Observer updates: ${_observer.updateCount}');
    });
  }

  String _deviceSubtype(Device device) {
    if (device is ConsumptionDevice) {
      return 'Consumption | ${device.getConsumption()} kWh';
    }
    if (device is ProductionDevice) {
      return 'Production | ${device.getProduction()} kWh';
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Classes Tester'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _createConsumptionDevice,
                  child: const Text('Create Consumption Device'),
                ),
                ElevatedButton(
                  onPressed: _createProductionDevice,
                  child: const Text('Create Production Device'),
                ),
                ElevatedButton(
                  onPressed: _collectReading,
                  child: const Text('Collect Sensor Data'),
                ),
                ElevatedButton(
                  onPressed: _renameLastDevice,
                  child: const Text('Update Last Device Name'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Devices: ${_devices.length} | Observer updates: ${_observer.updateCount}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _Panel(
                      title: 'Created Devices',
                      child: ListView.builder(
                        itemCount: _devices.length,
                        itemBuilder: (context, index) {
                          final device = _devices[index];
                          return ListTile(
                            dense: true,
                            title: Text(device.deviceName),
                            subtitle: Text(
                              'ID: ${device.deviceId} | ${_deviceSubtype(device)}',
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _Panel(
                      title: 'Action Logs',
                      child: ListView.builder(
                        itemCount: _logs.length,
                        itemBuilder: (context, index) => ListTile(
                          dense: true,
                          title: Text(_logs[index]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final String title;
  final Widget child;

  const _Panel({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const Divider(),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _DeviceObserverLogger implements Observer {
  int updateCount = 0;

  @override
  void update(Device device) {
    updateCount++;
  }
}
