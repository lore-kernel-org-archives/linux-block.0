Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DE9C4332B
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64FA64FB2
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhCPDSZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Mar 2021 23:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234765AbhCPDSO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Mar 2021 23:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615864693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IiPSr5VwrIg5qmtCl0gZdFgm3nFcl1UuqPwXIPyktps=;
        b=A08wCPtI688RI+1hf4v78hgPwlhzc+iuVUeiILqIbLUz6eQRzT8LWIXCRStCJ9mTb+wgK7
        oTBbpVanWLJ0Xe9SBk8USzgSz0Dao80BYRQE4yJnneYEkW0ssGaUg4IxJGy6bAzNXFQPev
        neW3rev48ZvVYxJn3UMSAIt/og5TY8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-j3BGYDWOMgqAe0S5pqn8bA-1; Mon, 15 Mar 2021 23:18:11 -0400
X-MC-Unique: j3BGYDWOMgqAe0S5pqn8bA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 565DD1074644;
        Tue, 16 Mar 2021 03:18:10 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 709725C261;
        Tue, 16 Mar 2021 03:17:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 04/11] block: create io poll context for submission and poll task
Date:   Tue, 16 Mar 2021 11:15:16 +0800
Message-Id: <20210316031523.864506-5-ming.lei@redhat.com>
In-Reply-To: <20210316031523.864506-1-ming.lei@redhat.com>
References: <20210316031523.864506-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Create per-task io poll context for both IO submission and poll task
if the queue is bio based and supports polling.

This io polling context includes two queues: submission queue(sq) for
storing HIPRI bio submission result(cookie) and the bio, written
by submission task and read by poll task; polling queue(pq) for holding
data moved from sq, only used in poll context for running bio polling.

Following patches will support bio poll.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c          | 59 +++++++++++++++++++++++++++++++--------
 block/blk-ioc.c           |  1 +
 block/blk-mq.c            | 14 ++++++++++
 block/blk.h               | 45 +++++++++++++++++++++++++++++
 include/linux/iocontext.h |  2 ++
 5 files changed, 109 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d58f8a0c80de..7c7b0dba4f5c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -792,16 +792,47 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
-static inline void blk_create_io_context(struct request_queue *q)
+static inline bool blk_queue_support_bio_poll(struct request_queue *q)
 {
-	/*
-	 * Various block parts want %current->io_context, so allocate it up
-	 * front rather than dealing with lots of pain to allocate it only
-	 * where needed. This may fail and the block layer knows how to live
-	 * with it.
-	 */
-	if (unlikely(!current->io_context))
-		create_task_io_context(current, GFP_ATOMIC, q->node);
+	return !queue_is_mq(q) && blk_queue_poll(q);
+}
+
+static inline struct blk_bio_poll_ctx *blk_get_bio_poll_ctx(void)
+{
+	struct io_context *ioc = current->io_context;
+
+	return ioc ? ioc->data : NULL;
+}
+
+static void bio_poll_ctx_init(struct blk_bio_poll_ctx *pc)
+{
+	spin_lock_init(&pc->lock);
+	INIT_KFIFO(pc->sq);
+
+	mutex_init(&pc->pq_lock);
+	memset(pc->pq, 0, sizeof(pc->pq));
+}
+
+void bio_poll_ctx_alloc(struct io_context *ioc)
+{
+	struct blk_bio_poll_ctx *pc;
+
+	pc = kmalloc(sizeof(*pc), GFP_ATOMIC);
+	if (pc) {
+		bio_poll_ctx_init(pc);
+		if (cmpxchg(&ioc->data, NULL, (void *)pc))
+			kfree(pc);
+	}
+}
+
+static inline void blk_bio_poll_preprocess(struct request_queue *q,
+		struct bio *bio)
+{
+	if (!(bio->bi_opf & REQ_HIPRI))
+		return;
+
+	if (!blk_queue_poll(q) || (!queue_is_mq(q) && !blk_get_bio_poll_ctx()))
+		bio->bi_opf &= ~REQ_HIPRI;
 }
 
 static noinline_for_stack bool submit_bio_checks(struct bio *bio)
@@ -848,10 +879,14 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		}
 	}
 
-	blk_create_io_context(q);
+	/*
+	 * Created per-task io poll queue if we supports bio polling
+	 * and it is one HIPRI bio.
+	 */
+	blk_create_io_context(q, blk_queue_support_bio_poll(q) &&
+			(bio->bi_opf & REQ_HIPRI));
 
-	if (!blk_queue_poll(q))
-		bio->bi_opf &= ~REQ_HIPRI;
+	blk_bio_poll_preprocess(q, bio);
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index b0cde18c4b8c..5574c398eff6 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -19,6 +19,7 @@ static struct kmem_cache *iocontext_cachep;
 
 static inline void free_io_context(struct io_context *ioc)
 {
+	kfree(ioc->data);
 	kmem_cache_free(iocontext_cachep, ioc);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 63c81df3b8b5..c832faa52ca0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3852,6 +3852,17 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 	return blk_mq_poll_hybrid_sleep(q, rq);
 }
 
+static int blk_bio_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
+{
+	/*
+	 * Create poll queue for storing poll bio and its cookie from
+	 * submission queue
+	 */
+	blk_create_io_context(q, true);
+
+	return 0;
+}
+
 /**
  * blk_poll - poll for IO completions
  * @q:  the queue
@@ -3875,6 +3886,9 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
+	if (!queue_is_mq(q))
+		return blk_bio_poll(q, cookie, spin);
+
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
 
 	/*
diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e..f7a889bb3720 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -7,6 +7,7 @@
 #include <linux/part_stat.h>
 #include <linux/blk-crypto.h>
 #include <xen/xen.h>
+#include <linux/kfifo.h>
 #include "blk-crypto-internal.h"
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
@@ -357,4 +358,48 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
+#define BLK_BIO_POLL_SQ_SZ		64U
+#define BLK_BIO_POLL_PQ_SZ		(BLK_BIO_POLL_SQ_SZ * 2)
+
+/* result of submit_bio */
+struct blk_bio_poll_data {
+	struct bio	*bio;
+};
+
+/* Per-task bio poll queue data and attached to io context */
+struct blk_bio_poll_ctx {
+	spinlock_t	lock;
+	/*
+	 * Submission queue for storing HIPRI bio submission result, written
+	 * by submission task and read by poll task
+	 */
+	DECLARE_KFIFO(sq, struct blk_bio_poll_data, BLK_BIO_POLL_SQ_SZ);
+
+	/* Holding poll data moved from sq, only used in poll task */
+	struct mutex  pq_lock;
+	struct blk_bio_poll_data pq[BLK_BIO_POLL_PQ_SZ];
+};
+
+void bio_poll_ctx_alloc(struct io_context *ioc);
+
+static inline void blk_create_io_context(struct request_queue *q,
+		bool need_poll_ctx)
+{
+	struct io_context *ioc;
+
+	/*
+	 * Various block parts want %current->io_context, so allocate it up
+	 * front rather than dealing with lots of pain to allocate it only
+	 * where needed. This may fail and the block layer knows how to live
+	 * with it.
+	 */
+	if (unlikely(!current->io_context))
+		create_task_io_context(current, GFP_ATOMIC, q->node);
+
+	ioc = current->io_context;
+	if (need_poll_ctx && unlikely(ioc && !ioc->data))
+		bio_poll_ctx_alloc(ioc);
+}
+
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index 0a9dc40b7be8..f9a467571356 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -110,6 +110,8 @@ struct io_context {
 	struct io_cq __rcu	*icq_hint;
 	struct hlist_head	icq_list;
 
+	void			*data;
+
 	struct work_struct release_work;
 };
 
-- 
2.29.2

