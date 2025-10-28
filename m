Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D991AC44D
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679253; cv=none; b=lIB1AcLc+AQFrmeuPWrA/bP3vUNqyKqzQ+ImSGP+VQP7ZY86N+DbveW2HtyRqbtv3k7bj4dTRLhKma5sajYnZ9gR+nrifY7+bUUkZPOdeevocLckd+/TNjE6sGcYPuktLpUDdNKGNZps4WgrJl+m/nYPMEnX58cHSbQZwoBLdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679253; c=relaxed/simple;
	bh=NVZdPCleQ0CQsp8hIW6QuoytFZ4F6sBofDe2NFZcw4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YjbHoPRq7/VZ2rH6SAtguNK6AOK88OQ8GZZOh/5KKHZqkI9mo9f63l7pfyEPRlaP20RFZx10v2crob5olVKvj4Be2auofA+UVurqz9RfG+blXCEN+APl2ajkUs4xWU3AWFMbkpUAfHSY/4rQXLcJKI4n+/Je4dATNV/OZf3o5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cek+89w1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cek+89w1"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34029c5beabso1434394a91.1
        for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761679252; x=1762284052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HYSq9IClrUvG1oGKDeC8H/7AeUSwxz0XnSZ/bQ9dAd0=;
        b=Cek+89w1YIobVI5Je9faYVZAz0NwrPcxpli7433QID8TXLaNvgL+mWLSNWbrZahuys
         d/qQMSbJyVFtH91lEouELut0BceAqx6JtcTl9HNPPtpUAzs09izKQUv9l8QLlMX1pHVu
         YHHpUL8JtrRCootKfNbLatytkB4Sqb/MIfCCKB+0KvA1UOeUvbWe0WE+x52SKlBeYnFr
         v8KQHJxPT6YcxJnXYNPke54U0I+AsHlYGPsTrwhQHSXQzTCa9Jo2PQPC3C+zKq5YG5YM
         3Wnue7DkkYRe6xK3U7cph73W2J9boWOwIWX1a8z6WZSzubNa1SixQVON7cIPoBuGYBSI
         wo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679252; x=1762284052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYSq9IClrUvG1oGKDeC8H/7AeUSwxz0XnSZ/bQ9dAd0=;
        b=ahCFrAAsKkAjZ1d+NV8wSDn5KTAR5kX1PVz7hJpNZhH4J01fE/TCoVeXVNgPIwkYUB
         xE1dLgH6TSE+2fsWTZ6pi8N68FKeu77lB6vsDY61bdJqbt9GVhYiyEjc9qlZo+lJP7y6
         4Us6G8wZNKBFITRsHt9nfbvT/3EzNr0nCFsWSYcLU7jJyMs57d8e8mL1Rs0Z143m0ck5
         1zTKnEqT9KBLlOV4S7aSKFi/sWudVtxrorilwQXRvkgx3+kRf/JvkVe5dbw0O5QGRknq
         8ibd9FbSMpQ0TGVgdE9eVHEB5xibNw5I/uBDlmtTQhECUntmeo3rZmhQL0s0U+pbxSrq
         l0aw==
X-Forwarded-Encrypted: i=1; AJvYcCW/7M3Yi5m3oXNVfRBdXItbJj7+Shv2c/x13hrguFrohwLXEe4yrE7+dB7xVsPIuP1pJPrW805mtzLiHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxY5BJjy32huqaqnFIO+X7kvLI3jtFx1P7AUdJmCOw5V3CP0y0
	Hft27R1zim/JIz96r0GH4/RDfddLlSMTLqgT0/x5xf6imnQTw+VjhTsZ
X-Gm-Gg: ASbGncv6kgDBZ/o8nU6xslMrccJz8wCK6w0f9Dv3T2C1w3A0NBEpM14+a8IDC8Z5Npq
	zuZueiA9G5mywppCcZ0A6QGSKdhdzMcm1QLCZBwLDfTC6KLU7LwJpKRe9np/0Ac7Qr6HwsYjr6O
	Mv8zPpRpxgIrULWwm2gNQMVV0scYHVMH1dIR7jgSvORNpEMgG8pJV0d5RMdbyXbkqQevkdEEeBz
	NIoBZRg0VdNBFc5aR1rvSMwz+fUj/wojIJPiQZ5rqz2riFr+812fjRTZYOEiiBcvNBE9+pc6Uwe
	DK8iunVaIiG6I3tA0dk1oheyw4ZiMpB7oJ4UxKV7K2OnXPxnHjWYjo/TBxGQhDlXH12Nszs4VCQ
	ffZiuyyHpoc1WE12kXVgxx+8UEZ+jyzXfK7kbPDMd91iITSciBmxk51gguuxbDy5a
X-Google-Smtp-Source: AGHT+IFgD5YXjG/WguaVlw8y5CCXqav6u9YvKxBGFedwnQ6rH7ANcRcUmbYYnRlYgogKTuS9ouMt+A==
X-Received: by 2002:a17:90b:4cd2:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-3403a15c41dmr217304a91.13.1761679251392;
        Tue, 28 Oct 2025 12:20:51 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3402a61f83asm1504879a91.13.2025.10.28.12.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 12:20:50 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: johannes.thumshirn@wdc.com
Cc: shinichiro.kawasaki@wdc.com,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V2 1/2] blktrace: add blktrace zone management regression test
Date: Tue, 28 Oct 2025 12:20:47 -0700
Message-Id: <20251028192048.18923-1-ckulkarnilinux@gmail.com>
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
Subsequent runs after the first trigger will not show the WARNING.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
V1->V2:
Removed dmesg -C to avoid clearing dmesg buffer from other tests
Use _dmesg_since_test_start() to only check messages from this test (Johannes)
---
 tests/blktrace/001     | 94 ++++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/001.out |  2 +
 tests/blktrace/rc      | 11 +++++
 3 files changed, 107 insertions(+)
 create mode 100755 tests/blktrace/001
 create mode 100644 tests/blktrace/001.out
 create mode 100644 tests/blktrace/rc

diff --git a/tests/blktrace/001 b/tests/blktrace/001
new file mode 100755
index 0000000..43331c1
--- /dev/null
+++ b/tests/blktrace/001
@@ -0,0 +1,94 @@
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
+	# Initialize null_blk with no default devices
+	if ! _init_null_blk nr_devices=0; then
+		return 1
+	fi
+
+	# Create zoned null_blk device via configfs
+	# 8 zones, 1GB total, 128MB per zone, no conventional zones
+	if ! _configure_null_blk nullb0 \
+		memory_backed=1 \
+		zone_size=128 \
+		zone_nr_conv=0 \
+		size=1024 \
+		zoned=1 \
+		power=1; then
+		return 1
+	fi
+
+	device=/dev/nullb0
+
+	# Verify it's a zoned device
+	local zoned_mode
+	zoned_mode=$(cat /sys/block/nullb0/queue/zoned)
+	if [[ "$zoned_mode" != "host-managed" ]]; then
+		echo "Device is not zoned (mode: $zoned_mode)"
+		_exit_null_blk
+		return 1
+	fi
+
+	# Start blktrace
+	blktrace -d "${device}" -o trace >> "$FULL" 2>&1 &
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
+	wait $blktrace_pid 2>/dev/null || true
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
index 0000000..9b987a2
--- /dev/null
+++ b/tests/blktrace/rc
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
+#
+# Tests for blktrace infrastructure
+
+. common/rc
+
+group_requires() {
+	_have_root && _have_blktrace && _have_program blkparse
+}
-- 
2.40.0

