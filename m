Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B780C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 09:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D637A2089F
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 09:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfBTJeA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:34:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbfBTJeA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 04:34:00 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F3CCDF4D0C91C1456927;
        Wed, 20 Feb 2019 17:33:57 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 17:33:48 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <linux-block@vger.kernel.org>, <osandov@fb.com>
CC:     <yangerkun@huawei.com>, <houtao1@huawei.com>, <yanaijie@huawei.com>
Subject: [PATCH blktests] loop/004: Need to wait for drop caches if block_size is changed
Date:   Wed, 20 Feb 2019 17:38:06 +0800
Message-ID: <1550655486-132008-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When i test blktests, loop/004 will be fail. The Key test steps
are as follows:
1. losetup -f --show  /dev/sda
2. src/loblksize /dev/loop0 4096

step 1 will create /dev/loop0. after that, daemon systemd-udevd
will visit and close /dev/loop0 who will add and delete
i_mapping->nrpages.
PS: the operation of systemd-udevd is in the background.

step 2 will set /dev/loop0 block size, linux kernel function
loop_set_block_size has been changed since commit 5db470e229e2
("loop: drop caches if offset or block_size are changed")
+ if (lo->lo_queue->limits.logical_block_size != arg &&
+     lo->lo_device->bd_inode->i_mapping->nrpages) {
+               err = -EAGAIN;
+               pr_warn("%s: loop%d (%s) has still dirty pages\n",
+                       __func__, lo->lo_number, lo->lo_file_name,
+                       lo->lo_device->bd_inode->i_mapping->nrpages);
+               goto out_unfreeze;
+       }
--->maybe systemd-udevd just visited /dev/loop0, this leads to failure

Add a step between 1 and 2.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 tests/loop/004 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/loop/004 b/tests/loop/004
index 363fb5e..fab34e8 100755
--- a/tests/loop/004
+++ b/tests/loop/004
@@ -28,6 +28,7 @@ test() {
 		return 1
 	fi

+	udevadm settle
 	src/loblksize "$loop_dev" 4096
 	losetup --direct-io=on "$loop_dev"
 	cat "/sys/block/${loop_dev#/dev/}/loop/dio"
--
2.7.4

