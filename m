Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB52B9A0
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717050353; cv=none; b=js3Ty/4b0c3wKHMTL3uP9TvrHyxBWP6SAQmm6ycHEhRRaQBnvZA2CSa48pCq4dE/l6K/vlW0TcgL2L3FTzzgzRIA99wXYkx8zkUuQmrPfD2h0dllSDaUaGP/EMIThsj34Xkpl5TF1RdmqZ88K7wyJYbgooDKT6NmgeN54dVmoes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717050353; c=relaxed/simple;
	bh=ZDcFsnA0i1LjyLR1crnrYyoQ5zgqFLBc1sDLgAA2fgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EIzwK1KGOBNC5DTYvTnaaYufPRw1jjIaQfMFOdbHvtx/fKIus4syw4i4MqS8UCO2H9DuR2bcNZxvsmOubRxzJW/RZ4/SAL86eM53//N9we7J9c1W/QCnjvdG+JtqBjzza+nEFeXMGcJRfbqwJRUuncRHsXIRfrllh7QOM/HpFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U5mRDX028552;
	Thu, 30 May 2024 06:25:47 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:message-id:mime-versi?=
 =?UTF-8?Q?on:subject:to;_s=3Dcorp-2023-11-20;_bh=3DPcwe1susMFs6axzxQyaLUP?=
 =?UTF-8?Q?82jY/su08Rw5XeJWqwwV0=3D;_b=3DYySbUFA761uXeECDn2Rm9IFiyHgw0L0mD?=
 =?UTF-8?Q?IrJk3XazT7MljomHuRAvp1XzkaKt/bpmumn_SyQW+Y9GEhpEm5a14IDHQprOp28?=
 =?UTF-8?Q?rFrlqi78PvHwRH1tSvWPm3JVx2NdZpVF+Bdpm35er_OQM66M0r8J8dH62Z+TvVV?=
 =?UTF-8?Q?AAYAqNXZpW4cFVrCh/eunc3XEVbdn/pNRZLZck/UdzQtthW_IXoZ3hbPMJfCaRK?=
 =?UTF-8?Q?3RxIAo0YPjNaV168JPGr1K9/Lvm0atdE15f73EnOvDu83Qidf7e75_5NW1Q3xdf?=
 =?UTF-8?Q?MKFtW666IRnbIYt3JLY8tbbCYzskVoqeionIlpM9RVbUTy4sLS3nJ/08Sz1_1g?=
 =?UTF-8?Q?=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g4894g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 06:25:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44U4u7wv010726;
	Thu, 30 May 2024 06:25:45 GMT
Received: from gms-lo-open-test.osdevelopmeniad.oraclevcn.com (gms-lo-open-test.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.129])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yc5106ngv-1;
	Thu, 30 May 2024 06:25:45 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com
Subject: [PATCH V3 blktests] loop: Detect a race condition between loop detach and open
Date: Thu, 30 May 2024 06:25:45 +0000
Message-Id: <20240530062545.79400-1-gulam.mohamed@oracle.com>
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
 definitions=2024-05-30_03,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=929 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300046
X-Proofpoint-GUID: PH65gPGD7bbD-JFkjqCelrEpneLXHAYe
X-Proofpoint-ORIG-GUID: PH65gPGD7bbD-JFkjqCelrEpneLXHAYe

When one process opens a loop device partition and another process detaches
it, there will be a race condition due to which stale loop partitions are
created causing IO errors. This test will detect the race

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
v3<-v2:
Resolved all the formatting issues

 tests/loop/010     | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/loop/010.out |  2 ++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/loop/010
 create mode 100644 tests/loop/010.out

diff --git a/tests/loop/010 b/tests/loop/010
new file mode 100755
index 000000000000..19ceb6ab69cf
--- /dev/null
+++ b/tests/loop/010
@@ -0,0 +1,77 @@
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
+	_have_program parted
+	_have_program mkfs.xfs
+	_have_program blkid
+	_have_program udevadm
+}
+
+image_file="$TMPDIR/loopImg"
+
+create_loop() {
+	while true
+	do
+		loop_device="$(losetup -P -f --show "${image_file}")"
+		blkid /dev/loop0p1 >> /dev/null 2>&1
+	done
+}
+
+detach_loop() {
+	while true
+	do
+		if [ -e /dev/loop0 ]; then
+			losetup -d /dev/loop0 > /dev/null 2>&1
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
+	truncate -s 1G "${image_file}"
+	parted -a none -s "${image_file}" mklabel gpt
+	loop_device="$(losetup -P -f --show "${image_file}")"
+	parted -a none -s "${loop_device}" mkpart primary 64s 109051s
+
+	udevadm settle
+
+	if [ ! -e "${loop_device}" ]; then
+		return 1
+	fi
+
+	mkfs.xfs -f "${loop_device}p1" > /dev/null 2>&1
+	losetup -d "${loop_device}" >  /dev/null 2>&1
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
+	losetup -D > /dev/null 2>&1
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

