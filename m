Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C8EC2B9F7
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 10:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A70610C8
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 10:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhEXKGs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 06:06:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:43844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232516AbhEXKGm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 06:06:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621850663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJTB0mhiVF36xmclPzLXC54mAqf6FwEFtH8nIl+mO+4=;
        b=aDZEyHTcOqZk+2aNVROPQ5fUPi2b808mlr53FRYPywEI4ov3bNmF6a5oEL9J6iVOr+/2pF
        iOgIIAIlojxRdx8b5mUpSzdr8k+Y7ZdfVigiFNewm5KE58HFQSdn4nrXhZY4zDi++0+MzX
        nYM0H9gK/MsMH9wGtKgNVDtg5Jh5rZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621850663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJTB0mhiVF36xmclPzLXC54mAqf6FwEFtH8nIl+mO+4=;
        b=S2jBZk0vLQ8lZwdBtiRTf+Mk8ZpolOtjBP6mqkk7N8b3+v7Ij8sUDe9BD5x/CfeVo5drjo
        jXpiHH7mUaRTuXCQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98601ABB1;
        Mon, 24 May 2021 10:04:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 772F41F2CA7; Mon, 24 May 2021 12:04:23 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Khazhy Kumykov <khazhy@google.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] bfq: Remove merged request already in bfq_requests_merged()
Date:   Mon, 24 May 2021 12:04:15 +0200
Message-Id: <20210524100416.3578-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210524100416.3578-1-jack@suse.cz>
References: <20210524100416.3578-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, bfq does very little in bfq_requests_merged() and handles all
the request cleanup in bfq_finish_requeue_request() called from
blk_mq_free_request(). That is currently safe only because
blk_mq_free_request() is called shortly after bfq_requests_merged()
while bfqd->lock is still held. However to fix a lock inversion between
bfqd->lock and ioc->lock, we need to call blk_mq_free_request() after
dropping bfqd->lock. That would mean that already merged request could
be seen by other processes inside bfq queues and possibly dispatched to
the device which is wrong. So move cleanup of the request from
bfq_finish_requeue_request() to bfq_requests_merged().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index acd1f881273e..50a29fdf51da 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2405,7 +2405,7 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 		*next_bfqq = bfq_init_rq(next);
 
 	if (!bfqq)
-		return;
+		goto remove;
 
 	/*
 	 * If next and rq belong to the same bfq_queue and next is older
@@ -2428,6 +2428,14 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 		bfqq->next_rq = rq;
 
 	bfqg_stats_update_io_merged(bfqq_group(bfqq), next->cmd_flags);
+remove:
+	/* Merged request may be in the IO scheduler. Remove it. */
+	if (!RB_EMPTY_NODE(&next->rb_node)) {
+		bfq_remove_request(next->q, next);
+		if (next_bfqq)
+			bfqg_stats_update_io_remove(bfqq_group(next_bfqq),
+						    next->cmd_flags);
+	}
 }
 
 /* Must be called with bfqq != NULL */
@@ -6376,6 +6384,7 @@ static void bfq_finish_requeue_request(struct request *rq)
 {
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 	struct bfq_data *bfqd;
+	unsigned long flags;
 
 	/*
 	 * rq either is not associated with any icq, or is an already
@@ -6393,39 +6402,15 @@ static void bfq_finish_requeue_request(struct request *rq)
 					     rq->io_start_time_ns,
 					     rq->cmd_flags);
 
+	spin_lock_irqsave(&bfqd->lock, flags);
 	if (likely(rq->rq_flags & RQF_STARTED)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&bfqd->lock, flags);
-
 		if (rq == bfqd->waited_rq)
 			bfq_update_inject_limit(bfqd, bfqq);
 
 		bfq_completed_request(bfqq, bfqd);
-		bfq_finish_requeue_request_body(bfqq);
-
-		spin_unlock_irqrestore(&bfqd->lock, flags);
-	} else {
-		/*
-		 * Request rq may be still/already in the scheduler,
-		 * in which case we need to remove it (this should
-		 * never happen in case of requeue). And we cannot
-		 * defer such a check and removal, to avoid
-		 * inconsistencies in the time interval from the end
-		 * of this function to the start of the deferred work.
-		 * This situation seems to occur only in process
-		 * context, as a consequence of a merge. In the
-		 * current version of the code, this implies that the
-		 * lock is held.
-		 */
-
-		if (!RB_EMPTY_NODE(&rq->rb_node)) {
-			bfq_remove_request(rq->q, rq);
-			bfqg_stats_update_io_remove(bfqq_group(bfqq),
-						    rq->cmd_flags);
-		}
-		bfq_finish_requeue_request_body(bfqq);
 	}
+	bfq_finish_requeue_request_body(bfqq);
+	spin_unlock_irqrestore(&bfqd->lock, flags);
 
 	/*
 	 * Reset private fields. In case of a requeue, this allows
-- 
2.26.2

