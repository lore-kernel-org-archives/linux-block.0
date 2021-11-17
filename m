Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5B7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 20:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A735A61AA7
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 20:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhKQUoF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 15:44:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229899AbhKQUoD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 15:44:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA13061A07;
        Wed, 17 Nov 2021 20:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637181664;
        bh=fj5ey0hsnOW7bmjxm5EDpiYTtgkucg2fJ4DJRqI/kH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktuptiYwjz07RevRnCOkWU1d+W7fN8TikglO9+X/UlFxLhie/YEU9BMINt2rj7Xfc
         IYO+LtyYexrp0KKB9723iz/+UwmOhH1ewaqNW/Xr3I75m8jogwR44xsIZCpSx/nYhB
         dFCFwcRTU05OUxIOPd3F8HSVGAUBqE3c+621u3TBRMo0Gd1Z33/4h2p/FeDnZcksOp
         5XysZfpdQHdExbzOJVnNpwZMAR3O/eRTPoxbAFkUI6g25ozV1wnaYK+8ftaoVm8Mtm
         szcYjXstbZiIte47t8xH7BAIU97Q5yKKjrj66n9KQ60vAv4KpMNxvvKrPMsyrK8Bd2
         ogzgbQ92+msMA==
Date:   Wed, 17 Nov 2021 12:41:01 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Message-ID: <20211117204101.GA3295649@dhcp-10-100-145-180.wdc.com>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117033807.185715-2-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 16, 2021 at 08:38:04PM -0700, Jens Axboe wrote:
> If we have a list of requests in our plug list, send it to the driver in
> one go, if possible. The driver must set mq_ops->queue_rqs() to support
> this, if not the usual one-by-one path is used.

It looks like we still need to sync with the request_queue quiesce flag.
Something like the following (untested) on top of this patch should do
it:

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 688ebf6a7a7b..447d0b77375d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -263,6 +263,9 @@ void blk_mq_wait_quiesce_done(struct request_queue *q)
 	unsigned int i;
 	bool rcu = false;
 
+	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
+		synchronize_srcu(q->srcu);
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
 			synchronize_srcu(hctx->srcu);
@@ -2201,6 +2204,25 @@ static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued,
 	*queued = 0;
 }
 
+static void queue_lock(struct request_queue *q, int *srcu_idx)
+	__acquires(q->srcu)
+{
+	if (!(q->tag_set->flags & BLK_MQ_F_BLOCKING)) {
+		*srcu_idx = 0;
+		rcu_read_lock();
+	} else
+		*srcu_idx = srcu_read_lock(q->srcu);
+}
+
+static void queue_unlock(struct request_queue *q, int srcu_idx)
+	__releases(q->srcu)
+{
+	if (!(q->tag_set->flags & BLK_MQ_F_BLOCKING))
+		rcu_read_unlock();
+	else
+		srcu_read_unlock(q->srcu, srcu_idx);
+}
+
 static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
@@ -2216,7 +2238,14 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 	 */
 	rq = rq_list_peek(&plug->mq_list);
 	if (rq->q->mq_ops->queue_rqs) {
-		rq->q->mq_ops->queue_rqs(&plug->mq_list);
+		struct request_queue *q = rq->q;
+		int srcu_idx;
+
+		queue_lock(q, &srcu_idx);
+		if (!blk_queue_quiesced(q))
+			q->mq_ops->queue_rqs(&plug->mq_list);
+		queue_unlock(q, srcu_idx);
+
 		if (rq_list_empty(plug->mq_list))
 			return;
 	}
@@ -3727,6 +3756,8 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
 	q->tag_set = set;
+	if (set->flags & BLK_MQ_F_BLOCKING)
+		init_srcu_struct(q->srcu);
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 	if (set->nr_maps > HCTX_TYPE_POLL &&
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bd4370baccca..ae7591dc9cbb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -373,6 +373,8 @@ struct request_queue {
 	 * devices that do not have multiple independent access ranges.
 	 */
 	struct blk_independent_access_ranges *ia_ranges;
+
+	struct srcu_struct	srcu[];
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
--
