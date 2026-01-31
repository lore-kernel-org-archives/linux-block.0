Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1C33B955
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876659; cv=none; b=tFXcfYu2pJD8T1IUzlHVGbxfBypNUZ2ECx7ngb5d25lf/u6Vns3CrB3Yg9w3xIa+/+sN/EbuMUaq5iPr9Rf6eBnMmcIxCX8CBQrI4v/px8VvI1kqw6au5PwkdS66WqzCKFnB+d4IX1udb92cF3n1Z3j1WDVeDzjt3FSI4C7ohLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876659; c=relaxed/simple;
	bh=nqDsdCnf3s7KcCnAziWza8C1dPVmFLUD/KKzcw4YVzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVgYtg0mklPOak4wV0KjosIDX0ln5hgXL3D/yS0rdpyFfHO2XyXIE/f8u5h8M7X/4PaLppFBa+DOWlrrJvf8y1QTo3LEVkTGfEwt+x7Sk3UUtTx7yHv43jH2CVqxFrTS64+zJZX9jfuVJB4xbSWId9woh9ABJ7m4fFet4XOqbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SebJJIe5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SebJJIe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769876657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8QE8IbY4TApNi1m1RCKJ2PC+bGcrOt/Sf/xVvb/JME=;
	b=SebJJIe5D0wvOPbLoLCJ9gcdwLr0DOXdaDgzYe6v2wqSPFHgYheFG7mGops1vH5xKePVbf
	J4suAMSrlRDTqa22ieSnf17vVP4Mtc7fpVGuKJ5+naVwTQ53hu+/KDRn3DvXMBSbawlXY0
	jk2fk0pAaBP91YJgFnVZIoLGrSmGl4I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-A1FEj4kwO26rC8errkbsTw-1; Sat,
 31 Jan 2026 11:24:13 -0500
X-MC-Unique: A1FEj4kwO26rC8errkbsTw-1
X-Mimecast-MFC-AGG-ID: A1FEj4kwO26rC8errkbsTw_1769876652
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F14E818003FD;
	Sat, 31 Jan 2026 16:24:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D15FB19560A2;
	Sat, 31 Jan 2026 16:24:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/9] selftests: ublk: add _ublk_del_dev helper function
Date: Sun,  1 Feb 2026 00:23:34 +0800
Message-ID: <20260131162342.13872-4-ming.lei@redhat.com>
In-Reply-To: <20260131162342.13872-1-ming.lei@redhat.com>
References: <20260131162342.13872-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add _ublk_del_dev() to delete a specific ublk device by ID and
use it in all test scripts instead of calling UBLK_PROG directly.

Also remove unused _remove_ublk_devices() function.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh     | 13 +++++++------
 tools/testing/selftests/ublk/test_generic_16.sh |  4 ++--
 tools/testing/selftests/ublk/test_null_04.sh    |  8 ++++----
 tools/testing/selftests/ublk/test_part_02.sh    |  4 ++--
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 8d298a7ee7b1..0f1fdb0892b4 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -106,11 +106,6 @@ _check_root() {
 	fi
 }
 
-_remove_ublk_devices() {
-	${UBLK_PROG} del -a
-	modprobe -r ublk_drv > /dev/null 2>&1
-}
-
 _get_ublk_dev_state() {
 	${UBLK_PROG} list -n "$1" | grep "state" | awk '{print $11}'
 }
@@ -277,10 +272,16 @@ __ublk_kill_daemon()
 	echo "$state"
 }
 
-__remove_ublk_dev_return() {
+_ublk_del_dev() {
 	local dev_id=$1
 
 	${UBLK_PROG} del -n "${dev_id}"
+}
+
+__remove_ublk_dev_return() {
+	local dev_id=$1
+
+	_ublk_del_dev "${dev_id}"
 	local res=$?
 	udevadm settle
 	return ${res}
diff --git a/tools/testing/selftests/ublk/test_generic_16.sh b/tools/testing/selftests/ublk/test_generic_16.sh
index 42e8d2e16ec9..3ef367836ac5 100755
--- a/tools/testing/selftests/ublk/test_generic_16.sh
+++ b/tools/testing/selftests/ublk/test_generic_16.sh
@@ -24,7 +24,7 @@ if ! ${UBLK_PROG} stop -n "${dev_id}" --safe; then
 fi
 
 # Clean up device
-${UBLK_PROG} del -n "${dev_id}" > /dev/null 2>&1
+_ublk_del_dev "${dev_id}" > /dev/null 2>&1
 udevadm settle
 
 # Test 2: stop --safe on device with active opener should fail
@@ -49,7 +49,7 @@ kill $dd_pid 2>/dev/null
 wait $dd_pid 2>/dev/null
 
 # Now device should be idle, regular delete should work
-${UBLK_PROG} del -n "${dev_id}"
+_ublk_del_dev "${dev_id}"
 udevadm settle
 
 _cleanup_test "null"
diff --git a/tools/testing/selftests/ublk/test_null_04.sh b/tools/testing/selftests/ublk/test_null_04.sh
index a5599d38583a..6713b280a6ff 100755
--- a/tools/testing/selftests/ublk/test_null_04.sh
+++ b/tools/testing/selftests/ublk/test_null_04.sh
@@ -34,7 +34,7 @@ _test_metadata_only() {
 		"$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")" 512 &&
 	_check_value "tag_size" "$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")" 0
 
-	${UBLK_PROG} del -n "${dev_id}"
+	_ublk_del_dev "${dev_id}"
 }
 
 _test_integrity_capable_ip() {
@@ -53,7 +53,7 @@ _test_integrity_capable_ip() {
 		"$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")" 512 &&
 	_check_value "tag_size" "$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")" 0
 
-	${UBLK_PROG} del -n "${dev_id}"
+	_ublk_del_dev "${dev_id}"
 }
 
 _test_integrity_reftag_t10dif() {
@@ -72,7 +72,7 @@ _test_integrity_reftag_t10dif() {
 		"$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")" 512 &&
 	_check_value "tag_size" "$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")" 0
 
-	${UBLK_PROG} del -n "${dev_id}"
+	_ublk_del_dev "${dev_id}"
 }
 
 _test_nvme_csum() {
@@ -91,7 +91,7 @@ _test_nvme_csum() {
 		"$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")" 512 &&
 	_check_value "tag_size" "$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")" 8
 
-	${UBLK_PROG} del -n "${dev_id}"
+	_ublk_del_dev "${dev_id}"
 }
 
 _prep_test "null" "integrity params"
diff --git a/tools/testing/selftests/ublk/test_part_02.sh b/tools/testing/selftests/ublk/test_part_02.sh
index 727d0f4610d6..acd098deda3a 100755
--- a/tools/testing/selftests/ublk/test_part_02.sh
+++ b/tools/testing/selftests/ublk/test_part_02.sh
@@ -46,13 +46,13 @@ _test_partition_scan_no_hang()
 	if [ "$state" != "${expected_state}" ]; then
 		echo "FAIL: Device state is $state, expected ${expected_state}"
 		ERR_CODE=255
-		${UBLK_PROG} del -n "${dev_id}" > /dev/null 2>&1
+		_ublk_del_dev "${dev_id}" > /dev/null 2>&1
 		return
 	fi
 	echo "PASS: Device transitioned to ${expected_state} in ${elapsed}s without hanging"
 
 	# Clean up the device
-	${UBLK_PROG} del -n "${dev_id}" > /dev/null 2>&1
+	_ublk_del_dev "${dev_id}" > /dev/null 2>&1
 }
 
 _prep_test "partition_scan" "verify async partition scan prevents IO hang"
-- 
2.47.0

