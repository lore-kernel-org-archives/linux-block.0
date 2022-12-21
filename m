Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CA3C41535
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiLUKfb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiLUKe4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:34:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81A9B7EE
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nzxBFknUyv63x0KL3VxpLH2ImrgIgZnruN6+7qv0hh8=; b=J7WrXHJ0Pq5bSPSXm0vtaUVsfw
        aKVP0/4mh6HWqh+27nXl+/NCO3x5zdAvT71Pympkzbqf+GJK9xGuYpG7Wk6+GEs4+tzWFAiBrpInC
        6XKjZ919gaiHZWU4xfxAjTbRcd5b0og9z1k9wrEdqfprigT75pg7wzCSvAXCWmn/WzmPhyVqURVr3
        av5HCGq7g8ibuC1JMrQDQy7uN55Mp3yftt//CkQ6n422+rpQW4FB3RuJhuR0c61kBC+3lB9ej7C++
        lbyG+yNjqEM0pXDuBwzdNfZvw2G9johFnnWd1MrDkWrm5wplrhO3ltN3noHX1mLVdEbM4MsiYrp1n
        ytoRqGdg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7wQx-00DUqf-MB; Wed, 21 Dec 2022 10:34:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, mcgrof@kernel.org
Cc:     joshi.k@samsung.com, j.granados@samsung.com, anuj20.g@samsung.com,
        ankit.kumar@samsung.com, vincent.fu@samsung.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 6/6] tests/zbd: add new basic test for reading zone character device
Date:   Wed, 21 Dec 2022 02:34:41 -0800
Message-Id: <20221221103441.3216600-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221221103441.3216600-1-mcgrof@kernel.org>
References: <20221221103441.3216600-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds a basic optimal write test using fio against a ZNS character
device.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/zbd/012     | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/012.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/zbd/012
 create mode 100644 tests/zbd/012.out

diff --git a/tests/zbd/012 b/tests/zbd/012
new file mode 100755
index 000000000000..474bcb07a27b
--- /dev/null
+++ b/tests/zbd/012
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Luis Chamberlain <mcgrof@kernel.org>
+#
+# This does basic optimal write test for the zone nvme character device.
+
+. tests/zbd/rc
+
+DESCRIPTION="basic optimal write using io_uring_cmd engine for zone nvme-ns character device"
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
+	) &&
+	_run_fio_verify_iouring_cmd_write_opts_zone "${fio_args[@]}" >>"${FULL}" 2>&1 ||
+	fail=true
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/zbd/012.out b/tests/zbd/012.out
new file mode 100644
index 000000000000..8ff654950c5f
--- /dev/null
+++ b/tests/zbd/012.out
@@ -0,0 +1,2 @@
+Running zbd/012
+Test complete
-- 
2.35.1

