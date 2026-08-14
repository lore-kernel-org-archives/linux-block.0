Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D903E49F3
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690885; cv=none; b=cEOd1QzheU8mdm4XMkPRs1Arhgs3oHQc5Pw+Ww7ofdwa3satJ5f35QS5cXArB9tEQ3CT3FAIARZLZMkQGVRMlgws8H0rafZe720EHNFKizRs3jjGd6hlDfqR736d2a47LmhUySQq9SHjPDePtP8s8/CXkh9Sq8wQWnIrsWTfStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690885; c=relaxed/simple;
	bh=2OI3yJDHF6jOOcTe7ztibZZAtnHsyIwOfgRpvp3w0Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UE3uQq6kEKnfh7N0bhFxrSjCkOVYXqXAfI/V3lo1I1AoVn7ryTmnwEVr6Y4mIm1PaO1x2IK3b2Bwp/MxhFKk/+oSvadNoZOWOMD1MqhJMVKhKYBRpvJ5WYuEcxQOtZWIpR6ztXc4MOPIJBDWzq87DQkFpM6JU48hUKJdIrG/ce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ec50510297ad11f1aa26b74ffac11d73-20260814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3e31d9cc-bf32-4d8f-aa1b-1874fbeabd27,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:3e31d9cc-bf32-4d8f-aa1b-1874fbeabd27,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:2ed935805f6988e8655069169cdc6be9,BulkI
	D:260814150112DZ9HXCS2,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|850|86
	5|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ec50510297ad11f1aa26b74ffac11d73-20260814
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 988355798; Fri, 14 Aug 2026 15:01:07 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH blktests] nvme/070: add multipath command effects log lifetime test
Date: Fri, 14 Aug 2026 15:00:19 +0800
Message-Id: <20260814070019.3860097-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for namespace head command effects log lifetime.

Create a two-path loop subsystem, remove the first controller, and issue
an I/O passthrough command through the namespace-head character device.
Kernels that keep the command effects log pointer in the shared namespace
head report the stale access through KASAN.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 tests/nvme/070     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |  2 ++
 2 files changed, 59 insertions(+)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

diff --git a/tests/nvme/070 b/tests/nvme/070
new file mode 100755
index 0000000..39195be
--- /dev/null
+++ b/tests/nvme/070
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Yao Sang <sangyao@kylinos.cn>
+#
+# Test NVMe multipath command effects log lifetime.
+
+. tests/nvme/rc
+
+nvme_trtype=loop
+
+DESCRIPTION="test NVMe multipath command effects log lifetime"
+QUICK=1
+CHECK_DMESG=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_is_loop
+	_have_kernel_options KASAN
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
diff --git a/tests/nvme/070.out b/tests/nvme/070.out
new file mode 100644
index 0000000..b765a28
--- /dev/null
+++ b/tests/nvme/070.out
@@ -0,0 +1,2 @@
+Running nvme/070
+Test complete
-- 
2.25.1

