Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC949C77B73
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 20:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjDPUJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 16:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPUJz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 16:09:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F5F30D8
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8hVg0g62RRffpXLUyIK5aTgeqcCbYnSWk4m2wMSS/t8=; b=UTk/H+F/kHO9Nte89C0ZyMw9JS
        HZdLlsKRmlsoNacEFz/bxsXwL6+TclomyjLajIsawP9TSjKs5T87us1hnA5AOOGmptaEi3THYg1Tu
        RPbPHarkd2x06kUSywsjlcD12PNG+hIv/KdYJBkYlslAeMzdcH1MsFoqXNCdYa2jJM3tpIE9EdKxX
        qqxJqO5PlhJDwNnkzpPcTt5cQGnJAVzzG6pwzd0RtQ+Af8oeIOJIgLZLQ7dn6Otw6wAf7QB9jgqiJ
        3L/T6QDVLuEH5Di7AVL+WZX5NTJXgqLM7mOHTaQAwYmw/YvmfMyHK6dE+7mHcqK5XflInlfD1sEb4
        zvIhSUuw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1po8h4-00EOIV-0q;
        Sun, 16 Apr 2023 20:09:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/7] blk-mq: also use the I/O scheduler for requests from the flush state machine
Date:   Sun, 16 Apr 2023 22:09:27 +0200
Message-Id: <20230416200930.29542-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416200930.29542-1-hch@lst.de>
References: <20230416200930.29542-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

Send write requests issued by the flush state machine through the normal
I/O submission path including the I/O scheduler (if present) so that I/O
scheduler policies are applied to writes with the FUA flag set.

Separate the I/O scheduler members from the flush members in struct
request since now a request may pass through both an I/O scheduler
and the flush machinery.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
[hch: rebased]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c      |  5 ++++-
 block/blk-mq-sched.c   | 14 ++++++++++++++
 block/blk-mq-sched.h   |  1 +
 block/blk-mq.c         | 24 ++++++------------------
 include/linux/blk-mq.h | 27 +++++++++++----------------
 5 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 5bc462524473b2..f62e74d9d56bc8 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -330,8 +330,11 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 		 * account of this driver tag
 		 */
 		flush_rq->rq_flags |= RQF_MQ_INFLIGHT;
-	} else
+	} else {
 		flush_rq->internal_tag = first_rq->internal_tag;
+		flush_rq->rq_flags |= RQF_ELV;
+		blk_mq_sched_prepare(flush_rq);
+	}
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
 	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 67c95f31b15bb1..70087554eeb8f4 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -16,6 +16,20 @@
 #include "blk-mq-sched.h"
 #include "blk-wbt.h"
 
+/* Prepare a request for insertion into an I/O scheduler. */
+void blk_mq_sched_prepare(struct request *rq)
+{
+	struct elevator_queue *e = rq->q->elevator;
+
+	INIT_HLIST_NODE(&rq->hash);
+	RB_CLEAR_NODE(&rq->rb_node);
+
+	if (e->type->ops.prepare_request) {
+		e->type->ops.prepare_request(rq);
+		rq->rq_flags |= RQF_ELVPRIV;
+	}
+}
+
 /*
  * Mark a hardware queue as needing a restart.
  */
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 7c3cbad17f3052..3049e988ca5916 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -7,6 +7,7 @@
 
 #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
 
+void blk_mq_sched_prepare(struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
 bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 452bc17cce4dcf..50a03e1592819c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -388,18 +388,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	WRITE_ONCE(rq->deadline, 0);
 	req_ref_set(rq, 1);
 
-	if (rq->rq_flags & RQF_ELV) {
-		struct elevator_queue *e = data->q->elevator;
-
-		INIT_HLIST_NODE(&rq->hash);
-		RB_CLEAR_NODE(&rq->rb_node);
-
-		if (!op_is_flush(data->cmd_flags) &&
-		    e->type->ops.prepare_request) {
-			e->type->ops.prepare_request(rq);
-			rq->rq_flags |= RQF_ELVPRIV;
-		}
-	}
+	if (rq->rq_flags & RQF_ELV)
+		blk_mq_sched_prepare(rq);
 
 	return rq;
 }
@@ -456,13 +446,11 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		data->rq_flags |= RQF_ELV;
 
 		/*
-		 * Flush/passthrough requests are special and go directly to the
-		 * dispatch list. Don't include reserved tags in the
-		 * limiting, as it isn't useful.
+		 * Do not limit the depth for passthrough requests nor for
+		 * requests with a reserved tag.
 		 */
-		if (!op_is_flush(data->cmd_flags) &&
+		if (e->type->ops.limit_depth &&
 		    !blk_op_is_passthrough(data->cmd_flags) &&
-		    e->type->ops.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.limit_depth(data->cmd_flags, data);
 	}
@@ -2496,7 +2484,7 @@ static void blk_mq_insert_request(struct request *rq, blk_insert_t flags)
 		 * dispatch it given we prioritize requests in hctx->dispatch.
 		 */
 		blk_mq_request_bypass_insert(rq, flags);
-	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
+	} else if (req_op(rq) == REQ_OP_FLUSH) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
 		 * sw queue, meantime we add flush request to dispatch queue(
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1dacb2c81fdda1..a204a5f3cc9524 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -169,25 +169,20 @@ struct request {
 		void *completion_data;
 	};
 
-
 	/*
 	 * Three pointers are available for the IO schedulers, if they need
-	 * more they have to dynamically allocate it.  Flush requests are
-	 * never put on the IO scheduler. So let the flush fields share
-	 * space with the elevator data.
+	 * more they have to dynamically allocate it.
 	 */
-	union {
-		struct {
-			struct io_cq		*icq;
-			void			*priv[2];
-		} elv;
-
-		struct {
-			unsigned int		seq;
-			struct list_head	list;
-			rq_end_io_fn		*saved_end_io;
-		} flush;
-	};
+	struct {
+		struct io_cq		*icq;
+		void			*priv[2];
+	} elv;
+
+	struct {
+		unsigned int		seq;
+		struct list_head	list;
+		rq_end_io_fn		*saved_end_io;
+	} flush;
 
 	union {
 		struct __call_single_data csd;
-- 
2.39.2

