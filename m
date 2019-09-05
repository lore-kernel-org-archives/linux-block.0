Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33197C43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B4920828
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 17:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfIERnw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:43:52 -0400
Received: from ale.deltatee.com ([207.54.116.67]:51042 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731599AbfIERnw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Sep 2019 13:43:52 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i5vnS-000641-3D; Thu, 05 Sep 2019 11:43:50 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i5vnR-00082u-H7; Thu, 05 Sep 2019 11:43:49 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  5 Sep 2019 11:43:47 -0600
Message-Id: <20190905174347.30886-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, osandov@fb.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests] nvme/031: Add test to check controller deletion after setup
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A number of bug fixes have been submitted to the kernel to
fix bugs when a controller is removed immediately after it is
set up. This new test ensures this doesn't regress.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

---

This is reallly just a resend. The patches this tests for are all in
5.3-rc7 or earlier and it passes on said kernel version.

I've rebased this patch onto the latest blktests as of today with no
changes required.

Thanks,

Logan

 tests/nvme/031     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/031.out |  2 ++
 2 files changed, 57 insertions(+)
 create mode 100755 tests/nvme/031
 create mode 100644 tests/nvme/031.out

diff --git a/tests/nvme/031 b/tests/nvme/031
new file mode 100755
index 000000000000..16390dcb380e
--- /dev/null
+++ b/tests/nvme/031
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+#
+# Regression test for the following patches:
+#    nvme: fix controller removal race with scan work
+#    nvme: fix regression upon hot device removal and insertion
+#    nvme-core: Fix extra device_put() call on error path
+#    nvmet-loop: Flush nvme_delete_wq when removing the port
+#    nvmet: Fix use-after-free bug when a port is removed
+#
+# All these patches fix issues related to deleting a controller
+# immediately after setting it up.
+
+. tests/nvme/rc
+
+DESCRIPTION="test deletion of NVMeOF controllers immediately after setup"
+QUICK=1
+
+requires() {
+	_have_program nvme &&
+	_have_modules loop nvme-loop nvmet &&
+	_have_configfs
+}
+
+test() {
+	local subsys="blktests-subsystem-"
+	local iterations=10
+	local loop_dev
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	truncate -s 1G "$TMPDIR/img"
+
+	local loop_dev
+	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+
+	port="$(_create_nvmet_port "loop")"
+
+	for ((i = 0; i < iterations; i++)); do
+		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
+		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
+		nvme connect -t loop -n "${subsys}$i"
+		nvme disconnect -n "${subsys}$i" >> "${FULL}" 2>&1
+		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
+		_remove_nvmet_subsystem "${subsys}$i"
+	done
+
+	_remove_nvmet_port "${port}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/031.out b/tests/nvme/031.out
new file mode 100644
index 000000000000..ae902bdd36d4
--- /dev/null
+++ b/tests/nvme/031.out
@@ -0,0 +1,2 @@
+Running nvme/031
+Test complete
--
2.20.1
