Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83FE19ABC3
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443739; cv=none; b=AuK/KMYaw8ukPztrIDyikCm2fv/+/jAx2HH8/vtg08scbW6w4S7hXjDeJruFvfh8qhnBMX/8lNGWEZbJZQwtqc7bZajJJTF9EW9eF3O5XvZZXLfXycrNtQmMhOqvCR1P+b/g4INSbWOKA9kn0FEPljVhFuffoosLsgSaDcKbM7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443739; c=relaxed/simple;
	bh=45XeCPqSyhha1d4LtUIwkcsRgdvQToqkr6aacoN15h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S++AFyRtvh+3yI7QRSGEeWvuN8it+h9oNxR0+mY4m2+MVKvid1BoBvBhc+ynYhQee6XlOMOZ6w+lWbIY7YQYDPDIdLMWvU5NXkIsNbRL2j+awiKs+mngy1qENqENkqNBHUY9CxlYmSfKQa5dzE/Ly857uI1YPFIvz02l9DEXKdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fpRce9aa; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fpRce9aa"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a2so1504228a12.1
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724443735; x=1725048535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3Vv04OoDmGvCyY5JEu/XjI0RpiXwnV7QLorDDNwgdQ=;
        b=fpRce9aa3KsGyH/1s08kM7lr9PGYeZe2RID6YEQL1ydCh/DdhBtskMPv6Dj+K0vQCv
         GzWJrMSH0t4I2a9bt0wM7zGluGZA+Qm1UFwjjwjVRyy9ymyB+M54EkPUva0k49GWuEae
         OV3ZtJhEJV6tlBGBTp5qme0B2ljleKRPPLEaN+YsoxICOB6RNGlxhkJqu42HW7qMS+zL
         zkLH22U4R0M/FpbJeutfDuxvK2RJrTZob+QlEZCpkcIeZ8veT2GaX5ect4IDIPcOQdxR
         knJNfx2XW3gx+5aG1uyrshz4bezqG8BTr2cuDWR3FgUVLOBhC35e2rQFL9+PG5RA9Y+g
         Uylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443735; x=1725048535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3Vv04OoDmGvCyY5JEu/XjI0RpiXwnV7QLorDDNwgdQ=;
        b=PXwE+HgEsyaWRe3dWKd75YF8O7BV1AzIdya/C1XDlh1wMR++t7jfR21dHEOM5iSemV
         BpgZuPn4ZMRJUgD2lh/ZOBAVBLiDVIc2I8aHsNoK/+bzt+11GgHp7dv7InkyxPYHLAWV
         Xcx0Atjtdz4brp/5RUCVmq8B8VjjXhMzmDhoxvAbY3VM2XVk9PbUhr5fM0GS42GUScR5
         5NAj+BdK5V00u+fFMQb9zvnJ9zx5cGt/cWyEygRdZ6am96s2QkDg5JrszW7z3USKBpg9
         fa4PyiVH4x4DUaT61VqwToWvcxqCySGKDueE5wpUBN9iFBh27YNvz4TGg7OrRS1N8s6Z
         68dg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ508tUaJZNkrG7X/M7M293BC9x5PKSh+gf+HpqEDKKiy2zQggeCq6Qtm1AbchpQrLsr0qS4SaOV+v4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe2ldRUC1O+eBeonQ+SbnpdjefnEam0k1nd7XR36QF/0HDwiw2
	yuxUv6WZEOy7ZqF4+/sDdByO1QLLgUeaiNMhOu5i9JeITTEMSK1Yf5TjgL/IF+w=
X-Google-Smtp-Source: AGHT+IGClPfTCHc7n+m5CdeWaJky+vTETP0m9NfS+oQScewpdaxHfr5SPi59VdpVqXT26F9sE1p9uw==
X-Received: by 2002:a05:6402:4312:b0:5a2:c1b1:4d3 with SMTP id 4fb4d7f45d1cf-5c0891a8227mr3088448a12.28.1724443734496;
        Fri, 23 Aug 2024 13:08:54 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5c04a3c8615sm2520618a12.23.2024.08.23.13.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 13:08:54 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 1/3] blktests: nvme: skip passthru tests on multipath devices
Date: Fri, 23 Aug 2024 22:08:19 +0200
Message-ID: <20240823200822.129867-1-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NVMe multipath devices have no associated character device that
can be used for NVMe passtrhu. Skip them.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
v2: used more expressive function name for non-multipath test (Daniel Wagner)

---
 tests/nvme/033 | 4 ++++
 tests/nvme/034 | 4 ++++
 tests/nvme/035 | 1 +
 tests/nvme/036 | 4 ++++
 tests/nvme/037 | 4 ++++
 tests/nvme/039 | 4 ++++
 tests/nvme/rc  | 8 ++++++++
 7 files changed, 29 insertions(+)

diff --git a/tests/nvme/033 b/tests/nvme/033
index 7a69b94..5e05175 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -13,6 +13,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_not_nvme_multipath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/034 b/tests/nvme/034
index 239757c..154fc91 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -14,6 +14,10 @@ requires() {
 	_have_fio
 }
 
+device_requires() {
+	_require_test_dev_is_not_nvme_multipath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/035 b/tests/nvme/035
index 8286178..ff217d6 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -17,6 +17,7 @@ requires() {
 }
 
 device_requires() {
+	_require_test_dev_is_not_nvme_multipath
 	_require_test_dev_size "${NVME_IMG_SIZE}"
 }
 
diff --git a/tests/nvme/036 b/tests/nvme/036
index ef6c29d..442ffe7 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -13,6 +13,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_not_nvme_multipath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/037 b/tests/nvme/037
index ef7ac59..f7ddc2d 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -12,6 +12,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_not_nvme_multipath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/039 b/tests/nvme/039
index a0f135c..e8020a7 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -18,6 +18,10 @@ requires() {
 	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
 }
 
+device_requires() {
+	_require_test_dev_is_not_nvme_multipath
+}
+
 # Get the last dmesg lines as many as specified. Exclude the lines to indicate
 # suppression by rate limit.
 last_dmesg()
diff --git a/tests/nvme/rc b/tests/nvme/rc
index dedc412..5c554b6 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -130,6 +130,14 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_test_dev_is_not_nvme_multipath() {
+	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ /nvme-subsystem/ ]]; then
+		SKIP_REASONS+=("$TEST_DEV is a NVMe multipath device")
+		return 1
+	fi
+	return 0
+}
+
 _require_nvme_test_img_size() {
 	local require_sz_mb
 	local nvme_img_size_mb
-- 
2.46.0

