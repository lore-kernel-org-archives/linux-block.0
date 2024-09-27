Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD84188A11
	for <linux-block@vger.kernel.org>; Fri, 27 Sep 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423829; cv=none; b=ZI0cGyHqciRappUhEn85wjIgFRCheh6ayMWXYclJquz/TuQc3EnKg6ZBF/3kkEHzBXJfTGur361DALQLvt/CLVA97cmmD2PFbwOE4aKqIlRDNLzX4t3WN3jZS+NWwde9bSZX8MwbNZQyE5/I0l3YOxk/o4+59nxUv2aPtq9c3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423829; c=relaxed/simple;
	bh=3XhQePPEQqZfCLYS5+O1S3Tjwfg5g0x+mk3d7idptU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OriAPHJO65LVIR1bojM7VVVM4Tu5CmpjMqlRbZT1cngHcCrz5+nJ3vkx9/ZvOpmuzzpsNu0hpl6d9BdAnNsNzKKPwuiQvRQXKGsqyeju62dSg8kUcYF+rbxli7HB5XvURDJBfLB2z9tgvaiT/fgoCZuIxMgX3/TEJD+tzZT4p7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BKujn29q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BKujn29q"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R6qxBm012527;
	Fri, 27 Sep 2024 07:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=ycPiCjGrLOdQjUggmEkRcMM+5Y
	zLFO19HoeuOQ7JjS4=; b=BKujn29ql3HH3J28R25fOtdJlkar0o/O2DeC5XPSfE
	D2W+rTpCqrtAnDNHg1FhVHQlAcHMDsSHtzocKmm+F7lJsclGybWFoPW2vRiVCWQr
	HkMUGGc/whp+L4Yl9cNshFgKBj3zBOsU66doCvXKwnsBpS9WzhzGRH3RJYWS0p3T
	jcvX96H1QtEBoc0n3+b0xfXcEdm0HhT6daBN210QaD7vkoySnmI4ryBnLI7K3Dy0
	A7PQdJ6AQUAGAOjzNMhnkGo0oEk1JYbtmpUZFfqOWoiVIWU6ktH9HLu1jDMg3+et
	gFEIkC8q1sCbIZJZOEKBG9GZlkLxcekiE3InX8SPCuZQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjkadek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 07:56:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48R4Ndef020823;
	Fri, 27 Sep 2024 07:56:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb63k7vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 07:56:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48R7uKYS22610300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 07:56:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DD6520040;
	Fri, 27 Sep 2024 07:56:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F4A720043;
	Fri, 27 Sep 2024 07:56:18 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.1.200])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Sep 2024 07:56:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, martin.wilck@suse.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 blktests] nvme/{033-037}: timeout while waiting for nvme passthru namespace device
Date: Fri, 27 Sep 2024 13:25:48 +0530
Message-ID: <20240927075616.343850-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TiusgRI7J9-YFPPNnDjQ_og3Mb08YUKT
X-Proofpoint-GUID: TiusgRI7J9-YFPPNnDjQ_og3Mb08YUKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_03,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=859 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270051

Avoid waiting indefinitely for nvme passthru namespace block device
to appear. Wait for up to 5 seconds and during this time if namespace
device doesn't appear then bail out and FAIL the test.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
    Changes from v2:
        - Add nsdev check back into nvme/036 (Shnichiro Kawasaki)
    Changes from v1:
        - Add a meaningful error message if test fails (Shnichiro
          Kawasaki)
        - Use sleep "1" instead of ".1" while waiting for nsdev to be
          created as we don't see much gain in test runtime with short 
          duration of sleep. This would also help further optimize
          the sleep logic (Shnichiro Kawasaki)
        - Few other trivial cleanups (Shnichiro Kawasaki)	           	
---
 tests/nvme/033 |  7 +++++--
 tests/nvme/034 |  8 +++++---
 tests/nvme/035 |  6 +++---
 tests/nvme/036 | 11 ++++++++---
 tests/nvme/037 |  7 ++++++-
 tests/nvme/rc  |  9 ++++++++-
 6 files changed, 35 insertions(+), 13 deletions(-)

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
index 442ffe7..11cd5c1 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -27,14 +27,19 @@ test_device() {
 	_setup_nvmet
 
 	local ctrldev
+	local nsdev
 
 	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect)
 
-	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
+	if [[ -z "$nsdev" ]]; then
+		echo "FAIL: Failed to find passthru target namespace"
+	else
+		ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
 
-	if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
-		echo "ERROR: reset failed"
+		if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
+			echo "ERROR: reset failed"
+		fi
 	fi
 
 	_nvme_disconnect_subsys
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

