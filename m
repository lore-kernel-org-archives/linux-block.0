Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AC7C433FE
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 10:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbiESKwt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbiESKwn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 06:52:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF922AF1C3
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 03:52:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5FC7B1F97E;
        Thu, 19 May 2022 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652957558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4k+ZSfjAneIX0NUGcevC9JYmxk8Z92Md3R2Cx0luj4=;
        b=Oj4fcOJIDoiOxRQvo5FALdkMjz69MXn4GkFArPniPVr28v8TMpk/mseeqIH+5sFG3Ctnmm
        nQE/0vdTc05bIb9g1oIPXfVykt3UVhziH7P7+s9me+blp6YCAwxZ1NylMkVcmSNVbCT8G7
        1tSh54bNzhrkZLbj4P4SICRlJ3BBxOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652957558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4k+ZSfjAneIX0NUGcevC9JYmxk8Z92Md3R2Cx0luj4=;
        b=C+bccho4EiFflejyhU0GAb0knxFdgaR0CLvHfw7GUDLPfVCPX6IqIZ53ZjxxNMo1MU+JpU
        kIyyKtPjx7bYLvDg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 50E9A2C146;
        Thu, 19 May 2022 10:52:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 75A20A0620; Thu, 19 May 2022 12:52:35 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/4] bfq: Relax waker detection for shared queues
Date:   Thu, 19 May 2022 12:52:29 +0200
Message-Id: <20220519105235.31397-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220519104621.15456-1-jack@suse.cz>
References: <20220519104621.15456-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150; h=from:subject; bh=XDqySJNqIGwoVns1eEnbv4pEyftTIPtZP+hQYSYPkbc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBihiFs5RJaTwuVAMxPEKz6t8p6ejjgwQwmy13FbMyJ HZ3vM9KJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYoYhbAAKCRCcnaoHP2RA2XWIB/ 9XwI/x+SfyBUJnMchZGlyP3K4NieVllI556DTugR+hdDCJ5bqYl+HeDSmf+OWl3DAsr0s0hPUYpzw/ 5aPiUKUOcWkDLezh+lIn+C+KC3tLn4tQTfwHUiTmM76hpgeWGMNphxrHV1k36XOOzXS4XRhgCibo7n WjsRhZDEGl3UxIT5a9P0uaNsB73aBVQJBRgj3QdbQsX9hw4xuF+t8gZoCLyYScF3kH+McZEDaz7jas AZe2ctVqeHqtGsbts7lh0q31yL4fKfxXnNQpSR6bP30T5YiYUIEmiJw7waWOsiIw0gk9D9wM4NA3wO IunPVt2NbhjtsRuM+0aVq6nmiEiXIY
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we look for waker only if current queue has no requests. This
makes sense for bfq queues with a single process however for shared
queues when there is a larger number of processes the condition that
queue has no requests is difficult to meet because often at least one
process has some request in flight although all the others are waiting
for the waker to do the work and this harms throughput. Relax the "no
queued request for bfq queue" condition to "the current task has no
queued requests yet". For this, we also need to start tracking number of
requests in flight for each task.

This patch (together with the following one) restores the performance
for dbench with 128 clients that regressed with commit c65e6fd460b4
("bfq: Do not let waker requests skip proper accounting") because
this commit makes requests of wakers properly enter BFQ queues and thus
these queues become ineligible for the old waker detection logic.
Dbench results:

         Vanilla 5.18-rc3        5.18-rc3 + revert      5.18-rc3 patched
Mean     1237.36 (   0.00%)      950.16 *  23.21%*      988.35 *  20.12%*

Numbers are time to complete workload so lower is better.

Fixes: c65e6fd460b4 ("bfq: Do not let waker requests skip proper accounting")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 5 +++--
 block/bfq-iosched.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2e0dd68a3cbe..397f6be3c8fe 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2127,7 +2127,6 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (!bfqd->last_completed_rq_bfqq ||
 	    bfqd->last_completed_rq_bfqq == bfqq ||
 	    bfq_bfqq_has_short_ttime(bfqq) ||
-	    bfqq->dispatched > 0 ||
 	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC ||
 	    bfqd->last_completed_rq_bfqq == bfqq->waker_bfqq)
 		return;
@@ -2204,7 +2203,7 @@ static void bfq_add_request(struct request *rq)
 	bfqq->queued[rq_is_sync(rq)]++;
 	bfqd->queued++;
 
-	if (RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_bfqq_sync(bfqq)) {
+	if (bfq_bfqq_sync(bfqq) && RQ_BIC(rq)->requests <= 1) {
 		bfq_check_waker(bfqd, bfqq, now_ns);
 
 		/*
@@ -6557,6 +6556,7 @@ static void bfq_finish_requeue_request(struct request *rq)
 		bfq_completed_request(bfqq, bfqd);
 	}
 	bfq_finish_requeue_request_body(bfqq);
+	RQ_BIC(rq)->requests--;
 	spin_unlock_irqrestore(&bfqd->lock, flags);
 
 	/*
@@ -6790,6 +6790,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 
 	bfqq_request_allocated(bfqq);
 	bfqq->ref++;
+	bic->requests++;
 	bfq_log_bfqq(bfqd, bfqq, "get_request %p: bfqq %p, %d",
 		     rq, bfqq, bfqq->ref);
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 3b83e3d1c2e5..25fada961bc9 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -468,6 +468,7 @@ struct bfq_io_cq {
 	struct bfq_queue *stable_merge_bfqq;
 
 	bool stably_merged;	/* non splittable if true */
+	unsigned int requests;	/* Number of requests this process has in flight */
 };
 
 /**
-- 
2.35.3

