Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5779BC433E6
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F94A23110
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbhAZFbj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:31:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11148 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbhAYJuD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 04:50:03 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DPMzJ2z2Lz15yXX;
        Mon, 25 Jan 2021 16:12:12 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 16:13:19 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <minchan@kernel.org>, <ngupta@vflare.org>,
        <sergey.senozhatsky.work@gmail.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH] zram: fix NULL check before some freeing functions is not needed
Date:   Mon, 25 Jan 2021 16:13:01 +0800
Message-ID: <1611562381-14985-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

fixed the below warning:
/drivers/block/zram/zram_drv.c:534:2-8: WARNING: NULL check
before some freeing functions is not needed.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e2933cb..92739b9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -530,8 +530,7 @@ static ssize_t backing_dev_store(struct device *dev,
 
 	return len;
 out:
-	if (bitmap)
-		kvfree(bitmap);
+	kvfree(bitmap);
 
 	if (bdev)
 		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
-- 
2.7.4

