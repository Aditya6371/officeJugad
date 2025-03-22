enum Request {
  get,
  post,
  put,
  patch,
  delete,
  postWithoutEncode,
  upload;
}

enum ButtonType {
  primary,
  secondary,
}

enum AppFlavor {
  dev,
  prod;
}

enum MessageType {
  error,
  success,
  information;
}

enum UserRole {
  admin,
  facilityManager,
  residence,
  departmentManager,
  associationManager,
  employee,
}

enum AssetStatus {
  pending,
  alloted,
  returnPending,
}

enum AuthMethod {
  phone,
  google,
  facebook,
}

enum UpdateType { none, mandatory, advisory }
