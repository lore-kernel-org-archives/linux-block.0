Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E120311
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214517; cv=none; b=ebl171s9UU8S15riE2O9z49qCapHx9UU9flUV/z9J58dYsGHlFbn7aGhBk4Kx1m7GMBPeT5NywwPwi/VSB9BbEY8T1BYEi9xERCLqgbWJb545G5A8OZnOEr+Tbxl69ksEqiCpkShCHuVUgPDuAu6EOF98jUPUz+QJgn7XSP4CP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214517; c=relaxed/simple;
	bh=ApwVjDmIXBt0stBgCypr1juZmAVo4HWKYDjS6clden0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZOE1piPa/3fI2bHPjlnSMLGU/vTYlIcVuN1mnpL3+4NLcmWe059WetQ3OK2HnYFz/wmYmT5FTgYvZWFImhdvGNRr1R3z8pt71R/TX8sAvdljTFFMLG5bnq848/vR51LoulT8JpkoA1kYl6LjxMcWTVpG2O2fth/35BheK/+UgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzbFBLnA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzbFBLnA"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso3409967a12.3
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 16:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762214513; x=1762819313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFAh1Lf+DzSWFTGamkCMcaVf3+AdKLlwHRxQRfyfM2U=;
        b=UzbFBLnAP5JJ65lKUwGtPCZd4y6HV30enLd0MNeyWaedmuFFiamEpKykbBO5sa04qC
         L78YPk9iT0NNR9zzxqXTTKllUS24AbZCDaNFyCCgFYm39abS9Un5+78DLz6rdRl+4a4Z
         E2YdUn9lkWScmFcVgPdZCXHLWOo3ub56hi/+0wFhhzRkEMy7xWZrUuPTCCkIADXG5/8R
         kdjtkltNoTWACKCPrAbnX3PHsgIZcbgrL6VobwYqpq+T/4ENBOUFy4YUnf4LP+r1T9wF
         h6U7ry1TnItR2TovXT4MWv9ehH5evsLF5zTHn5lh2j1oE1v1ar7c3xRLvJ/nI08tBw1p
         cXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762214513; x=1762819313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFAh1Lf+DzSWFTGamkCMcaVf3+AdKLlwHRxQRfyfM2U=;
        b=gONY0sRG98fq97OGnAv5FNu1FDzgYcNaQJdYulEuYw0txMt1Z4Y0B+D4skxunQMzj6
         RlSKx/yQDV1aDPpV0QDJuu32TAM1FRbM6B9uJstsIiWkzNw14fHtZ+HNFORmRpvFsQtM
         cveBkoHgEu9yGw8i2U9dHIu1JDsuG1OcAy5FnmXc3gCWJQwLP8KFcS3wEIdSIl/3TsLb
         oGExJHbPLSIB6jXLgTBUpBPTz3fvJRnSy9HGEvUg9Q12eyrX59oXeptKsNuqHzrXtRL0
         LJzUC/GpRz0yQA/kU14cXD2V7EHplU7sgHDf4PrGt6WrZnO5J/HE6dL96aArETyvXZdr
         1xkg==
X-Gm-Message-State: AOJu0Yyt4zGBGUPDXsO2e1mGntHHkKa6InrBdPUAbdH7A2RY9otzO5US
	FF7GfFOkMziS1F6oHr/G4/IXdMjQbCdhSGitWw0spz2gZ9yV0fWNSuft
X-Gm-Gg: ASbGnctzD90/CXLA6w5JJMh0iZfe6dB64voeZBHcql8qmN8lOru9juocuguzv5XMX66
	d9JkP5lDuNqTvwSMMRXMcX/HufK6HpT1xsgr2ckNneG3xGXLKPG9P4F2NgiLnAPcSyLCK09G3Da
	OirjEDiziRRH9uJogd0gPV0RTLViv5B1hZIlxmU2RbApGLrIoh+ZygnX4aZXu8U9o5D0sdS471I
	xo63lANXHIfOIahi+f1mW5SapJRL0x6gaJE2tRWX7B+7+KDju2Jn0cjo+IcWA65UbmBiEWsd0oE
	x6SGzm99vQ1miu55E2uuO7tEmJxnilFfyUZoAfPUTscxDRriVlGAD8rkgsFBtcgdmvV4s7UmtFj
	fVHExJ5UkYKCrKHFRNV0hvCIRTBNDOlOzM93xzyK4d4ZuJBJofJ/kzc5qrVqqPHsI4llMOjNhhX
	g9gr5tIHBvWLzyChMJExov2Cn9O8GRghPNoMbq
X-Google-Smtp-Source: AGHT+IGLQsW8MCrvASw25cTHQMT9+IuU5KXnds644A3P6gsII0n9+3kgKvGMpJOjSpdVHNiXbFri2Q==
X-Received: by 2002:a17:903:11c8:b0:294:fc1d:9d0 with SMTP id d9443c01a7336-2951a51d76fmr173409515ad.40.1762214512420;
        Mon, 03 Nov 2025 16:01:52 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a69d91sm3668585ad.95.2025.11.03.16.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:01:51 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: Johannes.Thumshirn@wdc.com,
	shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V3 1/2] blktrace: add blktrace zone management regression test
Date: Mon,  3 Nov 2025 16:01:48 -0800
Message-Id: <20251104000149.3212-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new blktrace test group and add a regression test for a
blktrace false positive WARNING that occurs when zone management
commands are traced with blktrace on V1 version.

Bug: https://syzkaller.appspot.com/bug?extid=153e64c0aa875d7e4c37
Location: kernel/trace/blktrace.c:367-368

The test:
1. Creates a zoned null_blk device (8 zones, 1GB, no conventional zones)
2. Starts blktrace on the device
3. Issues zone open command for all zones
4. Checks dmesg for the false positive WARNING

Device configuration:
- Total size: 1GB
- Zone size: 128MB
- Number of zones: 8
- Conventional zones: 0

If the WARNING is found, the bug is present and logged to the full
output. If no WARNING appears, the bug is fixed.

Note: The bug uses WARN_ON_ONCE, so it triggers only once per boot.
Subsequent runs after the first trigger will not show the WARNING:
commit 4a0940bdcac260be1e3460e99464fa63d317c6a2
Author: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Date:   Mon Oct 27 19:46:19 2025 -0700

    blktrace: use debug print to report dropped events

https://lore.kernel.org/linux-block/20251028024619.2906-1-ckulkarnilinux@gmail.com/

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
V2->V3:
- Remove _init_null_blk call (not needed with configfs)
- Change nullb0 to nullb1 (works with built-in null_blk)
- Update blktrace to use long options and store in TMPDIR
- Remove debug || true from wait command
- Keep || true from grep -c needed to prevent false failure
- Remove && operators in group_requires()
---
 tests/blktrace/001     | 90 ++++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/001.out |  2 +
 tests/blktrace/rc      | 13 ++++++
 3 files changed, 105 insertions(+)
 create mode 100755 tests/blktrace/001
 create mode 100644 tests/blktrace/001.out
 create mode 100644 tests/blktrace/rc

diff --git a/tests/blktrace/001 b/tests/blktrace/001
new file mode 100755
index 0000000..2cdad02
--- /dev/null
+++ b/tests/blktrace/001
@@ -0,0 +1,90 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
+#
+# Regression test for blktrace false positive WARNING on zone management
+# commands.
+#
+# Bug: https://syzkaller.appspot.com/bug?extid=153e64c0aa875d7e4c37
+# Location: kernel/trace/blktrace.c:367-368
+#
+# The bug triggers a WARNING when zone management commands (zone open/close/
+# finish/reset) are traced with blktrace on V1 version. This is a false
+# positive that should be fixed.
+
+. tests/blktrace/rc
+. common/null_blk
+
+DESCRIPTION="blktrace zone management command tracing"
+QUICK=1
+
+requires() {
+	_have_program blkzone
+	_have_null_blk
+	_have_module_param null_blk zoned
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local blktrace_pid
+	local warning_count
+	local device
+
+	# Create zoned null_blk device via configfs
+	# 8 zones, 1GB total, 128MB per zone, no conventional zones
+	if ! _configure_null_blk nullb1 \
+		memory_backed=1 \
+		zone_size=128 \
+		zone_nr_conv=0 \
+		size=1024 \
+		zoned=1 \
+		power=1; then
+		return 1
+	fi
+
+	device=/dev/nullb1
+
+	# Verify it's a zoned device
+	local zoned_mode
+	zoned_mode=$(cat /sys/block/nullb1/queue/zoned)
+	if [[ "$zoned_mode" != "host-managed" ]]; then
+		echo "Device is not zoned (mode: $zoned_mode)"
+		_exit_null_blk
+		return 1
+	fi
+
+	# Start blktrace
+	blktrace --dev="${device}" --output=trace --output-dir="$TMPDIR" \
+		>> "$FULL" 2>&1 &
+	blktrace_pid=$!
+	sleep 2
+
+	# Verify blktrace started
+	if ! ps -p $blktrace_pid > /dev/null 2>&1; then
+		echo "blktrace failed to start"
+		_exit_null_blk
+		return 1
+	fi
+
+	# Issue zone open command for all zones (triggers bug if present)
+	blkzone open "${device}" >> "$FULL" 2>&1
+
+	sleep 1
+
+	# Stop blktrace
+	kill $blktrace_pid 2>/dev/null
+	wait $blktrace_pid 2>/dev/null
+
+	# Check for WARNING (bug present if WARNING found)
+	warning_count=$(_dmesg_since_test_start | grep -c "WARNING.*blktrace.c:367" || true)
+
+	if [[ $warning_count -gt 0 ]]; then
+		echo "WARNING: blktrace bug detected at blktrace.c:367"
+		_dmesg_since_test_start | grep -A 10 "WARNING.*blktrace.c:367" >> "$FULL"
+	fi
+
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/blktrace/001.out b/tests/blktrace/001.out
new file mode 100644
index 0000000..a122a65
--- /dev/null
+++ b/tests/blktrace/001.out
@@ -0,0 +1,2 @@
+Running blktrace/001
+Test complete
diff --git a/tests/blktrace/rc b/tests/blktrace/rc
new file mode 100644
index 0000000..04c599f
--- /dev/null
+++ b/tests/blktrace/rc
@@ -0,0 +1,13 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
+#
+# Tests for blktrace infrastructure
+
+. common/rc
+
+group_requires() {
+	_have_root
+	_have_blktrace
+	_have_program blkparse
+}
-- 
2.40.0

