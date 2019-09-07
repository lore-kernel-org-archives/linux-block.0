Return-Path: <SRS0=IQpB=XC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF8EC43331
	for <linux-block@archiver.kernel.org>; Sat,  7 Sep 2019 10:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526EB20854
	for <linux-block@archiver.kernel.org>; Sat,  7 Sep 2019 10:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfIGKEe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Sep 2019 06:04:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728117AbfIGKEe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 7 Sep 2019 06:04:34 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6B019B71E51E0F6DDD94;
        Sat,  7 Sep 2019 18:04:31 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 7 Sep 2019
 18:04:21 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <hch@infradead.org>,
        <keith.busch@intel.com>, <tj@kernel.org>, <yuyufen@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] block: fix null pointer dereference in blk_mq_rq_timed_out()
Date:   Sat, 7 Sep 2019 18:24:50 +0800
Message-ID: <20190907102450.40291-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a race condition between timeout check and completion for
flush request as follow:

timeout_work    issue flush      issue flush
                blk_insert_flush
                                 blk_insert_flush
blk_mq_timeout_work
                blk_kick_flush

blk_mq_queue_tag_busy_iter
blk_mq_check_expired(flush_rq)

                __blk_mq_end_request
               flush_end_io
               blk_kick_flush
               blk_rq_init(flush_rq)
               memset(flush_rq, 0)

blk_mq_timed_out
BUG_ON flush_rq->q->mq_ops

For normal request, we need to get a tag and then allocate corresponding request.
Thus, the request cannot be reallocated before the tag have been free.
Commit 1d9bd5161ba ("blk-mq: replace timeout synchronization with a RCU and
generation based scheme") and commit 12f5b93145 ("blk-mq: Remove generation
seqeunce") can guarantee the consistency of timeout handle and completion.

However, 'flush_rq' have been forgotten. 'flush_rq' allocation management
dependents on flush implemention mechanism. Each hctx has only one 'flush_rq'.
When a flush request have completed, the next flush request will hold the 'flush_rq'.
In the end, timeout handle may access the cleared 'flush_rq'.

We fix this problem by checking request refcount 'rq->ref', as normal request.
If the refcount is not zero, flush_end_io() return and wait the last holder
recall it. To record the request status, we add a new entry 'rq_status',
which will be used in flush_end_io().

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-flush.c      | 8 ++++++++
 block/blk-mq.c         | 7 +++++--
 block/blk.h            | 5 +++++
 include/linux/blkdev.h | 2 ++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index aedd9320e605..359a7e1a0925 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -212,6 +212,14 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
 	struct blk_mq_hw_ctx *hctx;
 
+	if (!refcount_dec_and_test(&flush_rq->ref)) {
+		flush_rq->rq_status = error;
+		return;
+	}
+
+	if (flush_rq->rq_status != BLK_STS_OK)
+		error = flush_rq->rq_status;
+
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 	hctx = flush_rq->mq_hctx;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0835f4d8d42e..3d2b2c2e9cdf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -905,9 +905,12 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	 */
 	if (blk_mq_req_expired(rq, next))
 		blk_mq_rq_timed_out(rq, reserved);
-	if (refcount_dec_and_test(&rq->ref))
-		__blk_mq_free_request(rq);
 
+	if (is_flush_rq(rq, hctx)) {
+		rq->end_io(rq, 0);
+	} else if (refcount_dec_and_test(&rq->ref)) {
+		__blk_mq_free_request(rq);
+	}
 	return true;
 }
 
diff --git a/block/blk.h b/block/blk.h
index de6b2e146d6e..f503ef9ad3e6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -47,6 +47,11 @@ static inline void __blk_get_queue(struct request_queue *q)
 	kobject_get(&q->kobj);
 }
 
+static inline bool
+is_flush_rq(struct request *req, struct blk_mq_hw_ctx *hctx) {
+	return hctx->fq->flush_rq == req;
+}
+
 struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 		int node, int cmd_size, gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ef375dafb1c..b1d05077e03f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -237,6 +237,8 @@ struct request {
 	 */
 	rq_end_io_fn *end_io;
 	void *end_io_data;
+
+	blk_status_t rq_status;
 };
 
 static inline bool blk_op_is_scsi(unsigned int op)
-- 
2.17.2

