Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636251C84D6
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635962; cv=none; b=YpK4AiqiiDedu4/fNDXrOxgjmkoi8ASPLOGSx9ry2NuYzPdqKWR5XFXf+mHn1WdALcQH0Q4Rcoj7v6vqq59KTcHLrmHwbgB9rXtwelF0diFevUIJABKz5Fb6cO6qfnRAhSI6yBLFAeTCjSnsoXl7x5DQIm/GrGNqeS+0jZDyPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635962; c=relaxed/simple;
	bh=o0fJ0LjwoA+BWhVjthy26DqszKHS06EdXBHIX/Svsls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbogutbnDy26uSi+Ow8mrl3XEpm9ifQeWik72x/0f7lxFhEROqGUebLZd/voZlWLKSRxh3D6qEo/3TTvOmXk1TyeEZjnouOd6Gs8IGYCKBTjRtn1haV2mK2dblw9dKydqCQOZnp9L640urr046nj+0Ycx9xM1a1Jz+Fyy8vyAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6toPhjn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6toPhjn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742635959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqIUWbFQxeiULqDe9GbUBB22LZvH21pl/00ORXp7n7I=;
	b=Y6toPhjnFXjLFcKidefI6ZA4JCfSKQnNriAKPY8TIsumNGeMcgO8yJ3gVMcd6+udYVWZSy
	MvdzP1R3aigIDpk7uobLtTSzrV8NyiScqs5SD1mgfFMG2tKzLkGd7D3FgUfi24cDzJWQqN
	xqQOPVh3MCYMaiQRqYv4cGQQxjA79Po=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-dOjoH7bRPyGfRZayipFYnQ-1; Sat,
 22 Mar 2025 05:32:35 -0400
X-MC-Unique: dOjoH7bRPyGfRZayipFYnQ-1
X-Mimecast-MFC-AGG-ID: dOjoH7bRPyGfRZayipFYnQ_1742635954
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 279D5195E92A;
	Sat, 22 Mar 2025 09:32:34 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3177180B485;
	Sat, 22 Mar 2025 09:32:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 1/8] selftests: ublk: add generic_01 for verifying sequential IO order
Date: Sat, 22 Mar 2025 17:32:09 +0800
Message-ID: <20250322093218.431419-2-ming.lei@redhat.com>
In-Reply-To: <20250322093218.431419-1-ming.lei@redhat.com>
References: <20250322093218.431419-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

block layer, ublk and io_uring might re-order IO in the past

- plug

- queue ublk io command via task work

Add one test for verifying if sequential WRITE IO is dispatched in order.

- null target is taken, so we can just observe io order from
`tracepoint:block:block_rq_complete` which represents the dispatch order

- WRITE IO is taken because READ may come from system-wide utility

Cc: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  4 +-
 tools/testing/selftests/ublk/test_common.sh   | 22 ++++++++++
 .../testing/selftests/ublk/test_generic_01.sh | 44 +++++++++++++++++++
 tools/testing/selftests/ublk/trace/seq_io.bt  | 25 +++++++++++
 4 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_01.sh
 create mode 100644 tools/testing/selftests/ublk/trace/seq_io.bt

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 5d8d5939f051..652ab40adb73 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -3,7 +3,9 @@
 CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
 LDLIBS += -lpthread -lm -luring
 
-TEST_PROGS := test_null_01.sh
+TEST_PROGS := test_generic_01.sh
+
+TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_loop_01.sh
 TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 48fca609e741..75f54ac6b1c4 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -3,6 +3,26 @@
 
 UBLK_SKIP_CODE=4
 
+_have_program() {
+	if command -v "$1" >/dev/null 2>&1; then
+		return 0
+	fi
+	return 1
+}
+
+_get_disk_dev_t() {
+	local dev_id=$1
+	local dev
+	local major
+	local minor
+
+	dev=/dev/ublkb"${dev_id}"
+	major=$(stat -c '%Hr' "$dev")
+	minor=$(stat -c '%Lr' "$dev")
+
+	echo $(( (major & 0xfff) << 20 | (minor & 0xfffff) ))
+}
+
 _create_backfile() {
 	local my_size=$1
 	local my_file
@@ -121,6 +141,7 @@ _check_add_dev()
 
 _cleanup_test() {
 	"${UBLK_PROG}" del -a
+	rm -f "$UBLK_TMP"
 }
 
 _have_feature()
@@ -216,6 +237,7 @@ _ublk_test_top_dir()
 	cd "$(dirname "$0")" && pwd
 }
 
+UBLK_TMP=$(mktemp ublk_test_XXXXX)
 UBLK_PROG=$(_ublk_test_top_dir)/kublk
 UBLK_TEST_QUIET=1
 UBLK_TEST_SHOW_RESULT=1
diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
new file mode 100755
index 000000000000..9227a208ba53
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_01.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_01"
+ERR_CODE=0
+
+if ! _have_program bpftrace; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "null" "sequential io order"
+
+dev_id=$(_add_ublk_dev -t null)
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
diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
new file mode 100644
index 000000000000..272ac54c9d5f
--- /dev/null
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -0,0 +1,25 @@
+/*
+	$1: 	dev_t
+	$2: 	RWBS
+	$3:     strlen($2)
+*/
+BEGIN {
+	@last_rw[$1, str($2)] = 0;
+}
+tracepoint:block:block_rq_complete
+{
+	$dev = $1;
+	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
+		$last = @last_rw[$dev, str($2)];
+		if ((uint64)args.sector != $last) {
+			printf("io_out_of_order: exp %llu actual %llu\n",
+				args.sector, $last);
+		}
+		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
+	}
+	@ios = count();
+}
+
+END {
+	clear(@last_rw);
+}
-- 
2.47.0

