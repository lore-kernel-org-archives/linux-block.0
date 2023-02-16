Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8C1C636D6
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 03:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBPDD1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 22:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBPDD0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 22:03:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4C20579
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 19:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676516562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIIafezHqG+K6ikbA6ySdAbmJ2LIHTXmhLpu1Knob0A=;
        b=c+HFs9Qw8aOdKhbXENkX7ShrGOgkQoD5chrkJZ4TJc0iDWdvu6nUv9da5uukc9qoYwppR+
        pgwsO1P64fPjkQ1BHOw3uA3E0EtHkNuoRvPTpr7j6f5dpyJBwJ0vhNTRqSQ7JJ7pA23aSK
        1OUbTo2pBbXjUCwUCEdx6PzM9bBXdYE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-LstdQxwROcqVELX1SbDzmg-1; Wed, 15 Feb 2023 22:02:40 -0500
X-MC-Unique: LstdQxwROcqVELX1SbDzmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E61E9858F09;
        Thu, 16 Feb 2023 03:02:39 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22894C15BA0;
        Thu, 16 Feb 2023 03:02:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] blktests/033: add test to cover gendisk leak
Date:   Thu, 16 Feb 2023 11:01:34 +0800
Message-Id: <20230216030134.1368607-3-ming.lei@redhat.com>
In-Reply-To: <20230216030134.1368607-1-ming.lei@redhat.com>
References: <20230216030134.1368607-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far only sync ublk removal is supported, and the device's
last reference is dropped in gendisk's ->free_disk(), so it
can be used to test gendisk leak issue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 common/ublk         | 32 ++++++++++++++++++++++++++++++++
 tests/block/033     | 33 +++++++++++++++++++++++++++++++++
 tests/block/033.out |  2 ++
 3 files changed, 67 insertions(+)
 create mode 100644 common/ublk
 create mode 100755 tests/block/033
 create mode 100644 tests/block/033.out

diff --git a/common/ublk b/common/ublk
new file mode 100644
index 0000000..66b3a58
--- /dev/null
+++ b/common/ublk
@@ -0,0 +1,32 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ming Lei
+#
+# null_blk helper functions.
+
+. common/shellcheck
+
+_have_ublk() {
+	_have_driver ublk_drv
+	_have_src_program ublk/miniublk
+}
+
+_remove_ublk_devices() {
+	src/ublk/miniublk del -a
+}
+
+_init_ublk() {
+	if ! modprobe -r ublk_drv || ! modprobe ublk_drv "${args[@]}" ; then
+		SKIP_REASONS+=("requires modular ublk_drv")
+		return 1
+	fi
+
+	udevadm settle
+	return 0
+}
+
+_exit_ublk() {
+	_remove_ublk_devices
+	udevadm settle
+	modprobe -r -q ublk_drv
+}
diff --git a/tests/block/033 b/tests/block/033
new file mode 100755
index 0000000..342ccf3
--- /dev/null
+++ b/tests/block/033
@@ -0,0 +1,33 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ming Lei
+#
+# Test if gendisk is leaked, and regression in the following commit
+# c43332fe028c ("blk-cgroup: delay calling blkcg_exit_disk until disk_release")
+# can be covered
+
+. tests/block/rc
+. common/ublk
+
+DESCRIPTION="add & delete ublk device and test if gendisk is leaked"
+QUICK=1
+
+requires() {
+	_have_ublk
+}
+
+test() {
+	local ublk_prog="src/ublk/miniublk"
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_ublk; then
+		return 1
+	fi
+
+	local ublk_dev=`$ublk_prog add -t null --quiet`
+	$ublk_prog del --disk=$ublk_dev > /dev/null 2>&1
+
+	_exit_ublk
+
+	echo "Test complete"
+}
diff --git a/tests/block/033.out b/tests/block/033.out
new file mode 100644
index 0000000..067846a
--- /dev/null
+++ b/tests/block/033.out
@@ -0,0 +1,2 @@
+Running block/033
+Test complete
-- 
2.31.1

