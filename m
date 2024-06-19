Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71F152166
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817988; cv=none; b=hM06gVAk7r8BDTGfsoDqcsdjsrZIskXOG4snnuqO/UUlKSIvwju2t/vTIL/lpiIpIhHL2jLqoplLuh3DXD4f6yqynQmxAYBfCXV62KxodwuHZ5hrveMc77Eb2R2B5jN2fYSltWB3cRqfVGGhrkYIx6UYfaskWX1BfgpbiUlzYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817988; c=relaxed/simple;
	bh=lVMR8SJ08IHitmcWBLFS1aBHtuZ4SRhXm+Kf9UExpKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdeHZc/9r4P96VSDRlG715wc1afPUTHkJMEd5NUulC9RWt4eZsYjJgf0CpPNpLwE9vXLpda3qP+ZQLqqnSGijzpVppGkYqij5ciof5Wadcmnda5NH/YtZi07R8t+69ORNrS8rUH0qw5K1UIisboD5rc3Q3kCWOBa7kmg25nrjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IN3jF1i/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IN3jF1i/"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JGwhDE015117;
	Wed, 19 Jun 2024 17:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=22jZMfHoWIZi4QKhRjASc4xvc9/pgIrBjh6dPjp
	e1Yk=; b=IN3jF1i/RThMDu4+9YXlrWixGA+zAL3Kfp1b5PtmUgBbzEXuMaQKgSM
	sIuYatuPXfj7T7pPHPrYiPl0ENBWhwG8eu+mMiw2K/Q8cCuf2FNiYsXRWns8u7OA
	7UFUh8oqoUFNkl83GWaI3wGE4RSPvCN/9Cms6tLY7KbYur4gN9plPd/iGRiiKLqe
	E3ypAnoZ1DF+gQPLOUp6aiIOKiZewWwrpL2fxUXnn2E+caNiwruQYITxyEu9xuF9
	cw9Y3317yluYbBcA73c6uQKwgqiKZC+NObuciZPKC4zVV84HsKXyHrdhpqzKKGlR
	JLFHr8OkmMAf5IzXuXDRLHHpMkEARDw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv3apg38d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 17:26:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JFmT09023914;
	Wed, 19 Jun 2024 17:26:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9qesef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 17:26:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JHQ58441419082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 17:26:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F3A420065;
	Wed, 19 Jun 2024 17:26:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25D3A2004B;
	Wed, 19 Jun 2024 17:26:02 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.26.82])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 17:26:01 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, dwagner@suse.de
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.ibm.com,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 blktests] nvme: add test for creating/deleting file-ns
Date: Wed, 19 Jun 2024 22:55:02 +0530
Message-ID: <20240619172556.2968660-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uWFTlt2BmnaNden0ILW7V8-YiyIWpoh_
X-Proofpoint-GUID: uWFTlt2BmnaNden0ILW7V8-YiyIWpoh_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 mlxlogscore=954 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190131

This is regression test for commit be647e2c76b2 (nvme: use srcu for
iterating namespace list)[1]. It is fixed in commit ff0ffe5b7c3c(nvme:
fix namespace removal list)[2].

This test uses a regular file backed loop device for creating and then
deleting an NVMe namespace in a loop.

[1] https://lore.kernel.org/all/2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com/
[2] https://lore.kernel.org/all/20240613164246.75205-1-kbusch@meta.com/

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v3: 
    - Instead of sleeping for async opeartion (ns creation) to finish, 
      wait until the ns is created by polling ns/uuid (Daniel)
Changes from v2: 
    - Use defaults for creating and connecting to nvme target (Daniel)
Changes from v1: 
    - Add nvme prefix in the subject line instead of loop (Chaitanya)
    - Enrich the commit log with details including link to regression 
      discussion and fix commit (Chaitanya)
    - Few other formatting cleanup (Chaitanya)
    - Add fix commit information in the test header (Shinichiro)
    - Instead of using default 1000 iteration for test,
      set the test iteration count to 20 (Shinichiro)
    - Update test case no. to nvme/052 (Shinichiro)

---
 tests/nvme/052     | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/052.out |  2 ++
 2 files changed, 85 insertions(+)
 create mode 100755 tests/nvme/052
 create mode 100644 tests/nvme/052.out

diff --git a/tests/nvme/052 b/tests/nvme/052
new file mode 100755
index 0000000..cf6061a
--- /dev/null
+++ b/tests/nvme/052
@@ -0,0 +1,83 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Nilay Shroff
+#
+# Regression test for commit be647e2c76b2(nvme: use srcu for iterating
+# namespace list). This regression is resolved with commit ff0ffe5b7c3c
+# (nvme: fix namespace removal list)
+
+. tests/nvme/rc
+
+DESCRIPTION="Test file-ns creation/deletion under one subsystem"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype_is_loop
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+nvmf_wait_for_ns() {
+	local ns
+	local timeout="5"
+	local uuid="$1"
+
+	ns=$(_find_nvme_ns "${uuid}")
+
+	start_time=$(date +%s)
+	while [[ -z "$ns" ]]; do
+		sleep 1
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "namespace with uuid \"${uuid}\" not " \
+				"found within ${timeout} seconds"
+			return 1
+		fi
+		ns=$(_find_nvme_ns "${uuid}")
+	done
+
+	return 0
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local iterations=20
+
+	_nvmet_target_setup
+
+	_nvme_connect_subsys
+
+	# start iteration from ns-id 2 because ns-id 1 is created
+	# by default when nvme target is setup. Also ns-id 1 is
+	# deleted when nvme target is cleaned up.
+	for ((i = 2; i <= iterations; i++)); do {
+		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
+		uuid="$(uuidgen -r)"
+
+		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "${uuid}"
+
+		# wait until async request is processed and ns is created
+		nvmf_wait_for_ns "${uuid}"
+		if [ $? -eq 1 ]; then
+			echo "FAIL"
+			rm "$(_nvme_def_file_path).$i"
+			break
+		fi
+
+		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
+		rm "$(_nvme_def_file_path).$i"
+	}
+	done
+
+	_nvme_disconnect_subsys >> "${FULL}" 2>&1
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/052.out b/tests/nvme/052.out
new file mode 100644
index 0000000..f2d186d
--- /dev/null
+++ b/tests/nvme/052.out
@@ -0,0 +1,2 @@
+Running nvme/052
+Test complete
-- 
2.45.1

