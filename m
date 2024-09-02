Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4619C55D
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287284; cv=none; b=TJpzkriflk2hNG4CNcktXXs/kUdFkLc8Qo14wmrY/RpuOWho5f0tHdC7Vb3YH8m0iJydsq+bXL1fnBOo21YDBP84tSMbDSOCfBp1wmXRx8bqr6ZybwRdiaMUsVP/SVM4Bj58ypi/ez4vJ9qfZTZarV8cU6ibzsqNsutj7tJqr2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287284; c=relaxed/simple;
	bh=pIR3vM/y29oNJ445O02kZeRZAQ3oVk6XvfNJdo5dza8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1UQ2JafyH0LXQaNR4cp1Q89csiMeHyZ3QlTT0h/LAljBs+dfQCcfuD5pg9L/0zFh4iI6MIForesKurfTgKal1uhjE6S2hYaFlCTOMZ3w+NYD0ghXbm/Ei3/ycor3cUrilqTTpzVTP1o/N98W1mmqF8H9t/1uxLqMQHpaWzfQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GbHi20SZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GbHi20SZ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a843bef98so434954866b.2
        for <linux-block@vger.kernel.org>; Mon, 02 Sep 2024 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725287280; x=1725892080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=GbHi20SZrlCyf/SM2xGP4MvO/qLwLMkveBjqhADUYBvlDjfLUK5E8KcDMOdtrkK2q0
         qkZVgN7A5Wmgd94PUnscu2567BFUtzA6syhB2ePG9XfmWBLLcG1lw8z1G8wgMw0Oafd5
         T6gx164JPfkmwUeGHT03CxRg035fra4hCGVBx1lXm7z511gld3FrNww/2YlSQnHo/X+4
         2Wmrpif/Jl3MT6W9VS22mMWOvYl6HqFERxlDS1hkIYZqMIdK34s5HC0eW7lO05KFMaXS
         c0FFws9p4tVBYH716HqwfmHgO9YK6YW0y8s2qenujYs87Tdr7DEBUDPBea42D3csQ9rk
         qOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287280; x=1725892080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSE07mevysGs4hIlAiWiKLrTdVKJ6Yd2deEW2FZkz/M=;
        b=kWWoj9+uBeHolGCZy/75dU4mOkfswWftI64jM6K+G+EjI2BkIaZE7YanGXrUybkmTf
         nepa+juf6YiBIyKYTaUIdCceM27+gNRJ07wnXTVU218Lk3kwBDafz5ommfx1tjkolu4V
         blZGb8/E6gcEZKNv7Fpq/aRAojd1S3KC3Ee5ycxYZaUfoJgdN2+QRJDzZjt0cPsVsv2m
         acgB8hDT6Q2jxLlJvrSBN0AfumBzBy2h9DSWsI4pEKpgBfV/H+4D5JyzTYkK5hWrC4JW
         PH1HASD/DT6WbfmJjno24i6/m+tPTaURKPE1k5maH2fSjcpWqOo3keOChkNmdFSc5TsE
         yELQ==
X-Forwarded-Encrypted: i=1; AJvYcCW756bqsdA8lvFIJOAL1Fb9G1fvv6/jQQLmrUVY5w7pWnDluU/QJUaS8OKBbdwxEFG0Uv98bee3I6W3cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwELCBGPHzZ+kfufod7poJn8WlERmghuyi755Hba6Dm/pz5kHw
	0ggOGs/CxbLGQq+Ze0M8r1Rv4FTMg6zU4SDVHyydmLLg1dOuTcEebUDU2hhzCr8=
X-Google-Smtp-Source: AGHT+IHzmM/02a8X0RvNaEpE3DTRzM83VRKSxFjouuZ9q9FeyTnRWM8bE3z6odD+9nYtgHRAaJIUnw==
X-Received: by 2002:a17:907:26c2:b0:a86:92a5:247a with SMTP id a640c23a62f3a-a89d8781d07mr538729566b.17.1725287279800;
        Mon, 02 Sep 2024 07:27:59 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a8989196bc4sm564753866b.125.2024.09.02.07.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:27:59 -0700 (PDT)
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
Subject: [PATCH v3 2/3] blktests: nvme/032: skip on non-PCI devices
Date: Mon,  2 Sep 2024 16:27:46 +0200
Message-ID: <20240902142748.65779-2-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902142748.65779-1-mwilck@suse.com>
References: <20240902142748.65779-1-mwilck@suse.com>
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

