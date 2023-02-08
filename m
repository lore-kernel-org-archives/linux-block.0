Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC45C636CC
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 01:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBHBD3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 20:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBHBD3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 20:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE0975F
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 17:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675818162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ueoSEhNuYtLyTQoKPg+wanTDViu1TZulrDW8tl8VB0E=;
        b=LLCCoOfPBs9fNN6qpuevpSS9QkgMK/et25TZfFOkSffPcFstIJwoRG7Und5Kuo+hYiT3L9
        4SZsIoOCI/qMexUKmG451pG/INzhec9rxVjWYH1yKrYG53oTi3uD4TQTW3s97N47388FSP
        85LqCyZo7UgK4pxryUXC8Egx7Log9uk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-XYTYNz9LOHOVnVKAvNns1g-1; Tue, 07 Feb 2023 20:02:41 -0500
X-MC-Unique: XYTYNz9LOHOVnVKAvNns1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD4763C22745;
        Wed,  8 Feb 2023 01:02:40 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80080C15BA0;
        Wed,  8 Feb 2023 01:02:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2] blktests: add test to cover umount one deleted disk
Date:   Wed,  8 Feb 2023 09:02:35 +0800
Message-Id: <20230208010235.553252-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

disk can be disappear any time because of error handling, when
it is usually being mounted. Make sure umount can be done successfully
after disk deleting is done from error handling.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- add 032.out

 tests/block/032     | 35 +++++++++++++++++++++++++++++++++++
 tests/block/032.out |  2 ++
 2 files changed, 37 insertions(+)
 create mode 100755 tests/block/032
 create mode 100644 tests/block/032.out

diff --git a/tests/block/032 b/tests/block/032
new file mode 100755
index 0000000..b07b7ab
--- /dev/null
+++ b/tests/block/032
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ming Lei
+#
+# Test umount after deleting disk. Removes a device while the disk
+# is still mounted.
+
+. tests/block/rc
+. common/xfs
+. common/scsi_debug
+
+DESCRIPTION="remove one mounted device"
+QUICK=1
+
+requires() {
+	_have_xfs && _have_scsi_debug
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_scsi_debug dev_size_mb=300; then
+		return 1
+	fi
+
+	mkdir -p "${TMPDIR}/mnt"
+	_xfs_mkfs_and_mount "/dev/${SCSI_DEBUG_DEVICES[0]}" "${TMPDIR}/mnt" > /dev/null 2>&1
+	echo 1 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/device/delete"
+	sleep 2
+	umount "${TMPDIR}/mnt"
+
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/block/032.out b/tests/block/032.out
new file mode 100644
index 0000000..3604e9e
--- /dev/null
+++ b/tests/block/032.out
@@ -0,0 +1,2 @@
+Running block/032
+Test complete
-- 
2.38.1

