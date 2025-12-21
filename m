Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A5137C52
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766335329; cv=none; b=lvhq/Tf/J+nTI+ul94czlY+MjnISb/Oddl93ix1m5AdR0HjM85u/ZOfWmaG57CdXHsQDrnpfeoEN45f3zVMzX0nAQ0mBoSPINaw9j8yuzLuR0+0mPQNuubYJTpmpgBZat79Bk8Mb0lOswARvh1W8o1TXcePq8S/uHmIgXBFXIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766335329; c=relaxed/simple;
	bh=XE417c/xc8y0HDkhdXywdnhNQ6mOZfpFObkp5Fl6QcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlwVCBrzq8s5DFJArmzyKpy36Ug/w6Wsa2HL4g8jPrGQR8LDaqyJXrS7a1ACc2FRaj/yi0UARH2/+19zPSNGAOIvyFuFCmAVf+bXcFrZgpi00UiJ+OBPwndrTJ68iOrm8pB7NTxO1ODS1LjRZ/TSHI2VzxoaffkOnrQ36SLbuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXdAZoGY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXdAZoGY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766335325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihGaQTa9fPVxKtpBixbmxHqDfmImL4eTlqDQTqtAf7Y=;
	b=fXdAZoGY9wiD40JY+wpsfFTDkLzS+2lRREwJcI0jLX32hjHh3csKbgT+LcFNPAPdBafHb3
	CVkAPLBChJb1SWElYofKFleVh+rcrld7SCmnYhYfHkFjwEgX7n/StmipjjbQWVZlJk0rfv
	mnoEt1vCNEoGJ3b+f/3fyxBCHbSegTI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-Uf5Ej7qPMx2pzkQViTS4rQ-1; Sun,
 21 Dec 2025 11:42:02 -0500
X-MC-Unique: Uf5Ej7qPMx2pzkQViTS4rQ-1
X-Mimecast-MFC-AGG-ID: Uf5Ej7qPMx2pzkQViTS4rQ_1766335321
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17BDC195608D;
	Sun, 21 Dec 2025 16:42:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C19E1955F1A;
	Sun, 21 Dec 2025 16:41:59 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] selftests/ublk: add test for async partition scan
Date: Mon, 22 Dec 2025 00:41:42 +0800
Message-ID: <20251221164145.1703448-3-ming.lei@redhat.com>
In-Reply-To: <20251221164145.1703448-1-ming.lei@redhat.com>
References: <20251221164145.1703448-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add test_generic_15.sh to verify that async partition scan prevents
IO hang when reading partition tables.

The test creates ublk devices with fault_inject target and very large
delay (60s) to simulate blocked partition table reads, then kills the
daemon to verify proper state transitions without hanging:

1. Without recovery support (-r 0):
   - Create device with fault_inject and 60s delay
   - Kill daemon while partition scan may be blocked
   - Verify device transitions to DEAD state within 10s

2. With recovery support (-r 1):
   - Create device with fault_inject, 60s delay, and recovery
   - Kill daemon while partition scan may be blocked
   - Verify device transitions to QUIESCED state within 10s

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
 tools/testing/selftests/ublk/test_common.sh   | 16 +++-
 .../testing/selftests/ublk/test_generic_15.sh | 80 +++++++++++++++++++
 3 files changed, 93 insertions(+), 4 deletions(-)
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
index 000000000000..c241e641c340
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_15.sh
@@ -0,0 +1,80 @@
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
+	start_time=${SECONDS}
+	daemon_pid=$(_get_ublk_daemon_pid "${dev_id}")
+
+	# Kill daemon and check state transitions properly
+	state=$(__ublk_kill_daemon "${dev_id}" "${expected_state}")
+
+	elapsed=$((SECONDS - start_time))
+
+	# Verify the device transitioned to expected state
+	if [ "$state" != "${expected_state}" ]; then
+		echo "FAIL: Device state is $state, expected ${expected_state}"
+		ERR_CODE=255
+		${UBLK_PROG} del -n "${dev_id}" > /dev/null 2>&1
+		return
+	fi
+
+	# Verify state transition happened within reasonable time (< 10s)
+	# This ensures we didn't hang waiting for partition scan
+	if [ $elapsed -ge 10 ]; then
+		echo "FAIL: State transition took $elapsed seconds (>= 10s), likely hung on partition scan"
+		ERR_CODE=255
+		${UBLK_PROG} del -n "${dev_id}" > /dev/null 2>&1
+		return
+	fi
+
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

