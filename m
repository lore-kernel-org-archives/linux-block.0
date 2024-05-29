Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B01B810
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002920; cv=none; b=nrna/tLaD4R8znk3hiEAZJNoQLyfSjDACleGYq+rrKlTKGiGCWzZ4lfgNkzTpA4cJ8uFFFtb7udHFgf/LxR+n7xkG7vNHxB0g4tRk4Nng8DtQG5cRpLe4QsCGJRhuwdPji4OGcjZyribwYV3e/kuJNG7pXf2B7bi8TNf/hlxxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002920; c=relaxed/simple;
	bh=iaVDQ87gs6Mp2lGE6mGLXrEpYVMBwnGnt5yYnib3ZE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFD3heFq/GPt48bt+gCT3UgUnsFywyOSZUcR5VO2JHy32347HZ+VfEtr1cwqjtyNn7mTOyFh5VvgAjxxUaOi4yWdzlf9LcrOfaiLjx8N3XKja+eyiMJhmkCSLRnSbbiDXPj2kR0kKrttBlcmtcakC+gDayS2igw3VTLPInjsIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44TGYCTg026382;
	Wed, 29 May 2024 17:15:18 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:message-id:mime-versi?=
 =?UTF-8?Q?on:subject:to;_s=3Dcorp-2023-11-20;_bh=3DbGqyHs8h4F4ZDXY/O+HFrs?=
 =?UTF-8?Q?Zlutep7JWT1CZNwO+R7YM=3D;_b=3DNSd4vbmXDr6wzyAMkPYW1Ex1NkGp+6OJK?=
 =?UTF-8?Q?tRbEuQwvYXXRHlzauNqgFefFa43F+usSofk_FF4Jj2MlhEXnAweZpEKc4MLlL7t?=
 =?UTF-8?Q?c3/E88NwBVsBIrmtpvcdZTDCHj9Su8c5TcBlSWY2X_Gi4eJF0qFnZmEtOkjli4I?=
 =?UTF-8?Q?2LEAIeQlfd1c0L8LfVDxbqlLbSQGXH/pASAz212FCB8kTEd_9OKSlpCFpeQLRNX?=
 =?UTF-8?Q?1Uy8zLoMRg4ZSj9jY+kNTz30fHQ2MuN7UM8brT1tUQ4VCJdbzsZJ+_Sj+a8Lkl4?=
 =?UTF-8?Q?0apJ/Nks6gmRyt9t9ZS1/fkeQqyR84dOOdicfOUVbK8qmyZQpUgGK4GQxAW_Dg?=
 =?UTF-8?Q?=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7q4n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 17:15:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44TGKAl7024109;
	Wed, 29 May 2024 17:15:16 GMT
Received: from gms-lo-open-test.osdevelopmeniad.oraclevcn.com (gms-lo-open-test.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.129])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yc52cswjk-1;
	Wed, 29 May 2024 17:15:16 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com
Subject: [PATCH V2 blktests] loop: Detect a race condition between loop detach and open
Date: Wed, 29 May 2024 17:15:16 +0000
Message-Id: <20240529171516.54111-1-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_13,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=825 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405290120
X-Proofpoint-ORIG-GUID: opqWMRQuQLNKb7hBv9A6MD-C89Qd51qx
X-Proofpoint-GUID: opqWMRQuQLNKb7hBv9A6MD-C89Qd51qx

When one process opens a loop device partition and another process detaches
it, there will be a race condition due to which stale loop partitions are
created causing IO errors. This test will detect the race

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
 tests/loop/010     | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/loop/010.out |  2 ++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/loop/010
 create mode 100644 tests/loop/010.out

diff --git a/tests/loop/010 b/tests/loop/010
new file mode 100755
index 000000000000..aa9c1d33bdb9
--- /dev/null
+++ b/tests/loop/010
@@ -0,0 +1,75 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024, Oracle and/or its affiliates.
+#
+# Test to detect a race between loop detach and loop open which creates
+# stale loop partitions when one process opens the loop partition and
+# another process detaches the loop device
+#
+. tests/loop/rc
+DESCRIPTION="check stale loop partition"
+TIMED=1
+
+requires() {
+        _have_program parted
+        _have_program mkfs.xfs
+}
+
+image_file="$TMPDIR/loopImg"
+
+create_loop()
+{
+        while true
+        do
+                loop_device="$(losetup -P -f --show "${image_file}")"
+                blkid /dev/loop0p1 >> /dev/null 2>&1
+        done
+}
+
+detach_loop()
+{
+        while true
+        do
+                if [ -e /dev/loop0 ]; then
+                        losetup -d /dev/loop0 > /dev/null 2>&1
+                fi
+        done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	local loop_device
+
+	truncate -s 1G "${image_file}"
+	parted -a none -s "${image_file}" mklabel gpt
+	loop_device="$(losetup -P -f --show "${image_file}")"
+	parted -a none -s "${loop_device}" mkpart primary 64s 109051s
+	
+	udevadm settle
+        if [ ! -e "${loop_device}" ]; then
+		return 1
+        fi
+
+        mkfs.xfs -f "${loop_device}p1" > /dev/null 2>&1
+
+        losetup -d "${loop_device}" >  /dev/null 2>&1
+
+        create_loop &
+	create_pid=$!
+        detach_loop &
+	detach_pid=$!
+
+	sleep "${TIMEOUT:-90}"
+        {
+                kill -9 $create_pid
+		kill -9 $detach_pid
+                wait
+                sleep 1
+        } 2>/dev/null
+
+        losetup -D > /dev/null 2>&1
+	if _dmesg_since_test_start | grep -q "partition scan of loop0 failed (rc=-16)"; then
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

