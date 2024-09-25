Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B9158527
	for <linux-block@vger.kernel.org>; Wed, 25 Sep 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249600; cv=none; b=bB8vBF7+Qoh7X5/LfrmDSPhUCPez0h6IY+at/UeBPy+izAULSIsMFrzP9iDBDmiZzqTbvL4M/73NkyeaFNkr/tZPcsSoVYsAFj89AxfhA9nRwqteSZUjJuYeXgk0pzFIKZ8yPdfuUR7R4jfmwXkv+Bo0TE9mTsGwWBT+H2bcJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249600; c=relaxed/simple;
	bh=YCWluQEaMJPucKxSN2yyrwlTdBltJfxbGkYQbjI7VEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbz+O9TC2Xx2s/jRBCAitN/5qUT0U+VvAA2YOWwUbZtqqxi6lXox4TX+Zu+g3aym5wfluCNz70smLAPw+l1q+n/eHBmo/bQ2AG0wrbxHbGUqU5jUapgVGyCNxknlrJ+6Ho03r2tBZ6RP5wz3DcAGwAl1bhuYVzV+cd0e53pPMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h7y2PLqf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h7y2PLqf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1Wgw9024819;
	Wed, 25 Sep 2024 07:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=zTTlig+Ap1dHeUakrrloXox/In
	WQbWmV+08la8RC1hw=; b=h7y2PLqfBCzpVc6vMvZF7YX4aCUbvM8Rf5ibQnk3As
	2rmgJ0iOMnJbiip+G8oH7fvfLPCVhmfZQQNrW1YPJk/ZpOxx+izk2S+5OHUCkYUu
	65AE2IwjvqmoN+PrL6i8P5SEsdAchgHJ4OcVqPNd//Uf8Meo86QNkySXqHQRAxch
	7c2/GAIOST4DipHeXOxL52dloo56IGx321Fyf1qoWuILNK2MGOX6a1KNjQIOi6WN
	hBfALP0YTNWjFuiLcdhKAaB5+WPSoVWlUpnrPtO8pt+nfu4HwwlvrZZeyQpm6hzk
	2vr51VUSsStLClN0IdLMGt3XbduBMg4F/W6+HbdHGm2g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntweekr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 07:32:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48P5O71f008707;
	Wed, 25 Sep 2024 07:32:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t8v18b35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 07:32:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48P7WmSJ43123052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 07:32:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3648220040;
	Wed, 25 Sep 2024 07:32:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3E4620043;
	Wed, 25 Sep 2024 07:32:46 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.23.77])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Sep 2024 07:32:46 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, martin.wilck@suse.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 blktests] nvme/{033-037}: timeout while waiting for nvme passthru namespace device
Date: Wed, 25 Sep 2024 13:01:00 +0530
Message-ID: <20240925073245.241234-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vPxHLhU3IQQ8UqV4TlYBLgY6mfbYKj2q
X-Proofpoint-GUID: vPxHLhU3IQQ8UqV4TlYBLgY6mfbYKj2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=836 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250053

Avoid waiting indefinitely for nvme passthru namespace block device
to appear. Wait for up to 5 seconds and during this time if namespace
device doesn't appear then bail out and FAIL the test.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
    Changes from v1:
        - Add a meaningful error message if test fails (Shnichiro
          Kawasaki)
        - Use sleep "1" instead of ".1" while waiting for nsdev to be
          created as we don't see much gain in test runtime with short 
          duration of sleep. This would also help further optimize
          the sleep logic (Shnichiro Kawasaki)
        - Few other trivial cleanups (Shnichiro Kawasaki)
---
 tests/nvme/033 | 7 +++++--
 tests/nvme/034 | 8 +++++---
 tests/nvme/035 | 6 +++---
 tests/nvme/036 | 1 +
 tests/nvme/037 | 7 ++++++-
 tests/nvme/rc  | 9 ++++++++-
 6 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index 5e05175..d0581c2 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -62,8 +62,11 @@ test_device() {
 	_nvmet_passthru_target_setup
 
 	nsdev=$(_nvmet_passthru_target_connect)
-
-	compare_dev_info "${nsdev}"
+	if [[ -z "$nsdev" ]]; then
+		echo "FAIL: Failed to find passthru target namespace"
+	else
+		compare_dev_info "${nsdev}"
+	fi
 
 	_nvme_disconnect_subsys
 	_nvmet_passthru_target_cleanup
diff --git a/tests/nvme/034 b/tests/nvme/034
index 154fc91..a4c5e97 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -27,13 +27,15 @@ test_device() {
 
 	_setup_nvmet
 
-	local ctrldev
 	local nsdev
 
 	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect)
-
-	_run_fio_verify_io --size="${NVME_IMG_SIZE}" --filename="${nsdev}"
+	if [[ -z "$nsdev" ]]; then
+		echo "FAIL: Failed to find passthru target namespace"
+	else
+		_run_fio_verify_io --size="${NVME_IMG_SIZE}" --filename="${nsdev}"
+	fi
 
 	_nvme_disconnect_subsys
 	_nvmet_passthru_target_cleanup
diff --git a/tests/nvme/035 b/tests/nvme/035
index ff217d6..9f84ced 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -30,13 +30,13 @@ test_device() {
 
 	_setup_nvmet
 
-	local ctrldev
 	local nsdev
 
 	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect)
-
-	if ! _xfs_run_fio_verify_io "${nsdev}" "${NVME_IMG_SIZE}"; then
+	if [[ -z "$nsdev" ]]; then
+		echo "FAIL: Failed to find passthru target namespace"
+	elif ! _xfs_run_fio_verify_io "${nsdev}" "${NVME_IMG_SIZE}"; then
 		echo "FAIL: fio verify failed"
 	fi
 
diff --git a/tests/nvme/036 b/tests/nvme/036
index 442ffe7..a114a7c 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -27,6 +27,7 @@ test_device() {
 	_setup_nvmet
 
 	local ctrldev
+	local nsdev
 
 	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect)
diff --git a/tests/nvme/037 b/tests/nvme/037
index f7ddc2d..33a6857 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -27,7 +27,7 @@ test_device() {
 
 	local subsys="blktests-subsystem-"
 	local iterations=10
-	local ctrldev
+	local nsdev
 
 	for ((i = 0; i < iterations; i++)); do
 		_nvmet_passthru_target_setup --subsysnqn "${subsys}${i}"
@@ -37,6 +37,11 @@ test_device() {
 		_nvme_disconnect_subsys \
 			--subsysnqn "${subsys}${i}" >>"${FULL}" 2>&1
 		_nvmet_passthru_target_cleanup --subsysnqn "${subsys}${i}"
+
+		if [[ -z "$nsdev" ]]; then
+			echo "FAIL: Failed to find passthru target namespace"
+			break
+		fi
 	done
 
 	echo "Test complete"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index a877de3..671012e 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -394,6 +394,8 @@ _nvmet_passthru_target_setup() {
 
 _nvmet_passthru_target_connect() {
 	local subsysnqn="$def_subsysnqn"
+	local timeout="5"
+	local count="0"
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -414,7 +416,12 @@ _nvmet_passthru_target_connect() {
 	# The following tests can race with the creation
 	# of the device so ensure the block device exists
 	# before continuing
-	while [ ! -b "${nsdev}" ]; do sleep 1; done
+	while [ ! -b "${nsdev}" ]; do
+		sleep 1
+		if ((++count >= timeout)); then
+			return 1
+		fi
+	done
 
 	echo "${nsdev}"
 }
-- 
2.45.2

