Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2AC19E977
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287283; cv=none; b=CXjp6+MQ1fBdLapgqHZdqQmQKMQS5RuM6M+nsQi0Bl299BCdUvkYwIbRkEaJvw8vBorod3ZOpXKTA47IyZIq4ufKXkfgp8ZBwaJCzlJ3IN8v5l/BmghzYVzwtP1og3BTdnrJoX+TqXwNy7Qk118Obs895sL5Fz4OhdgMKLmaH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287283; c=relaxed/simple;
	bh=Sd5w9XFTXjbRiMlg7X607pJX0T7w9hnXfb2ERWW712A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eadehOCKaSBf7gtWZL6SHrCaHvLdm7EdB/IKIPX9K7Jz3JA8MwEJtFO7wrGJ5I5g2nohj3csd+NTyYApm73n+h9AUmtRoNHmq2XOQ7Te+BXL2hsIAfJFUpr5i8RyOkgBCSgFjRZLRMKa9WFEvMi3jU2eASVvhDQIgS4Oxntn508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VIirKn7I; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VIirKn7I"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a16c53d3cso56290066b.1
        for <linux-block@vger.kernel.org>; Mon, 02 Sep 2024 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725287279; x=1725892079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQqPVXsmN3ETPXhJs4cjYSNwhZKHftRjyjECFeKlbuo=;
        b=VIirKn7IUw3TJ9BuunCcOGT8gWIbl5yAFarLCnkbtkaQ8YR4W0QsLNJsZiHXcbE0ON
         ZLwg8Pxjm9OlXxiL033mEWo233HR5Vf+B9WeW05letxtJxueJUgz2klJbSbZ39LGkLtX
         X12oMCLC40CvJ1cIVdv0ASnQedlt6jqAuRl+0MZipHTIDaN5dlfcEEY3LWn5+sIdTtUT
         AHASA6P3iY1PPAupd6sYxvLJfiDMjC/pkem+WuNYSLemQARGHhlU9zLTwZGIuScZ0p+g
         bUN4sTPePhochLMS5TDgTIQ9wppHFhGn9CPQX+KimyAFXjXlwnqmw2udnLD2tlh3QPPT
         E/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287279; x=1725892079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQqPVXsmN3ETPXhJs4cjYSNwhZKHftRjyjECFeKlbuo=;
        b=qXybh//IU0w/Bw6RakKvI50nEStV8B3TtqU8kElBn5Eg99PC64fODsfey66COGlzgq
         GPDpTwTJVE6PNgfP+X/ORoGj6AWjt/UJsu3PapcqM5P8Lc0dwZWSWg46U23P1y2MWvJ+
         4nAFMUr9f5j24k/2W9S4Nn/M5ppe6NxvtE35jr6REA0Dyu76mnVIleoDJcjJJ6MSqic2
         uqLV+vuNUxtvhRarUdc0rBIrBeqi9DHJHNTtqvDkf8dFk6cEgWSRVO/HyQHAsub6KihD
         tmu37905harywmkMKfvrBB0wE1nZB7IbPkOz3q9L7RM33f8B/PayjA/ipV7Vgteqk2VE
         09+A==
X-Forwarded-Encrypted: i=1; AJvYcCXk07NcoYXUHJhfpML0FSn56Q9nogDbVcyuIcqBmPbanIFKzWXicgzjFB832wcW6WulwX8GlK+o4yqA/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+l4yJi/ypAQNg9DniZLt/gSv4cBEHHU9pc8n32rjikzjFKRE
	9M7HOyn4F3nX423QZP4bM4xFUMQa0ZKRAIKQ9VpGwsQgXg+Hfh5OclcG47MJDvI=
X-Google-Smtp-Source: AGHT+IFwU1bw/XpVW9MjXzWxGVdxxDsb7XOeZDUlCoaSOFEdDqvAv7ft1RhGTlzuaVlVoB1lmeR00A==
X-Received: by 2002:a17:907:da2:b0:a7d:e857:1490 with SMTP id a640c23a62f3a-a897f8d51dcmr1054688466b.37.1725287278630;
        Mon, 02 Sep 2024 07:27:58 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a8989022a69sm562225966b.87.2024.09.02.07.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:27:58 -0700 (PDT)
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
Subject: [PATCH v3 1/3] blktests: nvme/{033-037,039}: skip passthru tests on multipath devices
Date: Mon,  2 Sep 2024 16:27:45 +0200
Message-ID: <20240902142748.65779-1-mwilck@suse.com>
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
v3: improve patch subject (Shinichiro Kawasaki)
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

