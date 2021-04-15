Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3096DC433ED
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 08:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E90611C0
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 08:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhDOIkF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:40:05 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:37426 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231491AbhDOIkF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 04:40:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UVd46nH_1618475976;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVd46nH_1618475976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Apr 2021 16:39:40 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] block: remove unused function
Date:   Thu, 15 Apr 2021 16:39:35 +0800
Message-Id: <1618475975-106537-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following clang warning:

block/blk-zoned.c:55:24: warning: unused function 'blk_zone_start'
[-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 block/blk-zoned.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c0276b42..250cb76 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -52,14 +52,6 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
-static inline sector_t blk_zone_start(struct request_queue *q,
-				      sector_t sector)
-{
-	sector_t zone_mask = blk_queue_zone_sectors(q) - 1;
-
-	return sector & ~zone_mask;
-}
-
 /*
  * Return true if a request is a write requests that needs zone write locking.
  */
-- 
1.8.3.1

