Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D7CC433E7
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 06:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33980223C6
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 06:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgJTGy0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 02:54:26 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52826 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729212AbgJTGy0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 02:54:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UCcdPoy_1603176861;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UCcdPoy_1603176861)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Oct 2020 14:54:21 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     snitzer@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        joseph.qi@linux.alibaba.com, xiaoguang.wang@linux.alibaba.com,
        haoxu@linux.alibaba.com
Subject: [RFC 2/3] block: add back ->poll_fn in request queue
Date:   Tue, 20 Oct 2020 14:54:19 +0800
Message-Id: <20201020065420.124885-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201020065420.124885-1-jefflexu@linux.alibaba.com>
References: <20201020065420.124885-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a prep for adding support of IO polling for dm device.

->poll_fn is introduced in commit ea435e1b9392 ("block: add a poll_fn
callback to struct request_queue") for supporting non-mq queues such as
nvme multipath, but removed in commit 529262d56dbe ("block: remove
->poll_fn").

To add support of IO polling for dm device, support for non-mq device
should be added and thus we need ->poll_fn back.

commit c62b37d96b6e ("block: move ->make_request_fn to struct
block_device_operations") moved all callbacks into struct
block_device_operations in gendisk. But ->poll_fn can't be moved there
since there's no way to fetch the corresponding gendisk from
request_queue.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 block/blk-mq.c         | 30 ++++++++++++++++++++++++------
 include/linux/blkdev.h |  3 +++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 696450257ac1..b521ab01eaf3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,6 +43,7 @@
 
 static DEFINE_PER_CPU(struct list_head, blk_cpu_done);
 
+static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -3212,6 +3213,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	q->tag_set = set;
 
+	if (q->mq_ops->poll)
+		q->poll_fn = blk_mq_poll;
+
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 	if (set->nr_maps > HCTX_TYPE_POLL &&
 	    set->map[HCTX_TYPE_POLL].nr_queues)
@@ -3856,7 +3860,8 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+	hctx = queue_is_mq(q) ?
+		q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)] : NULL;
 
 	/*
 	 * If we sleep, have the caller restart the poll loop to reset
@@ -3864,21 +3869,26 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	 * caller is responsible for checking if the IO completed. If
 	 * the IO isn't complete, we'll get called again and will go
 	 * straight to the busy poll loop.
+	 *
+	 * Currently dm doesn't support hybrid polling.
 	 */
-	if (blk_mq_poll_hybrid(q, hctx, cookie))
+	if (hctx && blk_mq_poll_hybrid(q, hctx, cookie))
 		return 1;
 
-	hctx->poll_considered++;
+	if (hctx)
+		hctx->poll_considered++;
 
 	state = current->state;
 	do {
 		int ret;
 
-		hctx->poll_invoked++;
+		if (hctx)
+			hctx->poll_invoked++;
 
-		ret = q->mq_ops->poll(hctx);
+		ret = q->poll_fn(q, cookie);
 		if (ret > 0) {
-			hctx->poll_success++;
+			if (hctx)
+				hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
 			return ret;
 		}
@@ -3898,6 +3908,14 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 }
 EXPORT_SYMBOL_GPL(blk_poll);
 
+static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+	return q->mq_ops->poll(hctx);
+}
+
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
 	return rq->mq_ctx->cpu;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 639cae2c158b..d05684449893 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -288,6 +288,8 @@ static inline unsigned short req_get_ioprio(struct request *req)
 
 struct blk_queue_ctx;
 
+typedef int (poll_q_fn) (struct request_queue *q, blk_qc_t);
+
 struct bio_vec;
 
 enum blk_eh_timer_return {
@@ -486,6 +488,7 @@ struct request_queue {
 
 	struct blk_stat_callback	*poll_cb;
 	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];
+	poll_q_fn		*poll_fn;
 
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
-- 
2.27.0

