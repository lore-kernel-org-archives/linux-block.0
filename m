Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF756C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 07:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiGSHAJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 03:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiGSHAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 03:00:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7685583
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 00:00:05 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ln8ms3ZcNzlWDS;
        Tue, 19 Jul 2022 14:58:21 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 15:00:02 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 15:00:01 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <linux-block@vger.kernel.org>, <shinichiro.kawasaki@wdc.com>
CC:     <sunke32@huawei.com>, <hch@infradead.org>
Subject: [PATCH blktests v3] nbd: add a module load and device connect test
Date:   Tue, 19 Jul 2022 15:12:16 +0800
Message-ID: <20220719071216.1555636-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a regression test for commit 06c4da89c24e
nbd: call genl_unregister_family() first in nbd_cleanup()

Two concurrent processes，one load and unload nbd module
cyclically, the other one connect and disconnect nbd device cyclically.
Last for 10 seconds.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
v2->v3:
catch error and warning message

v1->v2: 
1.change install/uninstall to load/unlock
2.use _have_modules instead

 tests/nbd/004     | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nbd/004.out |  2 ++
 tests/nbd/rc      | 18 +++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100755 tests/nbd/004
 create mode 100644 tests/nbd/004.out

diff --git a/tests/nbd/004 b/tests/nbd/004
new file mode 100755
index 0000000..98afd09
--- /dev/null
+++ b/tests/nbd/004
@@ -0,0 +1,58 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Sun Ke
+#
+# Regression test for commit 06c4da89c24e
+# nbd: call genl_unregister_family() first in nbd_cleanup()
+
+. tests/nbd/rc
+
+DESCRIPTION="module load/unload concurrently with connect/disconnect"
+QUICK=1
+
+requires() {
+	_have_modules nbd
+}
+
+module_load_and_unload() {
+	while true; do
+		modprobe nbd >/dev/null 2>&1
+		modprobe -r nbd >/dev/null 2>&1
+	done
+}
+
+connect_and_disconnect() {
+	while true; do
+		_netlink_connect >/dev/null 2>&1
+		_netlink_disconnect >/dev/null 2>&1
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_start_nbd_server_netlink
+
+	module_load_and_unload &
+	pid1=$!
+	connect_and_disconnect &
+	pid2=$!
+
+	sleep 10
+	{
+		kill -9 $pid1
+		wait $pid1
+		kill -9 $pid2
+		wait $pid2
+	} 2>/dev/null
+
+	_stop_nbd_server_netlink
+
+	if _dmesg_since_test_start | grep -q -e "couldn't allocate config" \
+		-e "cannot create duplicate filename"; then
+			echo "Fail"
+	fi
+
+	echo "Test complete"
+}
+
diff --git a/tests/nbd/004.out b/tests/nbd/004.out
new file mode 100644
index 0000000..05ced0c
--- /dev/null
+++ b/tests/nbd/004.out
@@ -0,0 +1,2 @@
+Running nbd/004
+Test complete
diff --git a/tests/nbd/rc b/tests/nbd/rc
index 118553c..b0e7d91 100644
--- a/tests/nbd/rc
+++ b/tests/nbd/rc
@@ -76,3 +76,21 @@ _stop_nbd_server() {
 	rm -f "${TMPDIR}/nbd.pid"
 	rm -f "${TMPDIR}/export"
 }
+
+_start_nbd_server_netlink() {
+	truncate -s 10G "${TMPDIR}/export"
+	nbd-server 8000 "${TMPDIR}/export" >/dev/null 2>&1
+}
+
+_stop_nbd_server_netlink() {
+	killall -SIGTERM nbd-server
+	rm -f "${TMPDIR}/export"
+}
+
+_netlink_connect() {
+	nbd-client localhost 8000 /dev/nbd0 >> "$FULL" 2>&1
+}
+
+_netlink_disconnect() {
+	nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
+}
-- 
2.13.6

