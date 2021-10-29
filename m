Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FA9C433F5
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 09:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16CD610D2
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 09:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhJ2JxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 05:53:25 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:52006 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231534AbhJ2JxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 05:53:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uu7viOe_1635501035;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uu7viOe_1635501035)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Oct 2021 17:50:54 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] block: ataflop: Fix warning comparing pointer to 0
Date:   Fri, 29 Oct 2021 17:50:29 +0800
Message-Id: <1635501029-81391-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following coccicheck warning:

./drivers/block/ataflop.c:1464:20-21: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/block/ataflop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 2622803..d14bdc3 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1460,8 +1460,7 @@ static int floppy_revalidate(struct gendisk *disk)
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

