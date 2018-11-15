Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D181C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 04:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3411D214F1
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 04:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3411D214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeKOOGe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 09:06:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeKOOGd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 09:06:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17C422D7E0;
        Thu, 15 Nov 2018 04:00:26 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 481D51A902;
        Thu, 15 Nov 2018 04:00:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Sandoval <osandov@fb.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block/025: test discard sector alignement and sector size overflow
Date:   Thu, 15 Nov 2018 12:00:17 +0800
Message-Id: <20181115040017.4920-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 15 Nov 2018 04:00:26 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This test covers the following two issues:

1) discard sector need to be aligned with logical block size

2) make sure 'sector_t' instead of 'unsigned int' is used when comparing
with discard sector size

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/block/025     | 37 +++++++++++++++++++++++++++++++++++++
 tests/block/025.out |  2 ++
 2 files changed, 39 insertions(+)
 create mode 100755 tests/block/025
 create mode 100644 tests/block/025.out

diff --git a/tests/block/025 b/tests/block/025
new file mode 100755
index 000000000000..32b632431793
--- /dev/null
+++ b/tests/block/025
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Ming Lei <ming.lei@redhat.com>
+#
+# Check two corener cases of BLKDISCARD.
+#
+# 1) test if discard bio's sector is algined with logical size, fixed by
+#    1adfc5e4136f ("block: make sure discard bio is aligned with logical block size")
+# 2) test 32 bit overflow when comparing discard sector size. Fixed by
+#    4800bf7bc8c72 ("block: fix 32 bit overflow in __blkdev_issue_discard()")
+
+. tests/block/rc
+. common/scsi_debug
+
+DESCRIPTION="check sector alignment and sector size overflow of BLKDISCARD"
+
+requires() {
+	_have_scsi_debug
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	rm -f "$FULL"
+
+	# Create virtual device with unmap_zeroes_data support
+	if ! _init_scsi_debug virtual_gb=2049 sector_size=4096 lbpws10=1 dev_size_mb=512; then
+		return 1
+	fi
+
+	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
+	blkdiscard "$dev"
+
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/block/025.out b/tests/block/025.out
new file mode 100644
index 000000000000..fd9a6d5f70de
--- /dev/null
+++ b/tests/block/025.out
@@ -0,0 +1,2 @@
+Running block/025
+Test complete
-- 
2.9.5

