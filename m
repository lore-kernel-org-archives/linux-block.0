Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78A1487C1
	for <linux-block@vger.kernel.org>; Fri, 16 Feb 2024 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126177; cv=none; b=SxR2yU+fwVjQI2KC0xMLZRSawG3KRwbzSagGbBNo87AOfRo8Ve6VZCrjUsYe7wxyUt5uUYNk4bBnMOkc0x5FdcioNUchwK3jc0j0p8P2U5S+IIlfSQ2yCD9juQMjzgPPbxy/W9AQhda+Wd2pTZn68lHO6PJ+ShQmuZOtIyPx1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126177; c=relaxed/simple;
	bh=xWlK/PJ4C4EYMrAvTQjQbPE7HcsmjidOIkzUzwufSeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SBrHHi8nNipofCyRDonrjCz0yaQQLWO8e5j828KfXaF+HcICT48zjBuPM2QIxBBHxvCJKHT9SZnL+1l92lI8KmsCVKAn3RCbCYRqbBmJ9LuJu5o3tufrBnS4kZtOp5odH60vXBcYBPimGJTn/1bOA6nILHTKfAHUDjXYauHf5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c+uij9Wv; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c+uij9Wv"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKEGPG009241;
	Fri, 16 Feb 2024 23:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=KWRxmexjxRAwEdHggpUpLdmDcN6dwwiaTa/57ju/x7I=;
 b=c+uij9WvdluU/1tApg5U6V62mKlbhPOnQ5Hbwx25rY1/sItuGKgwiqcQVmTlhgNDQs24
 PJA+oQHiieLv92fonLVS0KbjT9765g4/FcjF0rdd06xN5PahigSJ0fp99Dwyn7uJzx4q
 3C+fl9Pf/dj+pKStBISbDOA9c6VL1nxPgG6YbJqeCKoJokR7XUvxmB5wyPEUyPyOlqrC
 sRoWIrS/LzNmwNLtbX9acr0HElkHmw39MiMetqMZ6a0N3xmNv7pSbr0hk4KS5BeEBzHT
 +jpN0tqzCH4L8v1Z7VK1894DtWf95bwd+8AJt2TSaAZxEChHeyNsCvitHaefZO7s8z1J zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0pe85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 23:29:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GMtFjh024016;
	Fri, 16 Feb 2024 23:29:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykk52ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 23:29:27 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GNTQ6Y011465;
	Fri, 16 Feb 2024 23:29:26 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykk529s-1;
	Fri, 16 Feb 2024 23:29:26 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, chaitanyak@nvidia.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests] nvme: Add passthru error logging tests to nvme/039
Date: Fri, 16 Feb 2024 15:30:53 -0800
Message-Id: <20240216233053.2795930-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_23,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160184
X-Proofpoint-GUID: vRaHQTal2QzNdadErdDkTDQ2zp1kpugm
X-Proofpoint-ORIG-GUID: vRaHQTal2QzNdadErdDkTDQ2zp1kpugm

Tests the ability to enable and disable error logging for passthru admin commands issued to
the controller and passthru IO commands issued to a namespace.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/039     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |  2 ++
 tests/nvme/rc      | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/tests/nvme/039 b/tests/nvme/039
index 73b53d0b949c..7cf7638ed4c8 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -130,6 +130,33 @@ inject_invalid_admin_cmd()
 	fi
 }
 
+inject_invalid_io_cmd_passthru()
+{
+	local ns_dev
+	local ctrl_dev
+	local ns
+
+	ns_dev="$1"
+	ctrl_dev=${ns_dev%n*}
+	ns=$(echo "$ns_dev" |  cut -d "n" -f3)
+
+	# Inject a 'Invalid Command Opcode' (0x1) on a read (0x02)
+	_nvme_enable_err_inject "$ns_dev" 0 100 1 0x1 1
+
+	nvme io-passthru /dev/"$ctrl_dev" --opcode=0x02 --namespace-id="$ns" \
+		--data-len=512 --read --cdw10=0 --cdw11=0 --cdw12="$2" 2> /dev/null 1>&2
+
+	_nvme_disable_err_inject "$1"
+	if ${nvme_verbose_errors}; then
+		last_dmesg 2 | grep "Invalid Command Opcode (" | \
+		    sed 's/nvme.*://g'
+	else
+		last_dmesg 2 | grep "Cmd(0x2" | sed 's/I\/O Cmd/Read/g' | \
+		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
@@ -147,6 +174,7 @@ test_device() {
 	ctrl_dev=${ns_dev%n*}
 
 	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
+	_nvme_passthru_logging_setup "${ns_dev}" "${ctrl_dev}"
 
 	# wait DEFAULT_RATELIMIT_INTERVAL=5 seconds to ensure errors are printed
 	sleep 5
@@ -155,6 +183,19 @@ test_device() {
 	inject_invalid_status_on_read "${ns_dev}"
 	inject_write_fault_on_write "${ns_dev}"
 
+	# Test Pass Thru Admin Logging
+	_nvme_disable_passthru_admin_error_logging "${ctrl_dev}"
+	inject_invalid_admin_cmd "${ctrl_dev}"
+	_nvme_enable_passthru_admin_error_logging "${ctrl_dev}"
+	inject_access_denied_on_identify "${ctrl_dev}"
+
+	# Test Pass Thru IO Logging
+	_nvme_disable_passthru_io_error_logging "${ns_dev}" "${ctrl_dev}"
+	inject_invalid_io_cmd_passthru "${ns_dev}" 0
+	_nvme_enable_passthru_io_error_logging "${ns_dev}" "${ctrl_dev}"
+	inject_invalid_io_cmd_passthru "${ns_dev}" 1
+
+	_nvme_passthru_logging_cleanup "${ns_dev}" "${ctrl_dev}"
 	_nvme_err_inject_cleanup "${ns_dev}" "${ctrl_dev}"
 
 	echo "Test complete"
diff --git a/tests/nvme/039.out b/tests/nvme/039.out
index 139070d22240..fea76cfd1245 100644
--- a/tests/nvme/039.out
+++ b/tests/nvme/039.out
@@ -2,4 +2,6 @@ Running nvme/039
  Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 
  Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR 
  Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR 
+ Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR cdw10=0x1 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0
+ Read(0x2), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR cdw10=0x0 cdw11=0x0 cdw12=0x1 cdw13=0x0 cdw14=0x0 cdw15=0x0
 Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index dfc4c1ef1975..2d6ebeab2f6f 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -943,6 +943,23 @@ _check_uuid() {
 
 declare -A NS_DEV_FAULT_INJECT_SAVE
 declare -A CTRL_DEV_FAULT_INJECT_SAVE
+ns_dev_passthru_logging=off
+ctrl_dev_passthru_logging=off
+
+_nvme_passthru_logging_setup()
+{
+	ctrl_dev_passthru_logging=$(cat /sys/class/nvme/"$2"/passthru_err_log_enabled)
+	ns_dev_passthru_logging=$(cat /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled)
+
+	_nvme_disable_passthru_admin_error_logging "$2"
+	_nvme_disable_passthru_io_error_logging "$1" "$2"
+}
+
+_nvme_passthru_logging_cleanup()
+{
+	echo $ctrl_dev_passthru_logging > /sys/class/nvme/"$2"/passthru_err_log_enabled
+	echo $ns_dev_passthru_logging > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
+}
 
 _nvme_err_inject_setup()
 {
@@ -985,6 +1002,26 @@ _nvme_disable_err_inject()
         echo 0 > /sys/kernel/debug/"$1"/fault_inject/times
 }
 
+_nvme_enable_passthru_admin_error_logging()
+{
+	echo on > /sys/class/nvme/"$1"/passthru_err_log_enabled
+}
+
+_nvme_enable_passthru_io_error_logging()
+{
+	echo on > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
+}
+
+_nvme_disable_passthru_admin_error_logging()
+{
+	echo off > /sys/class/nvme/"$1"/passthru_err_log_enabled
+}
+
+_nvme_disable_passthru_io_error_logging()
+{
+	echo off > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
+}
+
 _nvme_reset_ctrl() {
 	echo 1 > /sys/class/nvme/"$1"/reset_controller
 }
-- 
2.39.3

