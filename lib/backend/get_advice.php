<?php
require "db.php";

$user_id = intval($_GET["user_id"] ?? 0);

if ($user_id <= 0) {
  http_response_code(400);
  echo json_encode(["error" => "Missing user_id"]);
  exit;
}

$stmt = $conn->prepare("
  SELECT id, input_text, result_text, created_at
  FROM advice_history
  WHERE user_id = ?
  ORDER BY created_at DESC
");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$res = $stmt->get_result();

$rows = [];
while ($row = $res->fetch_assoc()) {
  $rows[] = $row;
}

echo json_encode($rows);
