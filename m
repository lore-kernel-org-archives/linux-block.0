Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CADFC43612
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E49520879
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 08:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfANIsR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:48:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:48710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbfANIsR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 03:48:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AB21AE10;
        Mon, 14 Jan 2019 08:48:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 814251E158F; Mon, 14 Jan 2019 09:48:15 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Josef Bacik <jbacik@fb.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] loop: Add test for changing capacity when filesystem is mounted
Date:   Mon, 14 Jan 2019 09:48:11 +0100
Message-Id: <20190114084811.14455-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190114084811.14455-1-jack@suse.cz>
References: <20190114084811.14455-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add test for changing capacity of a loop device when a filesystem with
non-default block size is mounted on it. This is a regression test for
"blockdev: Fix livelocks on loop device".

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/loop/007     | 38 ++++++++++++++++++++++++++++++++++++++
 tests/loop/007.out |  2 ++
 2 files changed, 40 insertions(+)
 create mode 100755 tests/loop/007
 create mode 100644 tests/loop/007.out

diff --git a/tests/loop/007 b/tests/loop/007
new file mode 100755
index 000000000000..1e2bf5131c97
--- /dev/null
+++ b/tests/loop/007
@@ -0,0 +1,38 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Jan Kara
+#
+# Test loop device capacity change handling with filesystem mounted on top.
+#
+# Regression test for patch "blockdev: Fix livelocks on loop device".
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
+	mkfs.ext4 -b 1024 "$loop_device"
+	mount -t ext4 "$loop_device" /mnt
+	losetup -c "$loop_device"
+	# This hangs if rereading capacity changed block size
+	l /mnt
+	umount /mnt
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

