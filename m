Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DFD242923
	for <linux-block@vger.kernel.org>; Thu, 29 May 2025 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562463; cv=none; b=qZHMw4CE6dPyrLiKeTan184PQzYzMq16pV0cS1IG5xZMcfRjarM6wltQSNfHoeDuX9jwu1w6B8nNkqfEGxfvQVV4R47cvH+Fy03YRNf2/sA8kTXpAvUOtDOA7wrdZH2IBiVQ9PXOTvrEX8F428H1SzMnqtkTOLPvfrA8rEs9OyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562463; c=relaxed/simple;
	bh=cUd78MMEbgFPUkXKSGAnKUwyPufXJBeXnM/cAC/MM0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJGCo8zczAFHGJSIP42ASn4Udw/fWXgAjPS1Ddn+PeKS9oQs4chhE9Lcy8y08I9Y84/hkrYB16DpyEkxr2cNyjpgzI4SaX9fsv7GcXZ9aT9mOR1qieYodkIllJJLrYBoGmMrnglav2HF1M64mLfQ3vJjTQE4jhpNfoi8zhsVUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VChr60mi; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VChr60mi"
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-2e8fc56f4e2so736733fac.3
        for <linux-block@vger.kernel.org>; Thu, 29 May 2025 16:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748562456; x=1749167256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4kPtR57n6FehTlRVxMvWCX+QEvXXFmJrsdczp0NHd8=;
        b=VChr60mi5UAGLyFROxdel2vDV+h22rrwcNRmpB5/gn9K/Ayv7s+cLu+8B0GOoSTD/X
         6CCyicRxRZPQpl+Y8CkhodHGvpA6XLDA/cHtG1Z+Seplxx3vyiQM38YaWdMl1ZI5LjPn
         h5pL3Maj5a7KbECjxDUzYzCXMoynahjxDZaedDqD8DGdNyM1v79YehukWJjX19X5fPNm
         aOQKcQJajJ1Wwx9bLfC54l4473f/DDD39n27BrKfo0TiEWxa01ExQlvXWJwSRqlp0jI/
         LqDNfk5dCqtUcpYbRBvoerC7xLHna407ojCmIZVypYXr85yQG9adDVbRIOfFZODNGO5P
         qjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562456; x=1749167256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4kPtR57n6FehTlRVxMvWCX+QEvXXFmJrsdczp0NHd8=;
        b=ZkwlPVulJL3cdnJVagR3v+3FItA5NSjEpgVZY0idXLbb5cYAzCiHtdzijthuvZNx5C
         p5+O8w9NPju8AHri7PHLd1tFDVcJw9ainNWPUKAj8TWJDzORLb6IQS+HjgO797gB2Blh
         9M6pP0wrIUuASC4QDxdI+uptmPgbyWgPucPz818/OTd84KNGpUxodpQJ5Y9UhSO6SyMI
         /S6yuLPVhfJo237G9PrlaSgLyA7JsLMcsrZgg/kfq1WLfHbEj8+o4N/xwy7IGWCeLRfT
         GALPSANVXkUppRZkGDKmD5Fysege524OKQcOv0IgtgllfZWwHiKqpv4EXY+Wt98O9EcU
         dlww==
X-Gm-Message-State: AOJu0Yy+LKIPUMqRZ+bkryZrHSFQ5eaUphDbdMDTeoaFKdvQp7ruiNqf
	3hbmMO0As12DNln5hL6m87tJQnCChGz9VTACY0LBUwYticv1qVbbmyjdUN30nefyS70YNfL/Gqw
	LFWULkpF0iCettDqF9kvGjuuM3bU4H4lya9hmvz7PCpQHLF4YIA53
X-Gm-Gg: ASbGncsUI1lv9T0TRM6rBxSUf0nRQGOwzka6kArtpsZaoQhhD1FE1TJgrFXqn5YiGng
	z5GlW21oeV3JJnNBpS7YXfmXC9XQ9f172MXonBCDRLJATgMRwrilgfZjA0OkjJrFFkBPa3jbt3L
	k15pMLR5fl6Iiwsf0DvucPlk9q2l1lqINv/iHEQCNbFLNiNbZq8+ZCISh1HT/j8QoUOcIHZJs2m
	XKYssxe788LvzxWAA3JoLwC3CG1G+tAm4RW1d+LOHMIkUMgxQ5Qsvo5YDwvQ7j2qRPwpRjrNVVM
	DF4M8Q0MUSLxN0V5rgG1jarBIJ4k4Tw=
X-Google-Smtp-Source: AGHT+IHpKni8rHg6UuaANZQmvzfFdnX2JDl7jNpDLZLVglSH02MMb3WrcTgtWUK2lyP5qkHej4/tqbnL56v9
X-Received: by 2002:a05:6870:d208:b0:2da:843d:e530 with SMTP id 586e51a60fabf-2e921166c9cmr845404fac.2.1748562456391;
        Thu, 29 May 2025 16:47:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2e906790b48sm118303fac.11.2025.05.29.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:47:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 217E33404A3;
	Thu, 29 May 2025 17:47:35 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id CEC5DE40FA6; Thu, 29 May 2025 17:47:34 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 29 May 2025 17:47:16 -0600
Subject: [PATCH v8 7/9] selftests: ublk: add functional test for per io
 daemons
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-ublk_task_per_io-v8-7-e9d3b119336a@purestorage.com>
References: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
In-Reply-To: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Add a new test test_generic_12 which:

- sets up a ublk server with per_io_tasks and a different number of ublk
  server threads and ublk_queues. This is possible now that these
  objects are decoupled
- runs some I/O load from a single CPU
- verifies that all the ublk server threads handle some I/O

Before this changeset, this test fails, since I/O issued from one CPU is
always handled by the one ublk server thread. After this changeset, the
test passes.

In the future, the last check above may be strengthened to "verify that
all ublk server threads handle the same amount of I/O." However, this
requires some adjustments/bugfixes to tag allocation, so this work is
postponed to a followup.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile              |  1 +
 tools/testing/selftests/ublk/test_generic_12.sh    | 55 ++++++++++++++++++++++
 .../selftests/ublk/trace/count_ios_per_tid.bt      | 11 +++++
 3 files changed, 67 insertions(+)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 4dde8838261d660ba31a07d608332d1733a6321d..5d7f4ecfb81612f919a89eb442f948d6bfafe225 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -19,6 +19,7 @@ TEST_PROGS += test_generic_08.sh
 TEST_PROGS += test_generic_09.sh
 TEST_PROGS += test_generic_10.sh
 TEST_PROGS += test_generic_11.sh
+TEST_PROGS += test_generic_12.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/test_generic_12.sh b/tools/testing/selftests/ublk/test_generic_12.sh
new file mode 100755
index 0000000000000000000000000000000000000000..7abbb00d251df9403857b1c6f53aec8bf8eab176
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_12.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_12"
+ERR_CODE=0
+
+if ! _have_program bpftrace; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "null" "do imbalanced load, it should be balanced over I/O threads"
+
+NTHREADS=6
+dev_id=$(_add_ublk_dev -t null -q 4 -d 16 --nthreads $NTHREADS --per_io_tasks)
+_check_add_dev $TID $?
+
+dev_t=$(_get_disk_dev_t "$dev_id")
+bpftrace trace/count_ios_per_tid.bt "$dev_t" > "$UBLK_TMP" 2>&1 &
+btrace_pid=$!
+sleep 2
+
+if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
+	_cleanup_test "null"
+	exit "$UBLK_SKIP_CODE"
+fi
+
+# do imbalanced I/O on the ublk device
+# pin to cpu 0 to prevent migration/only target one queue
+fio --name=write_seq \
+    --filename=/dev/ublkb"${dev_id}" \
+    --ioengine=libaio --iodepth=16 \
+    --rw=write \
+    --size=512M \
+    --direct=1 \
+    --bs=4k \
+    --cpus_allowed=0 > /dev/null 2>&1
+ERR_CODE=$?
+kill "$btrace_pid"
+wait
+
+# check that every task handles some I/O, even though all I/O was issued
+# from a single CPU. when ublk gets support for round-robin tag
+# allocation, this check can be strengthened to assert that every thread
+# handles the same number of I/Os
+NR_THREADS_THAT_HANDLED_IO=$(grep -c '@' ${UBLK_TMP})
+if [[ $NR_THREADS_THAT_HANDLED_IO -ne $NTHREADS ]]; then
+        echo "only $NR_THREADS_THAT_HANDLED_IO handled I/O! expected $NTHREADS"
+        cat "$UBLK_TMP"
+        ERR_CODE=255
+fi
+
+_cleanup_test "null"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/trace/count_ios_per_tid.bt b/tools/testing/selftests/ublk/trace/count_ios_per_tid.bt
new file mode 100644
index 0000000000000000000000000000000000000000..f4aa63ff2938a4097c2b848f379dbc87fe898a7f
--- /dev/null
+++ b/tools/testing/selftests/ublk/trace/count_ios_per_tid.bt
@@ -0,0 +1,11 @@
+/*
+ * Tabulates and prints I/O completions per thread for the given device
+ *
+ * $1: dev_t
+*/
+tracepoint:block:block_rq_complete
+{
+	if (args.dev == $1) {
+		@[tid] = count();
+	}
+}

-- 
2.34.1

