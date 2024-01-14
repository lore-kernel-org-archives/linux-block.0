Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31451FA3
	for <linux-block@vger.kernel.org>; Sun, 14 Jan 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W-XgLn-_1705224371;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-XgLn-_1705224371)
          by smtp.aliyun-inc.com;
          Sun, 14 Jan 2024 17:26:17 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com
Cc: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH blktests] test/nvme/050: test the reservation feature
Date: Sun, 14 Jan 2024 17:26:11 +0800
Message-ID: <20240114092611.69075-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the reservation feature, includes register, acquire, release
and report.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 tests/nvme/050     |  67 ++++++++++++++++++++++++++
 tests/nvme/050.out | 114 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/rc      |   3 ++
 3 files changed, 184 insertions(+)
 create mode 100644 tests/nvme/050
 create mode 100644 tests/nvme/050.out

diff --git a/tests/nvme/050 b/tests/nvme/050
new file mode 100644
index 0000000..a499f66
--- /dev/null
+++ b/tests/nvme/050
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Guixin Liu
+# Copyright (C) 2024 Alibaba Group.
+#
+# Test the reservation
+#
+. tests/nvme/rc
+
+DESCRIPTION="test the reservation"
+QUICK=1
+
+requires() {
+	_nvme_requires
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local nvmedev
+
+	_nvmet_target_setup --blkdev file
+
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
+	echo "Register"
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Replace"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=4 --nrkey=5 --rrega=2
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Unregister"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=5 --rrega=1
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Acquire"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Preempt"
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --racqa=1
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Release"
+	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --rrela=0
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+
+	echo "Clear"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	nvme resv-report "/dev/${nvmedev}n1" --cdw11=1
+	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rrela=1
+
+	_nvme_disconnect_subsys "${def_subsysnqn}"
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/050.out b/tests/nvme/050.out
new file mode 100644
index 0000000..3be417d
--- /dev/null
+++ b/tests/nvme/050.out
@@ -0,0 +1,114 @@
+Running nvme/050
+Register
+
+NVME Reservation status:
+
+gen       : 0
+rtype     : 0
+regctl    : 0
+ptpls     : 0
+
+NVME Reservation  success
+
+NVME Reservation status:
+
+gen       : 1
+rtype     : 0
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 0
+  rkey       : 4
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+Replace
+NVME Reservation  success
+
+NVME Reservation status:
+
+gen       : 2
+rtype     : 0
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 0
+  rkey       : 5
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+Unregister
+NVME Reservation  success
+
+NVME Reservation status:
+
+gen       : 3
+rtype     : 0
+regctl    : 0
+ptpls     : 0
+
+Acquire
+NVME Reservation  success
+NVME Reservation Acquire success
+
+NVME Reservation status:
+
+gen       : 4
+rtype     : 1
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 1
+  rkey       : 4
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+Preempt
+NVME Reservation Acquire success
+
+NVME Reservation status:
+
+gen       : 5
+rtype     : 2
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 1
+  rkey       : 4
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+Release
+NVME Reservation Release success
+
+NVME Reservation status:
+
+gen       : 5
+rtype     : 0
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 0
+  rkey       : 4
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+Clear
+NVME Reservation  success
+NVME Reservation Acquire success
+
+NVME Reservation status:
+
+gen       : 6
+rtype     : 1
+regctl    : 1
+ptpls     : 0
+regctlext[0] :
+  cntlid     : 1
+  rcsts      : 1
+  rkey       : 4
+  hostid     : f1fb429f7f4856b0b351e6b8de349
+
+NVME Reservation Release success
+disconnected 1 controller(s)
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index b0ef1ee..8de59e2 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -670,6 +670,9 @@ _create_nvmet_ns() {
 	mkdir "${ns_path}"
 	printf "%s" "${blkdev}" > "${ns_path}/device_path"
 	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	if [[ -f "${ns_path}/resv_enable" ]]; then
+		printf 1 > "${ns_path}/resv_enable"
+	fi
 	printf 1 > "${ns_path}/enable"
 }
 
-- 
2.30.1 (Apple Git-130)

