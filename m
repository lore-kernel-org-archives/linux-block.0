Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01C8C35641
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 04:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F28520658
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 04:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgBXE2s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:28:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbgBXE2s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Feb 2020 23:28:48 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4B66135868A9B0D695E2;
        Mon, 24 Feb 2020 12:28:45 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 12:28:34 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <linux-block@vger.kernel.org>, <osandov@fb.com>
CC:     <sunke32@huawei.com>
Subject: [PATCH blktests] nbd/003: improve the test
Date:   Mon, 24 Feb 2020 12:27:28 +0800
Message-ID: <20200224042728.31886-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Modify the DESCRIPTION, remove the umount and add rm.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/nbd/003 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nbd/003 b/tests/nbd/003
index 57fb63a..49ca30e 100644
--- a/tests/nbd/003
+++ b/tests/nbd/003
@@ -7,7 +7,7 @@
 
 . tests/nbd/rc
 
-DESCRIPTION="mount/unmount concurrently with NBD_CLEAR_SOCK"
+DESCRIPTION="connected by ioctl, mount/unmount concurrently with NBD_CLEAR_SOCK"
 QUICK=1
 
 requires() {
@@ -23,8 +23,8 @@ test() {
 
 	mkdir -p "${TMPDIR}/mnt"
 	src/mount_clear_sock /dev/nbd0 "${TMPDIR}/mnt" ext4 5000
-	umount "${TMPDIR}/mnt" > /dev/null 2>&1
 
 	nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
+	rm -rf "${TMPDIR}/mnt"
 	_stop_nbd_server
 }
-- 
2.13.6

