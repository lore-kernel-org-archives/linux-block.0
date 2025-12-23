Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4932D374F
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 03:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460489; cv=none; b=EWpNsvAZQqgVRxw8AFIqgLJtsHRVt2/Rc5GThBwDLNxYR6ZHGxush5YjRwdEakfc9bk7JLJpkS7DBrh4N0K9vNgEKXvNiQADlPTaT1O8caXuH9Jx16u15v/brjUR68iL9hG9RKEgpb+ItpD0+ncxoYXOKFyiYkYydFaxROLTNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460489; c=relaxed/simple;
	bh=sa0eAYJ/j0I8McteZsS2bW9MlTzq9UOnhqi6BkK+s6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFg3DEHT+XEo2+KI2Yea6LvSCwEd8Lg8KaO18dBw2KBFCID6tUYhq32ckJcSn1zCEKK+OJo0SDpUU9N3MoAkIqoy8XqmMPrdwaLhyeM23L9ZIJp2gXCoD3ZFO69Wu9wWwwT0/t0VRKAdpoOsYg1s714ljYsRu4Whjl/5i2gs4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EA4C5YiF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA4C5YiF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766460485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzgpLuNoknocPVPKbupl/TJpvnXqWhJNN1ZoYREaqt0=;
	b=EA4C5YiFjhWRQW22MkQSscHHFAI08ZWG1xh+UZpP5TBu5+HwqY7YZnwN96KymihecK2srP
	h5NsdtdQRQMfOIOfK+lw2BUHo5fhmZNtVmDvjtmvM4mtp/E2VN8EHXbskS0CHpAHlEXZJn
	dXqjDgDPg0ru7s9aspj158GsMWphvR8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-pdysStL0NvmKU1QdyIlo2w-1; Mon,
 22 Dec 2025 22:28:00 -0500
X-MC-Unique: pdysStL0NvmKU1QdyIlo2w-1
X-Mimecast-MFC-AGG-ID: pdysStL0NvmKU1QdyIlo2w_1766460479
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DA3C1800365;
	Tue, 23 Dec 2025 03:27:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.97])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B78081800666;
	Tue, 23 Dec 2025 03:27:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/3] selftests/ublk: add test for async partition scan
Date: Tue, 23 Dec 2025 11:27:41 +0800
Message-ID: <20251223032744.1927434-3-ming.lei@redhat.com>
In-Reply-To: <20251223032744.1927434-1-ming.lei@redhat.com>
References: <20251223032744.1927434-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add test_generic_15.sh to verify that async partition scan prevents
IO hang when reading partition tables.

The test creates ublk devices with fault_inject target and very large
delay (60s) to simulate blocked partition table reads, then kills the
daemon to verify proper state transitions without hanging:

1. Without recovery support:
   - Create device with fault_inject and 60s delay
   - Kill daemon while partition scan may be blocked
   - Verify device transitions to DEAD state

2. With recovery support (-r 1):
   - Create device with fault_inject, 60s delay, and recovery
   - Kill daemon while partition scan may be blocked
   - Verify device transitions to QUIESCED state

Before the async partition scan fix, killing the daemon during
partition scan would cause deadlock as partition scan held ub->mutex
while waiting for IO. With the async fix, partition scan happens in
a work function and flush_work() ensures proper synchronization.

Add _add_ublk_dev_no_settle() helper function to skip udevadm settle,
which would otherwise hang waiting for partition scan events to
complete when partition table read is delayed.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/test_common.sh   | 16 +++--
 .../testing/selftests/ublk/test_generic_15.sh | 68 +++++++++++++++++++
 3 files changed, 81 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_15.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 837977b62417..eb0e6cfb00ad 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -22,6 +22,7 @@ TEST_PROGS += test_generic_11.sh
 TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
 TEST_PROGS += test_generic_14.sh
+TEST_PROGS += test_generic_15.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 6f1c042de40e..ea9a5f3eb70a 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -178,8 +178,9 @@ _have_feature()
 _create_ublk_dev() {
 	local dev_id;
 	local cmd=$1
+	local settle=$2
 
-	shift 1
+	shift 2
 
 	if [ ! -c /dev/ublk-control ]; then
 		return ${UBLK_SKIP_CODE}
@@ -194,7 +195,10 @@ _create_ublk_dev() {
 		echo "fail to add ublk dev $*"
 		return 255
 	fi
-	udevadm settle
+
+	if [ "$settle" = "yes" ]; then
+		udevadm settle
+	fi
 
 	if [[ "$dev_id" =~ ^[0-9]+$ ]]; then
 		echo "${dev_id}"
@@ -204,14 +208,18 @@ _create_ublk_dev() {
 }
 
 _add_ublk_dev() {
-	_create_ublk_dev "add" "$@"
+	_create_ublk_dev "add" "yes" "$@"
+}
+
+_add_ublk_dev_no_settle() {
+	_create_ublk_dev "add" "no" "$@"
 }
 
 _recover_ublk_dev() {
 	local dev_id
 	local state
 
-	dev_id=$(_create_ublk_dev "recover" "$@")
+	dev_id=$(_create_ublk_dev "recover" "yes" "$@")
 	for ((j=0;j<20;j++)); do
 		state=$(_get_ublk_dev_state "${dev_id}")
 		[ "$state" == "LIVE" ] && break
diff --git a/tools/testing/selftests/ublk/test_generic_15.sh b/tools/testing/selftests/ublk/test_generic_15.sh
new file mode 100755
index 000000000000..76379362e0a2
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_15.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_15"
+ERR_CODE=0
+
+_test_partition_scan_no_hang()
+{
+	local recovery_flag=$1
+	local expected_state=$2
+	local dev_id
+	local state
+	local daemon_pid
+	local start_time
+	local elapsed
+
+	# Create ublk device with fault_inject target and very large delay
+	# to simulate hang during partition table read
+	# --delay_us 60000000 = 60 seconds delay
+	# Use _add_ublk_dev_no_settle to avoid udevadm settle hang waiting
+	# for partition scan events to complete
+	if [ "$recovery_flag" = "yes" ]; then
+		echo "Testing partition scan with recovery support..."
+		dev_id=$(_add_ublk_dev_no_settle -t fault_inject -q 1 -d 1 --delay_us 60000000 -r 1)
+	else
+		echo "Testing partition scan without recovery..."
+		dev_id=$(_add_ublk_dev_no_settle -t fault_inject -q 1 -d 1 --delay_us 60000000)
+	fi
+
+	_check_add_dev "$TID" $?
+
+	# The add command should return quickly because partition scan is async.
+	# Now sleep briefly to let the async partition scan work start and hit
+	# the delay in the fault_inject handler.
+	sleep 1
+
+	# Kill the ublk daemon while partition scan is potentially blocked
+	# And check state transitions properly
+	start_time=${SECONDS}
+	daemon_pid=$(_get_ublk_daemon_pid "${dev_id}")
+	state=$(__ublk_kill_daemon "${dev_id}" "${expected_state}")
+	elapsed=$((SECONDS - start_time))
+
+	# Verify the device transitioned to expected state
+	if [ "$state" != "${expected_state}" ]; then
+		echo "FAIL: Device state is $state, expected ${expected_state}"
+		ERR_CODE=255
+		${UBLK_PROG} del -n "${dev_id}" > /dev/null 2>&1
+		return
+	fi
+	echo "PASS: Device transitioned to ${expected_state} in ${elapsed}s without hanging"
+
+	# Clean up the device
+	${UBLK_PROG} del -n "${dev_id}" > /dev/null 2>&1
+}
+
+_prep_test "partition_scan" "verify async partition scan prevents IO hang"
+
+# Test 1: Without recovery support - should transition to DEAD
+_test_partition_scan_no_hang "no" "DEAD"
+
+# Test 2: With recovery support - should transition to QUIESCED
+_test_partition_scan_no_hang "yes" "QUIESCED"
+
+_cleanup_test "partition_scan"
+_show_result $TID $ERR_CODE
-- 
2.47.0

