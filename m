Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8105BC001DE
	for <linux-block@archiver.kernel.org>; Tue, 25 Jul 2023 13:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGYNTQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjGYNTO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jul 2023 09:19:14 -0400
Received: from out-26.mta0.migadu.com (out-26.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1271C1FF0
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 06:19:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690291149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUddR5wiZ9cxmW/YJtgRqWXnFRr905MF2Tu61yP3IU0=;
        b=rSKMhlIFuqqMn3IHOfN8AP7mdsm25+x6DSm5KPAxRxGD47IVz6ycLH4I4AV4ZRiRNOhVvm
        5XftPsf+x4V36bWCTlw5rKI3vavReqP7U0tbxcNaohBHS6d4IdyAyPa0WlQknaKP8VRD4n
        dw/7MPuxIL123WPEpdesOORx3TrJHig=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 4/4] blk-flush: don't need to end rq twice for non postflush
Date:   Tue, 25 Jul 2023 21:01:02 +0800
Message-ID: <20230725130102.3030032-5-chengming.zhou@linux.dev>
In-Reply-To: <20230725130102.3030032-1-chengming.zhou@linux.dev>
References: <20230725130102.3030032-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Now we unconditionally blk_rq_init_flush() to replace rq->end_io to
make rq return twice back to the flush state machine for post-flush.

Obviously, non post-flush requests don't need it, they don't need to
end request twice, so they don't need to replace rq->end_io callback.
And the same for requests with the FUA bit on hardware with FUA support.

There are also some other good points:
1. all requests on hardware with FUA support won't have post-flush, so
   all of them don't need to end twice.

2. non post-flush requests won't have RQF_FLUSH_SEQ rq_flags set, so
   they can merge like normal requests.

3. we don't account non post-flush requests in flush_data_in_flight,
   since there is no point to defer pending flush for these requests.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-flush.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index ed195c760617..a299dae65350 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -178,7 +178,8 @@ static void blk_end_flush(struct request *rq, struct blk_flush_queue *fq,
 	 * normal completion and end it.
 	 */
 	list_del_init(&rq->queuelist);
-	blk_flush_restore_request(rq);
+	if (rq->rq_flags & RQF_FLUSH_SEQ)
+		blk_flush_restore_request(rq);
 	blk_mq_end_request(rq, error);
 
 	blk_kick_flush(q, fq);
@@ -461,7 +462,8 @@ bool blk_insert_flush(struct request *rq)
 		 * Mark the request as part of a flush sequence and submit it
 		 * for further processing to the flush state machine.
 		 */
-		blk_rq_init_flush(rq);
+		if (policy & REQ_FSEQ_POSTFLUSH)
+			blk_rq_init_flush(rq);
 		spin_lock_irq(&fq->mq_flush_lock);
 		blk_enqueue_preflush(rq, fq);
 		spin_unlock_irq(&fq->mq_flush_lock);
-- 
2.41.0

