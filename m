Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0159C10F1B
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiLUKfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiLUKe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:34:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079EFBE26
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=URJ/vSFYaxObSi1D6m14yyD3utnvo0w49uSE8LfCh+o=; b=QwmUTvFd8dIZxeYgOBJDQ6qydH
        5WwG5p5SYalkAMwckDqdNtfw3az3OTs7kfUiDMxwh3VDw0jcxhVPLoH4nMsK+TJpnTEKK9V9B+wNI
        i+Igmsu4cZwkfC1blnD5+R7tCVO2lbSix2ngtQCtsaZ1OYGWTbUwYeh/hH0RJwCNofLnLedM7chWf
        fzoo8n6e4Xb/++vQM9IyJEPHuHwAaM3Y9ftz/Rea0Tg3fFk4EjfHVFEPpefFZarRy7cK2CG1Nl5Wf
        /HjxgKVyVDAR2moLxkkg/EZRPj54SFhKmLxlFqs3990WdQ7oKIdqXVHCuNQBnPUzXFRYLtwamiz3I
        JQr5nG8Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7wQx-00DUqT-0D; Wed, 21 Dec 2022 10:34:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, mcgrof@kernel.org
Cc:     joshi.k@samsung.com, j.granados@samsung.com, anuj20.g@samsung.com,
        ankit.kumar@samsung.com, vincent.fu@samsung.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 2/6] tests/nvme: add new test for rand-read on the nvme character device
Date:   Wed, 21 Dec 2022 02:34:37 -0800
Message-Id: <20221221103441.3216600-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221221103441.3216600-1-mcgrof@kernel.org>
References: <20221221103441.3216600-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This does basic rand-read testing of the character device of a
conventional NVMe drive.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/nvme/046     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |  2 ++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100755
index 000000000000..3526ab9eedab
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,42 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Luis Chamberlain <mcgrof@kernel.org>
+#
+# This does basic sanity test for the nvme character device. This is a basic
+# test and if it fails it is probably very likely other nvme character device
+# tests would fail.
+#
+. tests/nvme/rc
+
+DESCRIPTION="basic rand-read io_uring_cmd engine for nvme-ns character device"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_fio
+}
+
+device_requires() {
+	_require_test_dev_is_nvme
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	local ngdev=${TEST_DEV/nvme/ng}
+	local fio_args=(
+		--size=1M
+		--cmd_type=nvme
+		--filename="$ngdev"
+		--time_based
+		--runtime=10
+	) &&
+	_run_fio_rand_iouring_cmd "${fio_args[@]}" >>"${FULL}" 2>&1 ||
+	fail=true
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/nvme/046.out b/tests/nvme/046.out
new file mode 100644
index 000000000000..2b5fa6af63b1
--- /dev/null
+++ b/tests/nvme/046.out
@@ -0,0 +1,2 @@
+Running nvme/046
+Test complete
-- 
2.35.1

