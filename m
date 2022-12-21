Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF3DC3DA79
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiLUKfc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiLUKe4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:34:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DEEB1D6
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UTcKF+NrY00WDVRaxW5yqbHZcMTyx5ViwfKKPiqqTOU=; b=CE0X6oPvlpJwsUPsQWKf9Rt8RL
        TAk6K5kScXeoL27TuNzGtUwt1gT3s9yMeUvRFfIwBfHngkhmNY7LPYpmZL3xjIdEfnoXLLC3Xwm59
        FyzSOAQm4+EdreEuK+XgveBr+jFfn9SLqVvw3t8Hm11sAHdH9Sk2dl/vAcHcjOlYVItg8YQEC15x9
        7VZNf5PQhfXbKKsVOIq/uS+QcgVZwZqHyitxP3kvVhuSqjAZg2XitpUJHepEYZ68Sp9qoVJu/RWbc
        xrW9Ps4Xkk389HtKJW9xNcI9r7T16eb18VeyHEVEpocy9MJlzMxVExzcTN55Xi9lWTEyHmxspnfLB
        PAyspXzg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7wQx-00DUqY-7D; Wed, 21 Dec 2022 10:34:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, mcgrof@kernel.org
Cc:     joshi.k@samsung.com, j.granados@samsung.com, anuj20.g@samsung.com,
        ankit.kumar@samsung.com, vincent.fu@samsung.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 4/6] tests/nvme: add new test for optimal write on the nvme character device
Date:   Wed, 21 Dec 2022 02:34:39 -0800
Message-Id: <20221221103441.3216600-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221221103441.3216600-1-mcgrof@kernel.org>
References: <20221221103441.3216600-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This does basic optimal write testing of the character device of a
conventional NVMe drive.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/nvme/048     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/048.out |  2 ++
 2 files changed, 43 insertions(+)
 create mode 100755 tests/nvme/048
 create mode 100644 tests/nvme/048.out

diff --git a/tests/nvme/048 b/tests/nvme/048
new file mode 100755
index 000000000000..94329d9ed764
--- /dev/null
+++ b/tests/nvme/048
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Luis Chamberlain <mcgrof@kernel.org>
+#
+# This does basic optimal write test for the nvme character device.
+
+. tests/nvme/rc
+
+DESCRIPTION="basic optimal write io_uring_cmd engine for nvme-ns character device"
+QUICK=1
+CAN_BE_ZONED=1
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
+	_run_fio_verify_iouring_cmd_write_opts "${fio_args[@]}" >>"${FULL}" 2>&1 ||
+	fail=true
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/nvme/048.out b/tests/nvme/048.out
new file mode 100644
index 000000000000..65ffa47e34f1
--- /dev/null
+++ b/tests/nvme/048.out
@@ -0,0 +1,2 @@
+Running nvme/048
+Test complete
-- 
2.35.1

