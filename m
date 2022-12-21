Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B584C3DA79
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiLUKf1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiLUKe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:34:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E6DB879
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EU5hx8EPY2ObYMvaGr18kG+q5W0YmfXi6zYNqgfxw38=; b=njzCA+s+lVBGhOzX3ixaON2sPC
        ljcxfWL9tPDvsdzQ67Dw3eEeZZXglY8neQtB1ZsGyJ8gdDIx1bqGhkd/0ldSVn75cR+oxakZQ/rtA
        YIrbTWe43lV/RY+PqtevtuIEwS8FMJZ+VifCRa7LMHSaPyPEeCFQwCmKTVCL01iC6EjtzOI3J+uvW
        mlmSWGuemFSghvQJF26p0eS1yd0dce+j9i3ds434Of/OyJCrkcBGQSI+d6q7AcEdV4IIGP1nZU03K
        hEhSEniCe5aDRyMrSKKJOlzLhQFabKcGYdCuW5ABLpwpOp/+7MlcRlAOqyQP+pZfq6C6cvV67pMWl
        DJLZaSBA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7wQx-00DUqV-2r; Wed, 21 Dec 2022 10:34:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, mcgrof@kernel.org
Cc:     joshi.k@samsung.com, j.granados@samsung.com, anuj20.g@samsung.com,
        ankit.kumar@samsung.com, vincent.fu@samsung.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 3/6] tests/nvme: add new test for rand-write on the nvme character device
Date:   Wed, 21 Dec 2022 02:34:38 -0800
Message-Id: <20221221103441.3216600-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221221103441.3216600-1-mcgrof@kernel.org>
References: <20221221103441.3216600-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This does basic rand-write testing of the character device of a
conventional NVMe drive.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/nvme/047     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |  2 ++
 2 files changed, 43 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

diff --git a/tests/nvme/047 b/tests/nvme/047
new file mode 100755
index 000000000000..8ba55b250bc5
--- /dev/null
+++ b/tests/nvme/047
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Luis Chamberlain <mcgrof@kernel.org>
+#
+# This does basic random write test for the the convential nvme character
+# device.
+
+. tests/nvme/rc
+
+DESCRIPTION="basic rand-write io_uring_cmd engine for nvme-ns character device"
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
+	_run_fio_verify_iouring_cmd_randwrite "${fio_args[@]}" >>"${FULL}" 2>&1 ||
+	fail=true
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/nvme/047.out b/tests/nvme/047.out
new file mode 100644
index 000000000000..915d0a2389ca
--- /dev/null
+++ b/tests/nvme/047.out
@@ -0,0 +1,2 @@
+Running nvme/047
+Test complete
-- 
2.35.1

