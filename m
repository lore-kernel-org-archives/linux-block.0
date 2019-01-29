Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97830C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6792F2084C
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfA2XyQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:54:16 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:39004 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726846AbfA2XyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 18:54:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0TJEYufj_1548806053;
Received: from localhost(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TJEYufj_1548806053)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Jan 2019 07:54:14 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     linux-block@vger.kernel.org
Subject: [PATCH blktests] block: add test for io hang due to blk-iolatency
Date:   Wed, 30 Jan 2019 07:54:07 +0800
Message-Id: <20190129235407.64401-1-bo.liu@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add test for verifying io hang when enabling blk-iolatency after a few
IOs have been done.

This is a regression test for
"blk-iolatency: fix IO hang due to negative inflight counter".

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 tests/block/022     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/block/022.out |  2 ++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/block/022
 create mode 100644 tests/block/022.out

diff --git a/tests/block/022 b/tests/block/022
new file mode 100755
index 0000000..6e5ab42
--- /dev/null
+++ b/tests/block/022
@@ -0,0 +1,42 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Bo Liu <bo.liu@linux.alibaba.com>
+#
+# This test is a regression test for io hang due to blk-iolatency, the patch is
+# "blk-iolatency: fix IO hang due to negative inflight counter"
+
+. tests/block/rc
+. common/cgroup
+. common/null_blk
+DESCRIPTION="This test will demonstrate io hang due to blk-iolatency"
+
+requires() {
+	_have_null_blk && _have_cgroup2_controller_file io io.latency
+}
+
+test() {
+	local CGROUP2_DIR
+	local dir
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_null_blk queue_mode=2; then
+		return 1
+	fi
+
+	_init_cgroup2
+	dir=$(_cgroup2_base_dir)
+
+	echo $$ > ${CGROUP2_DIR}/cgroup.procs
+	xfs_io -f -d -c "pwrite 0 4k" /dev/nullb0
+
+	# target=1s
+	echo "`cat /sys/block/nullb0/dev` target=1000000" > ${CGROUP2_DIR}/io.latency
+
+	xfs_io -f -d -c "pwrite 0 4k" /dev/nullb0
+
+	echo $$ > ${dir}/cgroup.procs
+	_exit_cgroup2
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/block/022.out b/tests/block/022.out
new file mode 100644
index 0000000..14d43cb
--- /dev/null
+++ b/tests/block/022.out
@@ -0,0 +1,2 @@
+Running block/022
+Test complete
-- 
2.20.1.2.gb21ebb6

