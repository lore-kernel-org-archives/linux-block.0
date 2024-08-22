Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91B1474D3
	for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724355524; cv=none; b=EqZUxI8UUfFClJlls7Aml4tyIHmIsrCblO800WHJXRYafUaVMWm7jEEH+a2MNFSM0al6T0LCASCMV7ggz7j31/i88EI6DcsmO1JnvElMKpRguimkxB5cxc3dJU6AfVxT9J7RZK0DECCwSNwrUVUK6Bo/PEfLDoaNjM8l1P93xrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724355524; c=relaxed/simple;
	bh=3QgRViehynAhzu12q3fRCWz17v++8mYnVtz86i/+WK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdLd1x8sErQBavFZBZy/DrGCOrznhly6zw47nDtsLFa/umFKXsAGHEmhvUkcpo0auyUOtK/DHh9548o7CnXyf3tjFTGaWh/XW4GlDVpy011DaQkBl77V44vwQ+lq7kzxqDByqmrU3ufvqTgEp5BimH5ToJskpeUXJrmX+gfiXkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C0ZoN5Fi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C0ZoN5Fi"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bef4d9e7f8so1670380a12.2
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2024 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724355520; x=1724960320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrI6YvPwrcq19wxadBi4aL0IQgdlikB2v8gTv3oD1Yg=;
        b=C0ZoN5FidJ71cJM/9TiRBncJ4wm2Ox8rVfatmVfu5eJomwBlSayT+y/BqOw+Na0egy
         NzCQ+fKdgvzL03yy2slsxbSsWHI3HcjbkhihrIp984oMDNpAaQ8VqYC5UWYTbgpmDZsR
         ND0yD8d43WQaJzhqJE7sZWysC975FkuL1kBAFbHjOPMYjTnny7ERngmK+nehLMETfrj9
         l3BFoZruDWZjoQa8UGGKFQyu0LYrf14iuEZulodCt2dpY0uFPQuy74d59QpReZvuAPJu
         7LUBofksAQHsTtqngVVR7ISSFBfyvQL5RBIuROzf8QQNlcawCtcM90un/aB11yrjMDzt
         2itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724355520; x=1724960320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrI6YvPwrcq19wxadBi4aL0IQgdlikB2v8gTv3oD1Yg=;
        b=C/wkfh/nJIftej36IN9hbB6H6jioXLfu6lzaDmXMDqCYOIk3NHADwJpIFA+anQRrhm
         TBJC620loqci4kOw5DCQrr+9dN/Cm8o263CzGN9uqaYm1FRN+w5y1uSz4wNRD5VrkDG1
         LHFnZmCZzsRh/zGadVsryZrcqXQTxVl+Ecg23y3gvQ0f/KoA6xMbPWmR2Ol346Sy8J2s
         cPPb/vNJJiIr2Ug23/vEDgPOIH7sWEQln+DGzfL8eDbpQu5vyAtxzwPseM1u9ZXdma3+
         004D/EPlNf+PcZunYmLdRLhpz2Nkgq8bng5zZ1irNW9pn8cdVOXkjMq11bYSL3/+DrMr
         ivyw==
X-Forwarded-Encrypted: i=1; AJvYcCU7GCJJZSPvYgHnQ9YMiC/209DkWy3N0DlzMix1vZtcHiifLvIS64VYjaAq9zFBosXPMNbGuQebO94Vag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzZKV2ozg21hn7md4reUs4opeVUoojje5okXrtkStiFtcB2TB
	nulG+pA0eOretTbthI1BE07bj63wym6aMhVP43odrTP/2DyX9nVqSPTWrhRhWYg=
X-Google-Smtp-Source: AGHT+IGzlmYJLVymI/kyifxveNK/LfgQ+Xnjpvu8Tjcs/wSWITIV+fhUxqMJXvR2teMx2nC851dxiA==
X-Received: by 2002:a05:6402:2743:b0:5be:ec27:f304 with SMTP id 4fb4d7f45d1cf-5bf1f0dcafemr4222212a12.15.1724355519317;
        Thu, 22 Aug 2024 12:38:39 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5c04a4ca7fbsm1218344a12.67.2024.08.22.12.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 12:38:39 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH 2/3] blktests: nvme/032: skip on non-PCI devices
Date: Thu, 22 Aug 2024 21:38:13 +0200
Message-ID: <20240822193814.106111-2-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822193814.106111-1-mwilck@suse.com>
References: <20240822193814.106111-1-mwilck@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme/032 is a PCI-specific test.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 tests/nvme/032 | 2 +-
 tests/nvme/rc  | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/032 b/tests/nvme/032
index 5353e96..512d7ea 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -24,7 +24,7 @@ requires() {
 }
 
 device_requires() {
-	_require_test_dev_is_nvme
+	_require_test_dev_is_nvme_pci
 }
 
 test_device() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index b3b1149..e7d2ab1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -130,6 +130,14 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_test_dev_is_nvme_pci() {
+	if [[ ! "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ devices/pci ]]; then
+		SKIP_REASONS+=("$TEST_DEV is not a PCI NVMe device")
+		return 1
+	fi
+	return 0
+}
+
 _require_test_dev_is_nvme_no_mpath() {
 	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ /nvme-subsystem/ ]]; then
 		SKIP_REASONS+=("$TEST_DEV is a NVMe multipath device")
-- 
2.46.0

