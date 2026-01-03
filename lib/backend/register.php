<?php
require "db.php";

$data = json_decode(file_get_contents("php://input"), true);
$email = trim($data["email"] ?? "");
$password = $data["password"] ?? "";

if (!$email || !$password) {
  http_response_code(400);
  echo json_encode(["error" => "Missing fields"]);
  exit;
}

$hash = password_hash($password, PASSWORD_BCRYPT);

$stmt = $conn->prepare("INSERT INTO users(email, password_hash) VALUES (?, ?)");
$stmt->bind_param("ss", $email, $hash);

if ($stmt->execute()) {
  echo json_encode(["ok" => true, "user_id" => $stmt->insert_id]);
} else {
  http_response_code(400);
  echo json_encode(["error" => "Email already used"]);
}
