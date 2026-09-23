Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5734D382
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127365; cv=none; b=CIf600EAJjnVTkSz7Qiu+Oj6Mq67A7M+DoFWPIRIr7TWsHdYKj0t8YOdQ38WgiGOzwM3YwgnFApEC6shJOKvIkkm7Zdj6dKYAuknS/8qzcuO8uLShQ6FW9HrWe6Zd8wdD/WAk1waqagh43XyrDkEM9GMgVeCDJCoXMWWRDWFs/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127365; c=relaxed/simple;
	bh=RLQZL0sjn4loWFCmmw666OLQwsDEAotttYYtpsfG+cM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QkHGylqDIUWPT47GdcWIiStOXTnqHFHahCCtDVyRyyxgmk6oPngz7OFmDUnM7vDDhVRll0aK9rhtJS/pviw34XwzvjFwmkYCS03SQGQKvGx/7i9Me3AfkD3YAp1NrG4d/24wknvUrUF8vk3ryhALeBrmEEgqUVY1mJ3HH5xlHZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1c552f52b6ef11f19a56ed5b684f684d-20260923
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f044e42a-38ac-4c5f-b557-7e04f44276ed,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-INFO: VERSION:1.3.19,REQID:f044e42a-38ac-4c5f-b557-7e04f44276ed,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:fe93bb7daa71043d2c702f248ddc1c6d,BulkI
	D:260923093554CU5NQEQV,BulkQuantity:0,SF:10|66|78|102|127|850|865|898,TC:n
	il,Content:0|15|50|99,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1c552f52b6ef11f19a56ed5b684f684d-20260923
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 751574069; Wed, 23 Sep 2026 09:35:51 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: shinichiro.kawasaki@wdc.com
Cc: dwagner@suse.de,
	linux-block@vger.kernel.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH blktests v2] nvme/071: add multipath command effects log lifetime test
Date: Wed, 23 Sep 2026 09:35:36 +0800
Message-Id: <20260923013536.411702-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for kernel commit b2461c48db87 ("nvme: fix command
effects log lifetime for multipath heads").

Create a subsystem with two controller paths, remove the first controller,
and issue an I/O passthrough command through the namespace-head character
device. On affected kernels, the head still references the removed
controller's command effects log, and KASAN reports a use-after-free.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
Changes since v1:
- Reference the kernel fix in the commit message and test header.
- Use set_conditions() to run for the configured transports instead of
  forcing loop.
- Rebase on current blktests master and renumber nvme/070 to nvme/071.

The KASAN requirement is retained, as agreed in review.

v1: https://lore.kernel.org/linux-block/20260814070019.3860097-1-sangyao@kylinos.cn/

 tests/nvme/071     | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/071.out |  2 ++
 2 files changed, 61 insertions(+)
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out

diff --git a/tests/nvme/071 b/tests/nvme/071
new file mode 100755
index 0000000..6df76af
--- /dev/null
+++ b/tests/nvme/071
@@ -0,0 +1,59 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Yao Sang <sangyao@kylinos.cn>
+#
+# Regression test for kernel commit b2461c48db87 ("nvme: fix command effects
+# log lifetime for multipath heads").
+
+. tests/nvme/rc
+
+DESCRIPTION="test NVMe multipath command effects log lifetime"
+QUICK=1
+CHECK_DMESG=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_module_param_value nvme_core multipath Y
+	_have_kernel_options KASAN
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local first_ctrl
+	local ngdev
+	local ns
+	local nsid
+	local -a ports
+
+	_setup_nvmet
+	_nvmet_target_setup --ports 2
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+
+	_nvme_connect_subsys --port "${ports[0]}"
+	first_ctrl=$(_find_nvme_dev "${def_subsysnqn}")
+
+	_nvme_connect_subsys --port "${ports[1]}"
+
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	nsid=$(cat "/sys/block/${ns}/nsid")
+	ngdev="${ns/nvme/ng}"
+
+	_nvme_disconnect_ctrl "${first_ctrl}"
+
+	if ! nvme io-passthru "/dev/${ngdev}" --opcode 0 \
+		--namespace-id "${nsid}" >> "${FULL}" 2>&1; then
+		echo "io-passthru failed"
+	fi
+
+	_nvme_disconnect_subsys >> "${FULL}" 2>&1
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/071.out b/tests/nvme/071.out
new file mode 100644
index 0000000..146809b
--- /dev/null
+++ b/tests/nvme/071.out
@@ -0,0 +1,2 @@
+Running nvme/071
+Test complete
