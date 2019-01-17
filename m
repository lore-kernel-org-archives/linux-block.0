Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F00C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 03:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B463620657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 03:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfAQDoe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 22:44:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbfAQDoe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 22:44:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6F58C057E00;
        Thu, 17 Jan 2019 03:44:33 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE0A35D6A6;
        Thu, 17 Jan 2019 03:44:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: 028: block integrity funtion test
Date:   Thu, 17 Jan 2019 11:44:25 +0800
Message-Id: <20190117034425.18376-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 17 Jan 2019 03:44:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use scsi_debug's dif/dix to cover block layer's integrity function
test, then it can serve as block integrity regeression test.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/block/028     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/block/028.out |  9 +++++++++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/block/028
 create mode 100644 tests/block/028.out

diff --git a/tests/block/028 b/tests/block/028
new file mode 100755
index 000000000000..9b76b93d9eb6
--- /dev/null
+++ b/tests/block/028
@@ -0,0 +1,42 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Ming Lei <ming.lei@redhat.com>
+#
+# Test basic DIF/DIX test. Regression test for commit 7809167da5c86fd6
+# ("block: don't lose track of REQ_INTEGRITY flag")
+
+. tests/block/rc
+. common/scsi_debug
+
+DESCRIPTION="do scsi_debug dif/dix function test"
+
+requires() {
+	_have_scsi_debug
+}
+
+test_pi() {
+	if ! _init_scsi_debug dev_size_mb=128 dix=$1 dif=$2 delay=0; then
+		return 1
+	fi
+
+	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
+	local nr_sects=`blockdev --getsz $dev`
+
+	dd if=/dev/urandom of=$dev bs=512 count=$nr_sects status=none
+	dd if=$dev of=/dev/null bs=512 status=none
+
+	_exit_scsi_debug
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	for ((dix = 0; dix <= 1; dix++)); do
+		for ((dif = 0; dif <= 3; dif++)); do
+			test_pi $dix $dif
+			echo "Test(dix:$dix dif:$dif) complete"
+		done
+	done
+
+	rm -f "$FULL"
+}
diff --git a/tests/block/028.out b/tests/block/028.out
new file mode 100644
index 000000000000..d2512334b9f5
--- /dev/null
+++ b/tests/block/028.out
@@ -0,0 +1,9 @@
+Running block/028
+Test(dix:0 dif:0) complete
+Test(dix:0 dif:1) complete
+Test(dix:0 dif:2) complete
+Test(dix:0 dif:3) complete
+Test(dix:1 dif:0) complete
+Test(dix:1 dif:1) complete
+Test(dix:1 dif:2) complete
+Test(dix:1 dif:3) complete
-- 
2.9.5

