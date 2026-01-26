Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1233C1A3
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436547; cv=none; b=lULFlrxLZp3U1B3qWo9xfTIuec9vpTdYb2UaAT6c37wvngc+K7gtQoVWhCXhZtybUWhmZ80Fq9ohnsQYrgB2zxqNQ8F6TAzvAnr/xeQfTUoUIv1I7m4Q3Hr7swmkr6FKfz7wpADTgxpdHsX74jhyoQE2kAEtXiUZ3AdE93xHYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436547; c=relaxed/simple;
	bh=V3hWjaFN+PWKbsVr/k6crPxD8PkK1UpghATMsWxYnJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6FrLXDeQe8tNHe1vX4IB5SkuV1VpMa6ZVysc+ZbyZkg4eEcEUE02F2nwX98jQR9GbbKglddJWTkvZOqeCHTteQp4FBS1B50QhA0Uu421BLda6N7msfdbaNVeGtQcFjQziorTD/DGr+sBjHnycnlsS/w3UceytbzDq45Xxc9pPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZgKCG4P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZgKCG4P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769436543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/W+9iWa70fU5FOv/112MdcycT5zBAtsFkgLdRGmlUM0=;
	b=KZgKCG4PxlQCEyCEs4zJPzthsiiWyXZD0U1iC996JvEe6WArHXPcMX6UKhmcLbSk139mOD
	AQHbiigAiLLEiEOHoVMZUfbbIl0vsEs1BxVnzy06vqE59fB22UT3ICl21RnqeUaISg8B0I
	wvpdh/QuxUbOGBS4iwuV7Y+tzfpQxRI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-nxUrk1FdPL66pm2GSdZwvw-1; Mon,
 26 Jan 2026 09:09:00 -0500
X-MC-Unique: nxUrk1FdPL66pm2GSdZwvw-1
X-Mimecast-MFC-AGG-ID: nxUrk1FdPL66pm2GSdZwvw_1769436539
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C046E1956054;
	Mon, 26 Jan 2026 14:08:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.122])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E24C919560B4;
	Mon, 26 Jan 2026 14:08:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH] selftests: ublk: improve I/O ordering test with bpftrace
Date: Mon, 26 Jan 2026 22:08:48 +0800
Message-ID: <20260126140848.2879240-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The in-tree approach requires sequential IO maintained in the whole IO
stack, which is too strict and may cause false positive because of IO
reorder caused by block layer core code, and generic_01 only covers IO
order in ublk dispatch code path.

Rework test_generic_01 to verify that ublk dispatch doesn't reorder I/O
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
 .../testing/selftests/ublk/test_generic_01.sh | 23 ++++++---
 tools/testing/selftests/ublk/trace/seq_io.bt  | 47 +++++++++++++++----
 2 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
index 21a31cd5491a..e1e0b5f72e3d 100755
--- a/tools/testing/selftests/ublk/test_generic_01.sh
+++ b/tools/testing/selftests/ublk/test_generic_01.sh
@@ -14,7 +14,7 @@ if ! _have_program fio; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
-_prep_test "null" "sequential io order"
+_prep_test "null" "ublk dispatch won't reorder IO"
 
 dev_id=$(_add_ublk_dev -t null)
 _check_add_dev $TID $?
@@ -22,15 +22,20 @@ _check_add_dev $TID $?
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
@@ -40,9 +45,13 @@ fio --name=write_seq \
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
+
 _cleanup_test "null"
 _show_result $TID $ERR_CODE
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
2.47.1

