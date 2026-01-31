Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBE33D50A
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876687; cv=none; b=IxdlNs9quW872Rbxc4nBC/QF4Y0xthE+BYHL1vynYI5+n/LKNS3XToGYpC47gi61NZKeNjGe+2Z7Zm56eZ9wPA0djug2Aeuo4xhJQIaowdjN6m7JcN85qPlfN92I+fUQAruZA/Ys7F2oy/jtuFYssU3r+szCopbFjL7fBfwolVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876687; c=relaxed/simple;
	bh=NGddTg1PXvumyK5ao3pPbNQxBfnH8Cac6xdxdRVB7yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2Pnml18JwLGEVS5lLf3aJaZcqCN7Sg8O7mPfCcZXWRigxC/pgcPmpSVW8r24Cvt8zmLO5no2XmuLhyf4OGiDrConb01hSHecSyv4OWftkrCWLOT2n90U7CTLwQX28+1RsC7lDD1NX5khlAjnEN9xd8PPWoQX9q5+/q4NnTFK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8bxVaM/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8bxVaM/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769876682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dSuJ4STUvPnzSbeB61h027dSQrat1IhodmHat9c3J4=;
	b=c8bxVaM/4GkT8LTf6QRlCE6RaINNbEBYruoJENI0EG9j1yzj2VRuWJ128HWY4LqNvhH1QS
	UswpbqiaNV2PU/UXJisawthV6EK67zo8bmNwp0Gx0c7l3SzId1W5mmVY3Nm8euyu1eEfoA
	j3J1hF7KOgefPtsWU6KEguOMQZxNsg4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-XH-I6VAxMeOnLB-3U85DfQ-1; Sat,
 31 Jan 2026 11:24:39 -0500
X-MC-Unique: XH-I6VAxMeOnLB-3U85DfQ-1
X-Mimecast-MFC-AGG-ID: XH-I6VAxMeOnLB-3U85DfQ_1769876677
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A03BA19560B2;
	Sat, 31 Jan 2026 16:24:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8F951956056;
	Sat, 31 Jan 2026 16:24:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 9/9] selftests: ublk: improve I/O ordering test with bpftrace
Date: Sun,  1 Feb 2026 00:23:40 +0800
Message-ID: <20260131162342.13872-10-ming.lei@redhat.com>
In-Reply-To: <20260131162342.13872-1-ming.lei@redhat.com>
References: <20260131162342.13872-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove test_generic_01.sh since block layer may reorder I/O, making
the test prone to false positives. Apply the improvements to
test_generic_02.sh instead, which supposes for covering ublk dispatch
io order.

Rework test_generic_02 to verify that ublk dispatch doesn't reorder I/O
by comparing request start order with completion order using bpftrace.

The bpftrace script now:
- Tracks each request's start sequence number in a map keyed by sector
- On completion, verifies the request's start order matches expected
  completion order
- Reports any out-of-order completions detected

The test script:
- Wait bpftrace BEGIN code block is run
- Pins fio to CPU 0 for deterministic behavior
- Uses block_io_start and block_rq_complete tracepoints
- Checks bpftrace output for reordering errors

Reported-and-tested-by: Alexander Atanasov <alex@zazolabs.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  3 +-
 .../testing/selftests/ublk/test_generic_01.sh | 47 -------------------
 .../testing/selftests/ublk/test_generic_02.sh | 22 ++++++---
 tools/testing/selftests/ublk/trace/seq_io.bt  | 47 +++++++++++++++----
 4 files changed, 54 insertions(+), 65 deletions(-)
 delete mode 100755 tools/testing/selftests/ublk/test_generic_01.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index a62a06e13006..8ac2d4a682a1 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -7,8 +7,7 @@ endif
 
 LDLIBS += -lpthread -lm -luring
 
-TEST_PROGS := test_generic_01.sh
-TEST_PROGS += test_generic_02.sh
+TEST_PROGS := test_generic_02.sh
 TEST_PROGS += test_generic_03.sh
 TEST_PROGS += test_generic_06.sh
 TEST_PROGS += test_generic_07.sh
diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
deleted file mode 100755
index 26cf3c7ceeb5..000000000000
--- a/tools/testing/selftests/ublk/test_generic_01.sh
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-
-ERR_CODE=0
-
-if ! _have_program bpftrace; then
-	exit "$UBLK_SKIP_CODE"
-fi
-
-if ! _have_program fio; then
-	exit "$UBLK_SKIP_CODE"
-fi
-
-_prep_test "null" "sequential io order"
-
-dev_id=$(_add_ublk_dev -t null)
-_check_add_dev $TID $?
-
-dev_t=$(_get_disk_dev_t "$dev_id")
-bpftrace trace/seq_io.bt "$dev_t" "W" 1 > "$UBLK_TMP" 2>&1 &
-btrace_pid=$!
-sleep 2
-
-if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
-	_cleanup_test "null"
-	exit "$UBLK_SKIP_CODE"
-fi
-
-# run fio over this ublk disk
-fio --name=write_seq \
-    --filename=/dev/ublkb"${dev_id}" \
-    --ioengine=libaio --iodepth=16 \
-    --rw=write \
-    --size=512M \
-    --direct=1 \
-    --bs=4k > /dev/null 2>&1
-ERR_CODE=$?
-kill "$btrace_pid"
-wait
-if grep -q "io_out_of_order" "$UBLK_TMP"; then
-	cat "$UBLK_TMP"
-	ERR_CODE=255
-fi
-_cleanup_test "null"
-_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_02.sh b/tools/testing/selftests/ublk/test_generic_02.sh
index 1d4b1d6e059c..46b657143fd6 100755
--- a/tools/testing/selftests/ublk/test_generic_02.sh
+++ b/tools/testing/selftests/ublk/test_generic_02.sh
@@ -13,7 +13,7 @@ if ! _have_program fio; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
-_prep_test "null" "sequential io order for MQ"
+_prep_test "null" "ublk dispatch won't reorder IO for MQ"
 
 dev_id=$(_add_ublk_dev -t null -q 2)
 _check_add_dev $TID $?
@@ -21,15 +21,20 @@ _check_add_dev $TID $?
 dev_t=$(_get_disk_dev_t "$dev_id")
 bpftrace trace/seq_io.bt "$dev_t" "W" 1 > "$UBLK_TMP" 2>&1 &
 btrace_pid=$!
-sleep 2
 
-if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
+# Wait for bpftrace probes to be attached (BEGIN block prints BPFTRACE_READY)
+for _ in $(seq 100); do
+	grep -q "BPFTRACE_READY" "$UBLK_TMP" 2>/dev/null && break
+	sleep 0.1
+done
+
+if ! kill -0 "$btrace_pid" 2>/dev/null; then
 	_cleanup_test "null"
 	exit "$UBLK_SKIP_CODE"
 fi
 
-# run fio over this ublk disk
-fio --name=write_seq \
+# run fio over this ublk disk (pinned to CPU 0)
+taskset -c 0 fio --name=write_seq \
     --filename=/dev/ublkb"${dev_id}" \
     --ioengine=libaio --iodepth=16 \
     --rw=write \
@@ -39,8 +44,11 @@ fio --name=write_seq \
 ERR_CODE=$?
 kill "$btrace_pid"
 wait
-if grep -q "io_out_of_order" "$UBLK_TMP"; then
-	cat "$UBLK_TMP"
+
+# Check for out-of-order completions detected by bpftrace
+if grep -q "^out_of_order:" "$UBLK_TMP"; then
+	echo "I/O reordering detected:"
+	grep "^out_of_order:" "$UBLK_TMP"
 	ERR_CODE=255
 fi
 _cleanup_test "null"
diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index b2f60a92b118..9d36ba35468f 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -2,23 +2,52 @@
 	$1: 	dev_t
 	$2: 	RWBS
 	$3:     strlen($2)
+
+	Track request order between block_io_start and block_rq_complete.
+	Sequence starts at 1 so 0 means "never seen". On first valid
+	completion, sync complete_seq to handle probe attachment races.
+	block_rq_complete listed first to reduce missed completion window.
 */
+
 BEGIN {
-	@last_rw[$1, str($2)] = (uint64)0;
+	@start_seq = (uint64)1;
+	@complete_seq = (uint64)0;
+	@out_of_order = (uint64)0;
+	@start_order[0] = (uint64)0;
+	delete(@start_order[0]);
+	printf("BPFTRACE_READY\n");
 }
+
 tracepoint:block:block_rq_complete
+/(int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)/
 {
-	$dev = $1;
-	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
-		$last = @last_rw[$dev, str($2)];
-		if ((uint64)args.sector != $last) {
-			printf("io_out_of_order: exp %llu actual %llu\n",
-				args.sector, $last);
+	$expected = @start_order[args.sector];
+	if ($expected > 0) {
+		if (@complete_seq == 0) {
+			@complete_seq = $expected;
+		}
+		if ($expected != @complete_seq) {
+			printf("out_of_order: sector %llu started at seq %llu but completed at seq %llu\n",
+				args.sector, $expected, @complete_seq);
+			@out_of_order = @out_of_order + 1;
 		}
-		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
+		delete(@start_order[args.sector]);
+		@complete_seq = @complete_seq + 1;
 	}
 }
 
+tracepoint:block:block_io_start
+/(int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)/
+{
+	@start_order[args.sector] = @start_seq;
+	@start_seq = @start_seq + 1;
+}
+
 END {
-	clear(@last_rw);
+	printf("total_start: %llu total_complete: %llu out_of_order: %llu\n",
+		@start_seq - 1, @complete_seq, @out_of_order);
+	clear(@start_order);
+	clear(@start_seq);
+	clear(@complete_seq);
+	clear(@out_of_order);
 }
-- 
2.47.0

