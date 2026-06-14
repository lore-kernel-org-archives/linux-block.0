Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5739A73463
	for <linux-block@vger.kernel.org>; Sun, 14 Jun 2026 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781461333; cv=none; b=GgWgLzSMi4U6uZ84oIqtRuDvy8rGA/VZb8Xx4NA50krKaboRvDtikXuLPCBELXcbqOFyCt5+SQaGQKjogqSNfF8PvHOTAnjg29lRUcV03zPSC2TsKPsD2Y9jm5rzmo0nwzrU5eI5NQDd3H1Kxo+b2ApT6AapAD/U7BWQbRpXV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781461333; c=relaxed/simple;
	bh=jsFcSuYhKuimo076fmVmCBphWTenG/t/L8YXbQit3FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpLcR1K4lDvcLrwG0MvUp0JuyW0VaU7X1SbxHkmrTtuBNyNdoj02vteMrZwItlUX/62FiJduHawruUJaTtnj1ttvqnNRStZv0hquCeZx3YW6RdjKnOhfGq7GEnw1V53CaaA+cGO7bmJu8WOWOZVIWA2J0/G03XvrilWVVBVvgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeUogzBa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeUogzBa"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490be03d47bso26681655e9.0
        for <linux-block@vger.kernel.org>; Sun, 14 Jun 2026 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781461331; x=1782066131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFqh8nYKunPUCxIlPP7QZI2Gqt8nZL3xpDznYcWZpgk=;
        b=PeUogzBaKFX2qkwSj8mIaTPivJcpNevxhdZwXTKDnmZtFRO6Jvv3O3E5zpzyeDj/vH
         peF2axJjt6JOWsDPFrowPz4cHcZWQOeIGgmNrA+qoqbvOKo3AHjKWbH6rtSFVtD1gmkX
         HfqXzxxA+oj4v072YQ1lwROqQPdjCQhVNQdlbMweNY14Ea1w/U2KJSWqI+royVcLJdG5
         oosDmJuCKAXD32YCrm+dHhooNzsKpdu2cq0ZBuNyjLlmJiNQx5cO1r5aSZ+rjGrkIkTb
         Hm1XlxFiSZ8rYEsjowGiiv1ZRoJtT+ooBsis48505QSdbcm/HV3BpKQO7NIHfz7zDWsP
         IL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781461331; x=1782066131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFqh8nYKunPUCxIlPP7QZI2Gqt8nZL3xpDznYcWZpgk=;
        b=p9Xnl2Yu3Fl3K8imhYWKlJ8ZYaRMi25A03OAaeKhDcXCfbu42bgcWpMwDzUdlqX1ya
         BUkblLfAWgi5cY3Jt4eVaBlGEhzrRtfs5S95Pcu58Dxw2ogbPmcuV06ts1vgzo9hZVTp
         HJ+X6W++STCvgDmp7XYVp4hr/F8LEEouyW8CbX5fIPyAIyMgrZc3EIlJ5I2AOp2fFqg/
         oNjMao5ZMML++qXFp1EzvMvYqpB9n+GSvPWHT+5Ng6hOWTj01bRRG0xEEFQeYIsdtgrZ
         LyWvPUeL0vrAVr7Xz8n/IlZkXa9LD0za8OPaRlwKSe4BXcMK8m5DhgiFPixoILlX76VZ
         /08g==
X-Forwarded-Encrypted: i=1; AFNElJ8iB6AxdONxtTU4CMHusXZraRYHfv8qDIF+AW8SrzircCUb4RoJ9rUbkEdv9xK6CD7meTg8bXJ3Kgwo6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAcKFgmjYMMqEvuPapf4WywQ+jNFxiGskFuR6T/Ip3nXyxGWt2
	ec9oVIqEE/lvEk4JCRcCbYyBx46LKLI/uRLSmfQxDw5c5Dh1ORapvr7TBI9znQ==
X-Gm-Gg: Acq92OEOZ1c3gi+Fm4K9GIs3fjGTQ0uS20Dtd7Zp1FD1PEWCeZI3gWdVEq5VOVsipXL
	2zp+cNVCbHKElrVrz/NGR9g/608tmVk5o6evE3CiVPu7pIGMbSaL9OlbBI7xYnvHeIYIdrC3AOw
	wnvzK4El9uc/iSeZ4PCIDbFi6AQ0hESt33+XTsYvRo3Iz9fbaMvpgaJUcWP+nrrXSXPR+rv7GKL
	Mi96529foPGsB/WAQC+ctHuuKvIQ7BhiAYc9AFnMY0UqOrSuP3GfxpJneRPke7W8McaZGoXwMsb
	V+digFA/ajABWP82Uxa8roArC6r9o4g5V3+YK8fhM2InYgzBU922RG1XaP0V65eYnrvLt/yj53U
	ZX6D6JD3/zE9dIiXg4QeRUs3I74kvEy1c0SmBC2KkvAShSaSkeCV/DuoBJxR6hHFKgso8AWaJSw
	I+s4ROYyp3hBxRMOzt7ZPnzaZOdr1XtpEPtkpAQ466dQJaAnZhcF2ujJ46TOpKu05QiDgRfTtIS
	HRXTAXGhuTMJado2i48Yx2m
X-Received: by 2002:a05:600c:c177:b0:490:c2a3:3303 with SMTP id 5b1f17b1804b1-490ec51f18dmr147186805e9.34.1781461330727;
        Sun, 14 Jun 2026 11:22:10 -0700 (PDT)
Received: from localhost (apn-78-30-82-184.dynamic.gprs.plus.pl. [78.30.82.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d70sm27095649f8f.19.2026.06.14.11.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 11:22:10 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: shinichiro.kawasaki@wdc.com,
	linux-block@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH blktests] scsi/009: fix unset bytes_to_write in TEST 8
Date: Sun, 14 Jun 2026 20:16:52 +0200
Message-ID: <20260614181651.11554-2-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bytes_to_write was never assigned before TEST 8, causing it to pass for
the wrong reason. Set it to atomic_unit_max_bytes + logical_block_size
and update the golden output with the expected "pwrite: Invalid argument"
from xfs_io.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---

This is a followup on: https://github.com/linux-blktests/blktests/pull/245

 tests/scsi/009     | 1 +
 tests/scsi/009.out | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/scsi/009 b/tests/scsi/009
index 41a5152..c7a1754 100755
--- a/tests/scsi/009
+++ b/tests/scsi/009
@@ -143,6 +143,7 @@ test_device() {
 
 	test_desc="TEST 8 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 "
 	test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should not be succesful"
+	bytes_to_write=$(( sysfs_atomic_unit_max_bytes + sysfs_logical_block_size ))
 	bytes_written=$(run_xfs_io_pwritev2_atomic "$TEST_DEV" "$bytes_to_write")
 	if [ "$bytes_written" = "" ]
 	then
diff --git a/tests/scsi/009.out b/tests/scsi/009.out
index e94882d..6c3780f 100644
--- a/tests/scsi/009.out
+++ b/tests/scsi/009.out
@@ -6,6 +6,7 @@ TEST 4 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - p
 TEST 5 - check statx stx_atomic_write_unit_min - pass
 TEST 6 - check statx stx_atomic_write_unit_max - pass
 TEST 7 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
 TEST 8 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
 TEST 9 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
 pwrite: Invalid argument
-- 
2.51.0

