Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C02C0293
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633598; cv=none; b=Q6f2jFPUZgQtoALrcRCKyhKLOiTSdbfHoZ8StqZbW7/Tm62U38shC2IajBXCl2YKr5m1Lotnv/NeIv7GTZIxOEsWEXokCd8+lLdMNM5YP7HMpwarM7ZiYLFKZR4t2xGNXGhY89CuEP0ujVdU7+FHRPSKy985dSDyh1VQoENYM0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633598; c=relaxed/simple;
	bh=tzkE1thdXmdvSPD1kwvNCB7PzSIuHMvurBU+WDXYyS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o4OC45lykql3IrqiwKMpOJQmzE9F344ntv0xEzNghE2V+VnAp9EoTeKMjAdxUy87H4Qah7mbBtQUHGna1wM/MiiATWmJRulOjMSuFGeOIAGYM8sGh86UFemPoFUjCJ9+DbssWS/jc7WtsyJv7bMV3r5tRAPMmf9Fc/5Hp36olz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPyGLn38; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPyGLn38"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290dc630a07so39674515ad.1
        for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 23:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761633596; x=1762238396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nULmnNC1B3ayUuViw8iyE3V8T5hxKxh98fx7PJHa6OI=;
        b=YPyGLn38rDxkwjkOkV1jZDt0qep7qnw3KaHU6ojkp4cJ3BJltFTNtczDnNdRWEgvl7
         8V26cz2H/KEGkaBWPufmA9qqWFuzvcAekvEu2ajfpUpFd3ZOTnX9rcD6rEUhKAm+D+tr
         e9KdLWIe2tmGSGjwdK2U+ftVZeTRQTXqzpSBD0Vw2YbuA62cHrHJeKj/nBO+9h9uEXv9
         IrOjFdFey/NL9AwQMyNc8KrhZ35rO8ZkFDwAhojAiOlbIPUdTvy2tYAM9zvllrovZqqk
         ASQPM3vZz1+0PNOFb/S253328llSKRBfqcipoeqd0DY656VgUv/frASR9DKZV5oIrdRG
         ogqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761633596; x=1762238396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nULmnNC1B3ayUuViw8iyE3V8T5hxKxh98fx7PJHa6OI=;
        b=GogEUmrmqR7qHEQOIA7511upqr2vpccIcBeHt8vTuEbzV6WbGiRDqYkC8PZQr6ohQu
         rvMWFxiRCeVvOI5cPcZlnNEvmCEH2fnLQk5iDztXcDuDLTLbLoJjxB5kPpBLd3NIR/om
         71YwwfG8+CVEbxIhXr5q+O3qXf3sqfTl5on26NcOO9LhKPK7NfOjAs7dEZ5uLElKa9KB
         f6a+u7GUtuOfTpMdiWjFiSKp43UoiPVajbvl6x4K3pWBXOHnAp2hxfT3mMWW5X899qDC
         IalzOB3ict564FsZSS4TsG97242Hj/u/QTE0Fv7cSJgIHepFZCbQbvu58fbfbLuWHJoT
         TQsg==
X-Forwarded-Encrypted: i=1; AJvYcCUmM2/d5qW1FspLl/bMpy5jgVIznknCKk3rk6kDFpPG2mnZ/TrGsCrbqcrN2n8nBhaq7Shr5/kEFDti5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAw23NpJCrsBIIQEQlXXRPYeyzqXMgDP3RLFTTTzSNm4v+xnKZ
	Z3EE/2PvQBp24hwHYB+57j1QqlUsN8ikPLj6uYXfpGp1xq8VL1IAa67K
X-Gm-Gg: ASbGnctp5rVQhCRHFKaTKJpLWB9/Yg2AJscGrUZ0HbHl44vR/3q4+KsEqX9fwLFlxJA
	lbVkIyjoY7M2emtAIIwvspTnc68KtcK1nvqVZvyroEUs9fVEs7Vgvd0m+uV1IolXUSNjC0GhWAF
	jvkm4yvxUd6ZAENYwCY03Z3ivk1wNh6E4Wy0sKgu5d5jlZnXJXjSK6x1LOF+jLXzjIB2/ZSc84T
	C4jkLhP+W7tJyysEykBMnhEEt3U5EiOzHI8KuBsrvPaCqpISHCiL3abhhH7BTHXStV/MkuoO5la
	mhsvaYn4Elp4lno/MunV19MEBsvsyOkPmn4ZjJVgb6sFIvVW11UnCM0klAfKYeLClRbfdMwljZ/
	YjGdQYfAiB4bQTJ37SD1k4M8ayIsWHlY7uOg2HGPbEUIR25eL5luW5uewN9A8c0Rt
X-Google-Smtp-Source: AGHT+IGFJ/hZeTQcLVUMwYtTGIeMN66gcL8W8jOU0yU9ZH8Y3i/AuGynaxisAjyWiJT+UM6O1XwvXw==
X-Received: by 2002:a17:902:e84f:b0:294:98c4:41c8 with SMTP id d9443c01a7336-294cb52e3c2mr27279295ad.34.1761633596387;
        Mon, 27 Oct 2025 23:39:56 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a4d9sm103224855ad.37.2025.10.27.23.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:39:55 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: johannes.thumshirn@wdc.com
Cc: shinichiro.kawasaki@wdc.com,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH blktest 2/2] blktrace: add blktrace ftrace corruption regression test
Date: Mon, 27 Oct 2025 23:39:49 -0700
Message-Id: <20251028063949.10503-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251028063949.10503-1-ckulkarnilinux@gmail.com>
References: <20251028063949.10503-1-ckulkarnilinux@gmail.com>
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

