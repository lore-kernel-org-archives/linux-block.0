Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073B6C433FE
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 10:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhKWKfK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:35:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49862 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbhKWKfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 05:35:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BA52E218E0;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637663518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBZ4iJJW8iOv6zylNJ5CE1MGOmQ3Ui9KABbclnUqxes=;
        b=FfB0JUZZ+mhSDStFBcpuuSLVsA2TWCQzBEHP0F48E7rOcg4plKpqvgtOQZk6iRJSyABktR
        9krJMUr7rbnpDsCb4wwrWa43L+L40lC+M8CAafGtWQll5PjoYpWwmBRZ4m2wpm6/7P8ZA0
        pV25SVglNJhnwoSiRjjVMzMnsqEsrRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637663518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBZ4iJJW8iOv6zylNJ5CE1MGOmQ3Ui9KABbclnUqxes=;
        b=uVpnD+CGyOXfwO3T2xAn1+jrNzDw0nDccVCq58D8xGJPADVoFZ6v7iofLHPhe3L/dM68gG
        LVkGQFcRxNv5E0Bg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A71B7A3B8C;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7DA6E1E3BFC; Tue, 23 Nov 2021 11:31:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 8/8] bfq: Do not let waker requests skip proper accounting
Date:   Tue, 23 Nov 2021 11:29:20 +0100
Message-Id: <20211123103158.17284-8-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211123101109.20879-1-jack@suse.cz>
References: <20211123101109.20879-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5101; h=from:subject; bh=Zvfb1FbQ09Ev9F2yYH6+PJrx9WBduKXCC1GcidnIk7A=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhnMJ/nFW0//a7wd+B1qhyeYQFJoXnsnOg/3PeM44u 7fNdmoaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZzCfwAKCRCcnaoHP2RA2UD2B/ 0c6Iq8tA8UY6+bM12syhjp+dA/yij2MUvJwmWopHW6qBcrTUAboHd212AKzTSz8MGmq7R+M4fRypaB 9T3yzedwpXaR2+YR0msZvuhwfIT2GOIXKTWLA1Tof3pXq3es4Aa7Zc5qk/Vgda+/2kUwKXhKC7t48j io6JoqF5itb3Kh1WxKgqG1mfFWvtsOoqHFtsJG8BSVP7UQ0Oqqi+VtKA0z3EVv6CzoJHAKTwRJSv7S lM4q95BUlui1+oVFBZIc/iHYjixpXPJbczOCN/5QsiOoUl+A8sIu51mDyuMvhKK+/wzQ/y9UJhRnxA EYDj5FOeqPOR3GFcQUJRPvPL+DFduM
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 7cc4ffc55564 ("block, bfq: put reqs of waker and woken in
dispatch list") added a condition to bfq_insert_request() which added
waker's requests directly to dispatch list. The rationale was that
completing waker's IO is needed to get more IO for the current queue.
Although this rationale is valid, there is a hole in it. The waker does
not necessarily serve the IO only for the current queue and maybe it's
current IO is not needed for current queue to make progress. Furthermore
injecting IO like this completely bypasses any service accounting within
bfq and thus we do not properly track how much service is waker's queue
getting or that the waker is actually doing any IO. Depending on the
conditions this can result in the waker getting too much or too few
service.

Consider for example the following job file:

[global]
directory=/mnt/repro/
rw=write
size=8g
time_based
runtime=30
ramp_time=10
blocksize=1m
direct=0
ioengine=sync

[slowwriter]
numjobs=1
prioclass=2
prio=7
fsync=200

[fastwriter]
numjobs=1
prioclass=2
prio=0
fsync=200

Despite processes have very different IO priorities, they get the same
about of service. The reason is that bfq identifies these processes as
having waker-wakee relationship and once that happens, IO from
fastwriter gets injected during slowwriter's time slice. As a result bfq
is not aware that fastwriter has any IO to do and constantly schedules
only slowwriter's queue. Thus fastwriter is forced to compete with
slowwriter's IO all the time instead of getting its share of time based
on IO priority.

Drop the special injection condition from bfq_insert_request(). As a
result, requests will be tracked and queued in a normal way and on next
dispatch bfq_select_queue() can decide whether the waker's inserted
requests should be injected during the current queue's timeslice or not.

Fixes: 7cc4ffc55564 ("block, bfq: put reqs of waker and woken in dispatch list")
Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 44 +-------------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3f1c8a080b71..8cba769a29ed 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6132,48 +6132,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
-
-	/*
-	 * Reqs with at_head or passthrough flags set are to be put
-	 * directly into dispatch list. Additional case for putting rq
-	 * directly into the dispatch queue: the only active
-	 * bfq_queues are bfqq and either its waker bfq_queue or one
-	 * of its woken bfq_queues. The rationale behind this
-	 * additional condition is as follows:
-	 * - consider a bfq_queue, say Q1, detected as a waker of
-	 *   another bfq_queue, say Q2
-	 * - by definition of a waker, Q1 blocks the I/O of Q2, i.e.,
-	 *   some I/O of Q1 needs to be completed for new I/O of Q2
-	 *   to arrive.  A notable example of waker is journald
-	 * - so, Q1 and Q2 are in any respect the queues of two
-	 *   cooperating processes (or of two cooperating sets of
-	 *   processes): the goal of Q1's I/O is doing what needs to
-	 *   be done so that new Q2's I/O can finally be
-	 *   issued. Therefore, if the service of Q1's I/O is delayed,
-	 *   then Q2's I/O is delayed too.  Conversely, if Q2's I/O is
-	 *   delayed, the goal of Q1's I/O is hindered.
-	 * - as a consequence, if some I/O of Q1/Q2 arrives while
-	 *   Q2/Q1 is the only queue in service, there is absolutely
-	 *   no point in delaying the service of such an I/O. The
-	 *   only possible result is a throughput loss
-	 * - so, when the above condition holds, the best option is to
-	 *   have the new I/O dispatched as soon as possible
-	 * - the most effective and efficient way to attain the above
-	 *   goal is to put the new I/O directly in the dispatch
-	 *   list
-	 * - as an additional restriction, Q1 and Q2 must be the only
-	 *   busy queues for this commit to put the I/O of Q2/Q1 in
-	 *   the dispatch list.  This is necessary, because, if also
-	 *   other queues are waiting for service, then putting new
-	 *   I/O directly in the dispatch list may evidently cause a
-	 *   violation of service guarantees for the other queues
-	 */
-	if (!bfqq ||
-	    (bfqq != bfqd->in_service_queue &&
-	     bfqd->in_service_queue != NULL &&
-	     bfq_tot_busy_queues(bfqd) == 1 + bfq_bfqq_busy(bfqq) &&
-	     (bfqq->waker_bfqq == bfqd->in_service_queue ||
-	      bfqd->in_service_queue->waker_bfqq == bfqq)) || at_head) {
+	if (!bfqq || at_head) {
 		if (at_head)
 			list_add(&rq->queuelist, &bfqd->dispatch);
 		else
@@ -6200,7 +6159,6 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 * merge).
 	 */
 	cmd_flags = rq->cmd_flags;
-
 	spin_unlock_irq(&bfqd->lock);
 
 	bfq_update_insert_stats(q, bfqq, idle_timer_disabled,
-- 
2.26.2

