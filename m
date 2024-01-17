Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4AD1118C
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479482; cv=none; b=XlPGw7Txnb9ziK3igCybp3DLw/IgVO6EIBvgJHJQzKRrLEyC+FGOXJrl0l/j2Mxg6F2Hckhu69z5rULl6QScsBP9ruUu15o9n9jmz/6nArHA+6jQjrZUMxs5SV+Iaztpr7UfF3cPFgXfHWfVrMHkkqJcNyrKfj/4IWO9k/7YELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479482; c=relaxed/simple;
	bh=4kZDgRK7rjPVV58we6K7xR4kh0Q8kCdLtQBl0WtiGOQ=;
	h=X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Z5fqLkPUTwh04WD6U3VlcW38Q4zBgVK/9doTz1bZvxivUbG+VoCtHguFaNYShaHuSwrJLT5C92xiVrpicD2Gq8IFCvjUwXvm0uvlLFgU1AODB8bysj0oJlLzm0khmj0x2t7vztKu5qdnuyrhm9EkMyUjbPB/vNiB5FFVHl3gFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W-ogcXo_1705479472;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-ogcXo_1705479472)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 16:17:56 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com
Cc: chaitanyak@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/2] test/nvme/050: test the reservation feature
Date: Wed, 17 Jan 2024 16:17:42 +0800
Message-ID: <20240117081742.93941-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117081742.93941-1-kanie@linux.alibaba.com>
References: <20240117081742.93941-1-kanie@linux.alibaba.com>
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
 tests/nvme/050     |  96 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/050.out | 108 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 tests/nvme/050
 create mode 100644 tests/nvme/050.out

diff --git a/tests/nvme/050 b/tests/nvme/050
new file mode 100644
index 0000000..7e59de4
--- /dev/null
+++ b/tests/nvme/050
@@ -0,0 +1,96 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Guixin Liu
+# Copyright (C) 2024 Alibaba Group.
+#
+# Test the NVMe reservation feature
+#
+. tests/nvme/rc
+
+DESCRIPTION="test the reservation feature"
+QUICK=1
+
+requires() {
+	_nvme_requires
+}
+
+resv_report() {
+	local nvmedev=$1
+
+	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
+		nvme resv-report "/dev/${nvmedev}n1" --eds | grep -v "hostid"
+	else
+		nvme resv-report "/dev/${nvmedev}n1" --cdw11=1 | grep -v "hostid"
+	fi
+}
+
+test_resv() {
+	local nvmedev=$1
+
+	echo "Register"
+	resv_report "${nvmedev}"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	resv_report "${nvmedev}"
+
+	echo "Replace"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=4 --nrkey=5 --rrega=2
+	resv_report "${nvmedev}"
+
+	echo "Unregister"
+	nvme resv-register "/dev/${nvmedev}n1" --crkey=5 --rrega=1
+	resv_report "${nvmedev}"
+
+	echo "Acquire"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${nvmedev}"
+
+	echo "Preempt"
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --racqa=1
+	resv_report "${nvmedev}"
+
+	echo "Release"
+	nvme resv-release "/dev/${nvmedev}n1" --crkey=4 --rtype=2 --rrela=0
+	resv_report "${nvmedev}"
+
+	echo "Clear"
+	nvme resv-register "/dev/${nvmedev}n1" --nrkey=4 --rrega=0
+	nvme resv-acquire "/dev/${nvmedev}n1" --crkey=4 --rtype=1 --racqa=0
+	resv_report "${nvmedev}"
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
+		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
+
+		nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
+		test_resv "${nvmedev}"
+		_nvme_disconnect_subsys "${def_subsysnqn}"
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
diff --git a/tests/nvme/050.out b/tests/nvme/050.out
new file mode 100644
index 0000000..2a46b32
--- /dev/null
+++ b/tests/nvme/050.out
@@ -0,0 +1,108 @@
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
+
+NVME Reservation Release success
+disconnected 1 controller(s)
+Test complete
-- 
2.30.1 (Apple Git-130)

