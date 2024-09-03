Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78C18890E
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380993; cv=none; b=k2pMC8RikkS2u3Bt+F1DCoIZUerO8Gd/2xNF7x+2Lwk1OJ5nhbnXMWTH8TN7sjMZiJQgZnljZ7c0OfBGJcFoGPjez7X7TSCGAzcs9IOl6zz/otFaucX8zA/ktdJ1bwt9giIX7Z2O2KaZ5cVdYuNNiSH2WU8HDGNT+18vzGmRL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380993; c=relaxed/simple;
	bh=Sd5w9XFTXjbRiMlg7X607pJX0T7w9hnXfb2ERWW712A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nf4KlfNELvakoi+kAD9T/nqNG7nVm/SacqOPbbow81xgzn4ndQQY0yPRhC3d++mRBR5hggqZkWdSXwmP1ijARo18bhr6EfklSJQLU099+DUVNpu9jyZsE+1925G9oFnPj9WnyiRIBHTp7BoMsHFamCGWl+4iFCl+hkMc/VglU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SCbPwTT+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SCbPwTT+"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so5193931a12.3
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725380990; x=1725985790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQqPVXsmN3ETPXhJs4cjYSNwhZKHftRjyjECFeKlbuo=;
        b=SCbPwTT+q02PXaG2d5BkAdnoHh/o+Hx9UUYWZZg0kVml8eOW6xgRSvkp5mIXvarAs2
         eiLiSP7nmdwO0nCw7sTI0iYOzm9H+qoAPebzjvp6PDIZf5iiPMkcxXc2X5F8G37kR9eE
         oOctenKgHWoJWYVOoWlKrkXIqpHVcWZNvLJrblzrrYL8lL/VgoG4/9oyBDRuikvk3eT5
         cdCxWc9A0x7DNf/4WGMDOWd7nMxQCz2wXXBDn1ZgIjY51Uw9uWBDQwHQp5wAigURavSk
         APQjbWAl+Tox944eTUh72rtpM2GUqq6y9J7SadOfuYhAOWEfoKN8QqwR9oOOWe9Ckk/V
         YfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380990; x=1725985790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQqPVXsmN3ETPXhJs4cjYSNwhZKHftRjyjECFeKlbuo=;
        b=wd1LIPJVNd8l4YEy0UyeAt3H12PQyNkoEel/u4PHHE3KvM3kRTYkdkgrdFBWpFvaRS
         hxl+ckCH0Uz9P/J4/m50X04CL6CiVfCXrUyRHfiGItD93nI1dDoYn/tXqgnhHRW+zo39
         qjPn0Eb29fAKftb5bxI667Lo30Tuz1YWz3blhZGhrS1ylOOlZDlhrUk0wu27qDjHG1Co
         dH1G6wv1JsccMPhXWul1l0j80kS/piK6EuPl2OyeuwXtdDvL8F3pKFTu8S4kh/fdabqO
         Rg2nAaqtPWzvLcb3RapYQkV3ipWnrBu7HDnTfZxqIappPgU1N6stlRFQh1pjG5SLBwqP
         Xi1w==
X-Forwarded-Encrypted: i=1; AJvYcCUx6t0piQ8U49lej8f9Gu7WseEzH38I2aIF6FVaJ9L7eAzDjkWjEgXc6p9D3T8pPPIHTBamACuKbMoO5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83ZCw7XDQQDgysveKZFiv/Xbelf+xuj5RwzAM7XFWG4qcFnyc
	YKIBXJWBeYsr2EuPTr5yaq8DfZFRLqBTi7/riwtErsaU+bOXhiIGhWWjlbVDjb8=
X-Google-Smtp-Source: AGHT+IH7yYKLPVeQag7fEGv6/SszKPesauA8u1JjO4CePX3FkM/7vdP8YQ5ERcROMsGS34x+/fJVDw==
X-Received: by 2002:a17:907:72d3:b0:a88:a48d:2b9a with SMTP id a640c23a62f3a-a897fa74459mr1319001366b.52.1725380989485;
        Tue, 03 Sep 2024 09:29:49 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a898922259esm701051966b.209.2024.09.03.09.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 09:29:49 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v4 1/3] blktests: nvme/{033-037,039}: skip passthru tests on multipath devices
Date: Tue,  3 Sep 2024 18:29:28 +0200
Message-ID: <20240903162930.165018-1-mwilck@suse.com>
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

