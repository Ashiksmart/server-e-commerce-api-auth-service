CREATE TABLE `activity_history` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `model_id` int NOT NULL,
  `type` enum('create','update','delete') NOT NULL,
  `update_values` json NOT NULL,
  `updated_by` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `address_information` (
  `id` int NOT NULL,
  `account_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `mobile` varchar(100) NOT NULL,
  `landline` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `pincode` varchar(100) NOT NULL,
  `landmark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `additional_info` json DEFAULT NULL,
  `is_default` enum('Y','N') NOT NULL,
  `created_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `updated_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `attributes` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `attr_id` int DEFAULT NULL,
  `app_id` varchar(100) NOT NULL,
  `category_id` varchar(255) NOT NULL,
  `partner_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `attr_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `units` varchar(50) NOT NULL,
  `is_active` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `attributes_group` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `app_id` varchar(100) NOT NULL,
  `category_id` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `units` varchar(50) NOT NULL,
  `field` enum('TXT','COL') NOT NULL,
  `is_active` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `audit_log` (
  `id` int NOT NULL,
  `table_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `field` varchar(100) NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `record_id` int NOT NULL,
  `old_value` text NOT NULL,
  `new_value` text NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `brand` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `app_id` varchar(255) NOT NULL,
  `category_id` varchar(255) NOT NULL,
  `brand_name` varchar(100) NOT NULL,
  `brand_des` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `brand_verify` enum('Y','N') NOT NULL,
  `is_active` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Y',
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cart` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `products` json NOT NULL,
  `additional_info` json NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(100) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `category_new` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `app_id` varchar(50) NOT NULL,
  `details` json NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tax_details` json NOT NULL,
  `is_active` enum('Y','N') NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `crm_activity` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `partner_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type` enum('note','call','meeting') NOT NULL,
  `details` json NOT NULL,
  `contact_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `lead_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `company_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `deal_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `is_active` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `crm_company` (
  `id` int NOT NULL,
  `account_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `partner_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `details` json NOT NULL,
  `is_active` enum('Y','N') NOT NULL,
  `created_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `updated_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `crm_deals` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `partner_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `details` json NOT NULL,
  `contact_id` text,
  `lead_id` text,
  `user` varchar(255) NOT NULL,
  `is_active` enum('Y','N') NOT NULL DEFAULT 'Y',
  `company_id` text,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `crm_leads` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `associate_to_lead` text,
  `partner_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `company_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `phone_number` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `user` json DEFAULT NULL,
  `details` json DEFAULT NULL,
  `contact_details` json NOT NULL,
  `is_lead` enum('Y','N') NOT NULL DEFAULT 'Y',
  `is_contact` enum('Y','N') NOT NULL DEFAULT 'N',
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `crm_status` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `partner_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `module` varchar(100) DEFAULT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` enum('Y','N') NOT NULL DEFAULT 'Y'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `custom_table_header` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `header` json NOT NULL,
  `user_id` int NOT NULL,
  `module` varchar(100) NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `delete_track` (
  `id` int NOT NULL,
  `model` varchar(100) NOT NULL,
  `model_column` varchar(50) NOT NULL,
  `column_value` varchar(50) NOT NULL,
  `duration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `document` (
  `id` int NOT NULL,
  `file_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `content_type` varchar(100) DEFAULT NULL,
  `file_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `model` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employeegroup` (
  `id` int NOT NULL,
  `account_id` varchar(100) DEFAULT NULL,
  `partner_id` varchar(100) DEFAULT NULL,
  `employee_master_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `employee_id` varchar(100) NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employee_master` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `partner_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `teams` text NOT NULL,
  `employee_id` json NOT NULL,
  `team_leader` json NOT NULL,
  `app_id` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `flow_config` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `details` json NOT NULL,
  `flow_id` varchar(100) NOT NULL,
  `step_id` varchar(100) NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `import_documents` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `partner_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `details` json NOT NULL,
  `user` json NOT NULL,
  `type` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `skip_data_ref_id` text,
  `flag` enum('0','1') NOT NULL DEFAULT '0',
  `total_count` int DEFAULT NULL,
  `completed_count` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `updated_by` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `invoice` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `product_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `account_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `partner_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `category_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sub_category_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_info` json DEFAULT NULL,
  `product_details` json DEFAULT NULL,
  `delivery_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `additional_info` json DEFAULT NULL,
  `payment_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `payment_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `order_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `teams` text,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `location_city` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `city_code` int NOT NULL,
  `state_code` int NOT NULL,
  `is_popular` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'N',
  `is_active` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `location_state` (
  `account_id` varchar(100) NOT NULL,
  `state_code` int NOT NULL,
  `state_name` varchar(100) NOT NULL,
  `is_active` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `market_place` (
  `id` int NOT NULL,
  `account_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `partner_id` varchar(100) DEFAULT NULL,
  `label` text NOT NULL,
  `process` varchar(50) NOT NULL,
  `app_id` varchar(10) NOT NULL,
  `app_icon` text NOT NULL,
  `catagory_id` json DEFAULT NULL,
  `discription` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `is_default` enum('Y','N') NOT NULL,
  `is_active` enum('Y','N') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `show_on_market` enum('Y','N') NOT NULL,
  `is_costing` enum('Y','N') NOT NULL,
  `is_client_show` enum('Y','N') NOT NULL DEFAULT 'N',
  `is_install_permit` enum('Y','N') NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `market_place_nav` (
  `id` int NOT NULL,
  `account_id` varchar(100) DEFAULT NULL,
  `label` varchar(100) NOT NULL,
  `value` varchar(100) NOT NULL,
  `app_icon` text NOT NULL,
  `operation` json NOT NULL,
  `app_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `model` (
  `id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `notification` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `reciver` enum('Superadmin','Admin','SubSuperadmin','SubAdmin','Employee','Client','None') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type_id` int NOT NULL,
  `template_id` int NOT NULL,
  `vendor_id` int NOT NULL,
  `model_id` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `staff_id` longtext,
  `rules` json NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `notification_template` (
  `id` int NOT NULL,
  `template_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `vendor_id` int DEFAULT NULL,
  `template_message` longtext,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `attachment` enum('0','1') NOT NULL DEFAULT '0',
  `subject` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `notification_template_content` (
  `account_id` varchar(100) NOT NULL,
  `id` int NOT NULL,
  `template_id` int NOT NULL,
  `content` json NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `notification_type` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `one_time_password` (
  `id` int NOT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `additional_info` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `account_id` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `otp` int NOT NULL,
  `type` enum('1','2') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_detail` (
  `id` int NOT NULL,
  `invoice_id` json DEFAULT NULL,
  `account_id` text,
  `partner_id` json NOT NULL,
  `payment_method` varchar(100) DEFAULT NULL,
  `delivery_charges` varchar(100) DEFAULT '0',
  `user_id` varchar(100) NOT NULL,
  `additional_info` json DEFAULT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order_track` (
  `id` int NOT NULL,
  `order_id` varchar(100) NOT NULL,
  `invoice_id` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `link_to` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `partner_account` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `partner_id` varchar(100) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` text,
  `state` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `phone_number` bigint NOT NULL,
  `description` text NOT NULL,
  `is_product_limit` enum('Y','N') NOT NULL DEFAULT 'N',
  `product_limit` int NOT NULL,
  `product_utilize` int NOT NULL DEFAULT '0',
  `account_license` enum('Y','N') DEFAULT NULL,
  `account_req` enum('Y','N') NOT NULL DEFAULT 'N',
  `verify_items` enum('Y','N') NOT NULL,
  `active` enum('Y','N') NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `permission` (
  `id` int NOT NULL,
  `account_id` varchar(255) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `permission` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `active` enum('Y','N') NOT NULL,
  `default` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `partner_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `category_id` varchar(100) NOT NULL,
  `sub_category_id` varchar(100) NOT NULL,
  `details` json NOT NULL,
  `additional_info` json NOT NULL,
  `is_active` enum('Y','N') NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `project_account` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `phone_number` bigint NOT NULL,
  `description` text NOT NULL,
  `primay_logo` text NOT NULL,
  `secondary_logo` text NOT NULL,
  `primay_color` varchar(100) NOT NULL,
  `secondary_color` varchar(100) NOT NULL,
  `storage_service` enum('Y','N') NOT NULL,
  `app_url` text NOT NULL,
  `app_discription` text NOT NULL,
  `process` varchar(100) NOT NULL,
  `currency` varchar(100) NOT NULL,
  `is_product_limit` enum('N','Y') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'N',
  `product_limit` int NOT NULL DEFAULT '0',
  `product_utilize` int NOT NULL DEFAULT '0',
  `is_partner` enum('Y','N') NOT NULL DEFAULT 'N',
  `is_partner_limit` enum('N','Y') NOT NULL DEFAULT 'N',
  `partner_limit` int NOT NULL DEFAULT '0',
  `partner_utilize` int NOT NULL DEFAULT '0',
  `client_partner_request` enum('Y','N') NOT NULL DEFAULT 'N',
  `client_employee_request` enum('Y','N') NOT NULL DEFAULT 'N',
  `team_auto_assign` enum('Y','N') NOT NULL DEFAULT 'N',
  `is_user_limit` enum('Y','N') NOT NULL DEFAULT 'N',
  `user_limit` tinyint NOT NULL DEFAULT '0',
  `user_utilize` tinyint NOT NULL DEFAULT '0',
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `project_domain` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `main_domain` varchar(255) NOT NULL,
  `api_domain` json NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `system_reference` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `task_log` (
  `id` int NOT NULL,
  `partner_id` text,
  `account_id` text,
  `invoice_id` varchar(255) NOT NULL,
  `order_id` text NOT NULL,
  `app_id` text NOT NULL,
  `name` text,
  `description` text,
  `user` varchar(1000) DEFAULT '{}',
  `details` varchar(1000) DEFAULT '{}',
  `status` text,
  `work_status` varchar(255) NOT NULL DEFAULT 'todo',
  `created_by` varchar(255) NOT NULL,
  `updated_by` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `link_to` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `teams` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `name` text,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `app_id` text NOT NULL,
  `partner_id` text,
  `created_by` text,
  `updated_by` text,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` enum('Y','N') NOT NULL DEFAULT 'Y'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `template` (
  `id` int NOT NULL,
  `account_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `partner_id` varchar(100) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `is_active` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_deleted` enum('Y','N') NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `templates_field` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `partner_id` varchar(100) DEFAULT NULL,
  `app_id` json DEFAULT NULL,
  `catagory` varchar(100) NOT NULL,
  `template_id` int NOT NULL,
  `model` varchar(100) NOT NULL,
  `label` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `placeholder` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `is_badge` enum('Y','N') NOT NULL,
  `model_type` varchar(100) NOT NULL,
  `validation_type` varchar(100) NOT NULL,
  `validations` json NOT NULL,
  `readonly` enum('Y','N') NOT NULL,
  `disabled` enum('Y','N') NOT NULL,
  `required` enum('Y','N') NOT NULL,
  `multiple` enum('Y','N') NOT NULL,
  `link` json NOT NULL,
  `values` json NOT NULL,
  `is_default` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_delete` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `filter_role` varchar(30) NOT NULL DEFAULT 'Clinet,Brand,Partner',
  `show_in_table` enum('Y','N') NOT NULL,
  `show_on` varchar(255) NOT NULL DEFAULT 'Client,Brand,Partner',
  `position` int NOT NULL DEFAULT '0',
  `sample_data` text,
  `search_filter` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `id` int NOT NULL,
  `account_id` varchar(100) DEFAULT NULL,
  `partner_id` varchar(100) DEFAULT NULL,
  `roles` varchar(100) NOT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `avatar_url` text,
  `user_group` int DEFAULT NULL,
  `auth` enum('Y','N') NOT NULL,
  `active` enum('Y','N') NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `password` longblob,
  `additional_info` json DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `usergroup` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `partner_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `active` enum('Y','N') NOT NULL,
  `permission_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `vendor` (
  `id` int NOT NULL,
  `type_id` int DEFAULT NULL,
  `vendor` varchar(100) DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type_name` varchar(100) DEFAULT NULL,
  `vendor_value` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `vendor_credential` (
  `id` int NOT NULL,
  `vendor_id` int DEFAULT NULL,
  `details` json DEFAULT NULL,
  `account_id` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `version_control` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `major_version` int NOT NULL,
  `minor_version` int NOT NULL,
  `patch_version` int NOT NULL,
  `message` longtext,
  `type` varchar(100) NOT NULL,
  `redirect_url` text,
  `active` enum('Y','N') NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `workflow_status` (
  `id` int NOT NULL,
  `account_id` varchar(100) NOT NULL,
  `app_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) NOT NULL,
  `page_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `display_name` varchar(100) NOT NULL,
  `status_name` varchar(255) DEFAULT NULL,
  `type` int DEFAULT NULL,
  `default_status` enum('Y','N') DEFAULT NULL,
  `color` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `priority` int DEFAULT NULL,
  `link_to` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `link_type` enum('parent','child','') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `filter` json DEFAULT NULL,
  `content` json DEFAULT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_by` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `activity_history`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `address_information`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `fk_attr_id` (`attr_id`);

ALTER TABLE `attributes_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `brand`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `category_new`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`,`account_id`,`app_id`);

ALTER TABLE `crm_activity`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `crm_company`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `crm_deals`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `crm_leads`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `crm_status`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `custom_table_header`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `delete_track`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `document`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `employeegroup`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `employee_master`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `flow_config`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `import_documents`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `location_city`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `market_place`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `market_place_nav`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `model`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `notification_template`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `template_name` (`template_name`) USING BTREE;

ALTER TABLE `notification_template_content`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `notification_type`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `one_time_password`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `order_track`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`,`invoice_id`,`status`);

ALTER TABLE `partner_account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_id_2` (`account_id`,`username`,`email`,`phone_number`),
  ADD UNIQUE KEY `username` (`username`,`email`,`phone_number`);

ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_id` (`account_id`,`category_name`);

ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

ALTER TABLE `project_account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_id` (`account_id`),
  ADD UNIQUE KEY `account_id_2` (`account_id`,`username`,`email`,`phone_number`),
  ADD UNIQUE KEY `username` (`username`,`email`,`phone_number`);

ALTER TABLE `project_domain`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_id` (`account_id`,`main_domain`);

ALTER TABLE `system_reference`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `task_log`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `template`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_id` (`account_id`,`partner_id`,`name`);

ALTER TABLE `templates_field`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_id` (`account_id`,`partner_id`,`email`),
  ADD UNIQUE KEY `partner_id` (`partner_id`,`email`,`roles`) USING BTREE;

ALTER TABLE `usergroup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_id` (`account_id`,`partner_id`,`name`);

ALTER TABLE `vendor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendor_value` (`vendor_value`);

ALTER TABLE `vendor_credential`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `version_control`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_id` (`account_id`,`major_version`,`minor_version`,`patch_version`,`type`);

ALTER TABLE `workflow_status`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `activity_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `address_information`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `attributes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `attributes_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `audit_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `brand`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `cart`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `category_new`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `crm_activity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `crm_company`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `crm_deals`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `crm_leads`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `crm_status`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `custom_table_header`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `document`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `employeegroup`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `employee_master`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `flow_config`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `import_documents`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `invoice`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `location_city`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
ALTER TABLE `market_place`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `market_place_nav`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `model`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `notification`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `notification_template`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `notification_template_content`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `notification_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `one_time_password`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `order_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `order_track`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `partner_account`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `product`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `project_account`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `project_domain`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `system_reference`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `task_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `teams`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `template`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `templates_field`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `usergroup`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `vendor`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `vendor_credential`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `version_control`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `workflow_status`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `attributes`
  ADD CONSTRAINT `fk_attr_id` FOREIGN KEY (`attr_id`) REFERENCES `attributes_group` (`id`);

INSERT INTO `model` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'product', '2023-10-24 19:06:11', '2023-11-13 10:06:29'),
(2, 'user', '2023-10-24 19:06:11', '2023-11-13 10:06:29'),
(3, 'one_time_password', '2023-10-24 19:06:11', '2023-11-13 10:06:29');

INSERT INTO `notification_template` (`id`, `template_name`, `vendor_id`, `template_message`, `created_at`, `updated_at`, `attachment`, `subject`) VALUES
(1, 'create_account_admin', 1, '<!DOCTYPE html>\n<html>\n\n<head>\n    <title>Email Template</title>\n\n</head>\n\n<body style=\"\n      background: #f2f2f2;\n      font-family: Arial, sans-serif;\n      margin: 0;\n      padding: 0;\n      text-align: center;\n    \">\n    <!-- <div style=\"background: #fbea41; padding: 20px\">\n      <div\n        style=\"\n          background: #fff;\n          border-radius: 5px;\n          text-align: center;\n          padding: 20px;\n          width: 300px;\n          display: inline-block;\n        \"\n      >\n        <img\n          src=\"your-logo.png\"\n          alt=\"Company Logo\"\n          style=\"max-width: 100%; height: auto\"\n        />\n        \n      </div>\n    </div> -->\n    <div style=\"\n        background: #fff;\n        border-radius: 15px;\n        margin-top: 20px;\n        padding-top: 15px;\n        height: auto;\n        width: 500px;\n        margin:50px auto;\n        box-shadow: 0px 0px 20px 0px #e6e6e6;\n        position: relative;\n      \">\n        <p style=\"color: #333; font-size: 20px; margin: 10px 0\">{{company_name}}</p>\n        <h2>{{header}}</h2>\n        <img src=\"https://cdn.templates.unlayer.com/assets/1636450033923-19197947.png\" alt=\"Verify Email\"\n            style=\"display: block; margin: 0 auto; max-width: 50%; height: auto\" />\n\n        <p style=\"font-size: 1.1em; text-align: left; padding: 0px 25px\">{{greetings}} {{first_name}}</p>\n\n        <p style=\"margin-left: 20px; font-size: 15px; font-weight: 100\">\n            {{greetings_discription}}\n        </p>\n\n        <a href=\"{{email_verification_link}}\">\n            <button style=\"\n            background-color: {{primary_color}};\n            border-radius: 5%;\n            height: 40px;\n            width: 200px;\n            margin-top: 20px;\n            margin-bottom: 20px;\n          \">\n                <span style=\"color: #f2f2f2\">{{verify_button_text}}</span>\n            </button>\n        </a>\n        <p style=\"margin-left: 20px; font-size: 13px; text-align: left\">\n            {{footer}}\n        </p>\n        <div style=\"\n          background:{{primary_color}};\n          padding: 0 20px 10px 20px;\n          text-align: center;\n          margin-top: 20px;\n          height: 90px;\n          display: flex;\n          flex-direction: column;\n          justify-content: center;\n        \">\n            <h3 style=\"color: #f2f2f2; position: relative; margin-top: 20px\">\n                {{social_media_header}}\n                <span style=\"\n              border-bottom: 2px solid #f2f2f2;\n              width: 60%;\n              margin: 0 auto;\n              position: absolute;\n              bottom: -5px;\n              left: 0;\n              right: 0;\n            \"></span>\n            </h3>\n            \n        </div>\n\n        <div style=\"\n          background: {{secondary_color}};\n          height: 30px;\n          text-align: center;\n          display: flex;\n          align-items: center;\n          justify-content: center;\n        \">\n            <div style=\"color: #000; font-size: 10px\">&copy; {{year}} {{company_name}}</div>\n        </div>\n    </div>\n</body>\n\n</html>', '2023-10-24 19:29:33', '2024-01-08 14:08:52', '0', 'Hi {{first_name}} Password Creation Verification'),
(2, 'reset_account_admin', 1, '<!DOCTYPE html>\n<html>\n\n<head>\n    <title>Email Template</title>\n\n</head>\n\n<body style=\"\n      background: #f2f2f2;\n      font-family: Arial, sans-serif;\n      margin: 0;\n      padding: 0;\n      text-align: center;\n    \">\n    <!-- <div style=\"background: #fbea41; padding: 20px\">\n      <div\n        style=\"\n          background: #fff;\n          border-radius: 5px;\n          text-align: center;\n          padding: 20px;\n          width: 300px;\n          display: inline-block;\n        \"\n      >\n        <img\n          src=\"your-logo.png\"\n          alt=\"Company Logo\"\n          style=\"max-width: 100%; height: auto\"\n        />\n        \n      </div>\n    </div> -->\n    <div style=\"\n        background: #fff;\n        border-radius: 15px;\n        margin-top: 20px;\n        padding-top: 15px;\n        height: auto;\n        width: 500px;\n        margin:50px auto;\n        box-shadow: 0px 0px 20px 0px #e6e6e6;\n        position: relative;\n      \">\n        <p style=\"color: #333; font-size: 20px; margin: 10px 0\">{{company_name}}</p>\n        <h2>{{header}}</h2>\n        <img src=\"https://cdn.templates.unlayer.com/assets/1636450033923-19197947.png\" alt=\"Verify Email\"\n            style=\"display: block; margin: 0 auto; max-width: 50%; height: auto\" />\n\n        <p style=\"font-size: 1.1em; text-align: left; padding: 0px 25px\">{{greetings}} {{first_name}}</p>\n\n        <p style=\"margin-left: 20px; font-size: 15px; font-weight: 100\">\n            {{greetings_discription}}\n        </p>\n\n        <a href=\"{{email_verification_link}}\">\n            <button style=\"\n            background-color: {{primary_color}};\n            border-radius: 5%;\n            height: 40px;\n            width: 200px;\n            margin-top: 20px;\n            margin-bottom: 20px;\n          \">\n                <span style=\"color: #f2f2f2\">{{verify_button_text}}</span>\n            </button>\n        </a>\n        <p style=\"margin-left: 20px; font-size: 13px; text-align: left\">\n            {{footer}}\n        </p>\n        <div style=\"\n          background:{{primary_color}};\n          padding: 0 20px 10px 20px;\n          text-align: center;\n          margin-top: 20px;\n          height: 90px;\n          display: flex;\n          flex-direction: column;\n          justify-content: center;\n        \">\n            <h3 style=\"color: #f2f2f2; position: relative; margin-top: 20px\">\n                {{social_media_header}}\n                <span style=\"\n              border-bottom: 2px solid #f2f2f2;\n              width: 60%;\n              margin: 0 auto;\n              position: absolute;\n              bottom: -5px;\n              left: 0;\n              right: 0;\n            \"></span>\n            </h3>\n        </div>\n\n        <div style=\"\n          background: {{secondary_color}};\n          height: 30px;\n          text-align: center;\n          display: flex;\n          align-items: center;\n          justify-content: center;\n        \">\n            <div style=\"color: #000; font-size: 10px\">&copy; {{year}} {{company_name}}</div>\n        </div>\n    </div>\n</body>\n\n</html>', '2023-10-24 19:29:33', '2024-01-08 14:07:12', '0', 'Hi {{first_name}} Password Reset Verification'),
(3, 'reset_account_client', 1, '<!DOCTYPE html>\n<html>\n\n<head>\n    <title>Email Template</title>\n\n</head>\n\n<body style=\"\n      background: #f2f2f2;\n      font-family: Arial, sans-serif;\n      margin: 0;\n      padding: 0;\n      text-align: center;\n    \">\n    <!-- <div style=\"background: #fbea41; padding: 20px\">\n      <div\n        style=\"\n          background: #fff;\n          border-radius: 5px;\n          text-align: center;\n          padding: 20px;\n          width: 300px;\n          display: inline-block;\n        \"\n      >\n        <img\n          src=\"your-logo.png\"\n          alt=\"Company Logo\"\n          style=\"max-width: 100%; height: auto\"\n        />\n        \n      </div>\n    </div> -->\n    <div style=\"\n        background: #fff;\n        border-radius: 15px;\n        margin-top: 20px;\n        padding-top: 15px;\n        height: auto;\n        width: 500px;\n        margin:50px auto;\n        box-shadow: 0px 0px 20px 0px #e6e6e6;\n        position: relative;\n      \">\n        <p style=\"color: #333; font-size: 20px; margin: 10px 0\">{{company_name}}</p>\n        <h2>{{header}}</h2>\n        <img src=\"https://cdn.templates.unlayer.com/assets/1636450033923-19197947.png\" alt=\"Verify Email\"\n            style=\"display: block; margin: 0 auto; max-width: 50%; height: auto\" />\n\n        <p style=\"font-size: 1.1em; text-align: left; padding: 0px 25px\">{{greetings}} {{first_name}}</p>\n\n        <p style=\"margin-left: 20px; font-size: 15px; font-weight: 100\">\n            {{greetings_discription}}\n        </p>\n\n       <h2\n        style=\"\n          background: #181147;\n          margin: 0 auto;\n          width: max-content;\n          padding: 10px 10px;\n          color: #fff;\n          border-radius: 4px;\n        \"\n      >\n        {{otp}}\n      </h2>\n        <p style=\"margin-left: 20px; font-size: 13px; text-align: left\">\n            {{footer}}\n        </p>\n        <div style=\"\n          background:{{primary_color}};\n          padding: 0 20px 10px 20px;\n          text-align: center;\n          margin-top: 20px;\n          height: 90px;\n          display: flex;\n          flex-direction: column;\n          justify-content: center;\n        \">\n            <h3 style=\"color: #f2f2f2; position: relative; margin-top: 20px\">\n                {{social_media_header}}\n                <span style=\"\n              border-bottom: 2px solid #f2f2f2;\n              width: 60%;\n              margin: 0 auto;\n              position: absolute;\n              bottom: -5px;\n              left: 0;\n              right: 0;\n            \"></span>\n            </h3>\n            \n        </div>\n\n        <div style=\"\n          background: {{secondary_color}};\n          height: 30px;\n          text-align: center;\n          display: flex;\n          align-items: center;\n          justify-content: center;\n        \">\n            <div style=\"color: #000; font-size: 10px\">&copy; {{year}} {{company_name}}</div>\n        </div>\n    </div>\n</body>\n\n</html>', '2023-10-24 19:29:33', '2024-01-08 14:09:34', '0', 'Hi {{first_name}} Password Creation Verification'),
(4, 'create_account_client', 1, '<!DOCTYPE html>\n<html>\n\n<head>\n    <title>Email Template</title>\n\n</head>\n\n<body style=\"\n      background: #f2f2f2;\n      font-family: Arial, sans-serif;\n      margin: 0;\n      padding: 0;\n      text-align: center;\n    \">\n    <!-- <div style=\"background: #fbea41; padding: 20px\">\n      <div\n        style=\"\n          background: #fff;\n          border-radius: 5px;\n          text-align: center;\n          padding: 20px;\n          width: 300px;\n          display: inline-block;\n        \"\n      >\n        <img\n          src=\"your-logo.png\"\n          alt=\"Company Logo\"\n          style=\"max-width: 100%; height: auto\"\n        />\n        \n      </div>\n    </div> -->\n    <div style=\"\n        background: #fff;\n        border-radius: 15px;\n        margin-top: 20px;\n        padding-top: 15px;\n        height: auto;\n        width: 500px;\n        margin:50px auto;\n        box-shadow: 0px 0px 20px 0px #e6e6e6;\n        position: relative;\n      \">\n        <p style=\"color: #333; font-size: 20px; margin: 10px 0\">{{company_name}}</p>\n        <h2>{{header}}</h2>\n        <img src=\"https://cdn.templates.unlayer.com/assets/1636450033923-19197947.png\" alt=\"Verify Email\"\n            style=\"display: block; margin: 0 auto; max-width: 50%; height: auto\" />\n\n        <p style=\"font-size: 1.1em; text-align: left; padding: 0px 25px\">{{greetings}} {{first_name}}</p>\n\n        <p style=\"margin-left: 20px; font-size: 15px; font-weight: 100\">\n            {{greetings_discription}}\n        </p>\n\n       <h2\n        style=\"\n          background: #181147;\n          margin: 0 auto;\n          width: max-content;\n          padding: 10px 10px;\n          color: #fff;\n          border-radius: 4px;\n        \"\n      >\n        {{otp}}\n      </h2>\n        <p style=\"margin-left: 20px; font-size: 13px; text-align: left\">\n            {{footer}}\n        </p>\n        <div style=\"\n          background:{{primary_color}};\n          padding: 0 20px 10px 20px;\n          text-align: center;\n          margin-top: 20px;\n          height: 90px;\n          display: flex;\n          flex-direction: column;\n          justify-content: center;\n        \">\n            <h3 style=\"color: #f2f2f2; position: relative; margin-top: 20px\">\n                {{social_media_header}}\n                <span style=\"\n              border-bottom: 2px solid #f2f2f2;\n              width: 60%;\n              margin: 0 auto;\n              position: absolute;\n              bottom: -5px;\n              left: 0;\n              right: 0;\n            \"></span>\n            </h3>\n            \n        </div>\n\n        <div style=\"\n          background: {{secondary_color}};\n          height: 30px;\n          text-align: center;\n          display: flex;\n          align-items: center;\n          justify-content: center;\n        \">\n            <div style=\"color: #000; font-size: 10px\">&copy; {{year}} {{company_name}}</div>\n        </div>\n    </div>\n</body>\n\n</html>', '2023-10-24 19:29:33', '2024-01-08 14:10:01', '0', 'Hi {{first_name}} Password Reset Verification');

INSERT INTO `notification_type` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'email', '2023-10-24 19:35:03', '2023-11-13 10:06:29'),
(2, 'email', '2023-10-24 19:35:03', '2023-11-13 10:06:29'),
(3, 'email', '2023-10-24 19:35:03', '2023-11-13 10:06:29');

INSERT INTO `template` (`id`, `account_id`, `partner_id`, `name`, `type`, `is_active`, `is_deleted`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, NULL, '', 'PROD_CU', '1', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-23 11:14:23'),
(2, NULL, '', 'PROD_CAT', 'COSTING', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-23 20:18:24', '2023-12-18 05:48:20'),
(3, NULL, '', 'USR_CU', 'USR', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-23 20:18:24', '2023-12-18 05:48:20'),
(4, NULL, '', 'USR_PASS', 'USR', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-23 20:18:24', '2023-12-18 05:48:20'),
(5, NULL, '', 'USR_FILTER', 'USR', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-23 20:18:24', '2023-12-18 05:48:20'),
(6, NULL, '', 'PART_CU', 'PART', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-23 20:18:24', '2023-12-18 05:48:20'),
(7, NULL, '', 'PART_FILTER', 'PART', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-23 20:18:24', '2023-12-18 05:48:20'),
(8, NULL, '', 'USERGRP_CU', 'USERGRP', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-23 20:18:24', '2023-12-18 05:48:20'),
(9, NULL, '', 'USERGRP_FILTER', 'USERGRP', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-23 20:18:24', '2023-12-18 05:48:20'),
(10, NULL, '', 'PROD_ASSIGN_U', 'COSTING', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-29 16:57:03', '2023-12-18 05:48:20'),
(12, NULL, '', 'SERV_CU', '2', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-23 11:14:31'),
(13, NULL, '', 'PROD_FILTER', 'COSTING', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(14, NULL, '', 'SERV_FILTER', 'NON_COSTING', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(15, NULL, '', 'OSF_CU', 'FLOW', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(16, NULL, '', 'PFLOW_CU', 'FLOW', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(17, NULL, '', 'PFLOW_CONFIG', 'FLOW', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(18, NULL, '', 'BRAND_CU', 'CONFIG', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(19, NULL, '', 'ATTR_GRP_CU', 'CONFIG', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(20, NULL, '', 'ATTR_CU', 'CONFIG', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(21, NULL, '', 'EMPGRP_CU', 'EMPGRP', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-23 20:18:24', '2023-12-18 05:48:20'),
(22, NULL, '', 'PROD_ATTR_CU', 'PROD_ATTR', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-23 20:18:24', '2023-12-18 05:48:20'),
(44, NULL, '', 'USR_ADDRESS', 'USR', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-23 20:18:24', '2023-12-26 16:44:03'),
(45, NULL, '', 'CRM_LEADS_CU', '6', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-31 11:09:37'),
(47, NULL, '', 'CRM_CONTACT_CU', '6', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-31 11:09:37'),
(48, NULL, '', 'CRM_ACCOUNT_CU', '6', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-31 11:09:37'),
(49, NULL, '', 'CRM_DEALS_CU', '6', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-31 11:09:37'),
(50, NULL, '', 'CRM_STATUS_CU', '6', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-31 11:09:37'),
(51, NULL, '', 'CRM_ACTIVITY_CU', '6', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-31 11:09:37'),
(52, NULL, '', 'LEAD_GEN_FRM', 'ENQUIRY_FORM', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-31 11:09:37'),
(53, NULL, '', 'TEAMS', '3', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-31 11:09:37'),
(54, NULL, '', 'T&C_CONFIG', 'FLOW', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(56, NULL, '', 'ORDER', 'ORDER', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(57, NULL, '', 'ASSIGNTEAMS', 'ASSIGNTEAMS', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(58, NULL, '', 'INVOICE', 'INVOICE', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(59, NULL, '', 'ASSIGNMEMBER', 'ASSIGNMEMBER', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20'),
(60, NULL, '', 'TASK', 'TASK', 'Y', 'N', 'brand_admin@brand.com', 'brand_admin@brand.com', '2023-10-21 16:31:35', '2023-12-18 05:48:20');

INSERT INTO `vendor` (`id`, `type_id`, `vendor`, `description`, `created_at`, `updated_at`, `type_name`, `vendor_value`) VALUES
(1, 1, 'test', 'test', '2023-10-24 19:33:31', '2023-10-24 19:33:31', 'email', 'google_mail'),
(3, 1, 'test', 'test', '2023-10-24 19:33:31', '2023-10-24 19:33:31', 'email', 'webmail');