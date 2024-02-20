Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBAD154451
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471765; cv=none; b=BYPHF/Yn1oLcSsWc5pC4/BdNNK5Eu3cHoqONLsF8TgYMVO5CDhWM+SqNiTsUN8gyAHrNUgA3oGR5TYKXFP9/eUcHbobW96RigTRIL2poD+s2VX4LmuxugtHkYiAMbf/HkmPdv7JNMn3uM5juJPbVJN2olDOppQWg5Q1ghAjRAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471765; c=relaxed/simple;
	bh=3eTqOe/+ge7M3aHJyd+ySlfKnTeDZHJ4kR/PVnEhenM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pnTinZGGxVmppGTXnZD4NM0C02e7a5ORaOEPrYNwZZ69zPfyMBKR98KkiOyDuzbAhg39Ku51bkkiWgyiy4X+azN0WUZhWkJZoh6wunaN/LFfWNOFX2+SKqTXpPJ6UrWQlhlRMs68/5z7ig1sKBD+rA4zXUmvGZbXF7M939PhN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IIY1zTd3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IIY1zTd3"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KMD34D020308;
	Tue, 20 Feb 2024 23:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=pB6MzEkzCu/InewORhwMIq0/nijFN42eyo72Sk0IWtg=;
 b=IIY1zTd337G0tXfG291G7+7/nPVN4MO5FVSVYNril5VQmxgB+vFSOTVX72p4wYntPyI4
 xwvDVGULvfLsYcBgHq0q3r5AbKjg6nElOxRBWtwzNDsoOPB8OisPfiga9CI8DdB0tfmj
 aG6pHD97ebrWufDkpdxUv33WmNkdJoEaXnF1DMYTt42HSPMvAYqO+m+VOnQJpIYpJkrC
 SsL8NCDkSnYRksy0+DAihaDyF4+2FePxRvX81SgZrM7nsD1EKaL9kWPJeJVLaj5HXQea
 gbrOdOWWz1yfLH0/E5U9m8ThNmtXepld9unYiBQGZBQ/D6GvCD8BCcZ2THhm8Ww0/btH IA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud0db5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 23:29:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KN3wol006646;
	Tue, 20 Feb 2024 23:29:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88b8de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 23:29:16 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KNTFFP021792;
	Tue, 20 Feb 2024 23:29:16 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak88b8c5-2;
	Tue, 20 Feb 2024 23:29:16 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, chaitanyak@nvidia.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests V2 1/1] nvme: Add passthru error logging tests to nvme/039
Date: Tue, 20 Feb 2024 15:30:42 -0800
Message-Id: <20240220233042.2895330-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220233042.2895330-1-alan.adamson@oracle.com>
References: <20240220233042.2895330-1-alan.adamson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200168
X-Proofpoint-GUID: o7CD6gAFCwSzg28_ZwdhscPWoYzexcRs
X-Proofpoint-ORIG-GUID: o7CD6gAFCwSzg28_ZwdhscPWoYzexcRs

Tests the ability to enable and disable error logging for passthru admin commands issued to
the controller and passthru IO commands issued to a namespace.

These tests will only run on 6.8.0 and greater kernels.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/039     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |  2 ++
 tests/nvme/rc      | 37 +++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/tests/nvme/039 b/tests/nvme/039
index 73b53d0b949c..38a866417db9 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -130,6 +130,46 @@ inject_invalid_admin_cmd()
 	fi
 }
 
+inject_invalid_io_cmd_passthru()
+{
+	local ns
+
+	ns=$(echo "$1" |  cut -d "n" -f3)
+
+	# Inject a 'Invalid Command Opcode' (0x1) on a read (0x02)
+	_nvme_enable_err_inject "$ns_dev" 0 100 1 0x1 1
+
+	nvme io-passthru /dev/"$1" --opcode=0x02 --namespace-id="$ns" \
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
+RUN_PASSTHRU_TESTS=0;
+
+# Kernel must be at least 6.8.0 to run passthru logging tests
+check_kver680_for_passthru_tests() {
+        local d=6 e=8 f=0
+
+        IFS='.' read -r a b c < <(uname -r | sed 's/-.*//;s/[^.0-9]//')
+
+        if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
+        then
+		RUN_PASSTHRU_TESTS=0
+		return
+        fi
+
+	RUN_PASSTHRU_TESTS=1
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
@@ -143,6 +183,8 @@ test_device() {
 		nvme_verbose_errors=false
 	fi
 
+	check_kver680_for_passthru_tests
+
 	ns_dev=${TEST_DEV##*/}
 	ctrl_dev=${ns_dev%n*}
 
@@ -155,6 +197,26 @@ test_device() {
 	inject_invalid_status_on_read "${ns_dev}"
 	inject_write_fault_on_write "${ns_dev}"
 
+	if [ $RUN_PASSTHRU_TESTS -ne 0 ]; then
+		_nvme_passthru_logging_setup "${ns_dev}" "${ctrl_dev}"
+
+		# Test Pass Thru Admin Logging
+		_nvme_disable_passthru_admin_error_logging "${ctrl_dev}"
+		inject_invalid_admin_cmd "${ctrl_dev}"
+		_nvme_enable_passthru_admin_error_logging "${ctrl_dev}"
+		inject_access_denied_on_identify "${ctrl_dev}"
+
+		# Test Pass Thru IO Logging
+		_nvme_disable_passthru_io_error_logging "${ns_dev}" "${ctrl_dev}"
+		inject_invalid_io_cmd_passthru "${ns_dev}" 0
+		_nvme_enable_passthru_io_error_logging "${ns_dev}" "${ctrl_dev}"
+		inject_invalid_io_cmd_passthru "${ns_dev}" 1
+
+		_nvme_passthru_logging_cleanup "${ns_dev}" "${ctrl_dev}"
+	else
+		echo " Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR cdw10=0x1 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0"
+		echo " Read(0x2), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR cdw10=0x0 cdw11=0x0 cdw12=0x1 cdw13=0x0 cdw14=0x0 cdw15=0x0"
+	fi
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

