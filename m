Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A674C4167B
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiLUKfY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiLUKe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:34:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CCFB4B2
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ie4STAP6HM92ceLYD32Qh78BNILArF+8brPl1l+A2ow=; b=utgBUg/YkYNgC4jSEUCfRMv249
        oqzzgcmEgObZr/TOMlrDiBMMyPgrJBTVI/tnOZDUX1i6zXEnXA+iuozBVr0Ubavu8Hq0k/IXI7P3f
        Iy+idyHIiqeBTQs0eg8/g5Ao4mW/j3xP44uheJpaKm1OTNNb7u88ZRoUANPd+c7k6uw4nRnAz9ilt
        NNJ2ljN7pCm//JMtI8SwXuKDGY5je7LP/WGKTrDgRcxWbb3ouA8McytWULhbVNA6PhU2M+8vZIWcp
        KAYL/J0VEsMnGMfhepjPVjjHSG/rxQelCLJH/6I0e/xdhWySNCf80Ou4uFvQR61k24V5AN4YY/eB/
        zeKEywPw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7wQx-00DUqd-IK; Wed, 21 Dec 2022 10:34:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, mcgrof@kernel.org
Cc:     joshi.k@samsung.com, j.granados@samsung.com, anuj20.g@samsung.com,
        ankit.kumar@samsung.com, vincent.fu@samsung.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 5/6] tests/zbd: add new basic test for reading zone character device
Date:   Wed, 21 Dec 2022 02:34:40 -0800
Message-Id: <20221221103441.3216600-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221221103441.3216600-1-mcgrof@kernel.org>
References: <20221221103441.3216600-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds a basic test to read using fio against a ZNS character device.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/zbd/011     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/011.out |  2 ++
 2 files changed, 54 insertions(+)
 create mode 100755 tests/zbd/011
 create mode 100644 tests/zbd/011.out

diff --git a/tests/zbd/011 b/tests/zbd/011
new file mode 100755
index 000000000000..a4d46fcd6cd3
--- /dev/null
+++ b/tests/zbd/011
@@ -0,0 +1,52 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Luis Chamberlain <mcgrof@kernel.org>
+#
+# This does basic read test for the zone nvme character device.
+
+. tests/zbd/rc
+
+DESCRIPTION="basic read io_uring_cmd engine for zone nvme-ns character device"
+QUICK=1
+CAN_BE_ZONED=1
+
+requires() {
+	_have_fio
+}
+
+fallback_device() {
+	_fallback_null_blk_zoned
+}
+
+cleanup_fallback_device() {
+	_exit_null_blk
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	local -i bs
+	declare -a fio_args
+	local ngdev=${TEST_DEV/nvme/ng}
+
+	_get_sysfs_variable "${TEST_DEV}" || return $?
+	bs=${SYSFS_VARS[$SV_PHYS_BLK_SIZE]}
+	_put_sysfs_variable
+
+	fio_args=(
+		--bs="$bs"
+		--size=1024M
+		--cmd_type=nvme
+		--filename="$ngdev"
+		--time_based
+		--runtime=10
+	) &&
+	_run_fio_iouring_cmd_zone "${fio_args[@]}" >>"${FULL}" 2>&1 ||
+	fail=true
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/zbd/011.out b/tests/zbd/011.out
new file mode 100644
index 000000000000..aec7f703938a
--- /dev/null
+++ b/tests/zbd/011.out
@@ -0,0 +1,2 @@
+Running zbd/011
+Test complete
-- 
2.35.1

