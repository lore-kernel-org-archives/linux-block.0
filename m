Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B428EA
	for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724355522; cv=none; b=CE4SJFUJRXXEAP0qNOTN2OD5m1krRGJ5sSqed5d3RyiB0aj+/qvxslXzR5MZSh2aLIAPfKgFUR2sF17SMA4pF47PiyUaofBsd4uZSSk/Yl7ASEHP6k/gwNvF0A7Z7FNJzN1hL9tZdFnh5mGu1LZucH/W0kddJVAvte8hlHLXs1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724355522; c=relaxed/simple;
	bh=tyCKfu/4aJCufmoPcvrqRjgeK45lNgAoIhFwd7hYEng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAoZO2EgSkj8qyl4i/XNpTLH7O1A0slSFEvX/qtcrW4o7pqAmF5BD9tE74t7zCDv65TpSQRPVxMCgMc0VDdIEK2M3dNaq7J+qmRP2SxrqeHETncqw6A0K58XZyTnjJXAXa7kUqrnybUeP63kF97FpwvtYzZnxP2FPH2SxdYRIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SMNoJGdK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SMNoJGdK"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b3so1756715a12.0
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724355518; x=1724960318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9cnv+MdXwy4zAHoFrkb8mhAg31ASXI3YdjEyMyWEjg=;
        b=SMNoJGdKrjslooSIcDcztDFKWUo5p1C8Mg6GEkdj4XtbuGsIy7Jrtrfyr8Lw6QBJua
         v7X+pJ8FBau+kAAbOJ+3mYyVhlqDtNdyaLJAf4EoY5wrCNOGfsz2iS8EkJfTIZImTQ1E
         C1h926U4bV1LgS4cSOAclJAZuR98vm0CYUHmYFv1KzJ7vVDTaQC/0rgB7lg03zrZXpCX
         HpVu93xYcs3y126zwPwZmks54VS5oIcMVikwfq1zGq0WOsV0H0gegjxQeWkyNQ+WvsvZ
         nN3gagfPCPjd2l/f3tzfR/JqrBRIFcPsDQ8B6KzeIdnRqZ4Jrsi4RCHkkjW3yGlem4mS
         Wz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724355518; x=1724960318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9cnv+MdXwy4zAHoFrkb8mhAg31ASXI3YdjEyMyWEjg=;
        b=BjBhg3uazke32pwTVM5xMIR5NTOMj/ORkLKRYuuEAtJ2xc6VekbAa3ilaXjwQ66I+6
         p6AtCsRuimbKZcBSR6Qt4sv6CaLkMgzui5ZGSTkLtwk0xJoybYX4VIHea1sMvz+Kvy4r
         cJlhz/sI+sH+vp5QHR6/lXVZArI5pUIA+XXCJc+cB9x1VucLNMo6QGZJLj8qyK+EA0GN
         a1e2VfZEOus9ud9AqnHouLfJnqk0RwrnrF8clka3acwmjAq5HEi55/VPXVrhe3WA5/tY
         pviltxoFALS6vP2Bw0MOFxjCrOlmgRsTYEvny6n21EnvzkZRKGOsTFk8YmYsf+OD2pbl
         75XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUClc9grPDBCsRN9VG+A+2cV6imOndZzKOg+w830Y5y0GWYAUQ0ZnEShop2MImXvxe5JM4BsRGhsBQMkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3hHZwKMucB1BzrfsEamd7FUXMmVWnpu6IrU1to+b2V8uLnby
	bj3V4SnQTQsdettybkkvyTNQXzMuT151AxgnvY8b46XCZ9uBJCWqP/zWvr+/F0E=
X-Google-Smtp-Source: AGHT+IH9qlKGYHZCb4YNYmE00kgmI8xojuOxfpDY7bV3fdw2VD8FzFJOuPsUodin3Se8Inlu8aJP4Q==
X-Received: by 2002:a17:907:7251:b0:a86:993a:93db with SMTP id a640c23a62f3a-a86993adc45mr136738766b.39.1724355518045;
        Thu, 22 Aug 2024 12:38:38 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a868f2202fdsm156968666b.13.2024.08.22.12.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 12:38:37 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH 1/3] blktests: nvme: skip passthru tests on multipath devices
Date: Thu, 22 Aug 2024 21:38:12 +0200
Message-ID: <20240822193814.106111-1-mwilck@suse.com>
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
 tests/nvme/033 | 4 ++++
 tests/nvme/034 | 4 ++++
 tests/nvme/035 | 1 +
 tests/nvme/036 | 4 ++++
 tests/nvme/037 | 4 ++++
 tests/nvme/039 | 4 ++++
 tests/nvme/rc  | 8 ++++++++
 7 files changed, 29 insertions(+)

diff --git a/tests/nvme/033 b/tests/nvme/033
index 7a69b94..dda0763 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -13,6 +13,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_nvme_no_mpath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/034 b/tests/nvme/034
index 239757c..41f1542 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -14,6 +14,10 @@ requires() {
 	_have_fio
 }
 
+device_requires() {
+	_require_test_dev_is_nvme_no_mpath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/035 b/tests/nvme/035
index 8286178..4357efa 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -17,6 +17,7 @@ requires() {
 }
 
 device_requires() {
+	_require_test_dev_is_nvme_no_mpath
 	_require_test_dev_size "${NVME_IMG_SIZE}"
 }
 
diff --git a/tests/nvme/036 b/tests/nvme/036
index ef6c29d..3a28cb7 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -13,6 +13,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_nvme_no_mpath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/037 b/tests/nvme/037
index ef7ac59..557d491 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -12,6 +12,10 @@ requires() {
 	_have_kernel_option NVME_TARGET_PASSTHRU
 }
 
+device_requires() {
+	_require_test_dev_is_nvme_no_mpath
+}
+
 set_conditions() {
 	_set_nvme_trtype "$@"
 }
diff --git a/tests/nvme/039 b/tests/nvme/039
index a0f135c..ff8c1eb 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -18,6 +18,10 @@ requires() {
 	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
 }
 
+device_requires() {
+	_require_test_dev_is_nvme_no_mpath
+}
+
 # Get the last dmesg lines as many as specified. Exclude the lines to indicate
 # suppression by rate limit.
 last_dmesg()
diff --git a/tests/nvme/rc b/tests/nvme/rc
index dedc412..b3b1149 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -130,6 +130,14 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_test_dev_is_nvme_no_mpath() {
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

