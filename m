Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DA5C4346E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 04:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61E220674
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 04:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIXEPd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 00:15:33 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:46145 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbgIXEPd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 00:15:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U9vmfNq_1600920930;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0U9vmfNq_1600920930)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Sep 2020 12:15:31 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com
Subject: [PATCH] block: check poll() callback when setting QUEUE_FLAG_POLL
Date:   Thu, 24 Sep 2020 12:15:30 +0800
Message-Id: <20200924041530.114227-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If queue mapping is set for polling while mq_ops->poll() not
defined, blk_poll() will crash directly.

I can understand this constraint is achieved by ensuring that
mq_ops->poll() will always be defined whenever queue mapping
is set for polling during code review phase.

However adding the extra checking can enhance the code robustness,
and the checking is cheap after all since it's done only once when
initializing the queue.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b3d2785eefe9..12f6b3406211 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3204,7 +3204,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->tag_set = set;
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
-	if (set->nr_maps > HCTX_TYPE_POLL &&
+	if (q->mq_ops->poll && set->nr_maps > HCTX_TYPE_POLL &&
 	    set->map[HCTX_TYPE_POLL].nr_queues)
 		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
 
-- 
2.27.0

