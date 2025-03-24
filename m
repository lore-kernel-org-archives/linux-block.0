Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312814F9FB
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824206; cv=none; b=nUyrlrGqJEcVVA5/YlT+KIC4580SqEKDDTHeif/Vg8VgEqCSczEEpVtTyzUOw7v/tiolPv3lR3eUO5C38QDmgINUPxWtRpZhw1+XpjFes+t0pX1Ht6xX/CgW5b5Swj7/lRGSK0YkZ3CvYtXvRQntrtnTR5nYqEFpNg1k6OPRmlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824206; c=relaxed/simple;
	bh=phHt0ZYAsH4bso+TQ+t6leY2RBmeD1G0aUhlKqfv3Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2MRAnIjemA8cHGPQsb/L8Z863q51N0YWtUuBJNYabzdb8WYx+jpvqSBKcVybZUnOAQYEnqIuwJQA42mJWa7Y9sdxYKj5wH+ChUJ4pjQ3MmcudsmyyErzO4Bs6/nwaLwNzmqp0UVJlZJ0NJNml0rLodeERXNnY0s6sMZbZ28q8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqGqYNna; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqGqYNna"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742824203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OezlmP2vS203Svj2LDkGVdLU9FqPQAAePXsJm3459OE=;
	b=NqGqYNnaQi2mkxSO/vq+39FGIzJncyGfXa1pXTjPvZeuYx00ZjL9n6I25nouLjQMxLHFjv
	CFlLG0vq7BneWsV2JIvLkwgGnaz2hNGUaNMG6JEh3y6gu4SrquQ3NP7GRh6klbhRL/j21O
	UFtxYK6aGuAhkuYFeJwT8UzRqQ7CYu0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-PMKcIoDHP2WUYxm0mU6NOA-1; Mon,
 24 Mar 2025 09:49:58 -0400
X-MC-Unique: PMKcIoDHP2WUYxm0mU6NOA-1
X-Mimecast-MFC-AGG-ID: PMKcIoDHP2WUYxm0mU6NOA_1742824196
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2E021933B49;
	Mon, 24 Mar 2025 13:49:56 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC2CF19560AD;
	Mon, 24 Mar 2025 13:49:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/8] selftests: ublk: add more tests for covering MQ
Date: Mon, 24 Mar 2025 21:49:02 +0800
Message-ID: <20250324134905.766777-8-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-1-ming.lei@redhat.com>
References: <20250324134905.766777-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add test test_generic_02.sh for covering IO dispatch order in case of MQ.

Especially we just support ->queue_rqs() which may affect IO dispatch
order.

Add test_loop_05.sh and test_stripe_03.sh for covering MQ.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  3 ++
 tools/testing/selftests/ublk/test_common.sh   |  6 +++
 .../testing/selftests/ublk/test_generic_02.sh | 44 +++++++++++++++++++
 tools/testing/selftests/ublk/test_loop_01.sh  | 14 +++---
 tools/testing/selftests/ublk/test_loop_03.sh  | 14 +++---
 tools/testing/selftests/ublk/test_loop_05.sh  | 28 ++++++++++++
 .../testing/selftests/ublk/test_stripe_01.sh  | 14 +++---
 .../testing/selftests/ublk/test_stripe_03.sh  | 30 +++++++++++++
 8 files changed, 126 insertions(+), 27 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_05.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_03.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 7817afe29005..7a8c994de244 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -4,6 +4,7 @@ CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
 LDLIBS += -lpthread -lm -luring
 
 TEST_PROGS := test_generic_01.sh
+TEST_PROGS += test_generic_02.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
@@ -11,8 +12,10 @@ TEST_PROGS += test_loop_01.sh
 TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
 TEST_PROGS += test_loop_04.sh
+TEST_PROGS += test_loop_05.sh
 TEST_PROGS += test_stripe_01.sh
 TEST_PROGS += test_stripe_02.sh
+TEST_PROGS += test_stripe_03.sh
 
 TEST_PROGS += test_stress_01.sh
 TEST_PROGS += test_stress_02.sh
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 75f54ac6b1c4..a88b35943227 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -23,6 +23,12 @@ _get_disk_dev_t() {
 	echo $(( (major & 0xfff) << 20 | (minor & 0xfffff) ))
 }
 
+_run_fio_verify_io() {
+	fio --name=verify --rw=randwrite --direct=1 --ioengine=libaio \
+		--bs=8k --iodepth=32 --verify=crc32c --do_verify=1 \
+		--verify_state_save=0 "$@" > /dev/null
+}
+
 _create_backfile() {
 	local my_size=$1
 	local my_file
diff --git a/tools/testing/selftests/ublk/test_generic_02.sh b/tools/testing/selftests/ublk/test_generic_02.sh
new file mode 100755
index 000000000000..3e80121e3bf5
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_02.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_02"
+ERR_CODE=0
+
+if ! _have_program bpftrace; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "null" "sequential io order for MQ"
+
+dev_id=$(_add_ublk_dev -t null -q 2)
+_check_add_dev $TID $?
+
+dev_t=$(_get_disk_dev_t "$dev_id")
+bpftrace trace/seq_io.bt "$dev_t" "W" 1 > "$UBLK_TMP" 2>&1 &
+btrace_pid=$!
+sleep 2
+
+if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
+	_cleanup_test "null"
+	exit "$UBLK_SKIP_CODE"
+fi
+
+# run fio over this ublk disk
+fio --name=write_seq \
+    --filename=/dev/ublkb"${dev_id}" \
+    --ioengine=libaio --iodepth=16 \
+    --rw=write \
+    --size=512M \
+    --direct=1 \
+    --bs=4k > /dev/null 2>&1
+ERR_CODE=$?
+kill "$btrace_pid"
+wait
+if grep -q "io_out_of_order" "$UBLK_TMP"; then
+	cat "$UBLK_TMP"
+	ERR_CODE=255
+fi
+_cleanup_test "null"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_01.sh b/tools/testing/selftests/ublk/test_loop_01.sh
index c882d2a08e13..1ef8b6044777 100755
--- a/tools/testing/selftests/ublk/test_loop_01.sh
+++ b/tools/testing/selftests/ublk/test_loop_01.sh
@@ -6,6 +6,10 @@
 TID="loop_01"
 ERR_CODE=0
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "loop" "write and verify test"
 
 backfile_0=$(_create_backfile 256M)
@@ -14,15 +18,7 @@ dev_id=$(_add_ublk_dev -t loop "$backfile_0")
 _check_add_dev $TID $? "${backfile_0}"
 
 # run fio over the ublk disk
-fio --name=write_and_verify \
-    --filename=/dev/ublkb"${dev_id}" \
-    --ioengine=libaio --iodepth=16 \
-    --rw=write \
-    --size=256M \
-    --direct=1 \
-    --verify=crc32c \
-    --do_verify=1 \
-    --bs=4k > /dev/null 2>&1
+_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
 ERR_CODE=$?
 
 _cleanup_test "loop"
diff --git a/tools/testing/selftests/ublk/test_loop_03.sh b/tools/testing/selftests/ublk/test_loop_03.sh
index 269c96787d7d..e9ca744de8b1 100755
--- a/tools/testing/selftests/ublk/test_loop_03.sh
+++ b/tools/testing/selftests/ublk/test_loop_03.sh
@@ -6,6 +6,10 @@
 TID="loop_03"
 ERR_CODE=0
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "loop" "write and verify over zero copy"
 
 backfile_0=$(_create_backfile 256M)
@@ -13,15 +17,7 @@ dev_id=$(_add_ublk_dev -t loop -z "$backfile_0")
 _check_add_dev $TID $? "$backfile_0"
 
 # run fio over the ublk disk
-fio --name=write_and_verify \
-    --filename=/dev/ublkb"${dev_id}" \
-    --ioengine=libaio --iodepth=64 \
-    --rw=write \
-    --size=256M \
-    --direct=1 \
-    --verify=crc32c \
-    --do_verify=1 \
-    --bs=4k > /dev/null 2>&1
+_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
 ERR_CODE=$?
 
 _cleanup_test "loop"
diff --git a/tools/testing/selftests/ublk/test_loop_05.sh b/tools/testing/selftests/ublk/test_loop_05.sh
new file mode 100755
index 000000000000..2e6e2e6978fc
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_05.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="loop_05"
+ERR_CODE=0
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "loop" "write and verify test"
+
+backfile_0=$(_create_backfile 256M)
+
+dev_id=$(_add_ublk_dev -q 2 -t loop "$backfile_0")
+_check_add_dev $TID $? "${backfile_0}"
+
+# run fio over the ublk disk
+_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
+ERR_CODE=$?
+
+_cleanup_test "loop"
+
+_remove_backfile "$backfile_0"
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_01.sh b/tools/testing/selftests/ublk/test_stripe_01.sh
index c01f3dc325ab..7e387ef656ea 100755
--- a/tools/testing/selftests/ublk/test_stripe_01.sh
+++ b/tools/testing/selftests/ublk/test_stripe_01.sh
@@ -6,6 +6,10 @@
 TID="stripe_01"
 ERR_CODE=0
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "stripe" "write and verify test"
 
 backfile_0=$(_create_backfile 256M)
@@ -15,15 +19,7 @@ dev_id=$(_add_ublk_dev -t stripe "$backfile_0" "$backfile_1")
 _check_add_dev $TID $? "${backfile_0}"
 
 # run fio over the ublk disk
-fio --name=write_and_verify \
-    --filename=/dev/ublkb"${dev_id}" \
-    --ioengine=libaio --iodepth=32 \
-    --rw=write \
-    --size=512M \
-    --direct=1 \
-    --verify=crc32c \
-    --do_verify=1 \
-    --bs=4k > /dev/null 2>&1
+_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=512M
 ERR_CODE=$?
 
 _cleanup_test "stripe"
diff --git a/tools/testing/selftests/ublk/test_stripe_03.sh b/tools/testing/selftests/ublk/test_stripe_03.sh
new file mode 100755
index 000000000000..c1b34af36145
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_03.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="stripe_03"
+ERR_CODE=0
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "stripe" "write and verify test"
+
+backfile_0=$(_create_backfile 256M)
+backfile_1=$(_create_backfile 256M)
+
+dev_id=$(_add_ublk_dev -q 2 -t stripe "$backfile_0" "$backfile_1")
+_check_add_dev $TID $? "${backfile_0}"
+
+# run fio over the ublk disk
+_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=512M
+ERR_CODE=$?
+
+_cleanup_test "stripe"
+
+_remove_backfile "$backfile_0"
+_remove_backfile "$backfile_1"
+
+_show_result $TID $ERR_CODE
-- 
2.47.0

