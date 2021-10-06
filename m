Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5EBC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37358610CC
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhJFReA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:34:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41998 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbhJFRdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 13:33:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0C80B2006A;
        Wed,  6 Oct 2021 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633541518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/cdzGWpVIi/1lQxdCU4YeORCPw1dAioHvfRnoNLvf0=;
        b=0x9ne/1J4UprHY8IHdP2CokYpftFFyo2CjfkqwS26YdRaMKCWyHOTyX84nftp0GO8RqRK9
        v4vwxa3xpOWy8e6sb89QBX2OtzcSfM+qbi/4a505rEkKIXL5dGQoy4UAXJaRA5V7uaNgTE
        hbgwDwWHy0GMTc6InOFq0+KNyVLbew0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633541518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/cdzGWpVIi/1lQxdCU4YeORCPw1dAioHvfRnoNLvf0=;
        b=RrD4ABMCXNsBItRip3TaFyFzX+XuJGg4Rbv8xU/KRI8natIoocoJDAZPXGNRJaKc4CQp/5
        HWtlxJOmyoWD9kDw==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id E91FDA3B91;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 782291F2CA8; Wed,  6 Oct 2021 19:31:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 8/8] bfq: Do not let waker requests skip proper accounting
Date:   Wed,  6 Oct 2021 19:31:47 +0200
Message-Id: <20211006173157.6906-8-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211006164110.10817-1-jack@suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5049; h=from:subject; bh=JvltDTlTsWoqMQ81Lk3WlFrszv2LKI4OA/zKkQgyAs8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhXd2C9iUzzdgguU1Fwl4Ti/1wE0vJWWwMVIQ7KpIh vioEWF2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYV3dggAKCRCcnaoHP2RA2XVaCA CwjVfttwuL5/siGYZePU412Z97Q6odxlbHXkRdrRpmnBZU506rcDZbT+Xq0F4Lb9PMAXHNuyNITS8x YUuHgxZXGOBg0d+YIi+PYnt8N+ZQiaHs96NgMr+f5fUcr438LqdgoP33tVWVWz99pxySoBQu4KPbLe Qxzlt98JHCQGy8kBeCFs1CXlDm/muTHE7x1oX0Zmvf/UjvCi08i5XwhZNVPd6dJrvJ9/Vh/+1X9NWg 5D0q3C3UDhJ05REyTSCaqodn5aTNFKtdllgrEeTVz09KiQXdPTV8Qfoe6PoJHNWmxHQmih507hW/LS zjSsf+WvTAJ7dJcChf9zLr9zferMPS
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
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 44 +-------------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 886befc35b57..803a0c313f0f 100644
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

