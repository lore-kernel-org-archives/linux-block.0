Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0199215574F
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170776; cv=none; b=Zg/UnbN80EHnJbkbdcSVRXKA9jSLap20OBydwPp4p62lzwx3/0YxhZEqmNG9v8P1Va8e1SAsP0XKvmUKXlhuYBfRH9s5arVMlXBBuiSZWJcd5KsdYaQlf2TO2G8H2GOpJ4u2d6KmppsMd6fQh12OSu99cbAK37LDylSFaPmE3KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170776; c=relaxed/simple;
	bh=RV7GOBkMD7Kztavn/z9JQF7Ken9p0b4/wZatHvse9Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ga3gD8HTTNWRJdH2I/1/YxYs79SdpbUypAnqJEkozwhaMCaIJqZXwmBImZs3FWO0CU075eXrmBZbo0udPe16x4/1sNGZlK7WKqsHdeKsCsCzaxq7X+T4LLE1jWwdGaM7UVU/gYKQceDzOhXvFOvNoQMz3Ce9q4XKNHoWjZapRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nuwkp8ND; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nuwkp8ND"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O0YH6c001659;
	Tue, 24 Sep 2024 08:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=OFSXQdbU4eGt5D3bPR1JWE10TDEbBJ2tSqvS8uo
	xnp0=; b=Nuwkp8NDGqmoS7YUpd/PWRhkXN313sqoroj+AyvoBbfztvED4CVrjJf
	Bm6/BaC4T9LWKS8EfVvpQfvuLow1pk7ea6kXnZjFbEVg4OKR35hidjjyvq8rSdr+
	2J+G8fTTy1x+gSqlkPJJPpLHbhSAdxKixJg7Q+w7acO4i4Hi8RRlrmZXTuu+9+JY
	HnLPHWDx+kw4zxCQQfpMMHg8Dh3IJlnO+HvBtMeKJ7ay6p/nXg93UEdIk7nGgnss
	vV37YZyS9Q0HC+IqvOz8i4YLvlGQCJEHI9GvhvBtrYn/xJ1J1I8Bu/6a5+qTnAs4
	dCaKbfwa/UEBsWjpxLungNARllV1e2w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvb0pbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 08:49:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48O8HJfB005810;
	Tue, 24 Sep 2024 08:49:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tapmaqnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 08:49:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48O8nAQl53084584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 08:49:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FA6520040;
	Tue, 24 Sep 2024 08:49:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0975C20043;
	Tue, 24 Sep 2024 08:49:09 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.42.77])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Sep 2024 08:49:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, martin.wilck@suse.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH blktests] nvme/{033-037}: timeout while waiting for nvme passthru namespace device
Date: Tue, 24 Sep 2024 14:18:45 +0530
Message-ID: <20240924084907.143999-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: usYr5aIqkuBN2luRweNOciY43CHZP7MY
X-Proofpoint-GUID: usYr5aIqkuBN2luRweNOciY43CHZP7MY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240061

Avoid waiting indefinitely for nvme passthru namespace block device
to appear. Wait for up to 5 seconds and during this time if namespace
block device doesn't appear then bail out and FAIL the test.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Hi,

You may find more details about this issue here[1]. 

I found that blktest nvme/033-037 hangs indefinitely when 
kernel rejects the passthru target namespace due to the 
duplicate IDs. This patch helps address this issue by  
ensuring that we bail out and fail the test if for any 
reason passthru target namspace is not created on the 
host. The relevant kernel patchv2 to fix the issue with 
duplicate IDs while using passthru loop target can be
found here[2].

[1]: https://lore.kernel.org/all/8b17203f-ea4b-403b-a204-4fbc00c261ca@linux.ibm.com/
[2]: https://lore.kernel.org/all/20240921070547.531991-1-nilay@linux.ibm.com/

Thanks!
---
 tests/nvme/033 |  7 +++++--
 tests/nvme/034 |  7 +++++--
 tests/nvme/035 |  6 +++---
 tests/nvme/036 | 14 ++++++++------
 tests/nvme/037 |  6 +++++-
 tests/nvme/rc  | 12 +++++++++++-
 6 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index 5e05175..171974e 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -62,8 +62,11 @@ test_device() {
 	_nvmet_passthru_target_setup
 
 	nsdev=$(_nvmet_passthru_target_connect)
-
-	compare_dev_info "${nsdev}"
+	if [[ -z "$nsdev" ]]; then
+		echo "FAIL"
+	else
+		compare_dev_info "${nsdev}"
+	fi
 
 	_nvme_disconnect_subsys
 	_nvmet_passthru_target_cleanup
diff --git a/tests/nvme/034 b/tests/nvme/034
index 154fc91..7625204 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -32,8 +32,11 @@ test_device() {
 
 	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect)
-
-	_run_fio_verify_io --size="${NVME_IMG_SIZE}" --filename="${nsdev}"
+	if [[ -z "$nsdev" ]]; then
+		echo "FAIL"
+	else
+		_run_fio_verify_io --size="${NVME_IMG_SIZE}" --filename="${nsdev}"
+	fi
 
 	_nvme_disconnect_subsys
 	_nvmet_passthru_target_cleanup
diff --git a/tests/nvme/035 b/tests/nvme/035
index ff217d6..6ad9c56 100755
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
+		echo "FAIL"
+	elif ! _xfs_run_fio_verify_io "${nsdev}" "${NVME_IMG_SIZE}"; then
 		echo "FAIL: fio verify failed"
 	fi
 
diff --git a/tests/nvme/036 b/tests/nvme/036
index 442ffe7..a67ca12 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -30,13 +30,15 @@ test_device() {
 
 	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect)
-
-	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
-
-	if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
-		echo "ERROR: reset failed"
+	if [[ -z "$nsdev" ]]; then
+		echo "FAIL"
+	else
+		ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
+
+		if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
+			echo "ERROR: reset failed"
+		fi
 	fi
-
 	_nvme_disconnect_subsys
 	_nvmet_passthru_target_cleanup
 
diff --git a/tests/nvme/037 b/tests/nvme/037
index f7ddc2d..f0c8a77 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -27,7 +27,6 @@ test_device() {
 
 	local subsys="blktests-subsystem-"
 	local iterations=10
-	local ctrldev
 
 	for ((i = 0; i < iterations; i++)); do
 		_nvmet_passthru_target_setup --subsysnqn "${subsys}${i}"
@@ -37,6 +36,11 @@ test_device() {
 		_nvme_disconnect_subsys \
 			--subsysnqn "${subsys}${i}" >>"${FULL}" 2>&1
 		_nvmet_passthru_target_cleanup --subsysnqn "${subsys}${i}"
+
+		if [[ -z "$nsdev" ]]; then
+			echo "FAIL"
+			break
+		fi
 	done
 
 	echo "Test complete"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index a877de3..3def0d0 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -394,6 +394,7 @@ _nvmet_passthru_target_setup() {
 
 _nvmet_passthru_target_connect() {
 	local subsysnqn="$def_subsysnqn"
+	local timeout="5"
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -414,9 +415,18 @@ _nvmet_passthru_target_connect() {
 	# The following tests can race with the creation
 	# of the device so ensure the block device exists
 	# before continuing
-	while [ ! -b "${nsdev}" ]; do sleep 1; done
+	start_time=$(date +%s)
+	while [ ! -b "${nsdev}" ]; do
+		sleep .1
+		end_time=$(date +%s)
+		if ((end_time - start_time > timeout)); then
+			echo ""
+			return 1
+		fi
+	done
 
 	echo "${nsdev}"
+	return 0
 }
 
 _nvmet_passthru_target_cleanup() {
-- 
2.45.2

