Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A4148822;
	Tue, 21 May 2024 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331378; cv=none; b=OP0NXfhnkDX8sryJsQdWhjQtcb1RJrsQAhhggjzyEwGJGoXgTIPiFr5tKLBfRyEcz8I2aS8Pu7yuQ0AEJBB+G1Pt/NSPEvpB9s2CKyR/+r1sUZRyS7hKoUmMQBoRjYyFI6gJ82/DIi3AxboYOuj0ihp4UCPsROedTpkFRTB64eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331378; c=relaxed/simple;
	bh=yY8zlT/PL5VTNiq3vdotGSL660sAVocZU7U+6+I24yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VXnEC5ry4IVreTgs5gJVMcqBVSsB+Zn+CbcCLt9am2a7nXr6FHB1c+Ylj0gUMsB1qNK44GHekdDIfftudIhUBbH4FBpowLBn8PnvoR5FH5eS30+NYTXYnouHAuOd+spPpnFuLuZ/BpnwhPEFLwbVsQVUHh04MHfx0Mva4Sez6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WCZGvxIg; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WCZGvxIg"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LJi3HC011527;
	Tue, 21 May 2024 22:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=ysAxM2ZHB/G5roOubrF1gDHkCZEmg5fMV3KnGM+3Vmk=;
 b=WCZGvxIgYgimuxARfzq37A20yMiVcM0EqntebL9QSfzJwHs/a1KsyRPKX5zuXvlNctst
 hQ783ypxESx5Ey4K7QtLXTiVE6dVj29KlOD32Rd7c6bqenR0QyiWzsxsu+DNIIKkJWc2
 CPzBcK1x4FqKvA4NcoFEWbPcXWR5IPHkjxb9wN3CB5p4CoNxryyHDcSX84uz7SRne5TV
 1jIjSh8dIH3w+kwLj6W3M3f7TFfgSEPP2zALJ6D81ByPd05aCGtE16biH6/dcLf3lg44
 dk+SoRmjCWOOANz2qVV81lgBqP61wjuja0xq9s9CA7DbR73VlBC4CFHv7koHCBXITckm tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcdxhpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 22:42:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LLIjjs019519;
	Tue, 21 May 2024 22:42:50 GMT
Received: from gms-lo-open-test.osdevelopmeniad.oraclevcn.com (gms-lo-open-test.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.129])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js8ef4q-2;
	Tue, 21 May 2024 22:42:50 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
        hch@lst.de
Subject: [PATCH 2/2] loop: Test to detect a race condition between loop detach and open
Date: Tue, 21 May 2024 22:42:49 +0000
Message-Id: <20240521224249.7389-2-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240521224249.7389-1-gulam.mohamed@oracle.com>
References: <20240521224249.7389-1-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_14,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=883 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210172
X-Proofpoint-ORIG-GUID: SM8MsTt8DaHYLWvj4muQ5MNXSzGCPGuR
X-Proofpoint-GUID: SM8MsTt8DaHYLWvj4muQ5MNXSzGCPGuR

When one process opens a loop device partition and another process detaches
it, there will be a race condition due to which stale loop partitions are
created causing IO errors. This test will detect the race

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
 tests/loop/010     | 90 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/loop/010.out |  2 ++
 2 files changed, 92 insertions(+)
 create mode 100755 tests/loop/010
 create mode 100644 tests/loop/010.out

diff --git a/tests/loop/010 b/tests/loop/010
new file mode 100755
index 000000000000..ea93a120d51a
--- /dev/null
+++ b/tests/loop/010
@@ -0,0 +1,90 @@
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
+image_file="/tmp/loopImg"
+line1="partition scan of loop0 failed (rc=-16)"
+
+function create_loop()
+{
+        while [ 1 ]
+        do
+                loop_device="$(losetup -P -f --show "${image_file}")"
+                blkid /dev/loop0p1 >> /dev/null 2>&1
+        done
+}
+
+function detach_loop()
+{
+        while [ 1 ]
+        do
+                if [ -e /dev/loop0 ]; then
+                        losetup -d /dev/loop0 > /dev/null 2>&1
+                fi
+        done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	local failure="/tmp/failure"
+	touch $failure
+	echo 0 > $failure
+	dmesg -c > /dev/null 2>&1
+
+	truncate -s 2G "${image_file}"
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
+	sleep "${TIMEOUT:-180}"
+        {
+                kill -9 $create_pid
+		kill -9 $detach_pid
+                wait
+                sleep 1
+        } 2>/dev/null
+
+        losetup -D > /dev/null 2>&1
+        dmesg  | while IFS= read -r line2
+	do
+        	match=$(echo "$line2" | grep -o "$line1")
+                if [ "$line1" == "$match" ]; then
+			echo 1 > "/tmp/failure"
+			break
+                fi
+        done
+	failed=$(cat $failure)
+	if [ $failed -eq 0 ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+	fi
+	rm -f $failure
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

