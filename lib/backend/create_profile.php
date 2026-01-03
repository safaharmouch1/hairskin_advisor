<?php
require "db.php";

$data = json_decode(file_get_contents("php://input"), true);

$user_id  = intval($data["user_id"] ?? 0);
$full_name = trim($data["full_name"] ?? "");
$skin_type = trim($data["skin_type"] ?? "");
$hair_type = trim($data["hair_type"] ?? "");

if ($user_id <= 0) {
  http_response_code(400);
  echo json_encode(["error" => "Missing user_id"]);
  exit;
}

$stmt = $conn->prepare("
  INSERT INTO profiles (user_id, full_name, skin_type, hair_type)
  VALUES (?, ?, ?, ?)
  ON DUPLICATE KEY UPDATE
    full_name = VALUES(full_name),
    skin_type = VALUES(skin_type),
    hair_type = VALUES(hair_type)
");

$stmt->bind_param("isss", $user_id, $full_name, $skin_type, $hair_type);

if ($stmt->execute()) {
  echo json_encode(["ok" => true]);
} else {
  http_response_code(500);
  echo json_encode(["error" => "Failed to save profile"]);
}
