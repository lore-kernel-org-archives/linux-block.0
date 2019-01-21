Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89FCC7113B
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 12:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E7121019
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 12:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfAUMCL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:02:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:38906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728139AbfAUMCK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 07:02:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C11E3AF18;
        Mon, 21 Jan 2019 12:02:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 68D081E1584; Mon, 21 Jan 2019 13:02:09 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Omar Sandoval <osandov@fb.com>
Cc:     <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] loop: Add test for changing capacity when filesystem is mounted
Date:   Mon, 21 Jan 2019 13:02:03 +0100
Message-Id: <20190121120203.13644-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add test for changing capacity of a loop device when a filesystem with
non-default block size is mounted on it. This is a regression test for
"blockdev: Fix livelocks on loop device".

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/loop/007     | 39 +++++++++++++++++++++++++++++++++++++++
 tests/loop/007.out |  2 ++
 2 files changed, 41 insertions(+)
 create mode 100755 tests/loop/007
 create mode 100644 tests/loop/007.out

diff --git a/tests/loop/007 b/tests/loop/007
new file mode 100755
index 000000000000..97e6468de4e5
--- /dev/null
+++ b/tests/loop/007
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Jan Kara
+#
+# Test loop device capacity change handling with filesystem mounted on top.
+#
+# Regression test for commit 04906b2f542c "blockdev: Fix livelocks on loop
+# device".
+#
+
+. tests/loop/rc
+
+DESCRIPTION="update loop device capacity with filesystem"
+
+QUICK=1
+
+requires() {
+	_have_program mkfs.ext4
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local mount_dir="/mnt/blktests/"
+
+	truncate -s 1G "$TMPDIR/img"
+	mkdir -p "$mount_dir"
+	local loop_device="$(losetup -P -f --show "$TMPDIR/img")"
+	mkfs.ext4 -b 1024 "$loop_device" &>/dev/null
+	mount -t ext4 "$loop_device" "$mount_dir"
+	losetup -c "$loop_device"
+	# This hangs if rereading capacity changed block size
+	ls -l "$mount_dir" >/dev/null
+	umount "$mount_dir"
+	losetup -d "$loop_device"
+	rm -fr "$mount_dir" "$TMPDIR/img"
+
+	echo "Test complete"
+}
diff --git a/tests/loop/007.out b/tests/loop/007.out
new file mode 100644
index 000000000000..32752934d48a
--- /dev/null
+++ b/tests/loop/007.out
@@ -0,0 +1,2 @@
+Running loop/007
+Test complete
-- 
2.16.4

