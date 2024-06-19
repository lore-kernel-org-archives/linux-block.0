Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DFC73514
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782956; cv=none; b=s9JuBdZK7Y2ZAx8vCupXGi+Qx0c8TAf/OsiUs5aL1G0Gx/uNFiI+VTcK1EhgC9gIMpQxaUQ+Y6BwPwUBanVldaoz3sj9Vi1iriKlxcLtaIKItoMz487DY8KxIUZZQ+pjsyauYpCDRktLo2AkIK432cQOTxRVj6KqeEN63x3HdL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782956; c=relaxed/simple;
	bh=F/XZAzCC3vnxgpvnFK+t2WuPn+nHqk1zshpyWzFfazk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9T3w7fVe4AT2aO8zFkf8y92sj47rvqmseBPCs/TDHgukgPCV4r7O5FodPr929o7SJJaMbDYYSOS3PoITbqC5g92ipiL/u42aLYTdtSgg0e5n9QLQlxE/qNJ77GBp2GZSJxB8wPze/t4Bm+hnLGNySfbVQz5xLQY12R3zRqipV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fJx0weeH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fJx0weeH"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J7egNf001818;
	Wed, 19 Jun 2024 07:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=U6bkFzY0Id/LoyyCyCFMSdw3FYnGF4rtcQdK9ky
	QZZI=; b=fJx0weeH5m9jAdbNoe1l69SNZO8rln0+5e/ESUtngkr7KhkgC+Ti2/2
	drOcr+wEfJwaxE7a+9Cwmox4D8DEENPUztUopElW/ouC7kEFxSnrTalOB7Eq952+
	zvePvoLOfuv+16aqEpJuJRDkRafMLo5LbnMsUy34SR4yE6TojH0n4ZzXxEDqfe0r
	MfABZAIgLlk7PVaoyG0ENJHxq6zSLD/BosKFRW9YB0EXdTi6ZOz9a0yQXdmbtHis
	1cbMR8X4wxL2Z+1/GFfys9fdEBf+CA5vO+oAFtjQy76+GntoEDi9dXwOoqVZtrDr
	M9HLRIrE1vi9RAo8giLlhfjg4GgP5Pw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yuu50005f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:42:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45J6Cf8Z011037;
	Wed, 19 Jun 2024 07:42:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsna33u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:42:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45J7gFiA45220264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 07:42:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E927C20063;
	Wed, 19 Jun 2024 07:42:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 411472004E;
	Wed, 19 Jun 2024 07:42:12 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.48.107])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 07:42:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        linux-nvme@lists.infradead.org, venkat88@linux.vnet.ibm.com,
        sachinp@linux.vnet.ibm.com, linux-block@vger.kernel.org,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 blktests] nvme: add test for creating/deleting file-ns
Date: Wed, 19 Jun 2024 13:11:40 +0530
Message-ID: <20240619074208.2900127-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zzGQqo71C-BGrqWr9nKq4mTixWjxME42
X-Proofpoint-ORIG-GUID: zzGQqo71C-BGrqWr9nKq4mTixWjxME42
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
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=869 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190053

This is regression test for commit be647e2c76b2 (nvme: use srcu for
iterating namespace list)[1]. It is fixed in commit ff0ffe5b7c3c(nvme:
fix namespace removal list)[2].

This test uses a regular file backed loop device for creating and then
deleting an NVMe namespace in a loop.

[1] https://lore.kernel.org/all/2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com/
[2] https://lore.kernel.org/all/20240613164246.75205-1-kbusch@meta.com/

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
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
 tests/nvme/052     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/052.out |  2 ++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/nvme/052
 create mode 100644 tests/nvme/052.out

diff --git a/tests/nvme/052 b/tests/nvme/052
new file mode 100755
index 0000000..9daed8f
--- /dev/null
+++ b/tests/nvme/052
@@ -0,0 +1,69 @@
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
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local subsys="blktests-subsystem-1"
+	local iterations=20
+	local loop_dev
+	local port
+
+	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
+
+	loop_dev="$(losetup -f --show "$(_nvme_def_file_path)")"
+
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+
+	_nvmet_target_setup --subsysnqn "${subsys}" --blkdev "${loop_dev}"
+
+	_nvme_connect_subsys --subsysnqn "${subsys}"
+
+	# start iteration from ns-id 2 because ns-id 1 is created
+	# by default when nvme target is setup. Also ns-id 1 is
+	# deleted when nvme target is cleaned up.
+	for ((i = 2; i <= iterations; i++)); do {
+		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
+		_create_nvmet_ns "${subsys}" "${i}" "$(_nvme_def_file_path).$i"
+
+		# allow async request to be processed
+		sleep 1
+
+		_remove_nvmet_ns "${subsys}" "${i}"
+		rm "$(_nvme_def_file_path).$i"
+	}
+	done
+
+	_nvme_disconnect_subsys --subsysnqn "${subsys}" >> "${FULL}" 2>&1
+
+	_nvmet_target_cleanup --subsysnqn "${subsys}" --blkdev "${loop_dev}"
+
+	_remove_nvmet_port "${port}"
+
+	losetup -d "$loop_dev"
+
+	rm "$(_nvme_def_file_path)"
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

