Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7CAC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbiGNSHu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239994AbiGNSHs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:48 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0B968704
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:45 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso3830133pjj.5
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cC9N5WKsKWdLOvNtgS1hhfW5B6dBxEM5YEebkSxyvCY=;
        b=cCD4MmMZarPrmmVNBYYXSiL4l201kuOC+CRhrPlOwnoZb3quHVF1mgXSaCrjCWQ1Sb
         F3xl/1N3/QF7G3bd+pCGLWp5aOlJxCDsSItALGBsUkv+C8rSzPxsZ+Pr4ZdDEixO5WJl
         edSuOuJbGZnzSfh1B14PKSQU5LwWS1aRFO+Z6hRaFNj7b3snSzs9OlrVTXIg9+sVx9X0
         nSbN9E/eVX3PzyYMTSyTMDkdAIiu1r4bbM06xox5OHGU98xdiv+2mDE/ToCIalyzojGG
         Dv2XvutFA2gQxdJHbENLO34mCBanTT0eHe+0Ji/0SndqmVMlsWbwB7q19awpIwz7gd8E
         yJjg==
X-Gm-Message-State: AJIora+IBCbSPBzzcIqB8Hv+7rds8D41qjjI+jalwkmwcuP4taqHpzdC
        QP51XvH6bShe6trBkjbQtl9Vte6R0Z4=
X-Google-Smtp-Source: AGRyM1u3Qv46s4E+BF9wupbJtXzohkr6Qveq7XtQTM6Th7Iz4O2dh3jrRh5s6hHET51tHW1+K/ljfg==
X-Received: by 2002:a17:90b:3b8e:b0:1f0:2a5f:b4b3 with SMTP id pc14-20020a17090b3b8e00b001f02a5fb4b3mr10860861pjb.135.1657822065408;
        Thu, 14 Jul 2022 11:07:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 06/63] block: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:06:32 -0700
Message-Id: <20220714180729.1065367-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for arguments and variables that represent
request flags or a bitwise combination of a request operation and
request flags. Rename the function arguments and also a structure member
that hold a request operation and flags from 'rw' into 'opf'.

This patch does not change any functionality.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bio.c               | 10 +++++-----
 block/blk-cgroup-rwstat.h |  8 ++++----
 block/blk-core.c          |  2 +-
 block/blk-flush.c         |  6 +++---
 block/blk-merge.c         |  6 +++---
 block/blk-mq-debugfs.c    |  4 ++--
 block/blk-mq.c            | 15 ++++++++-------
 block/blk-mq.h            |  6 +++---
 block/blk-wbt.c           | 16 ++++++++--------
 block/elevator.h          |  2 +-
 block/fops.c              | 12 ++++++------
 include/linux/bio.h       | 10 +++++-----
 include/linux/blk-mq.h    |  6 +++---
 include/linux/blkdev.h    |  2 +-
 14 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 888ee81ea303..6f9f883f9a65 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -239,7 +239,7 @@ static void bio_free(struct bio *bio)
  * when IO has completed, or when the bio is released.
  */
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
-	      unsigned short max_vecs, unsigned int opf)
+	      unsigned short max_vecs, blk_opf_t opf)
 {
 	bio->bi_next = NULL;
 	bio->bi_bdev = bdev;
@@ -292,7 +292,7 @@ EXPORT_SYMBOL(bio_init);
  *   preserved are the ones that are initialized by bio_alloc_bioset(). See
  *   comment in struct bio.
  */
-void bio_reset(struct bio *bio, struct block_device *bdev, unsigned int opf)
+void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf)
 {
 	bio_uninit(bio);
 	memset(bio, 0, BIO_RESET_BYTES);
@@ -341,7 +341,7 @@ void bio_chain(struct bio *bio, struct bio *parent)
 EXPORT_SYMBOL(bio_chain);
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
-		unsigned int nr_pages, unsigned int opf, gfp_t gfp)
+		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
 {
 	struct bio *new = bio_alloc(bdev, nr_pages, opf, gfp);
 
@@ -409,7 +409,7 @@ static void punt_bios_to_rescuer(struct bio_set *bs)
 }
 
 static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
-		unsigned short nr_vecs, unsigned int opf, gfp_t gfp,
+		unsigned short nr_vecs, blk_opf_t opf, gfp_t gfp,
 		struct bio_set *bs)
 {
 	struct bio_alloc_cache *cache;
@@ -468,7 +468,7 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
  * Returns: Pointer to new bio on success, NULL on failure.
  */
 struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
-			     unsigned int opf, gfp_t gfp_mask,
+			     blk_opf_t opf, gfp_t gfp_mask,
 			     struct bio_set *bs)
 {
 	gfp_t saved_gfp = gfp_mask;
diff --git a/block/blk-cgroup-rwstat.h b/block/blk-cgroup-rwstat.h
index 9f2723b34b75..022527b0b043 100644
--- a/block/blk-cgroup-rwstat.h
+++ b/block/blk-cgroup-rwstat.h
@@ -59,20 +59,20 @@ void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
  * caller is responsible for synchronizing calls to this function.
  */
 static inline void blkg_rwstat_add(struct blkg_rwstat *rwstat,
-				   unsigned int op, uint64_t val)
+				   blk_opf_t opf, uint64_t val)
 {
 	struct percpu_counter *cnt;
 
-	if (op_is_discard(op))
+	if (op_is_discard(opf))
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_DISCARD];
-	else if (op_is_write(op))
+	else if (op_is_write(opf))
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_WRITE];
 	else
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_READ];
 
 	percpu_counter_add_batch(cnt, val, BLKG_STAT_CPU_BATCH);
 
-	if (op_is_sync(op))
+	if (op_is_sync(opf))
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_SYNC];
 	else
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_ASYNC];
diff --git a/block/blk-core.c b/block/blk-core.c
index 67b8bcfa27f0..123468b9d2e4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1203,7 +1203,7 @@ EXPORT_SYMBOL_GPL(blk_io_schedule);
 
 int __init blk_dev_init(void)
 {
-	BUILD_BUG_ON(REQ_OP_LAST >= (1 << REQ_OP_BITS));
+	BUILD_BUG_ON((__force u32)REQ_OP_LAST >= (1 << REQ_OP_BITS));
 	BUILD_BUG_ON(REQ_OP_BITS + REQ_FLAG_BITS > 8 *
 			sizeof_field(struct request, cmd_flags));
 	BUILD_BUG_ON(REQ_OP_BITS + REQ_FLAG_BITS > 8 *
diff --git a/block/blk-flush.c b/block/blk-flush.c
index c68968724870..d20a0c6b2c66 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -94,7 +94,7 @@ enum {
 };
 
 static void blk_kick_flush(struct request_queue *q,
-			   struct blk_flush_queue *fq, unsigned int flags);
+			   struct blk_flush_queue *fq, blk_opf_t flags);
 
 static inline struct blk_flush_queue *
 blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
@@ -173,7 +173,7 @@ static void blk_flush_complete_seq(struct request *rq,
 {
 	struct request_queue *q = rq->q;
 	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
-	unsigned int cmd_flags;
+	blk_opf_t cmd_flags;
 
 	BUG_ON(rq->flush.seq & seq);
 	rq->flush.seq |= seq;
@@ -290,7 +290,7 @@ bool is_flush_rq(struct request *rq)
  *
  */
 static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
-			   unsigned int flags)
+			   blk_opf_t flags)
 {
 	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
 	struct request *first_rq =
diff --git a/block/blk-merge.c b/block/blk-merge.c
index de178a8b4c82..3c3f785f558a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -712,7 +712,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
  */
 void blk_rq_set_mixed_merge(struct request *rq)
 {
-	unsigned int ff = rq->cmd_flags & REQ_FAILFAST_MASK;
+	blk_opf_t ff = rq->cmd_flags & REQ_FAILFAST_MASK;
 	struct bio *bio;
 
 	if (rq->rq_flags & RQF_MIXED_MERGE)
@@ -928,7 +928,7 @@ enum bio_merge_status {
 static enum bio_merge_status bio_attempt_back_merge(struct request *req,
 		struct bio *bio, unsigned int nr_segs)
 {
-	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
+	const blk_opf_t ff = bio->bi_opf & REQ_FAILFAST_MASK;
 
 	if (!ll_back_merge_fn(req, bio, nr_segs))
 		return BIO_MERGE_FAILED;
@@ -952,7 +952,7 @@ static enum bio_merge_status bio_attempt_back_merge(struct request *req,
 static enum bio_merge_status bio_attempt_front_merge(struct request *req,
 		struct bio *bio, unsigned int nr_segs)
 {
-	const int ff = bio->bi_opf & REQ_FAILFAST_MASK;
+	const blk_opf_t ff = bio->bi_opf & REQ_FAILFAST_MASK;
 
 	if (!ll_front_merge_fn(req, bio, nr_segs))
 		return BIO_MERGE_FAILED;
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6cc2411e2d26..8559cea7f300 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -313,8 +313,8 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	else
 		seq_printf(m, "%s", op_str);
 	seq_puts(m, ", .cmd_flags=");
-	blk_flags_show(m, rq->cmd_flags & ~REQ_OP_MASK, cmd_flag_name,
-		       ARRAY_SIZE(cmd_flag_name));
+	blk_flags_show(m, (__force unsigned int)(rq->cmd_flags & ~REQ_OP_MASK),
+		       cmd_flag_name, ARRAY_SIZE(cmd_flag_name));
 	seq_puts(m, ", .rq_flags=");
 	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
 		       ARRAY_SIZE(rqf_name));
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f1b84e20b1a9..d716b7f3763f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -510,13 +510,13 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 					alloc_time_ns);
 }
 
-struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
+struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
 		blk_mq_req_flags_t flags)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.flags		= flags,
-		.cmd_flags	= op,
+		.cmd_flags	= opf,
 		.nr_tags	= 1,
 	};
 	struct request *rq;
@@ -540,12 +540,12 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
-	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
+	blk_opf_t opf, blk_mq_req_flags_t flags, unsigned int hctx_idx)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.flags		= flags,
-		.cmd_flags	= op,
+		.cmd_flags	= opf,
 		.nr_tags	= 1,
 	};
 	u64 alloc_time_ns = 0;
@@ -660,7 +660,7 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
 {
 	printk(KERN_INFO "%s: dev %s: flags=%llx\n", msg,
 		rq->q->disk ? rq->q->disk->disk_name : "?",
-		(unsigned long long) rq->cmd_flags);
+		(__force unsigned long long) rq->cmd_flags);
 
 	printk(KERN_INFO "  sector %llu, nr/cnr %u/%u\n",
 	       (unsigned long long)blk_rq_pos(rq),
@@ -713,8 +713,9 @@ static void blk_print_req_error(struct request *req, blk_status_t status)
 		"phys_seg %u prio class %u\n",
 		blk_status_to_str(status),
 		req->q->disk ? req->q->disk->disk_name : "?",
-		blk_rq_pos(req), req_op(req), blk_op_str(req_op(req)),
-		req->cmd_flags & ~REQ_OP_MASK,
+		blk_rq_pos(req), (__force u32)req_op(req),
+		blk_op_str(req_op(req)),
+		(__force u32)(req->cmd_flags & ~REQ_OP_MASK),
 		req->nr_phys_segments,
 		IOPRIO_PRIO_CLASS(req->ioprio));
 }
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e694ec67d646..8ca453ac243d 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -86,7 +86,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
 	return xa_load(&q->hctx_table, q->tag_set->map[type].mq_map[cpu]);
 }
 
-static inline enum hctx_type blk_mq_get_hctx_type(unsigned int opf)
+static inline enum hctx_type blk_mq_get_hctx_type(blk_opf_t opf)
 {
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
@@ -107,7 +107,7 @@ static inline enum hctx_type blk_mq_get_hctx_type(unsigned int opf)
  * @ctx: software queue cpu ctx
  */
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
-						     unsigned int opf,
+						     blk_opf_t opf,
 						     struct blk_mq_ctx *ctx)
 {
 	return ctx->hctxs[blk_mq_get_hctx_type(opf)];
@@ -152,7 +152,7 @@ struct blk_mq_alloc_data {
 	struct request_queue *q;
 	blk_mq_req_flags_t flags;
 	unsigned int shallow_depth;
-	unsigned int cmd_flags;
+	blk_opf_t cmd_flags;
 	req_flags_t rq_flags;
 
 	/* allocate multiple requests/tags in one go */
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 7bf09ae06577..f2e4bf1dca47 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -451,7 +451,7 @@ static bool close_io(struct rq_wb *rwb)
 
 #define REQ_HIPRIO	(REQ_SYNC | REQ_META | REQ_PRIO)
 
-static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
+static inline unsigned int get_limit(struct rq_wb *rwb, blk_opf_t opf)
 {
 	unsigned int limit;
 
@@ -462,7 +462,7 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	if (!rwb_enabled(rwb))
 		return UINT_MAX;
 
-	if ((rw & REQ_OP_MASK) == REQ_OP_DISCARD)
+	if ((opf & REQ_OP_MASK) == REQ_OP_DISCARD)
 		return rwb->wb_background;
 
 	/*
@@ -473,9 +473,9 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	 * the idle limit, or go to normal if we haven't had competing
 	 * IO for a bit.
 	 */
-	if ((rw & REQ_HIPRIO) || wb_recent_wait(rwb) || current_is_kswapd())
+	if ((opf & REQ_HIPRIO) || wb_recent_wait(rwb) || current_is_kswapd())
 		limit = rwb->rq_depth.max_depth;
-	else if ((rw & REQ_BACKGROUND) || close_io(rwb)) {
+	else if ((opf & REQ_BACKGROUND) || close_io(rwb)) {
 		/*
 		 * If less than 100ms since we completed unrelated IO,
 		 * limit us to half the depth for background writeback.
@@ -490,13 +490,13 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 struct wbt_wait_data {
 	struct rq_wb *rwb;
 	enum wbt_flags wb_acct;
-	unsigned long rw;
+	blk_opf_t opf;
 };
 
 static bool wbt_inflight_cb(struct rq_wait *rqw, void *private_data)
 {
 	struct wbt_wait_data *data = private_data;
-	return rq_wait_inc_below(rqw, get_limit(data->rwb, data->rw));
+	return rq_wait_inc_below(rqw, get_limit(data->rwb, data->opf));
 }
 
 static void wbt_cleanup_cb(struct rq_wait *rqw, void *private_data)
@@ -510,13 +510,13 @@ static void wbt_cleanup_cb(struct rq_wait *rqw, void *private_data)
  * the timer to kick off queuing again.
  */
 static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
-		       unsigned long rw)
+		       blk_opf_t opf)
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
 	struct wbt_wait_data data = {
 		.rwb = rwb,
 		.wb_acct = wb_acct,
-		.rw = rw,
+		.opf = opf,
 	};
 
 	rq_qos_wait(rqw, &data, wbt_inflight_cb, wbt_cleanup_cb);
diff --git a/block/elevator.h b/block/elevator.h
index 16cd8bdedb7e..3f0593b3bf9d 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -34,7 +34,7 @@ struct elevator_mq_ops {
 	int (*request_merge)(struct request_queue *q, struct request **, struct bio *);
 	void (*request_merged)(struct request_queue *, struct request *, enum elv_merge);
 	void (*requests_merged)(struct request_queue *, struct request *, struct request *);
-	void (*limit_depth)(unsigned int, struct blk_mq_alloc_data *);
+	void (*limit_depth)(blk_opf_t, struct blk_mq_alloc_data *);
 	void (*prepare_request)(struct request *);
 	void (*finish_request)(struct request *);
 	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head *, bool);
diff --git a/block/fops.c b/block/fops.c
index 86d3cab9bf93..29066ac5a2fa 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -32,14 +32,14 @@ static int blkdev_get_block(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static unsigned int dio_bio_write_op(struct kiocb *iocb)
+static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 {
-	unsigned int op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
+	blk_opf_t opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 
 	/* avoid the need for a I/O completion work item */
 	if (iocb->ki_flags & IOCB_DSYNC)
-		op |= REQ_FUA;
-	return op;
+		opf |= REQ_FUA;
+	return opf;
 }
 
 static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
@@ -175,7 +175,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
-	unsigned int opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
+	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
@@ -297,7 +297,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 {
 	struct block_device *bdev = iocb->ki_filp->private_data;
 	bool is_read = iov_iter_rw(iter) == READ;
-	unsigned int opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
+	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	loff_t pos = iocb->ki_pos;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 992ee987f273..ca22b06700a9 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -405,7 +405,7 @@ extern void bioset_exit(struct bio_set *);
 extern int biovec_init_pool(mempool_t *pool, int pool_entries);
 
 struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
-			     unsigned int opf, gfp_t gfp_mask,
+			     blk_opf_t opf, gfp_t gfp_mask,
 			     struct bio_set *bs);
 struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask);
 extern void bio_put(struct bio *);
@@ -418,7 +418,7 @@ int bio_init_clone(struct block_device *bdev, struct bio *bio,
 extern struct bio_set fs_bio_set;
 
 static inline struct bio *bio_alloc(struct block_device *bdev,
-		unsigned short nr_vecs, unsigned int opf, gfp_t gfp_mask)
+		unsigned short nr_vecs, blk_opf_t opf, gfp_t gfp_mask)
 {
 	return bio_alloc_bioset(bdev, nr_vecs, opf, gfp_mask, &fs_bio_set);
 }
@@ -456,9 +456,9 @@ struct request_queue;
 
 extern int submit_bio_wait(struct bio *bio);
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
-	      unsigned short max_vecs, unsigned int opf);
+	      unsigned short max_vecs, blk_opf_t opf);
 extern void bio_uninit(struct bio *);
-void bio_reset(struct bio *bio, struct block_device *bdev, unsigned int opf);
+void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
 void bio_chain(struct bio *, struct bio *);
 
 int bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
@@ -789,6 +789,6 @@ static inline void bio_clear_polled(struct bio *bio)
 }
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
-		unsigned int nr_pages, unsigned int opf, gfp_t gfp);
+		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp);
 
 #endif /* __LINUX_BIO_H */
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 677195de0663..effee1dc715a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -80,7 +80,7 @@ struct request {
 	struct blk_mq_ctx *mq_ctx;
 	struct blk_mq_hw_ctx *mq_hctx;
 
-	unsigned int cmd_flags;		/* op and common flags */
+	blk_opf_t cmd_flags;		/* op and common flags */
 	req_flags_t rq_flags;
 
 	int tag;
@@ -715,10 +715,10 @@ enum {
 	BLK_MQ_REQ_PM		= (__force blk_mq_req_flags_t)(1 << 2),
 };
 
-struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
+struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
 		blk_mq_req_flags_t flags);
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
-		unsigned int op, blk_mq_req_flags_t flags,
+		blk_opf_t opf, blk_mq_req_flags_t flags,
 		unsigned int hctx_idx);
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ca2ff113ea00..d04bdf549efa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -250,7 +250,7 @@ static inline int blk_validate_block_size(unsigned long bsize)
 	return 0;
 }
 
-static inline bool blk_op_is_passthrough(unsigned int op)
+static inline bool blk_op_is_passthrough(blk_opf_t op)
 {
 	op &= REQ_OP_MASK;
 	return op == REQ_OP_DRV_IN || op == REQ_OP_DRV_OUT;
