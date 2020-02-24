Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1C4C35669
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 04:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BEA20658
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 04:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBXE2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:28:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727218AbgBXE2b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Feb 2020 23:28:31 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6DAEB688B1AE2382CEE0;
        Mon, 24 Feb 2020 12:28:25 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 12:28:18 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <linux-block@vger.kernel.org>, <osandov@fb.com>
CC:     <sunke32@huawei.com>
Subject: [PATCH blktests] Add mount and clear_sock test for nbd by netlink
Date:   Mon, 24 Feb 2020 12:27:03 +0800
Message-ID: <20200224042703.31587-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This test case catches regressions fixed by commit 92b5c8f0063e4 "nbd:
replace kill_bdev() with __invalidate_device() again". The nbd device is
connected by netlink interface.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/nbd/004     | 30 ++++++++++++++++++++++++++++++
 tests/nbd/004.out |  1 +
 tests/nbd/rc      | 10 ++++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 tests/nbd/004
 create mode 100644 tests/nbd/004.out

diff --git a/tests/nbd/004 b/tests/nbd/004
new file mode 100644
index 0000000..324c903
--- /dev/null
+++ b/tests/nbd/004
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2020 Sun Ke
+#
+# Regression test for commit 2b5c8f0063e4 ("nbd: replace kill_bdev() with
+# __invalidate_device() again").
+
+. tests/nbd/rc
+
+DESCRIPTION="connected by netlink, mount/unmount concurrently with NBD_CLEAR_SOCK"
+QUICK=1
+
+requires() {
+	_have_nbd && _have_src_program mount_clear_sock
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_start_nbd_server_netlink
+	nbd-client localhost 8000 /dev/nbd0 >> "$FULL" 2>&1
+	mkfs.ext4 /dev/nbd0 >> "$FULL" 2>&1
+
+	mkdir -p "${TMPDIR}/mnt"
+	src/mount_clear_sock /dev/nbd0 "${TMPDIR}/mnt" ext4 5000
+
+	nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
+	rm -rf "${TMPDIR}/mnt"
+	_stop_nbd_server_netlink
+}
diff --git a/tests/nbd/004.out b/tests/nbd/004.out
new file mode 100644
index 0000000..01a875a
--- /dev/null
+++ b/tests/nbd/004.out
@@ -0,0 +1 @@
+Running nbd/004
diff --git a/tests/nbd/rc b/tests/nbd/rc
index 9d0e3d1..767043a 100644
--- a/tests/nbd/rc
+++ b/tests/nbd/rc
@@ -76,3 +76,13 @@ _stop_nbd_server() {
 	rm -f "${TMPDIR}/nbd.pid"
 	rm -f "${TMPDIR}/export"
 }
+
+_start_nbd_server_netlink() {
+	truncate -s 10G "${TMPDIR}/export"
+	nbd-server 8000 "${TMPDIR}/export" >> "$FULL" 2>&1
+}
+
+_stop_nbd_server_netlink() {
+	pkill -SIGTERM -f 8000
+	rm -f "${TMPDIR}/export"
+}
-- 
2.13.6

