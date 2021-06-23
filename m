Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A865C48BE5
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 09:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2280D61220
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 09:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFWJi7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 05:38:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53718 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFWJi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 05:38:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E4F881FD66;
        Wed, 23 Jun 2021 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624441000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=362AqqFYt54Vuml7SJQROHajS0KLTolJ9ZkbHKmgIsU=;
        b=JA4s+jzecC/vhAck3uaTv9pNGPXXHYeFEBlfYbqlpd4XhBk9n2eE05SmwgvFJghppUIy0z
        pAorwdSJ9jQKszi+fFalvIzmRCoGsSiHMS0UO9EVRri6jQSZWcR7+Nu+V0Sb5CtZi6Z79t
        cgLMoaWT9wAvMv8Kb6Gvr3eOa6wZRAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624441000;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=362AqqFYt54Vuml7SJQROHajS0KLTolJ9ZkbHKmgIsU=;
        b=/UeOYxh028BXSxz6eAKLHgcNX0NFSgYQm5m7/p4EP0gtZBqWFxanwKpnIQ3qRMq3q7+8/q
        uMEP+FtUDPXH+2Cw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 8B8AEA3B8A;
        Wed, 23 Jun 2021 09:36:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CB6771E0414; Wed, 23 Jun 2021 11:36:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] bfq: Remove merged request already in bfq_requests_merged()
Date:   Wed, 23 Jun 2021 11:36:33 +0200
Message-Id: <20210623093634.27879-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210623093634.27879-1-jack@suse.cz>
References: <20210623093634.27879-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3512; h=from:subject; bh=QdEpWKpi+h8fGc/nQS9oPNguy58aTuoIghWGWfAIIHc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg0wCgf7wF/aAmCR7GnLn311cdBbVX8UYyc1GrqRKr zWjyiz2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYNMAoAAKCRCcnaoHP2RA2ZlPCA C7gWAcEmCHMlOAwdYgVh+I0XH3sJ4kTuFc852cYuZ/FHbvpTSsb/3vpURA1gwa3uXfHtLot+ldgc+t yfofFhNCxLfDnSIReTLWQCs9l0zMUP10TqQFYYgP95M7kYLGO3jmPbw1O7vvIc+T//870tDIIyl1L+ MwlKz1tU+6jXexINif8/2YyNa3AEW5T0wOQNbPwzILW9Vjowgwsabo4A3zF+fWJ6mV/OpUifewn1Tu ArFACWc5ogogfemlNraATQbad4wPOLYTOHVqhhQuAnzuvqb23I4EP6wLmT7luvL5OIa/mqc03jZtW2 +p0RINgKXr/fdr1DBUoF6w9bB/mPhk
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
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

Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fedb0a8fd388..9433d38e486c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2433,7 +2433,7 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 		*next_bfqq = bfq_init_rq(next);
 
 	if (!bfqq)
-		return;
+		goto remove;
 
 	/*
 	 * If next and rq belong to the same bfq_queue and next is older
@@ -2456,6 +2456,14 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
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
@@ -6414,6 +6422,7 @@ static void bfq_finish_requeue_request(struct request *rq)
 {
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 	struct bfq_data *bfqd;
+	unsigned long flags;
 
 	/*
 	 * rq either is not associated with any icq, or is an already
@@ -6431,39 +6440,15 @@ static void bfq_finish_requeue_request(struct request *rq)
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

