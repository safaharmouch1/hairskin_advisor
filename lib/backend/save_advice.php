<?php
require "db.php";

$data = json_decode(file_get_contents("php://input"), true);

$user_id = intval($data["user_id"] ?? 0);
$input_text = trim($data["input_text"] ?? "");
$result_text = trim($data["result_text"] ?? "");

if ($user_id <= 0 || !$input_text || !$result_text) {
  http_response_code(400);
  echo json_encode(["error" => "Missing fields"]);
  exit;
}

$stmt = $conn->prepare("INSERT INTO advice_history (user_id, input_text, result_text) VALUES (?, ?, ?)");
$stmt->bind_param("iss", $user_id, $input_text, $result_text);

if ($stmt->execute()) {
  echo json_encode(["ok" => true, "advice_id" => $stmt->insert_id]);
} else {
  http_response_code(500);
  echo json_encode(["error" => "Failed to save advice"]);
}
