Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39ACC636D6
	for <linux-block@archiver.kernel.org>; Mon, 20 Feb 2023 03:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBTDr7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Feb 2023 22:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjBTDr6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Feb 2023 22:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4154E3A5
        for <linux-block@vger.kernel.org>; Sun, 19 Feb 2023 19:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676864832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjr0MS73c4erVd8gjrCyTQhwvZoechcgPW7YCFyx8LQ=;
        b=jGr865uAm21RYQWruAh2rBZCXxPHBLSaOVk/DqKKu5mj4/3btZKia+eIG/w4r9rFTZXULA
        1/IlR49VN4s4Qri4kmLr8dbBis/nPxpRjdjyh7omv1d2+nOyqIdz3AWEoA9jpdhgJ7qMx8
        mpP45KfjKhFcXv1sqLzu6K5gvsLe1Ro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-xbcIRWPUO7u64PTORnqoEg-1; Sun, 19 Feb 2023 22:47:09 -0500
X-MC-Unique: xbcIRWPUO7u64PTORnqoEg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4674E833948;
        Mon, 20 Feb 2023 03:47:09 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 640BB492B01;
        Mon, 20 Feb 2023 03:47:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH blktests v3 2/2] block/033: add test to cover gendisk leak
Date:   Mon, 20 Feb 2023 11:46:49 +0800
Message-Id: <20230220034649.1522978-3-ming.lei@redhat.com>
In-Reply-To: <20230220034649.1522978-1-ming.lei@redhat.com>
References: <20230220034649.1522978-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far only sync ublk removal is supported, and the device's
last reference is dropped in gendisk's ->free_disk(), so it
can be used to test gendisk leak issue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 common/ublk         | 35 +++++++++++++++++++++++++++++++++++
 tests/block/033     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/block/033.out |  2 ++
 3 files changed, 78 insertions(+)
 create mode 100644 common/ublk
 create mode 100755 tests/block/033
 create mode 100644 tests/block/033.out

diff --git a/common/ublk b/common/ublk
new file mode 100644
index 0000000..932c534
--- /dev/null
+++ b/common/ublk
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ming Lei
+#
+# ublk_drv helper functions.
+
+. common/shellcheck
+
+_have_ublk() {
+	_have_driver ublk_drv
+	_have_src_program miniublk
+}
+
+_remove_ublk_devices() {
+	src/miniublk del -a
+}
+
+_init_ublk() {
+	_remove_ublk_devices
+
+	modprobe -rq ublk_drv
+	if ! modprobe ublk_drv; then
+		SKIP_REASONS+=("requires ublk_drv")
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
index 0000000..762f606
--- /dev/null
+++ b/tests/block/033
@@ -0,0 +1,41 @@
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
+	local ublk_prog="src/miniublk"
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_ublk; then
+		return 1
+	fi
+
+	${ublk_prog} add -t null -n 0 > "$FULL"
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
+		echo "fail to list dev"
+	fi
+	if ! dd if=/dev/ublkb0 iflag=direct of=/dev/null bs=1M count=512 >> "$FULL" 2>&1; then
+		echo "fail io"
+	fi
+	${ublk_prog} del -n 0 >> "$FULL"
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

