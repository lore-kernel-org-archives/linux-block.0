Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E114A0AA
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896496; cv=none; b=F/xPKIZf8Bcs+ZhOjr3pU5b2lgV3q/3LULS0dt1lTueynkkrFQVSCn0+EYO/84jaAMpwZ/Nkd5L3Wx2Fg+bHrpnYbZcTudKeZLD+231rEMXqsdi1FRdjFMJsdopwBeijB3TXtgP1LEpe97Ula18I+7wCE0SsnJvPtCPVr6EJg9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896496; c=relaxed/simple;
	bh=5CD/klQD9N24ZkwTkbXyQg0GuLcpcDdAFPOrlCUaVPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiuVwfDMHDETuy65koQfhnWmxg10WhfD75PBHAwDoeXJuOQYW09uvSIF706pxdrY3L9PJYIvGGU7jsWjIqjsB1MCxYST0krGzrYH6fNMmIrCL0UY6shAnIahVFmkZMsZ5oouIUhJFxAkT3k0mgAnzcK6QO5tUvchvQk1qgHyw6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lF3I+Lxp; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lF3I+Lxp"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728896491; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=udq7pcCctGr3Sx5CeKGqMrVTo2htOSu7TSWvRa2n8Yk=;
	b=lF3I+LxpAI0N+I7uE0002cP/acr27Q+oxsNTWxwiuGqe/paKKkKjmWBRxCct5Z8vJo7/d7uuI5GNl0sOdsQBHRYCRnwsBmiaO9sA2yScUtHYyZOJzxEFCTVYI52e41OArT0Y1Jj++YsGpAPlpb1wcyv6ZDlkjnCXs+5RrXij51Q=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH3Sv3x_1728896486 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 17:01:31 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v4 2/2] nvme: test the nvme reservation feature
Date: Mon, 14 Oct 2024 17:01:16 +0800
Message-ID: <20241014090116.125500-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014090116.125500-1-kanie@linux.alibaba.com>
References: <20241014090116.125500-1-kanie@linux.alibaba.com>
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/054     | 101 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/054.out |  68 ++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 tests/nvme/054
 create mode 100644 tests/nvme/054.out

diff --git a/tests/nvme/054 b/tests/nvme/054
new file mode 100644
index 0000000..dc674a7
--- /dev/null
+++ b/tests/nvme/054
@@ -0,0 +1,101 @@
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
+	local test_dev=$1
+	local report_arg=$2
+
+	nvme resv-report "${test_dev}" "${report_arg}" | grep -v "hostid" | \
+		grep -E "gen|rtype|regctl|regctlext|cntlid|rcsts|rkey"
+}
+
+test_resv() {
+	local nvmedev=$1
+	local report_arg="--cdw11=1"
+	test_dev="/dev/${nvmedev}n1"
+
+	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
+		report_arg="--eds"
+	fi
+
+	echo "Register"
+	resv_report "${test_dev}" "${report_arg}"
+	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Replace"
+	nvme resv-register "${test_dev}" --crkey=4 --nrkey=5 --rrega=2
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Unregister"
+	nvme resv-register "${test_dev}" --crkey=5 --rrega=1
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Acquire"
+	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
+	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Preempt"
+	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=2 --racqa=1
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Release"
+	nvme resv-release "${test_dev}" --crkey=4 --rtype=2 --rrela=0
+	resv_report "${test_dev}" "${report_arg}"
+
+	echo "Clear"
+	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
+	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${test_dev}" "${report_arg}"
+	nvme resv-release "${test_dev}" --crkey=4 --rrela=1
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
index 0000000..5adb30d
--- /dev/null
+++ b/tests/nvme/054.out
@@ -0,0 +1,68 @@
+Running nvme/054
+Register
+gen       : 0
+rtype     : 0
+regctl    : 0
+NVME Reservation  success
+gen       : 1
+rtype     : 0
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 0
+  rkey       : 4
+Replace
+NVME Reservation  success
+gen       : 2
+rtype     : 0
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 0
+  rkey       : 5
+Unregister
+NVME Reservation  success
+gen       : 3
+rtype     : 0
+regctl    : 0
+Acquire
+NVME Reservation  success
+NVME Reservation Acquire success
+gen       : 4
+rtype     : 1
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 1
+  rkey       : 4
+Preempt
+NVME Reservation Acquire success
+gen       : 5
+rtype     : 2
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 1
+  rkey       : 4
+Release
+NVME Reservation Release success
+gen       : 5
+rtype     : 0
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 0
+  rkey       : 4
+Clear
+NVME Reservation  success
+NVME Reservation Acquire success
+gen       : 6
+rtype     : 1
+regctl    : 1
+regctlext[0] :
+  cntlid     : ffff
+  rcsts      : 1
+  rkey       : 4
+NVME Reservation Release success
+disconnected 1 controller(s)
+Test complete
-- 
2.43.0

