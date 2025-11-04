Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264ED41C71
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214516; cv=none; b=nlZI89beaJxNGmlUBa0Q7hK39ZqhWZtLLbT9+SyNTynjDAqUOwhsBVdXt+UHGpzpNgUzYk6QrGwI0ZCf5MVTrHyYdsR+BztlKbEDXBp6IDg8fNhtOWdNElN1Y+zy3+dOpo016EmciefB3N8lMV2U+d76XMxFaa7HZs6pvosoGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214516; c=relaxed/simple;
	bh=GDKEU+PoQXSpHdfwWqyi+XWQsw8Kwpd+8PJiPtAjJO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IeHS8V2MmahWFNzOWDDeRdysMqaJ1RBKJRU3HJ23SEx5PpSyqMkUzEaQ/9wpVJxAMn5VnlhkqxGhO0ADawDgtE5DEWoIptL+hMYx2sqXILn2M56HXPhyPPKmoMV5RG9h6ULuOsIrb0ndRBvzYOwgkV5OBvOdlWxe5K0Fjl2TgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsqyZcHh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsqyZcHh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-292fd52d527so50529705ad.2
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 16:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762214514; x=1762819314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5glpTSlk1p4oQcFGetB2ISPZGnYdEIOBRqieuINbsA=;
        b=RsqyZcHh1w8X1zE3Tq5e5PUH1x304ix8o+p9VFHBzq05r9RHcAiDiXhwlH1Z/ZFRQj
         FytuUw7sv4hh/UO1bePgOmhQjlNVloSg5yhFbATYNexF3Hkw/nrwYGlUo9R6NB1pRMC8
         tLViK7O9UHFeTQ5xwQVekJ6yQeDfbXNI4t6/E88oNbq+xFp+bgghye4qFKe0RHuM1jy3
         dTbYNnIEn8W1MDwU0d1087MH8cBNt+Md3aMfDBCsinw36TfA3SUeyhKVPYv+2h+anMaB
         w+1Aa1Mz7KY0hHrzGunXf8iP833YvMfTpRGnefbSij8EaKjNj/SG8pxkZ6aPqYQBwUTl
         m5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762214514; x=1762819314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5glpTSlk1p4oQcFGetB2ISPZGnYdEIOBRqieuINbsA=;
        b=iX2kn9oNK4NwFOOTQZ/CehR1PeoSrPJLZLZ1F6yieLXaYS64y91ry+7Qmwt/qJEIdf
         ArbZHSMXynPKeIo+5FTJDtCYwt4K1gvDWkTysdEFx7aLrc2zuU2DiRXucawvPVUU+p06
         N0nAyqJd0EtBRnuZoy+BePB6MmqfWpfZ36S/1XkxRJGWvLV/z6nc23SpYeLb+9eBw0tB
         fdEn7S0p6/s9GRUiEauxsres7UedKHve80mJ4Vwu6yjsNy0UQkWRL2KpgDZ+CaychUxz
         DtQRbRy218IMb+fuIO4K8KtuG6GVC+Ip26TtSIOL5tiTgBXiCWXpLrOLQc1H3UULu+DY
         vkVA==
X-Gm-Message-State: AOJu0Yy+SIcrUp3Vf4qAINBUBWSKpeRPCtIgYf15nTgDYDjJ8Q2UVIRg
	HUP/O5a4oGZNd138HGs/UJtav0cTLF9RP5qI6QQTDXhMb/s+xwFBBNUzt/3iFw==
X-Gm-Gg: ASbGncunvHdW6MydylGHlNHHLEsbBjxTie6udWbWyWg7FI/2fTHpa3cKCkJUzHWvqJB
	5pqU+q5Qb6iwG5q1+A6kGywY6Ap1kQcBWyMKvxVwOGZukuP8oJa2ATTWOLKmZ0y5C3rF9V4NtS4
	qt/fDnXzHx8/O2Mg9CptR5YaRgUMu3WYubiuHJ3wKaoqz2CBSAU1czx3wogH9slAEOXIbRQwp9P
	CweHWUoTcodB4QxxdAdCNxjoj3D2aWUEEy8UpCD8Q25Rybs0lSlrF6aBu6E49dXIOST4RXu8ZtC
	6f1rllfNWGXLQnVH1f8jsiN/kkh763WMR253quKAElR/El/B2UHj5iKcxGAa2tFrzl5PxNbpGNa
	ofimHMQJmrtEDsKn1wez7b6iUxn0EWBstpDgQuNffAk0hvDjI/4cz0XGYde4z8Jli5X3ESx5Txh
	W+Zs7uW0tqM4YcnkqcCef+sHXv9DsJYdSBAA71sc5v5NzOwt8ys8JbeZ/KFg==
X-Google-Smtp-Source: AGHT+IGnqBrQ4nCwt4SmysdsBjRmLrJyj17LCp+UEKl3qYHGopxdx5rPmO5ZA5VL7UN7dIKs2I4iwQ==
X-Received: by 2002:a17:902:cece:b0:295:5668:2f1d with SMTP id d9443c01a7336-2955668304fmr127295665ad.41.1762214514075;
        Mon, 03 Nov 2025 16:01:54 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296018a4d94sm4311765ad.0.2025.11.03.16.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:01:53 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: Johannes.Thumshirn@wdc.com,
	shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V3 2/2] blktrace: add blktrace ftrace corruption regression test
Date: Mon,  3 Nov 2025 16:01:49 -0800
Message-Id: <20251104000149.3212-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251104000149.3212-1-ckulkarnilinux@gmail.com>
References: <20251104000149.3212-1-ckulkarnilinux@gmail.com>
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

This test confirms the fix by the kernel patch:

commit e48886b9d668d80be24e37345bd0904e9138473c
Author: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Date:   Mon Oct 27 22:50:42 2025 -0700

    blktrace: for ftrace use correct trace format ver

Link: https://lore.kernel.org/linux-block/20251028055042.2948-1-ckulkarnilinux@gmail.com/
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
V2->V3:
- Add kernel patch reference and Link tag to commit message
- Replace _init_null_blk with _configure_null_blk (works with built-in)
- Change nullb0 to nullb1 throughout test (5 locations)
- Remove debug || true from cleanup commands (redundant with 2>/dev/null)
- Remove debug || true from final cleanup commands
---
 tests/blktrace/002     | 97 ++++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/002.out |  3 ++
 2 files changed, 100 insertions(+)
 create mode 100755 tests/blktrace/002
 create mode 100644 tests/blktrace/002.out

diff --git a/tests/blktrace/002 b/tests/blktrace/002
new file mode 100755
index 0000000..ba8f6c3
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
+	if ! _configure_null_blk nullb1 power=1; then
+		return 1
+	fi
+
+	device=/dev/nullb1
+
+	# Verify device exists
+	if [[ ! -b "$device" ]]; then
+		echo "Device $device not found"
+		_exit_null_blk
+		return 1
+	fi
+
+	# Clean up any previous trace state
+	echo 0 > "$trace_dir/tracing_on" 2>/dev/null
+	echo > "$trace_dir/trace" 2>/dev/null
+	echo nop > "$trace_dir/current_tracer" 2>/dev/null
+
+	# Enable sysfs trace for nullb1 (this triggers the bug path)
+	if [[ -f /sys/block/nullb1/trace/enable ]]; then
+		echo 1 > /sys/block/nullb1/trace/enable
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
+	echo 0 > /sys/block/nullb1/trace/enable 2>/dev/null
+	echo nop > "$trace_dir/current_tracer" 2>/dev/null
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

