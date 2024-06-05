Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5419D899
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604301; cv=none; b=i1SiHuvC55hImfi8giI+84nOKgJAN8mbMfYDbhkU1p93HvEUSmLMn5Qm4zxrEEIqXHqrNgB3up2+kbk/PkaKloyVjXseTZwx36mLUDm9HXuTgw8y8Ja5WLxzNo6Koyw4m+5IaBhiz/gy2nwOiZmpGbS5AuxRVFF0b5NOzA8TrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604301; c=relaxed/simple;
	bh=fwWU9ACLHlXOSaWCSc9OkDOHKfli8HD1HB9skGbW5wA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JTLiNgrV/TvMUTCtVXI9Mr7jFXLlaVujqJXtm2Vs8JkqS1T+l4qPWOLVkt084RMMOK0kfL2i8vGeTIZlSNXvWkpvE4/rU0Ez3iGu2IlgnS2j9qrvzDBelNK7fH09o3RXs8EEQZ5aezAcQEQ/U+PZ/P4xITKBl59vxT16HHoAS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Snfrg//j; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Snfrg//j"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455CX74w016230;
	Wed, 5 Jun 2024 16:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=corp-2023-11-20;
 bh=nXDwuzf8ZCw8mtVnH92xBGHNdkLZ8tOpmAeNBQr7cXU=;
 b=Snfrg//juf+nMt9Ez99XFYqYig/MtuKXi0gIC9tQdfZCvB/JTNoZgMpSIDCO7SqzYG9f
 JpWqeF65UsGs8cGkODxPyxiypP65DseTW5AbbsfCG4UZ3PPW6IU0SUPyUp1A3fFtxyC4
 1RN/5OxQR68E3Xf46HZEDTXSNoKy8reXFr/aneV2KDVOzWHmhP6kBMXoAsHSaeDWPCb2
 hVIBFtxyafe9+2ctBl3NmOZQZpHDW4EnbleTaJrIbNdi9UrFuIUrA3BaZlVvXUaWCNsd
 G8ltq9e5tJ9OQO9q/DSaDJfBIysTNXaimXv2CJqqdsu0o/6zWWHs5lEOwcLavbKa+o4O GA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtw9pbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 16:18:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455G4o03016140;
	Wed, 5 Jun 2024 16:18:16 GMT
Received: from gms-lo-open-test.osdevelopmeniad.oraclevcn.com (gms-lo-open-test.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.129])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ygrsbs5xq-1;
	Wed, 05 Jun 2024 16:18:16 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com
Subject: [PATCH V4 blktests] loop: Detect a race condition between loop detach and open
Date: Wed,  5 Jun 2024 16:18:15 +0000
Message-Id: <20240605161815.34923-1-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=983 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050122
X-Proofpoint-GUID: Zb-1lH4ZaPFIa7hZhG9afySw_f_NqBbO
X-Proofpoint-ORIG-GUID: Zb-1lH4ZaPFIa7hZhG9afySw_f_NqBbO

When one process opens a loop device partition and another process detaches
it, there will be a race condition due to which stale loop partitions are
created causing IO errors. This test will detect the race.

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
v4<-v3:
1. Resolved formatting issues
2. Using long options for commands instead of short options

 tests/loop/010     | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/loop/010.out |  2 ++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/loop/010
 create mode 100644 tests/loop/010.out

diff --git a/tests/loop/010 b/tests/loop/010
new file mode 100755
index 000000000000..f5d1bf1f9c18
--- /dev/null
+++ b/tests/loop/010
@@ -0,0 +1,75 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024, Oracle and/or its affiliates.
+#
+# Test to detect a race between loop detach and loop open which creates
+# stale loop partitions when one process opens the loop partition and
+# another process detaches the loop device.
+#
+. tests/loop/rc
+DESCRIPTION="check stale loop partition"
+TIMED=1
+
+requires() {
+	_have_program parted
+	_have_program mkfs.xfs
+}
+
+image_file="$TMPDIR/loopImg"
+
+create_loop() {
+	while true
+	do
+		loop_device="$(losetup --partscan --find --show "${image_file}")"
+		blkid /dev/loop0p1 >& /dev/null
+	done
+}
+
+detach_loop() {
+	while true
+	do
+		if [ -e /dev/loop0 ]; then
+			losetup --detach /dev/loop0 >& /dev/null
+		fi
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	local loop_device
+	local create_pid
+	local detach_pid
+
+	truncate --size 1G "${image_file}"
+	parted --align none --script "${image_file}" mklabel gpt
+	loop_device="$(losetup --partscan --find --show "${image_file}")"
+	parted --align none --script "${loop_device}" mkpart primary 64s 109051s
+
+	udevadm settle
+
+	if [ ! -e "${loop_device}" ]; then
+		return 1
+	fi
+
+	mkfs.xfs --force "${loop_device}p1" >& /dev/null
+	losetup --detach "${loop_device}" >&  /dev/null
+
+	create_loop &
+	create_pid=$!
+	detach_loop &
+	detach_pid=$!
+
+	sleep "${TIMEOUT:-90}"
+	{
+		kill -9 $create_pid
+		kill -9 $detach_pid
+		wait
+		sleep 1
+	} 2>/dev/null
+
+	losetup --detach-all >& /dev/null
+	if _dmesg_since_test_start | grep --quiet "partition scan of loop0 failed (rc=-16)"; then
+		echo "Fail"
+	fi
+	echo "Test complete"
+}
diff --git a/tests/loop/010.out b/tests/loop/010.out
new file mode 100644
index 000000000000..64a6aee00b8a
--- /dev/null
+++ b/tests/loop/010.out
@@ -0,0 +1,2 @@
+Running loop/010
+Test complete
-- 
2.39.3

