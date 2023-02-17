Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6AEC636CC
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 01:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBQBkJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 20:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBQBkJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 20:40:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E59582A4
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 17:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676597959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypIAFww87GzW8/OA6dwOJBUMoLBtZM6OutUnLDbkCGk=;
        b=SJ2K/B316wGC+ISB432Qrr4S3AqP9Kqjs4Fp1Ll3A9vBVIZMd+GkHcasdpX5Ri04k2+zah
        QtM8CjXdIBz9vB6OdSADehstP449fnCqrV+11AdLj4Sno/VwLAy+JXzSkbNO0o9u4aJjQx
        4Jm9RI+m4e0bsBwKvcQS2DVyR7lVunE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-S-0vRxYQP2-CY_120-fw8A-1; Thu, 16 Feb 2023 20:39:12 -0500
X-MC-Unique: S-0vRxYQP2-CY_120-fw8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C62E3C0D194;
        Fri, 17 Feb 2023 01:39:12 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D9A12026D4B;
        Fri, 17 Feb 2023 01:39:11 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH blktests v2 2/2] block/033: add test to cover gendisk leak
Date:   Fri, 17 Feb 2023 09:38:51 +0800
Message-Id: <20230217013851.1402864-3-ming.lei@redhat.com>
In-Reply-To: <20230217013851.1402864-1-ming.lei@redhat.com>
References: <20230217013851.1402864-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far only sync ublk removal is supported, and the device's
last reference is dropped in gendisk's ->free_disk(), so it
can be used to test gendisk leak issue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 common/ublk         | 34 ++++++++++++++++++++++++++++++++++
 tests/block/033     | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/block/033.out |  2 ++
 3 files changed, 76 insertions(+)
 create mode 100644 common/ublk
 create mode 100755 tests/block/033
 create mode 100644 tests/block/033.out

diff --git a/common/ublk b/common/ublk
new file mode 100644
index 0000000..a7b442a
--- /dev/null
+++ b/common/ublk
@@ -0,0 +1,34 @@
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
+	_have_src_program ublk/miniublk
+}
+
+_remove_ublk_devices() {
+	src/ublk/miniublk del -a
+}
+
+_init_ublk() {
+	_remove_ublk_devices
+
+	if ! modprobe -r ublk_drv || ! modprobe ublk_drv; then
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
index 0000000..eaba599
--- /dev/null
+++ b/tests/block/033
@@ -0,0 +1,40 @@
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
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_ublk; then
+		return 1
+	fi
+
+	${ublk_prog} add -t null -n 0 --quiet > /dev/null 2>&1
+	if ! ${ublk_prog} list -n 0 > /dev/null 2>&1; then
+		echo "fail to list dev"
+	fi
+	if ! dd if=/dev/ublkb0 iflag=direct of=/dev/null bs=1M count=512 > /dev/null 2>&1; then
+		echo "fail io"
+	fi
+	${ublk_prog} del -n 0 > /dev/null 2>&1
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

