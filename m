Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB234C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiFWTAp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiFWTAR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:17 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C619FB8F81
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:43 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 184so135816pga.12
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15ZE93zixLMD1noiBiQWX0qOw0r4Zq62PS4ZUPNXYhk=;
        b=PNriHCshPU6olkhkx4sIGQsNJPDucxZ4TW6xS0NKWLK1GtSzNO9kgNbP9mIRJvzGG/
         rmJQkvXLVXp/fIDYSzRMx/K9Ac5m2kD9Wm1u+BsU3khBB4KQCZ4bdQWxT/m/JlRNqnYv
         QsP6/uV+b90/c/qiGm0F2XKfSeNWma7zBH8tJALK9B3PXaWmRAmKAfWvFtqLiSIwqie1
         D4XcmdftxUsNeyGHLF+rKS+a+2BNq4hvncCEYmrnEKJhyhaL2rjUJvDY8OgkBq2LxbTr
         XFHq/f0/0ALMxFhyiYMWWI8iySEHO0mS96NcOdxOvFDKdt38Wige2wx17Lizaploc1oy
         zSrg==
X-Gm-Message-State: AJIora/vefhgawHFdZxs7sN3aAAtBMPe5kI4cUp80Dzuf+0G5hY91C9W
        h0s2RCe2RWBCQ8EwR69DGEc=
X-Google-Smtp-Source: AGRyM1sVP/1wslUjm6J+7ewCS1qbbRsLACNB567Xx1i2zp6IffCaV9PPzIQwp0n0+P/bN/MGbxP1Zg==
X-Received: by 2002:a05:6a00:190e:b0:4f7:8813:b2cb with SMTP id y14-20020a056a00190e00b004f78813b2cbmr41969520pfi.54.1656007543069;
        Thu, 23 Jun 2022 11:05:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 06/51] block: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:04:43 -0700
Message-Id: <20220623180528.3595304-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
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
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-cgroup.c        | 16 ++++++++--------
 block/bfq-iosched.c       |  8 ++++----
 block/bfq-iosched.h       |  8 ++++----
 block/bio.c               | 10 +++++-----
 block/blk-cgroup-rwstat.h |  2 +-
 block/blk-core.c          |  2 +-
 block/blk-flush.c         |  6 +++---
 block/blk-merge.c         |  6 +++---
 block/blk-mq-debugfs.c    |  4 ++--
 block/blk-mq.c            | 11 ++++++-----
 block/blk-mq.h            |  6 +++---
 block/blk-wbt.c           | 16 ++++++++--------
 block/elevator.h          |  2 +-
 block/fops.c              |  8 ++++----
 block/kyber-iosched.c     |  6 +++---
 block/mq-deadline.c       |  2 +-
 include/linux/bio.h       | 10 +++++-----
 include/linux/blk-mq.h    |  4 ++--
 include/linux/blkdev.h    |  5 +++--
 19 files changed, 67 insertions(+), 65 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fc605791b1e..af79028627a5 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -220,7 +220,7 @@ void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg)
 }
 
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
-			      unsigned int op)
+			      blk_opf_t op)
 {
 	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
 	bfqg_stats_end_empty_time(&bfqg->stats);
@@ -228,18 +228,18 @@ void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
 		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
 }
 
-void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op)
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t op)
 {
 	blkg_rwstat_add(&bfqg->stats.queued, op, -1);
 }
 
-void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op)
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t op)
 {
 	blkg_rwstat_add(&bfqg->stats.merged, op, 1);
 }
 
 void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
-				  u64 io_start_time_ns, unsigned int op)
+				  u64 io_start_time_ns, blk_opf_t op)
 {
 	struct bfqg_stats *stats = &bfqg->stats;
 	u64 now = ktime_get_ns();
@@ -255,11 +255,11 @@ void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
 #else /* CONFIG_BFQ_CGROUP_DEBUG */
 
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
-			      unsigned int op) { }
-void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op) { }
-void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op) { }
+			      blk_opf_t op) { }
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t op) { }
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t op) { }
 void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
-				  u64 io_start_time_ns, unsigned int op) { }
+				  u64 io_start_time_ns, blk_opf_t op) { }
 void bfqg_stats_update_dequeue(struct bfq_group *bfqg) { }
 void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg) { }
 void bfqg_stats_update_idle_time(struct bfq_group *bfqg) { }
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e6d7e6b01a05..a724fc882158 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -668,7 +668,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
  * significantly affect service guarantees coming from the BFQ scheduling
  * algorithm.
  */
-static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+static void bfq_limit_depth(blk_opf_t op, struct blk_mq_alloc_data *data)
 {
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
 	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
@@ -6104,7 +6104,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 static void bfq_update_insert_stats(struct request_queue *q,
 				    struct bfq_queue *bfqq,
 				    bool idle_timer_disabled,
-				    unsigned int cmd_flags)
+				    blk_opf_t cmd_flags)
 {
 	if (!bfqq)
 		return;
@@ -6129,7 +6129,7 @@ static void bfq_update_insert_stats(struct request_queue *q,
 static inline void bfq_update_insert_stats(struct request_queue *q,
 					   struct bfq_queue *bfqq,
 					   bool idle_timer_disabled,
-					   unsigned int cmd_flags) {}
+					   blk_opf_t cmd_flags) {}
 #endif /* CONFIG_BFQ_CGROUP_DEBUG */
 
 static struct bfq_queue *bfq_init_rq(struct request *rq);
@@ -6141,7 +6141,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct bfq_queue *bfqq;
 	bool idle_timer_disabled = false;
-	unsigned int cmd_flags;
+	blk_opf_t cmd_flags;
 	LIST_HEAD(free);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index ca8177d7bf7c..6bde1f4ecc50 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -994,11 +994,11 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
 
 void bfqg_stats_update_legacy_io(struct request_queue *q, struct request *rq);
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
-			      unsigned int op);
-void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op);
-void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op);
+			      blk_opf_t op);
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t op);
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t op);
 void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
-				  u64 io_start_time_ns, unsigned int op);
+				  u64 io_start_time_ns, blk_opf_t op);
 void bfqg_stats_update_dequeue(struct bfq_group *bfqg);
 void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
 void bfqg_stats_update_idle_time(struct bfq_group *bfqg);
diff --git a/block/bio.c b/block/bio.c
index 933ea3210954..8978f7d3ae48 100644
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
index 9f2723b34b75..6c0237148c0d 100644
--- a/block/blk-cgroup-rwstat.h
+++ b/block/blk-cgroup-rwstat.h
@@ -59,7 +59,7 @@ void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
  * caller is responsible for synchronizing calls to this function.
  */
 static inline void blkg_rwstat_add(struct blkg_rwstat *rwstat,
-				   unsigned int op, uint64_t val)
+				   blk_opf_t op, uint64_t val)
 {
 	struct percpu_counter *cnt;
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 9d420dff90f6..ef082aa7b8fb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1260,7 +1260,7 @@ EXPORT_SYMBOL_GPL(blk_io_schedule);
 
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
index 9d96c9239219..3a928ebb6b5e 100644
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
index df0b9a458f34..e30ef69dfa39 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -315,8 +315,8 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
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
index 50fc1194ebc0..24548dc536cc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -508,13 +508,13 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
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
@@ -655,7 +655,7 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
 {
 	printk(KERN_INFO "%s: dev %s: flags=%llx\n", msg,
 		rq->q->disk ? rq->q->disk->disk_name : "?",
-		(unsigned long long) rq->cmd_flags);
+		(__force unsigned long long) rq->cmd_flags);
 
 	printk(KERN_INFO "  sector %llu, nr/cnr %u/%u\n",
 	       (unsigned long long)blk_rq_pos(rq),
@@ -708,8 +708,9 @@ static void blk_print_req_error(struct request *req, blk_status_t status)
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
index e4c6fe2c8ac8..51fc5d6606e4 100644
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
@@ -151,7 +151,7 @@ struct blk_mq_alloc_data {
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
index 86d3cab9bf93..dd22e8c9b76f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -32,9 +32,9 @@ static int blkdev_get_block(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static unsigned int dio_bio_write_op(struct kiocb *iocb)
+static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 {
-	unsigned int op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
+	blk_opf_t op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 
 	/* avoid the need for a I/O completion work item */
 	if (iocb->ki_flags & IOCB_DSYNC)
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
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 8f7c745b4a57..102b6a311b5c 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -195,9 +195,9 @@ struct kyber_hctx_data {
 static int kyber_domain_wake(wait_queue_entry_t *wait, unsigned mode, int flags,
 			     void *key);
 
-static unsigned int kyber_sched_domain(unsigned int op)
+static unsigned int kyber_sched_domain(blk_opf_t opf)
 {
-	switch (op & REQ_OP_MASK) {
+	switch (opf & REQ_OP_MASK) {
 	case REQ_OP_READ:
 		return KYBER_READ;
 	case REQ_OP_WRITE:
@@ -553,7 +553,7 @@ static void rq_clear_domain_token(struct kyber_queue_data *kqd,
 	}
 }
 
-static void kyber_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+static void kyber_limit_depth(blk_opf_t op, struct blk_mq_alloc_data *data)
 {
 	/*
 	 * We use the scheduler tags as per-hardware queue queueing tokens.
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1a9e835e816c..c5589e9155e6 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -543,7 +543,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
  * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
  * function is used by __blk_mq_get_tag().
  */
-static void dd_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+static void dd_limit_depth(blk_opf_t op, struct blk_mq_alloc_data *data)
 {
 	struct deadline_data *dd = data->q->elevator->elevator_data;
 
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
index 9a1838bbed02..fbaacd4607a0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -79,7 +79,7 @@ struct request {
 	struct blk_mq_ctx *mq_ctx;
 	struct blk_mq_hw_ctx *mq_hctx;
 
-	unsigned int cmd_flags;		/* op and common flags */
+	blk_opf_t cmd_flags;		/* op and common flags */
 	req_flags_t rq_flags;
 
 	int tag;
@@ -712,7 +712,7 @@ enum {
 	BLK_MQ_REQ_PM		= (__force blk_mq_req_flags_t)(1 << 2),
 };
 
-struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
+struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
 		blk_mq_req_flags_t flags);
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		enum req_op op, blk_mq_req_flags_t flags,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index de47b0e0e18f..9751f164d2f0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -220,9 +220,10 @@ static inline int blk_validate_block_size(unsigned long bsize)
 	return 0;
 }
 
-static inline bool blk_op_is_passthrough(unsigned int op)
+static inline bool blk_op_is_passthrough(blk_opf_t opf)
 {
-	op &= REQ_OP_MASK;
+	enum req_op op = opf & REQ_OP_MASK;
+
 	return op == REQ_OP_DRV_IN || op == REQ_OP_DRV_OUT;
 }
 
