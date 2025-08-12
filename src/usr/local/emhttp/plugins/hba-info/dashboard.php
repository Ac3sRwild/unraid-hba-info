<?php
// Run the info script and parse output
$controllers = [];
exec('/usr/local/emhttp/plugins/hba-info/scripts/check_hba_info.sh', $output);

foreach ($output as $line) {
    // Expect tab-separated fields: controller  adapter_type  model  serial  fw_ver  temp
    $fields = explode("\t", $line);
    if (count($fields) == 6) {
        $controllers[] = [
            'id' => $fields[0],
            'adapter_type' => $fields[1],
            'model' => $fields[2],
            'serial' => $fields[3],
            'firmware_version' => $fields[4],
            'temperature' => $fields[5],
        ];
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>HBA Information</title>
    <style>
      table { border-collapse: collapse; }
      td, th { border: 1px solid #aaa; padding: 5px; }
    </style>
</head>
<body>
    <h1>HBA Information</h1>
    <?php if (count($controllers)): ?>
    <table>
        <tr>
            <th>Controller</th>
            <th>Adapter Type</th>
            <th>Model</th>
            <th>Serial Number</th>
            <th>Firmware Version</th>
            <th>Temperature</th>
        </tr>
        <?php foreach ($controllers as $c): ?>
        <tr>
            <td><?= htmlspecialchars($c['id']) ?></td>
            <td><?= htmlspecialchars($c['adapter_type']) ?></td>
            <td><?= htmlspecialchars($c['model']) ?></td>
            <td><?= htmlspecialchars($c['serial']) ?></td>
            <td><?= htmlspecialchars($c['firmware_version']) ?></td>
            <td><?= htmlspecialchars($c['temperature']) ?> &deg;C</td>
        </tr>
        <?php endforeach ?>
    </table>
    <?php else: ?>
    <p>No controllers detected.</p>
    <?php endif ?>
</body>
</html>
