Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8861C433DB
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C45F61920
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 15:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhC2P1p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 11:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231297AbhC2P1h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 11:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617031656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HpR7pU5Z2wT/dmFhvZrQXuEam+zMDtMGANHrIUN5Vg=;
        b=ROiQYDaFLhiB9IDoe5X9x1hXIt86Erl0Z1HY4yGzEeJGjL2vU+s8ef8obJd8/cFjWAKz3E
        dtL07XbmD6cHOwXU0vIDykmwXa8iKdBZP69HW8vc5pYu1yiOiPgNgpuF9YthHY0PmVC5Pj
        G9EZ/uv1mnnNVu4lP1o3zu2sgvvPpe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-WIxElZe2Nf-di9zcISduNg-1; Mon, 29 Mar 2021 11:27:33 -0400
X-MC-Unique: WIxElZe2Nf-di9zcISduNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44CE39CDC4;
        Mon, 29 Mar 2021 15:27:32 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0107E5C5DF;
        Mon, 29 Mar 2021 15:27:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 03/12] block: create io poll context for submission and poll task
Date:   Mon, 29 Mar 2021 23:26:13 +0800
Message-Id: <20210329152622.173035-4-ming.lei@redhat.com>
In-Reply-To: <20210329152622.173035-1-ming.lei@redhat.com>
References: <20210329152622.173035-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Create per-task io poll context for both IO submission and poll task
if the queue is bio based and supports polling.

This io polling context includes two queues:

1) submission queue(sq) for storing HIPRI bio, written by submission task
   and read by poll task.
2) polling queue(pq) for holding data moved from sq, only used in poll
   context for running bio polling.

Following patches will support bio based io polling.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c          | 79 +++++++++++++++++++++++++++++++++------
 block/blk-ioc.c           |  1 +
 block/blk-mq.c            | 14 +++++++
 block/blk.h               | 38 +++++++++++++++++++
 include/linux/iocontext.h |  2 +
 5 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a31371d55b9d..8a21a8c010a6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -792,6 +792,61 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
+static inline struct blk_bio_poll_ctx *blk_get_bio_poll_ctx(void)
+{
+	struct io_context *ioc = current->io_context;
+
+	return ioc ? ioc->data : NULL;
+}
+
+static inline unsigned int bio_grp_list_size(unsigned int nr_grps)
+{
+	return sizeof(struct bio_grp_list) + nr_grps *
+		sizeof(struct bio_grp_list_data);
+}
+
+static void bio_poll_ctx_init(struct blk_bio_poll_ctx *pc)
+{
+	pc->sq = (void *)pc + sizeof(*pc);
+	pc->sq->max_nr_grps = BLK_BIO_POLL_SQ_SZ;
+
+	pc->pq = (void *)pc->sq + bio_grp_list_size(BLK_BIO_POLL_SQ_SZ);
+	pc->pq->max_nr_grps = BLK_BIO_POLL_PQ_SZ;
+
+	spin_lock_init(&pc->sq_lock);
+	spin_lock_init(&pc->pq_lock);
+}
+
+void bio_poll_ctx_alloc(struct io_context *ioc)
+{
+	struct blk_bio_poll_ctx *pc;
+	unsigned int size = sizeof(*pc) +
+		bio_grp_list_size(BLK_BIO_POLL_SQ_SZ) +
+		bio_grp_list_size(BLK_BIO_POLL_PQ_SZ);
+
+	pc = kzalloc(GFP_ATOMIC, size);
+	if (pc) {
+		bio_poll_ctx_init(pc);
+		if (cmpxchg(&ioc->data, NULL, (void *)pc))
+			kfree(pc);
+	}
+}
+
+static inline bool blk_queue_support_bio_poll(struct request_queue *q)
+{
+	return !queue_is_mq(q) && blk_queue_poll(q);
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
+}
+
 static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
@@ -836,8 +891,19 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		}
 	}
 
-	if (!blk_queue_poll(q))
-		bio->bi_opf &= ~REQ_HIPRI;
+	/*
+	 * Various block parts want %current->io_context, so allocate it up
+	 * front rather than dealing with lots of pain to allocate it only
+	 * where needed. This may fail and the block layer knows how to live
+	 * with it.
+	 */
+	if (unlikely(!current->io_context))
+		create_task_io_context(current, GFP_ATOMIC, q->node);
+
+	if (blk_queue_support_bio_poll(q) && (bio->bi_opf & REQ_HIPRI))
+		blk_create_io_poll_context(q);
+
+	blk_bio_poll_preprocess(q, bio);
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
@@ -876,15 +942,6 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		break;
 	}
 
-	/*
-	 * Various block parts want %current->io_context, so allocate it up
-	 * front rather than dealing with lots of pain to allocate it only
-	 * where needed. This may fail and the block layer knows how to live
-	 * with it.
-	 */
-	if (unlikely(!current->io_context))
-		create_task_io_context(current, GFP_ATOMIC, q->node);
-
 	if (blk_throtl_bio(bio)) {
 		blkcg_bio_issue_init(bio);
 		return false;
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
index 63c81df3b8b5..1ada2c0e76b1 100644
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
+	blk_create_io_poll_context(q);
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
index 3b53e44b967e..35901cee709d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -357,4 +357,42 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
+/* Grouping bios that share same data into one list */
+struct bio_grp_list_data {
+	void *grp_data;
+
+	/* all bios in this list share same 'grp_data' */
+	struct bio_list list;
+};
+
+struct bio_grp_list {
+	unsigned int max_nr_grps, nr_grps;
+	struct bio_grp_list_data head[0];
+};
+
+struct blk_bio_poll_ctx {
+	spinlock_t sq_lock;
+	struct bio_grp_list *sq;
+
+	spinlock_t pq_lock;
+	struct bio_grp_list *pq;
+};
+
+#define BLK_BIO_POLL_SQ_SZ		16U
+#define BLK_BIO_POLL_PQ_SZ		(BLK_BIO_POLL_SQ_SZ * 2)
+
+void bio_poll_ctx_alloc(struct io_context *ioc);
+
+static inline void blk_create_io_poll_context(struct request_queue *q)
+{
+	struct io_context *ioc;
+
+	if (unlikely(!current->io_context))
+		create_task_io_context(current, GFP_ATOMIC, q->node);
+
+	ioc = current->io_context;
+	if (unlikely(ioc && !ioc->data))
+		bio_poll_ctx_alloc(ioc);
+}
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

