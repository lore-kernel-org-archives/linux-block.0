Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1477C433E6
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 10:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9864F5F
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 10:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhCKKMn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 05:12:43 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38373 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231639AbhCKKMa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 05:12:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0URS8awp_1615457537;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0URS8awp_1615457537)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Mar 2021 18:12:28 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ataflop: fix warning comparing pointer to 0
Date:   Thu, 11 Mar 2021 18:12:16 +0800
Message-Id: <1615457536-26368-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following coccicheck warning:

./drivers/block/ataflop.c:1440:20-21: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/block/ataflop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 104b713f4..995374c 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1436,8 +1436,7 @@ static int floppy_revalidate(struct gendisk *disk)
 	unsigned int drive = p - unit;
 
 	if (test_bit(drive, &changed_floppies) ||
-	    test_bit(drive, &fake_change) ||
-	    p->disktype == 0) {
+	    test_bit(drive, &fake_change) || !p->disktype) {
 		if (UD.flags & FTD_MSG)
 			printk(KERN_ERR "floppy: clear format %p!\n", UDT);
 		BufferDrive = -1;
-- 
1.8.3.1

