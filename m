Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF36C7EE2C
	for <linux-block@archiver.kernel.org>; Thu, 24 Aug 2023 14:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbjHXOpd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Aug 2023 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241737AbjHXOpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2023 10:45:19 -0400
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [IPv6:2001:41d0:203:375::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C163D1BC6
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 07:45:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692888316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z52FLMQcKzOLYIHH0RGB6ixBmspzLyNsEH35/uGCkUU=;
        b=gfcGC/VTEK9hRqOYp40Qr8BqqMyydafpamnriWKBMMOUVH+b0BWiM8Kl/hOyRFfYEdpzgE
        0mC1Dr7e7ZsuUplosZ6goBPqIcKGYF5vrsRIJbJMCQOU4WGL5nvDd3AyAQWTwXddXPXGsH
        r4ir/SNLmF/05Id+BbtnD+GWCC8kRgk=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org, kbusch@kernel.org
Cc:     mst@redhat.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        kch@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH 3/6] blk-mq: support batched queue_rqs() on shared tags queue
Date:   Thu, 24 Aug 2023 22:44:00 +0800
Message-ID: <20230824144403.2135739-4-chengming.zhou@linux.dev>
In-Reply-To: <20230824144403.2135739-1-chengming.zhou@linux.dev>
References: <20230824144403.2135739-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Since active requests have been accounted when allocate driver tags,
we can remove this limit now.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1d0459142f61..44595385b34c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2781,13 +2781,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		 * If we do, we can dispatch the whole plug list in one go. We
 		 * already know at this point that all requests belong to the
 		 * same queue, caller must ensure that's the case.
-		 *
-		 * Since we pass off the full list to the driver at this point,
-		 * we do not increment the active request count for the queue.
-		 * Bypass shared tags for now because of that.
 		 */
-		if (q->mq_ops->queue_rqs &&
-		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
+		if (q->mq_ops->queue_rqs) {
 			blk_mq_run_dispatch_ops(q,
 				__blk_mq_flush_plug_list(q, plug));
 			if (rq_list_empty(plug->mq_list))
-- 
2.41.0

