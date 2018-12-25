Return-Path: <SRS0=TC5o=PC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEAFC43387
	for <linux-block@archiver.kernel.org>; Tue, 25 Dec 2018 05:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CACF2173B
	for <linux-block@archiver.kernel.org>; Tue, 25 Dec 2018 05:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbeLYFlF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Dec 2018 00:41:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17058 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbeLYFlF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Dec 2018 00:41:05 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9AE481837541F;
        Tue, 25 Dec 2018 13:41:00 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 25 Dec 2018
 13:40:52 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <zhaohongjiang@huawei.com>,
        <zhengbin13@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH] block: Add secure discard check in blk_ioctl_discard
Date:   Tue, 25 Dec 2018 13:44:23 +0800
Message-ID: <1545716663-123177-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkdev_ioctl--->blk_ioctl_discard(BLKDISCARD or BLKSECDISCARD).
If cmd is BLKSECDISCARD and device does not support this cmd,
we will drop page cache(should not be dropped) and return
EOPNOTSUPP to caller. This patch fixes that.

Fixes: 351499a172c0 ("block: Invalidate cache on discard v2")
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 block/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 4825c78..ee3a6af 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -212,6 +212,11 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	if (!blk_queue_discard(q))
 		return -EOPNOTSUPP;

+	if (flags & BLKDEV_DISCARD_SECURE) {
+		if (!blk_queue_secure_erase(q))
+			return -EOPNOTSUPP;
+	}
+
 	if (copy_from_user(range, (void __user *)arg, sizeof(range)))
 		return -EFAULT;

--
2.7.4

