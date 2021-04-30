Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F34BC433ED
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 09:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570C5613EA
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 09:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhD3J1m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Apr 2021 05:27:42 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46802 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhD3J1m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Apr 2021 05:27:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UXFfKkM_1619774807;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UXFfKkM_1619774807)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Apr 2021 17:26:52 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     efremov@linux.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] floppy: Remove redundant assignment to nr_sectors
Date:   Fri, 30 Apr 2021 17:26:45 +0800
Message-Id: <1619774805-121562-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Variable nr_sectors is set to zero but this value is never
read as it is overwritten later on, hence it is a redundant
assignment and can be removed.

Clean up the following clang-analyzer warning:

drivers/block/floppy.c:2333:2: warning: Value stored to 'nr_sectors' is
never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/block/floppy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 8a9d222..e96ad5b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2330,7 +2330,6 @@ static void rw_interrupt(void)
 	if (!drive_state[current_drive].first_read_date)
 		drive_state[current_drive].first_read_date = jiffies;
 
-	nr_sectors = 0;
 	ssize = DIV_ROUND_UP(1 << raw_cmd->cmd[SIZECODE], 4);
 
 	if (reply_buffer[ST1] & ST1_EOC)
-- 
1.8.3.1

