Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFAE1922DB
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616074; cv=none; b=Qylt5eXcKJarCla3UFbbpeRPsyObuCIwxVWjDQ1XR2AFFqyPfIkRD7lTHDj+qkdIiJ1ERWSfD7dVWiZh0DXiUReNDIzcyU87kGR5/+EHvFmAyIEqCK8k9q7A/9HtyLiYvCIywRzJ8rCQg5QQ6JdSNtcEWAspZ8YheW1QXuIJLLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616074; c=relaxed/simple;
	bh=uORpi95LFYRt6HO4OEcd8EGxeh8xZRiaPPxvtdJu5Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JY4D9L7svb5GYLLcyxRmUnvwkS+rZv5kG78CDqnIHtSulQQate+t/xLw7vBpaK1mXeQgge+MoYgbqTLeI2qI+StcQxa8kypbL38ZOQfAVeuevhxwqsvKleoRzuIibuA1QipKEdlk0uGc8sl1txVypiN3PPK8/Gb/g1wkvDam+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MxhKzYIE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MxhKzYIE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H8wlbB016420;
	Mon, 17 Jun 2024 09:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=X1MS6dA9V2dRSM6RDMrzTGXaYec8dkDveWB2EOS
	XXuk=; b=MxhKzYIE8N8pOz3CF3vHbPmlQvnkBLWbE6QRjBaECmtscGmN1PgaNXL
	PeoUZ4AS+kB9Ve7F6nc35ailI/fHPxHZXR0ZhyNIClzbiaYHU5x7LHsMKXaSuPQ9
	xw94fim9w9R0wzN0vvhEC/Ki/iFXePyFmcDpoAbXOQVBZjmn2by0clGOgTp/Da2H
	s+Rro+L8rfIegtfGcpAbpQCw7uiBkOvn8A35D1Du5gDOUjYHd1YIfXiyLXtedzhA
	uz+xvOctlUsvTWDtN1jJS9QcygFV+4iK4LfGDR3u8aVmAp6v6S+1bHpurTtovjOZ
	7R1lWBqnb7/g3z4cNY3kJAqm/eiBo7A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytj3q81g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 09:21:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45H8WtDj013440;
	Mon, 17 Jun 2024 09:21:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr0385tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 09:20:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45H9Ksa822413666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 09:20:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BFBB20040;
	Mon, 17 Jun 2024 09:20:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4B812004D;
	Mon, 17 Jun 2024 09:20:51 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.13.239])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 09:20:51 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: shinichiro.kawasaki@wdc.com
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        linux-block@vger.kernel.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH blktests] loop: add test for creating/deleting file-ns
Date: Mon, 17 Jun 2024 14:47:22 +0530
Message-ID: <20240617092035.2755785-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iaShkn9Iw3gIwh3IvEN5AEgv2oAt3rjC
X-Proofpoint-GUID: iaShkn9Iw3gIwh3IvEN5AEgv2oAt3rjC
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
 definitions=2024-06-17_07,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=574 impostorscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406170068

This is regression test for commit be647e2c76b2
(nvme: use srcu for iterating namespace list)

This test uses a regulare file backed loop device
for creating and then deleting an NVMe namespace
in a loop.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
This regression was first reported[1], and now it's 
fixed in 6.10-rc4[2]

[1] https://lore.kernel.org/all/2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com/
[2] commit ff0ffe5b7c3c (nvme: fix namespace removal list)
---
 tests/nvme/051     | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/051.out |  2 ++
 2 files changed, 67 insertions(+)
 create mode 100755 tests/nvme/051
 create mode 100644 tests/nvme/051.out

diff --git a/tests/nvme/051 b/tests/nvme/051
new file mode 100755
index 0000000..0de5c56
--- /dev/null
+++ b/tests/nvme/051
@@ -0,0 +1,65 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Nilay Shroff(nilay@linux.ibm.com)
+#
+# Regression test for commit be647e2c76b2(nvme: use srcu for iterating
+# namespace list)
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
+	local iterations="${NVME_NUM_ITER}"
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
diff --git a/tests/nvme/051.out b/tests/nvme/051.out
new file mode 100644
index 0000000..156f068
--- /dev/null
+++ b/tests/nvme/051.out
@@ -0,0 +1,2 @@
+Running nvme/051
+Test complete
-- 
2.45.1

