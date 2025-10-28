Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199D34F482
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679256; cv=none; b=DJlcrKVt+LlEpvMJCQhO1M6tt4OuOTiznPcKhUja1pSohizysaA4BuC4GGTJdnrEQnKGFA9E+uGlQeUJ+4DCXoIxU15Rb0xBXNwqyf+qyqvaBxIsb4vpliwT2X8OhQQFtQIKt3WZ2W7eYk6VtE6QtrziAB418GstN/MvISzJXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679256; c=relaxed/simple;
	bh=tzkE1thdXmdvSPD1kwvNCB7PzSIuHMvurBU+WDXYyS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTFCgqg8EkN/377sm1JwbbQlVvSdk2wovJmMcUZ9vfXrUp8RYWdrGhAoD1XRnTRV1xnr2gQSmfyt3oGy01v16vcI+HB/xIjZu7IfY48aVLJWIVt7le5JQLPo/CDM40CcpgjkVAU6Kr9xbs/3cAkQiciqUqgXkEcQBdj3eHwduBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6IrBSAI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6IrBSAI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290aaff555eso58953345ad.2
        for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761679254; x=1762284054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nULmnNC1B3ayUuViw8iyE3V8T5hxKxh98fx7PJHa6OI=;
        b=H6IrBSAIUllY94sg4GHhorjKFPEQ2vdWOgdHobgjbsIko8c4eGEPGTekGFE0BG/8b1
         RPkkbC1nbLwyF+XhZb8q2deXecbBLD/Br3GnnTbfaerN3ypHvQsPIPpB1wbemV4HlgrB
         QsL9ksATH4a9I5glKO5YiV+pwua8yZQk4MMtW7faNO5zn82g8A8kz4rQzlTmsbpww/e1
         Q9O1lyye4RdiNTv6oxE/YABvkUAyymFpkHG4UB0xQeZ6bN9jOGX8AmJ1HzD7zAQszkhV
         d2cZcqeKfNUE3PQCVYGhnlo3/zz/PEf+QkPriwhGWAVW4+rbynjNMbM0D9fUppEtCmFN
         IUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679254; x=1762284054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nULmnNC1B3ayUuViw8iyE3V8T5hxKxh98fx7PJHa6OI=;
        b=DqN9IFrg2Q91kLjRPyU2Z61SXErfFyoTSsEKsnyDvEWhxmq3c9DJsjik0IpP7kTDHd
         IpOmfW/bfL0fPhTq0eFrfGGWJl1jUUhw0NHEqYfhJuB3bzDMzAdnbXM07xXRTgxxCsC7
         SnWGR2MW6n4uxpy8DV8fTUmPpBr8g22GMxvgA/ROV+o0LFRF0Bb6FkeZ7nnbfwGD1ci8
         +xhCv36+ms1yV+WP3O7wcmlcyCLjBYURRrlPmtMhavKHdb/PQBUH5sZf33NQiBO7JCX4
         QMfkcYOoLa7gDhXaG748S2fAnPpHzq4Q3+9fE3gAib0mXFPOVMmkujIbBcWWBuAcORem
         91bw==
X-Forwarded-Encrypted: i=1; AJvYcCUcmdt8nwVrirLcqXZ+MrHA7IJOdKtoUCE9nX4AexJ+66YRWbooztTSDqreWlJ0nUXvy6z3jlZUMBcdPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3bx7p4KBvENo+T4wNabObT1/US4BIYOtVX03HfoKjwdL/9Db
	t/nSNuZW/tqc/XJM5lDq86UfAeDaZoex2fDVGJXsS7gN40nD60R2WZ2N
X-Gm-Gg: ASbGnctn5amilgSvynmpzdy8o0R94ppbGL+xg3o7PJMl0YF06VvtKeCB+Wx/YMMdisq
	VFbjucOiF96zJmJh3M0Y+77qC8MsBKkHYrxD8PdFzWiDYEA4taplYRhuKGMraM9VYC6We3f2LBv
	kJFx7K6b6wxvpjSeMTsEEXR5kuyA9pD8EIdOjLLtBXVxi5QQPjnLp0J8eYCLUkcyDOzCFowyWXY
	hG0cLbL2nyiU3eA8qK5falDqZJeJtjbupPFqSe9FicyabiTJ2W7Iadn6o8MsYVH5VQvutAr8qwV
	HEXNqv6WcNLzFq1uRmk5LROvQ5i9rBM3pMiz2C4XuSqBtgIQUv8znrzS5MydPNgWf1fLOZ0xb/G
	0puP8Jj4d9zbJF+cd2ypKqLzykp7zB4ZbFBG5a0DejM6pNFLrgaYGsTF+3TQMYQLf
X-Google-Smtp-Source: AGHT+IGirE4lTWQn4+mh2/Whn8RwSBeSs+tPBsapow5X70N0VYW4jzGac01/yKsu605hOJRlmGhM4Q==
X-Received: by 2002:a17:903:2a88:b0:267:9a29:7800 with SMTP id d9443c01a7336-294def3638emr3646535ad.59.1761679254371;
        Tue, 28 Oct 2025 12:20:54 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm12929248a91.16.2025.10.28.12.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 12:20:53 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: johannes.thumshirn@wdc.com
Cc: shinichiro.kawasaki@wdc.com,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V2 2/2] blktrace: add blktrace ftrace corruption regression test
Date: Tue, 28 Oct 2025 12:20:48 -0700
Message-Id: <20251028192048.18923-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251028192048.18923-1-ckulkarnilinux@gmail.com>
References: <20251028192048.18923-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add regression test for blktrace ftrace corruption bug that occurs when
sysfs trace is enabled followed by ftrace blk tracer.

When /sys/block/*/trace/enable is enabled and then ftrace's blk tracer
is activated, the trace output becomes corrupted showing "Unknown action"
with invalid hex values instead of proper action codes.

The root cause is that ftrace allocates a blk_io_trace2 buffer (64 bytes)
but calls record_blktrace_event() which writes v1 format (48 bytes),
causing field offset mismatches and corruption.

This test verifies that the trace output is correct and doesn't show
the corruption pattern.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 tests/blktrace/002     | 97 ++++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/002.out |  3 ++
 2 files changed, 100 insertions(+)
 create mode 100755 tests/blktrace/002
 create mode 100644 tests/blktrace/002.out

diff --git a/tests/blktrace/002 b/tests/blktrace/002
new file mode 100755
index 0000000..73b8597
--- /dev/null
+++ b/tests/blktrace/002
@@ -0,0 +1,97 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
+#
+# Regression test for blktrace ftrace corruption bug when using sysfs
+# trace enable with ftrace blk tracer.
+#
+# Bug: When sysfs trace is enabled (/sys/block/*/trace/enable) and then
+# ftrace blk tracer is enabled, the trace output becomes corrupted showing
+# "Unknown action" with invalid hex values.
+#
+# Root cause: ftrace allocated blk_io_trace2 buffer (64 bytes) but called
+# record_blktrace_event() which writes v1 format (48 bytes), causing field
+# offset mismatches and corruption.
+
+. tests/blktrace/rc
+. common/null_blk
+
+DESCRIPTION="blktrace ftrace corruption with sysfs trace"
+QUICK=1
+
+requires() {
+	_have_null_blk
+	_have_tracefs
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local trace_dir="/sys/kernel/debug/tracing"
+	local device
+
+	# Initialize null_blk with one device
+	if ! _init_null_blk nr_devices=1; then
+		return 1
+	fi
+
+	device=/dev/nullb0
+
+	# Verify device exists
+	if [[ ! -b "$device" ]]; then
+		echo "Device $device not found"
+		_exit_null_blk
+		return 1
+	fi
+
+	# Clean up any previous trace state
+	echo 0 > "$trace_dir/tracing_on" 2>/dev/null || true
+	echo > "$trace_dir/trace" 2>/dev/null || true
+	echo nop > "$trace_dir/current_tracer" 2>/dev/null || true
+
+	# Enable sysfs trace for nullb0 (this triggers the bug path)
+	if [[ -f /sys/block/nullb0/trace/enable ]]; then
+		echo 1 > /sys/block/nullb0/trace/enable
+	else
+		echo "No sysfs trace support"
+		_exit_null_blk
+		return 1
+	fi
+
+	# Enable blk ftrace tracer
+	echo blk > "$trace_dir/current_tracer"
+	echo 1 > "$trace_dir/tracing_on"
+
+	# Generate some I/O
+	dd if="$device" of=/dev/null bs=4k count=10 iflag=direct >> "$FULL" 2>&1
+
+	# Stop tracing
+	echo 0 > "$trace_dir/tracing_on"
+
+	# Check trace output for corruption
+	# Get first 10 non-comment lines
+	local trace_output
+	trace_output=$(grep -v "^#" "$trace_dir/trace" | head -10)
+
+	if [[ -z "$trace_output" ]]; then
+		echo "No trace output captured"
+		_exit_null_blk
+		return 1
+	fi
+
+	# Check for "Unknown action" which indicates the bug
+	if echo "$trace_output" | grep -q "Unknown action"; then
+		echo "BUG: Trace corruption detected with 'Unknown action'"
+		echo "$trace_output" | head -5 >> "$FULL"
+	else
+		echo "Trace output looks correct"
+	fi
+
+	# Cleanup: disable sysfs trace
+	echo 0 > /sys/block/nullb0/trace/enable 2>/dev/null || true
+	echo nop > "$trace_dir/current_tracer" 2>/dev/null || true
+
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/blktrace/002.out b/tests/blktrace/002.out
new file mode 100644
index 0000000..b358be9
--- /dev/null
+++ b/tests/blktrace/002.out
@@ -0,0 +1,3 @@
+Running blktrace/002
+Trace output looks correct
+Test complete
-- 
2.40.0

