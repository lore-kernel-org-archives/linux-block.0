Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37384C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 07:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12938207FF
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 07:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfI0H7m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:59:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbfI0H7m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 03:59:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 471E7A31099FB25D5874;
        Fri, 27 Sep 2019 15:59:40 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Sep 2019
 15:59:34 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>,
        <hch@infradead.org>, <keith.busch@intel.com>, <bvanassche@acm.org>
Subject: [PATCH v5] block: fix null pointer dereference in blk_mq_rq_timed_out()
Date:   Fri, 27 Sep 2019 16:19:55 +0800
Message-ID: <20190927081955.44680-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We got a null pointer deference BUG_ON in blk_mq_rq_timed_out()
as following:

[  108.825472] BUG: kernel NULL pointer dereference, address: 0000000000000040
[  108.827059] PGD 0 P4D 0
[  108.827313] Oops: 0000 [#1] SMP PTI
[  108.827657] CPU: 6 PID: 198 Comm: kworker/6:1H Not tainted 5.3.0-rc8+ #431
[  108.829503] Workqueue: kblockd blk_mq_timeout_work
[  108.829913] RIP: 0010:blk_mq_check_expired+0x258/0x330
[  108.838191] Call Trace:
[  108.838406]  bt_iter+0x74/0x80
[  108.838665]  blk_mq_queue_tag_busy_iter+0x204/0x450
[  108.839074]  ? __switch_to_asm+0x34/0x70
[  108.839405]  ? blk_mq_stop_hw_queue+0x40/0x40
[  108.839823]  ? blk_mq_stop_hw_queue+0x40/0x40
[  108.840273]  ? syscall_return_via_sysret+0xf/0x7f
[  108.840732]  blk_mq_timeout_work+0x74/0x200
[  108.841151]  process_one_work+0x297/0x680
[  108.841550]  worker_thread+0x29c/0x6f0
[  108.841926]  ? rescuer_thread+0x580/0x580
[  108.842344]  kthread+0x16a/0x1a0
[  108.842666]  ? kthread_flush_work+0x170/0x170
[  108.843100]  ret_from_fork+0x35/0x40

The bug is caused by the race between timeout handle and completion for
flush request.

When timeout handle function blk_mq_rq_timed_out() try to read
'req->q->mq_ops', the 'req' have completed and reinitiated by next
flush request, which would call blk_rq_init() to clear 'req' as 0.

After commit 12f5b93145 ("blk-mq: Remove generation seqeunce"),
normal requests lifetime are protected by refcount. Until 'rq->ref'
drop to zero, the request can really be free. Thus, these requests
cannot been reused before timeout handle finish.

However, flush request has defined .end_io and rq->end_io() is still
called even if 'rq->ref' doesn't drop to zero. After that, the 'flush_rq'
can be reused by the next flush request handle, resulting in null
pointer deference BUG ON.

We fix this problem by covering flush request with 'rq->ref'.
If the refcount is not zero, flush_end_io() return and wait the
last holder recall it. To record the request status, we add a new
entry 'rq_status', which will be used in flush_end_io().

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Yufen Yu <yuyufen@huawei.com>

-------
v2:
 - move rq_status from struct request to struct blk_flush_queue
v3:
 - remove unnecessary '{}' pair.
v4:
 - let spinlock to protect 'fq->rq_status'
v5:
 - move rq_status after flush_running_idx member of struct blk_flush_queue
---
 block/blk-flush.c | 10 ++++++++++
 block/blk-mq.c    |  5 ++++-
 block/blk.h       |  7 +++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index aedd9320e605..1eec9cbe5a0a 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -214,6 +214,16 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
+
+	if (!refcount_dec_and_test(&flush_rq->ref)) {
+		fq->rq_status = error;
+		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
+		return;
+	}
+
+	if (fq->rq_status != BLK_STS_OK)
+		error = fq->rq_status;
+
 	hctx = flush_rq->mq_hctx;
 	if (!q->elevator) {
 		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 20a49be536b5..e04fa9ab5574 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -912,7 +912,10 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	 */
 	if (blk_mq_req_expired(rq, next))
 		blk_mq_rq_timed_out(rq, reserved);
-	if (refcount_dec_and_test(&rq->ref))
+
+	if (is_flush_rq(rq, hctx))
+		rq->end_io(rq, 0);
+	else if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 
 	return true;
diff --git a/block/blk.h b/block/blk.h
index ed347f7a97b1..2d8cdafee799 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -19,6 +19,7 @@ struct blk_flush_queue {
 	unsigned int		flush_queue_delayed:1;
 	unsigned int		flush_pending_idx:1;
 	unsigned int		flush_running_idx:1;
+	blk_status_t 		rq_status;
 	unsigned long		flush_pending_since;
 	struct list_head	flush_queue[2];
 	struct list_head	flush_data_in_flight;
@@ -47,6 +48,12 @@ static inline void __blk_get_queue(struct request_queue *q)
 	kobject_get(&q->kobj);
 }
 
+static inline bool
+is_flush_rq(struct request *req, struct blk_mq_hw_ctx *hctx)
+{
+	return hctx->fq->flush_rq == req;
+}
+
 struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 		int node, int cmd_size, gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
-- 
2.17.2

