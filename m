Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13C7C3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 08:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BE122CF8
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 08:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfICISP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:18:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfICISO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Sep 2019 04:18:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D25D38A2196;
        Tue,  3 Sep 2019 08:18:14 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (dhcp-12-105.nay.redhat.com [10.66.12.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 508B319C78;
        Tue,  3 Sep 2019 08:18:11 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@fb.com, ming.lei@redhat.com
Subject: [PATCH blktests] nvme: Add new test case about nvme rescan/reset/remove during IO
Date:   Tue,  3 Sep 2019 16:17:52 +0800
Message-Id: <20190903081752.463-1-yi.zhang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Tue, 03 Sep 2019 08:18:14 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one test to cover NVMe SSD rescan/reset/remove operation during
IO, the steps found several issues during my previous testing, check
them here:
http://lists.infradead.org/pipermail/linux-nvme/2017-February/008358.html
http://lists.infradead.org/pipermail/linux-nvme/2017-May/010259.html

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/031     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/031.out |  2 ++
 2 files changed, 45 insertions(+)
 create mode 100755 tests/nvme/031
 create mode 100644 tests/nvme/031.out

diff --git a/tests/nvme/031 b/tests/nvme/031
new file mode 100755
index 0000000..4113d12
--- /dev/null
+++ b/tests/nvme/031
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Yi Zhang <yi.zhang@redhat.com>
+#
+# Test nvme pci adapter rescan/reset/remove operation during I/O
+#
+# Regression test for bellow two commits:
+# http://lists.infradead.org/pipermail/linux-nvme/2017-May/010367.html
+# 986f75c876db nvme: avoid to use blk_mq_abort_requeue_list()
+# 806f026f9b90 nvme: use blk_mq_start_hw_queues() in nvme_kill_queues()
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvme pci adapter rescan/reset/remove during I/O"
+TIMED=1
+
+requires() {
+	_have_fio
+}
+
+device_requires() {
+	_test_dev_is_nvme
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	pdev="$(_get_pci_dev_from_blkdev)"
+
+	# start fio job
+	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
+		--ignore_error=EIO,ENXIO,ENODEV --group_reporting  &> /dev/null &
+
+	# do rescan/reset/remove operation
+	echo 1 > /sys/bus/pci/devices/"${pdev}"/rescan
+	echo 1 > /sys/bus/pci/devices/"${pdev}"/reset
+	echo 1 > /sys/bus/pci/devices/"${pdev}"/remove
+	sleep .5
+	echo 1 > /sys/bus/pci/rescan
+	sleep 5
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/031.out b/tests/nvme/031.out
new file mode 100644
index 0000000..ae902bd
--- /dev/null
+++ b/tests/nvme/031.out
@@ -0,0 +1,2 @@
+Running nvme/031
+Test complete
-- 
2.17.2

