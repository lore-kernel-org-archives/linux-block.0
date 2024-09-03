Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A1139ADD
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380994; cv=none; b=q0xmbg17O9GPjve5luf1+7Tj0CvRmLAqRmanT7rjHqid2VGT6El4Lvx9wRMyBI5W03OWviOS0Sz+CFcVGBPwwGBA3vy+HiiFfruNQvgaArHLKy6Yp0cd4pVtXdL9VHClQJ7lvid5IoGWvYE81lFk3sNY56o4LagUEvEm7EiSEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380994; c=relaxed/simple;
	bh=pIR3vM/y29oNJ445O02kZeRZAQ3oVk6XvfNJdo5dza8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQDqhRbzIaldVJ2n/igduaTd4jKnKx9/JzS/5YaOu0kf/YWZYKjA6COJukH0XskGubN+XSvGMFUSikYsgDMU6UYEr865t6kVnuMoh+yT99Uig9+a1yj5B/+ZxZs9k1iAt/NLeZAMKVrDO4KDypV/sMGnRZZg/sXPg8G9XXAPI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LDO/cvpf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LDO/cvpf"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so2232529a12.3
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725380991; x=1725985791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=LDO/cvpfRVwLDovkfrGIqy3eEUL4yCBOuiZa+MVdVEfjn4VQIKNjMvk2juZ4SkYJUO
         wJBwjymQbd7zD1hUoy01j3QB7fp/ty9LeJDWshpTD+mTny95qFBTxLVgm+eMf9nI942p
         ry2SPCIbiD2FXThI4C+kMdurpA6TjBTgQL5xgI1Oyzdm7NpZ/UEt5Sd1gqr5WkCpW5lO
         An39xd8XUbNIaqOSMB59T6cL6UYaCjkremRh+Ui1f86eR/TEGkitgKTSQK4uVEf91byU
         RbJCCFoJGwBA7dY4ebg+6S1/8/xNpzQnFpN6I6992GdxVfArTDA97nNyPWc1twuXmBju
         BPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380991; x=1725985791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=CZx9hYtnBCaGeeFthKJ+3BEivcOXH4utm1zHCigCxePOUluMaw+VVJQ+FLOYnhNBqF
         2Bj9JqgZ9h6/HcsL4H7RFI57WWBqE0TR72AcdAVrGAK7OTCpUwwIlWWEB2pbJ3AFAr1y
         7rMxLjOK5IplK2ZMxQXKdNdc++9wVpAQAcCvzGWplpIk96+0lFbAmZUsdw5o/n32/Wj4
         s20OjrngsPJNZ8F+KAkIZXT8n40OcPsmwy1goYPz9OwUhqDx8cxVvuCvGWwqH7Bj8GB1
         Q7GXOUISNLZfvD6ngdjEf4Oyxs7fhsSVK6k04dNiLePpwrsrURzMYYzIAy9x6xw8w7xB
         WQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCUR5GSFrQlShSDzEzx3aifyVLR7L4ihwOQMC7T7pixMJjVzNJ58Y1NNkryNgHmCUx/iO9zPAZMNQg6AzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhoKtYTADdA97qXdJsReitRD0FBuJBUzLs1D6RS0t2Ewiu9orC
	xHfQ8kJaGjdiryIdwrOD4CVGkJ0yRQ7S22RP6Wyz+o0sM3tTt2caT0+IUlsEwgc=
X-Google-Smtp-Source: AGHT+IHtUoACfXNZ0W0C+bZ5247zZGeTkQsGperLhXX0DXaaUPvoiZyijPDr90lFDqYaGmMUUYdyBw==
X-Received: by 2002:a17:907:1c03:b0:a7a:b561:3575 with SMTP id a640c23a62f3a-a89fafab356mr646544266b.56.1725380990545;
        Tue, 03 Sep 2024 09:29:50 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a8989221df2sm693736566b.203.2024.09.03.09.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 09:29:50 -0700 (PDT)
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
Subject: [PATCH v4 2/3] blktests: nvme/032: skip on non-PCI devices
Date: Tue,  3 Sep 2024 18:29:29 +0200
Message-ID: <20240903162930.165018-2-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903162930.165018-1-mwilck@suse.com>
References: <20240903162930.165018-1-mwilck@suse.com>
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
index 5c554b6..b702a57 100644
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
 _require_test_dev_is_not_nvme_multipath() {
 	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ /nvme-subsystem/ ]]; then
 		SKIP_REASONS+=("$TEST_DEV is a NVMe multipath device")
-- 
2.46.0

