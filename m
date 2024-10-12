Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8E815575C
	for <linux-block@vger.kernel.org>; Sat, 12 Oct 2024 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731542; cv=none; b=t607unBWXCi3xeW4XnCSjnzVV0qtOrj/wKNh8KHThrALsIsoma6/VNmb+DlhUngwtF2Cv6UBMY11LalQzp/iMhM0taApn57m/7nyv6O8vMQHXCfwkwz8jEaaUcLe/mRvu9wxMaMW76snLkD1+RL1O9IDD5eexinO7Cytpfn6iEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731542; c=relaxed/simple;
	bh=VyyoHngUZLgB/qp6SwT1qLw/FO6bKMjEAMvVuQ76Yc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFobVn1PcUULltnQOB78nX4hdYz+bGkJNGa3mjOaOc4hzewbbFdfD4eKMPC60GN4XBaYPUQmivXc1ARupTH7Q6CK+LNOLFVwdX1UQG4/u1/KwMVp9dlbFk861TjGvu9wMbkHVySa1UGoymfTTd7/VO8gpgrVNx8MAlIR9FZQ/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ARu4F+NY; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ARu4F+NY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728731532; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DFeiuL4jI2MzWGWI9sJ7eu2aW8e9t3wrO81YILLR8iM=;
	b=ARu4F+NYXsApkhQAxZbqtp8UsCfuvXkdBvxQtU1S+LYeuf2nmIk5FdQLFbmKkV/kTO0rD3D8t0l3xtBQPlPWF2r9cr8Bf2ipzfjl0POAI5I0Effb1/dfPst7xWOgtmsyxMFIPWMgLM8InPdixF5jjNPwoto4hjAg2qSt2TWg4b0=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGvtE9O_1728731527 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 19:12:11 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v3 2/2] nvme: test the nvme reservation feature
Date: Sat, 12 Oct 2024 19:11:57 +0800
Message-ID: <20241012111157.44368-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012111157.44368-1-kanie@linux.alibaba.com>
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the NVMe reservation feature, including register, acquire,
release and report.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 tests/nvme/054     |  99 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/054.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100644 tests/nvme/054
 create mode 100644 tests/nvme/054.out

diff --git a/tests/nvme/054 b/tests/nvme/054
new file mode 100644
index 0000000..f352c73
--- /dev/null
+++ b/tests/nvme/054
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Guixin Liu
+# Copyright (C) 2024 Alibaba Group.
+#
+# Test the NVMe reservation feature
+#
+. tests/nvme/rc
+
+DESCRIPTION="Test the NVMe reservation feature"
+QUICK=1
+nvme_trtype="loop"
+
+requires() {
+	_nvme_requires
+}
+
+resv_report() {
+	local nvmedev=$1
+	local report_arg=$2
+
+	nvme resv-report "/dev/${nvmedev}n1" "${report_arg}" | grep -v "hostid"
+}
+
+test_resv() {
+	local nvmedev=$1
+	local report_arg="--cdw11=1"
+
+	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
+		report_arg="--eds"
+	fi
+
+	echo "Register"
+	resv_report "${nvmedev}" "${report_arg}"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Replace"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=4 --nrkey=5 --rrega=2
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Unregister"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=5 --rrega=1
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Acquire"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Preempt"
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --racqa=1
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Release"
+	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --rrela=0
+	resv_report "${nvmedev}" "${report_arg}"
+
+	echo "Clear"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${nvmedev}" "${report_arg}"
+	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rrela=1
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local nvmedev
+	local skipped=false
+	local subsys_path=""
+	local ns_path=""
+
+	_nvmet_target_setup --blkdev file --resv_enable
+	subsys_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
+	ns_path="${subsys_path}/namespaces/1"
+
+	if [[ -f "${ns_path}/resv_enable" ]] ; then
+		_nvme_connect_subsys
+
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
+		test_resv "${nvmedev}"
+		_nvme_disconnect_subsys
+	else
+		SKIP_REASONS+=("missing reservation feature")
+		skipped=true
+	fi
+
+	_nvmet_target_cleanup
+
+	if [[ "${skipped}" = true ]] ; then
+		return 1
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/054.out b/tests/nvme/054.out
new file mode 100644
index 0000000..66e51dd
--- /dev/null
+++ b/tests/nvme/054.out
@@ -0,0 +1,108 @@
+Running nvme/054
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
+  cntlid     : ffff
+  rcsts      : 0
+  rkey       : 4
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
+  cntlid     : ffff
+  rcsts      : 0
+  rkey       : 5
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
+  cntlid     : ffff
+  rcsts      : 1
+  rkey       : 4
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
+  cntlid     : ffff
+  rcsts      : 1
+  rkey       : 4
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
+  cntlid     : ffff
+  rcsts      : 0
+  rkey       : 4
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
+  cntlid     : ffff
+  rcsts      : 1
+  rkey       : 4
+
+NVME Reservation Release success
+disconnected 1 controller(s)
+Test complete
-- 
2.43.0

