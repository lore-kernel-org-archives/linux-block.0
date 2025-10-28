Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C622BE7C6
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633595; cv=none; b=CuofjGKZEjrQRc8moOrB3kkj7mo0wIft5uA0GOf4rCnszbQAim/Jr9B2uPCg7bzen+2/lJGbEyD22TTE1Mu7VADrebEgmouxso5dtc0rsM6IFJqag+MtQ1S/bQdlEjf8BOoKFZlQh7YXC04ddsr8LwYdlLLM7MYMGW/Lu8mcNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633595; c=relaxed/simple;
	bh=QsvJ7pHXVDsZBpLFZnZ0aGnk0dcVvYuoj84+UNPh6fU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=krGc6NnzocDCbkM+OSIBsItlb1y2QJ9eC5o4QaOHwroOVy6rXLpFuwq4XiapjB4+ZczDnLqj3N07BH7ZB9tMDEa3q9EcJo8CrmQglDo6886hcPz2BoJZM7+Wbu5xsZSwQ2CatxufJ8XSg6SWgzheH1CtMSGkoaxo2IBWa9MybAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a28kyBfj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a28kyBfj"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so7390253b3a.2
        for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 23:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761633593; x=1762238393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHgRpSvDPuBfiOVtTvsFg2e5DcRe3UyDkg0eRtH7Nno=;
        b=a28kyBfjMCc44BvJHHWRMAyiDdMZqNFmmJVjafCfgcH5sgOnEnSNCxsXqsy70mRdtJ
         Ct4VTe9I7uAthE3lG7H3ur9ZdR6KRNQI8WwngvmLjU7UrGgHG13mNiTh43Bp6NrRq8Ae
         d17ZxTxQylf1TXutZ1euO+8hor/TIZwTAQl33CGVIuVE9HTNadq0mM0XaMCFmZ06BKke
         TLwwqU9GgXC734CKhk0+nXNFEoM/fyP1dmRbbDHp58s0O5jWHKQX3Kr4ngtVs6knO87A
         O4OANKSkz+v6gk4u/lo+VM6SVQaoT4Bwla0fbEdz21YZsmKUbN8whK7RWcpdSBPT1kHv
         TmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761633593; x=1762238393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHgRpSvDPuBfiOVtTvsFg2e5DcRe3UyDkg0eRtH7Nno=;
        b=GciIHyrLnqI2iDSgRdxTxWtokJ/UJpySpAVzQ3Sg9hstMG4jeFNJFDV1TZ8akytUor
         VvJfOuDcoTb2cyrVQVBs/soLDkOsb9D3XQN1b270PfuGAnZx6iVPnFAp+pUoWChWOkxS
         33e+hJrqYfH/IVqFrrbWsytFSQYqcYtuOtAXAylS34W+OcOWNtJz17KNoHij9AOHpIND
         IkRami+nJuQqN78dwprR52lvhyOSYpQFbRjFIiVibrduP53E1FC2oSW6n9Gc7Fw+1Sm5
         7SmnzJskVyCYBr+WpfRSr8VGews8Dpxr8LkbqJxeWAGVAaPvNwEnmqRR84GyqA0+hLWR
         /ICA==
X-Forwarded-Encrypted: i=1; AJvYcCWGRa+QIxrwUHCP543tNDBAgmw/RnVE1kCKqP59qwu9zr9n7UGvib9jIQl6MZPAqrUvprEFTdh95iEcIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQH57dKGYGRqQW9275Az1/G0UBBkSRH7YoM2Oj7basEpa/u5wC
	MM4VpQYWhNhXbSWhXHkSzJ0wYcnlFQu6NYd/jwsouHohkz/r73Ez0q7r
X-Gm-Gg: ASbGncsmrpXzlqSacNA6pS763WbVyEsUhaTyddj7YrniN7GorrJ/pqKBLO0fdxHgHeJ
	S5l719ISgfPlU0PpicqkousMk0pBF6tw24Wna9VCLnatr9awPKNcIV+1/MIvkfNRH91nLYQSfHp
	QU8N5Gkc+fqZmckHf+zElnIHFJw1batadkNUw6YSeJSHZeTuhHizV3vAZtOFwwyMlBuTADhcoMr
	OO0etqnzo0JG4IzJgjUbgtLx35plP2yOoqAlUo+Q7vYiLiHL9El39r1YR6kcxQ9uR5EWWDc+Ytf
	jLVP0kWopldi7PNF1epAb60ln9+Vsk7x3QwjvbY8aY8VMhgkBsYr9HX6VKYsbPrK7XIC48gXrPE
	51Al4QB+2MpA9oLdzBtZ53X/FtlAfGei5Q/iD7RXppXXrP/cjN67xJ+xt37Nq/E6L
X-Google-Smtp-Source: AGHT+IGVQJSaw4PkxSOrdoGYUJuhduB2kY9Iw96/21hjM0Sw6Zcm8GLl46c9VaQvKBrHiZVeOR6Pfw==
X-Received: by 2002:a05:6a00:399d:b0:77f:11bd:749a with SMTP id d2e1a72fcca58-7a441c1d583mr2460395b3a.20.1761633592882;
        Mon, 27 Oct 2025 23:39:52 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414062b6csm10503019b3a.42.2025.10.27.23.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:39:52 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: johannes.thumshirn@wdc.com
Cc: shinichiro.kawasaki@wdc.com,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH blktests 1/2] blktrace: add blktrace zone management regression test
Date: Mon, 27 Oct 2025 23:39:48 -0700
Message-Id: <20251028063949.10503-1-ckulkarnilinux@gmail.com>
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
 tests/blktrace/001     | 97 ++++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/001.out |  2 +
 tests/blktrace/rc      | 11 +++++
 3 files changed, 110 insertions(+)
 create mode 100755 tests/blktrace/001
 create mode 100644 tests/blktrace/001.out
 create mode 100644 tests/blktrace/rc

diff --git a/tests/blktrace/001 b/tests/blktrace/001
new file mode 100755
index 0000000..bf6273a
--- /dev/null
+++ b/tests/blktrace/001
@@ -0,0 +1,97 @@
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
+	# Clear dmesg to isolate test output
+	dmesg -C 2>/dev/null || true
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
+	warning_count=$(dmesg | grep -c "WARNING.*blktrace.c:367" || true)
+
+	if [[ $warning_count -gt 0 ]]; then
+		echo "WARNING: blktrace bug detected at blktrace.c:367"
+		dmesg | grep -A 10 "WARNING.*blktrace.c:367" >> "$FULL"
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

