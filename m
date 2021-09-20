Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CBDC433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1E960F43
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbhITMrD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238614AbhITMrD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:47:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A5EC061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=d14s6pMAcjNQoIlHJmgQFFtOHY0FBbxg1EGxQmHcR7s=; b=WDFJ7YUI8RrLJLv/plOSUHFUk1
        zw3SDPr7MCQVWR8dVha7PU3BzvNZkwprtrMX8OsqaANLBMCyIAb7ENKwVmIEgRDwCEe8EpzMXtRmo
        SwwLSLRxLrmjDVCuAzYmAN1cFM+2qEu2xOlDLcI5KY0mAFCKU/4aAW/qlpWLaXNZuQXRwxsX5omGI
        T/KUd1RB4h3cFyTZZFTJf8i+GSTzAhBHeIfEDd0MS8xU8vAxs0mWMLa60WivuRVAmW9TwJRPM8wtI
        60H9TnrG+CWJuNPP/DffAaP2Q0xVm30YwOOgPPLtJCZde3IAcRj6CCGAk/QWpASbbz1I1VYMgXFRU
        swHxWYWg==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIf0-002fak-VR; Mon, 20 Sep 2021 12:44:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 17/17] block: move struct request to blk-mq.h
Date:   Mon, 20 Sep 2021 14:33:28 +0200
Message-Id: <20210920123328.1399408-18-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

struct request is only used by blk-mq drivers, so move it and all
related declarations to blk-mq.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-crypto-fallback.c         |   1 +
 block/blk-crypto-internal.h         |   2 +-
 drivers/block/rnbd/rnbd-proto.h     |   2 +-
 drivers/md/dm-verity-target.c       |   1 +
 drivers/mmc/core/sd.c               |   1 +
 drivers/target/target_core_file.c   |   1 +
 drivers/target/target_core_iblock.c |   1 +
 include/linux/blk-mq.h              | 465 +++++++++++++++++++++++++++
 include/linux/blk_types.h           |   2 -
 include/linux/blkdev.h              | 469 +---------------------------
 include/linux/blktrace_api.h        |   2 +-
 include/linux/t10-pi.h              |   2 +-
 include/scsi/scsi_device.h          |   2 +-
 13 files changed, 476 insertions(+), 475 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index c322176a1e099..ec4c7823541c8 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -18,6 +18,7 @@
 #include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/random.h>
+#include <linux/scatterlist.h>
 
 #include "blk-crypto-internal.h"
 
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 0d36aae538d7b..2fb0d65a464ca 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -7,7 +7,7 @@
 #define __LINUX_BLK_CRYPTO_INTERNAL_H
 
 #include <linux/bio.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 
 /* Represents a crypto mode supported by blk-crypto  */
 struct blk_crypto_mode {
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index c1bc5c0fef71d..de5d5a8df81d7 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -10,7 +10,7 @@
 #define RNBD_PROTO_H
 
 #include <linux/types.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/limits.h>
 #include <linux/inet.h>
 #include <linux/in.h>
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 22a5ac82446a6..88e2702b473b0 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -18,6 +18,7 @@
 #include "dm-verity-verify-sig.h"
 #include <linux/module.h>
 #include <linux/reboot.h>
+#include <linux/scatterlist.h>
 
 #define DM_MSG_PREFIX			"verity"
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 4646b7a03db6b..c9db24e16af13 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index ef4a8e189fba0..02f64453b4c5f 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -20,6 +20,7 @@
 #include <linux/vmalloc.h>
 #include <linux/falloc.h>
 #include <linux/uio.h>
+#include <linux/scatterlist.h>
 #include <scsi/scsi_proto.h>
 #include <asm/unaligned.h>
 
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index d39b87e2ed100..31df20abe141f 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -23,6 +23,7 @@
 #include <linux/genhd.h>
 #include <linux/file.h>
 #include <linux/module.h>
+#include <linux/scatterlist.h>
 #include <scsi/scsi_proto.h>
 #include <asm/unaligned.h>
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 13ba1861e688f..bd4086a6f28e0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -6,10 +6,218 @@
 #include <linux/sbitmap.h>
 #include <linux/srcu.h>
 #include <linux/lockdep.h>
+#include <linux/scatterlist.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
 
+#define BLKDEV_MIN_RQ	4
+#define BLKDEV_MAX_RQ	128	/* Default maximum */
+
+typedef void (rq_end_io_fn)(struct request *, blk_status_t);
+
+/*
+ * request flags */
+typedef __u32 __bitwise req_flags_t;
+
+/* drive already may have started this one */
+#define RQF_STARTED		((__force req_flags_t)(1 << 1))
+/* may not be passed by ioscheduler */
+#define RQF_SOFTBARRIER		((__force req_flags_t)(1 << 3))
+/* request for flush sequence */
+#define RQF_FLUSH_SEQ		((__force req_flags_t)(1 << 4))
+/* merge of different types, fail separately */
+#define RQF_MIXED_MERGE		((__force req_flags_t)(1 << 5))
+/* track inflight for MQ */
+#define RQF_MQ_INFLIGHT		((__force req_flags_t)(1 << 6))
+/* don't call prep for this one */
+#define RQF_DONTPREP		((__force req_flags_t)(1 << 7))
+/* vaguely specified driver internal error.  Ignored by the block layer */
+#define RQF_FAILED		((__force req_flags_t)(1 << 10))
+/* don't warn about errors */
+#define RQF_QUIET		((__force req_flags_t)(1 << 11))
+/* elevator private data attached */
+#define RQF_ELVPRIV		((__force req_flags_t)(1 << 12))
+/* account into disk and partition IO statistics */
+#define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
+/* runtime pm request */
+#define RQF_PM			((__force req_flags_t)(1 << 15))
+/* on IO scheduler merge hash */
+#define RQF_HASHED		((__force req_flags_t)(1 << 16))
+/* track IO completion time */
+#define RQF_STATS		((__force req_flags_t)(1 << 17))
+/* Look at ->special_vec for the actual data payload instead of the
+   bio chain. */
+#define RQF_SPECIAL_PAYLOAD	((__force req_flags_t)(1 << 18))
+/* The per-zone write lock is held for this request */
+#define RQF_ZONE_WRITE_LOCKED	((__force req_flags_t)(1 << 19))
+/* already slept for hybrid poll */
+#define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 20))
+/* ->timeout has been called, don't expire again */
+#define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
+
+/* flags that prevent us from merging requests: */
+#define RQF_NOMERGE_FLAGS \
+	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
+
+enum mq_rq_state {
+	MQ_RQ_IDLE		= 0,
+	MQ_RQ_IN_FLIGHT		= 1,
+	MQ_RQ_COMPLETE		= 2,
+};
+
+/*
+ * Try to put the fields that are referenced together in the same cacheline.
+ *
+ * If you modify this structure, make sure to update blk_rq_init() and
+ * especially blk_mq_rq_ctx_init() to take care of the added fields.
+ */
+struct request {
+	struct request_queue *q;
+	struct blk_mq_ctx *mq_ctx;
+	struct blk_mq_hw_ctx *mq_hctx;
+
+	unsigned int cmd_flags;		/* op and common flags */
+	req_flags_t rq_flags;
+
+	int tag;
+	int internal_tag;
+
+	/* the following two fields are internal, NEVER access directly */
+	unsigned int __data_len;	/* total data len */
+	sector_t __sector;		/* sector cursor */
+
+	struct bio *bio;
+	struct bio *biotail;
+
+	struct list_head queuelist;
+
+	/*
+	 * The hash is used inside the scheduler, and killed once the
+	 * request reaches the dispatch list. The ipi_list is only used
+	 * to queue the request for softirq completion, which is long
+	 * after the request has been unhashed (and even removed from
+	 * the dispatch list).
+	 */
+	union {
+		struct hlist_node hash;	/* merge hash */
+		struct llist_node ipi_list;
+	};
+
+	/*
+	 * The rb_node is only used inside the io scheduler, requests
+	 * are pruned when moved to the dispatch queue. So let the
+	 * completion_data share space with the rb_node.
+	 */
+	union {
+		struct rb_node rb_node;	/* sort/lookup */
+		struct bio_vec special_vec;
+		void *completion_data;
+		int error_count; /* for legacy drivers, don't use */
+	};
+
+	/*
+	 * Three pointers are available for the IO schedulers, if they need
+	 * more they have to dynamically allocate it.  Flush requests are
+	 * never put on the IO scheduler. So let the flush fields share
+	 * space with the elevator data.
+	 */
+	union {
+		struct {
+			struct io_cq		*icq;
+			void			*priv[2];
+		} elv;
+
+		struct {
+			unsigned int		seq;
+			struct list_head	list;
+			rq_end_io_fn		*saved_end_io;
+		} flush;
+	};
+
+	struct gendisk *rq_disk;
+	struct block_device *part;
+#ifdef CONFIG_BLK_RQ_ALLOC_TIME
+	/* Time that the first bio started allocating this request. */
+	u64 alloc_time_ns;
+#endif
+	/* Time that this request was allocated for this IO. */
+	u64 start_time_ns;
+	/* Time that I/O was submitted to the device. */
+	u64 io_start_time_ns;
+
+#ifdef CONFIG_BLK_WBT
+	unsigned short wbt_flags;
+#endif
+	/*
+	 * rq sectors used for blk stats. It has the same value
+	 * with blk_rq_sectors(rq), except that it never be zeroed
+	 * by completion.
+	 */
+	unsigned short stats_sectors;
+
+	/*
+	 * Number of scatter-gather DMA addr+len pairs after
+	 * physical address coalescing is performed.
+	 */
+	unsigned short nr_phys_segments;
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	unsigned short nr_integrity_segments;
+#endif
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	struct bio_crypt_ctx *crypt_ctx;
+	struct blk_ksm_keyslot *crypt_keyslot;
+#endif
+
+	unsigned short write_hint;
+	unsigned short ioprio;
+
+	enum mq_rq_state state;
+	refcount_t ref;
+
+	unsigned int timeout;
+	unsigned long deadline;
+
+	union {
+		struct __call_single_data csd;
+		u64 fifo_time;
+	};
+
+	/*
+	 * completion callback.
+	 */
+	rq_end_io_fn *end_io;
+	void *end_io_data;
+};
+
+#define req_op(req) \
+	((req)->cmd_flags & REQ_OP_MASK)
+
+static inline bool blk_rq_is_passthrough(struct request *rq)
+{
+	return blk_op_is_passthrough(req_op(rq));
+}
+
+static inline unsigned short req_get_ioprio(struct request *req)
+{
+	return req->ioprio;
+}
+
+#define rq_data_dir(rq)		(op_is_write(req_op(rq)) ? WRITE : READ)
+
+#define rq_dma_dir(rq) \
+	(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
+
+enum blk_eh_timer_return {
+	BLK_EH_DONE,		/* drivers has completed the command */
+	BLK_EH_RESET_TIMER,	/* reset timer and try again */
+};
+
+#define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */
+#define BLK_TAG_ALLOC_RR 1 /* allocate starting from last allocated tag */
+
 /**
  * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware
  * block device
@@ -637,4 +845,261 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio);
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
 		struct lock_class_key *key);
 
+static inline bool rq_is_sync(struct request *rq)
+{
+	return op_is_sync(rq->cmd_flags);
+}
+
+void blk_rq_init(struct request_queue *q, struct request *rq);
+void blk_put_request(struct request *rq);
+struct request *blk_get_request(struct request_queue *q, unsigned int op,
+		blk_mq_req_flags_t flags);
+int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
+		struct bio_set *bs, gfp_t gfp_mask,
+		int (*bio_ctr)(struct bio *, struct bio *, void *), void *data);
+void blk_rq_unprep_clone(struct request *rq);
+blk_status_t blk_insert_cloned_request(struct request_queue *q,
+		struct request *rq);
+
+struct rq_map_data {
+	struct page **pages;
+	int page_order;
+	int nr_entries;
+	unsigned long offset;
+	int null_mapped;
+	int from_user;
+};
+
+int blk_rq_map_user(struct request_queue *, struct request *,
+		struct rq_map_data *, void __user *, unsigned long, gfp_t);
+int blk_rq_map_user_iov(struct request_queue *, struct request *,
+		struct rq_map_data *, const struct iov_iter *, gfp_t);
+int blk_rq_unmap_user(struct bio *);
+int blk_rq_map_kern(struct request_queue *, struct request *, void *,
+		unsigned int, gfp_t);
+int blk_rq_append_bio(struct request *rq, struct bio *bio);
+void blk_execute_rq_nowait(struct gendisk *, struct request *, int,
+		rq_end_io_fn *);
+blk_status_t blk_execute_rq(struct gendisk *bd_disk, struct request *rq,
+		int at_head);
+
+struct req_iterator {
+	struct bvec_iter iter;
+	struct bio *bio;
+};
+
+#define __rq_for_each_bio(_bio, rq)	\
+	if ((rq->bio))			\
+		for (_bio = (rq)->bio; _bio; _bio = _bio->bi_next)
+
+#define rq_for_each_segment(bvl, _rq, _iter)			\
+	__rq_for_each_bio(_iter.bio, _rq)			\
+		bio_for_each_segment(bvl, _iter.bio, _iter.iter)
+
+#define rq_for_each_bvec(bvl, _rq, _iter)			\
+	__rq_for_each_bio(_iter.bio, _rq)			\
+		bio_for_each_bvec(bvl, _iter.bio, _iter.iter)
+
+#define rq_iter_last(bvec, _iter)				\
+		(_iter.bio->bi_next == NULL &&			\
+		 bio_iter_last(bvec, _iter.iter))
+
+/*
+ * blk_rq_pos()			: the current sector
+ * blk_rq_bytes()		: bytes left in the entire request
+ * blk_rq_cur_bytes()		: bytes left in the current segment
+ * blk_rq_err_bytes()		: bytes left till the next error boundary
+ * blk_rq_sectors()		: sectors left in the entire request
+ * blk_rq_cur_sectors()		: sectors left in the current segment
+ * blk_rq_stats_sectors()	: sectors of the entire request used for stats
+ */
+static inline sector_t blk_rq_pos(const struct request *rq)
+{
+	return rq->__sector;
+}
+
+static inline unsigned int blk_rq_bytes(const struct request *rq)
+{
+	return rq->__data_len;
+}
+
+static inline int blk_rq_cur_bytes(const struct request *rq)
+{
+	return rq->bio ? bio_cur_bytes(rq->bio) : 0;
+}
+
+unsigned int blk_rq_err_bytes(const struct request *rq);
+
+static inline unsigned int blk_rq_sectors(const struct request *rq)
+{
+	return blk_rq_bytes(rq) >> SECTOR_SHIFT;
+}
+
+static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
+{
+	return blk_rq_cur_bytes(rq) >> SECTOR_SHIFT;
+}
+
+static inline unsigned int blk_rq_stats_sectors(const struct request *rq)
+{
+	return rq->stats_sectors;
+}
+
+/*
+ * Some commands like WRITE SAME have a payload or data transfer size which
+ * is different from the size of the request.  Any driver that supports such
+ * commands using the RQF_SPECIAL_PAYLOAD flag needs to use this helper to
+ * calculate the data transfer size.
+ */
+static inline unsigned int blk_rq_payload_bytes(struct request *rq)
+{
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
+		return rq->special_vec.bv_len;
+	return blk_rq_bytes(rq);
+}
+
+/*
+ * Return the first full biovec in the request.  The caller needs to check that
+ * there are any bvecs before calling this helper.
+ */
+static inline struct bio_vec req_bvec(struct request *rq)
+{
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
+		return rq->special_vec;
+	return mp_bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter);
+}
+
+static inline unsigned int blk_rq_count_bios(struct request *rq)
+{
+	unsigned int nr_bios = 0;
+	struct bio *bio;
+
+	__rq_for_each_bio(bio, rq)
+		nr_bios++;
+
+	return nr_bios;
+}
+
+void blk_steal_bios(struct bio_list *list, struct request *rq);
+
+/*
+ * Request completion related functions.
+ *
+ * blk_update_request() completes given number of bytes and updates
+ * the request without completing it.
+ */
+bool blk_update_request(struct request *rq, blk_status_t error,
+			       unsigned int nr_bytes);
+void blk_abort_request(struct request *);
+
+/*
+ * Number of physical segments as sent to the device.
+ *
+ * Normally this is the number of discontiguous data segments sent by the
+ * submitter.  But for data-less command like discard we might have no
+ * actual data segments submitted, but the driver might have to add it's
+ * own special payload.  In that case we still return 1 here so that this
+ * special payload will be mapped.
+ */
+static inline unsigned short blk_rq_nr_phys_segments(struct request *rq)
+{
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
+		return 1;
+	return rq->nr_phys_segments;
+}
+
+/*
+ * Number of discard segments (or ranges) the driver needs to fill in.
+ * Each discard bio merged into a request is counted as one segment.
+ */
+static inline unsigned short blk_rq_nr_discard_segments(struct request *rq)
+{
+	return max_t(unsigned short, rq->nr_phys_segments, 1);
+}
+
+int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
+		struct scatterlist *sglist, struct scatterlist **last_sg);
+static inline int blk_rq_map_sg(struct request_queue *q, struct request *rq,
+		struct scatterlist *sglist)
+{
+	struct scatterlist *last_sg = NULL;
+
+	return __blk_rq_map_sg(q, rq, sglist, &last_sg);
+}
+void blk_dump_rq_flags(struct request *, char *);
+
+#ifdef CONFIG_BLK_DEV_ZONED
+static inline unsigned int blk_rq_zone_no(struct request *rq)
+{
+	return blk_queue_zone_no(rq->q, blk_rq_pos(rq));
+}
+
+static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
+{
+	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
+}
+
+bool blk_req_needs_zone_write_lock(struct request *rq);
+bool blk_req_zone_write_trylock(struct request *rq);
+void __blk_req_zone_write_lock(struct request *rq);
+void __blk_req_zone_write_unlock(struct request *rq);
+
+static inline void blk_req_zone_write_lock(struct request *rq)
+{
+	if (blk_req_needs_zone_write_lock(rq))
+		__blk_req_zone_write_lock(rq);
+}
+
+static inline void blk_req_zone_write_unlock(struct request *rq)
+{
+	if (rq->rq_flags & RQF_ZONE_WRITE_LOCKED)
+		__blk_req_zone_write_unlock(rq);
+}
+
+static inline bool blk_req_zone_is_write_locked(struct request *rq)
+{
+	return rq->q->seq_zones_wlock &&
+		test_bit(blk_rq_zone_no(rq), rq->q->seq_zones_wlock);
+}
+
+static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
+{
+	if (!blk_req_needs_zone_write_lock(rq))
+		return true;
+	return !blk_req_zone_is_write_locked(rq);
+}
+#else /* CONFIG_BLK_DEV_ZONED */
+static inline bool blk_req_needs_zone_write_lock(struct request *rq)
+{
+	return false;
+}
+
+static inline void blk_req_zone_write_lock(struct request *rq)
+{
+}
+
+static inline void blk_req_zone_write_unlock(struct request *rq)
+{
+}
+static inline bool blk_req_zone_is_write_locked(struct request *rq)
+{
+	return false;
+}
+
+static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
+{
+	return true;
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
+#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
+# error	"You should define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE for your platform"
 #endif
+#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
+void rq_flush_dcache_pages(struct request *rq);
+#else
+static inline void rq_flush_dcache_pages(struct request *rq)
+{
+}
+#endif /* ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE */
+#endif /* BLK_MQ_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index be622b5a21ed5..3b967053e9f5a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -431,8 +431,6 @@ enum stat_group {
 
 #define bio_op(bio) \
 	((bio)->bi_opf & REQ_OP_MASK)
-#define req_op(req) \
-	((req)->cmd_flags & REQ_OP_MASK)
 
 /* obsolete, don't use in new code */
 static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 56e60e5c09d07..0e960d74615ec 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -14,7 +14,6 @@
 #include <linux/gfp.h>
 #include <linux/rcupdate.h>
 #include <linux/percpu-refcount.h>
-#include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
 #include <linux/sbitmap.h>
 
@@ -32,9 +31,6 @@ struct blk_queue_stats;
 struct blk_stat_callback;
 struct blk_keyslot_manager;
 
-#define BLKDEV_MIN_RQ	4
-#define BLKDEV_MAX_RQ	128	/* Default maximum */
-
 /* Must be consistent with blk_mq_poll_stats_bkt() */
 #define BLK_MQ_POLL_STATS_BKTS 16
 
@@ -47,213 +43,12 @@ struct blk_keyslot_manager;
  */
 #define BLKCG_MAX_POLS		6
 
-typedef void (rq_end_io_fn)(struct request *, blk_status_t);
-
-/*
- * request flags */
-typedef __u32 __bitwise req_flags_t;
-
-/* drive already may have started this one */
-#define RQF_STARTED		((__force req_flags_t)(1 << 1))
-/* may not be passed by ioscheduler */
-#define RQF_SOFTBARRIER		((__force req_flags_t)(1 << 3))
-/* request for flush sequence */
-#define RQF_FLUSH_SEQ		((__force req_flags_t)(1 << 4))
-/* merge of different types, fail separately */
-#define RQF_MIXED_MERGE		((__force req_flags_t)(1 << 5))
-/* track inflight for MQ */
-#define RQF_MQ_INFLIGHT		((__force req_flags_t)(1 << 6))
-/* don't call prep for this one */
-#define RQF_DONTPREP		((__force req_flags_t)(1 << 7))
-/* vaguely specified driver internal error.  Ignored by the block layer */
-#define RQF_FAILED		((__force req_flags_t)(1 << 10))
-/* don't warn about errors */
-#define RQF_QUIET		((__force req_flags_t)(1 << 11))
-/* elevator private data attached */
-#define RQF_ELVPRIV		((__force req_flags_t)(1 << 12))
-/* account into disk and partition IO statistics */
-#define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
-/* runtime pm request */
-#define RQF_PM			((__force req_flags_t)(1 << 15))
-/* on IO scheduler merge hash */
-#define RQF_HASHED		((__force req_flags_t)(1 << 16))
-/* track IO completion time */
-#define RQF_STATS		((__force req_flags_t)(1 << 17))
-/* Look at ->special_vec for the actual data payload instead of the
-   bio chain. */
-#define RQF_SPECIAL_PAYLOAD	((__force req_flags_t)(1 << 18))
-/* The per-zone write lock is held for this request */
-#define RQF_ZONE_WRITE_LOCKED	((__force req_flags_t)(1 << 19))
-/* already slept for hybrid poll */
-#define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 20))
-/* ->timeout has been called, don't expire again */
-#define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
-
-/* flags that prevent us from merging requests: */
-#define RQF_NOMERGE_FLAGS \
-	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
-
-/*
- * Request state for blk-mq.
- */
-enum mq_rq_state {
-	MQ_RQ_IDLE		= 0,
-	MQ_RQ_IN_FLIGHT		= 1,
-	MQ_RQ_COMPLETE		= 2,
-};
-
-/*
- * Try to put the fields that are referenced together in the same cacheline.
- *
- * If you modify this structure, make sure to update blk_rq_init() and
- * especially blk_mq_rq_ctx_init() to take care of the added fields.
- */
-struct request {
-	struct request_queue *q;
-	struct blk_mq_ctx *mq_ctx;
-	struct blk_mq_hw_ctx *mq_hctx;
-
-	unsigned int cmd_flags;		/* op and common flags */
-	req_flags_t rq_flags;
-
-	int tag;
-	int internal_tag;
-
-	/* the following two fields are internal, NEVER access directly */
-	unsigned int __data_len;	/* total data len */
-	sector_t __sector;		/* sector cursor */
-
-	struct bio *bio;
-	struct bio *biotail;
-
-	struct list_head queuelist;
-
-	/*
-	 * The hash is used inside the scheduler, and killed once the
-	 * request reaches the dispatch list. The ipi_list is only used
-	 * to queue the request for softirq completion, which is long
-	 * after the request has been unhashed (and even removed from
-	 * the dispatch list).
-	 */
-	union {
-		struct hlist_node hash;	/* merge hash */
-		struct llist_node ipi_list;
-	};
-
-	/*
-	 * The rb_node is only used inside the io scheduler, requests
-	 * are pruned when moved to the dispatch queue. So let the
-	 * completion_data share space with the rb_node.
-	 */
-	union {
-		struct rb_node rb_node;	/* sort/lookup */
-		struct bio_vec special_vec;
-		void *completion_data;
-		int error_count; /* for legacy drivers, don't use */
-	};
-
-	/*
-	 * Three pointers are available for the IO schedulers, if they need
-	 * more they have to dynamically allocate it.  Flush requests are
-	 * never put on the IO scheduler. So let the flush fields share
-	 * space with the elevator data.
-	 */
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
-
-	struct gendisk *rq_disk;
-	struct block_device *part;
-#ifdef CONFIG_BLK_RQ_ALLOC_TIME
-	/* Time that the first bio started allocating this request. */
-	u64 alloc_time_ns;
-#endif
-	/* Time that this request was allocated for this IO. */
-	u64 start_time_ns;
-	/* Time that I/O was submitted to the device. */
-	u64 io_start_time_ns;
-
-#ifdef CONFIG_BLK_WBT
-	unsigned short wbt_flags;
-#endif
-	/*
-	 * rq sectors used for blk stats. It has the same value
-	 * with blk_rq_sectors(rq), except that it never be zeroed
-	 * by completion.
-	 */
-	unsigned short stats_sectors;
-
-	/*
-	 * Number of scatter-gather DMA addr+len pairs after
-	 * physical address coalescing is performed.
-	 */
-	unsigned short nr_phys_segments;
-
-#if defined(CONFIG_BLK_DEV_INTEGRITY)
-	unsigned short nr_integrity_segments;
-#endif
-
-#ifdef CONFIG_BLK_INLINE_ENCRYPTION
-	struct bio_crypt_ctx *crypt_ctx;
-	struct blk_ksm_keyslot *crypt_keyslot;
-#endif
-
-	unsigned short write_hint;
-	unsigned short ioprio;
-
-	enum mq_rq_state state;
-	refcount_t ref;
-
-	unsigned int timeout;
-	unsigned long deadline;
-
-	union {
-		struct __call_single_data csd;
-		u64 fifo_time;
-	};
-
-	/*
-	 * completion callback.
-	 */
-	rq_end_io_fn *end_io;
-	void *end_io_data;
-};
-
 static inline bool blk_op_is_passthrough(unsigned int op)
 {
 	op &= REQ_OP_MASK;
 	return op == REQ_OP_DRV_IN || op == REQ_OP_DRV_OUT;
 }
 
-static inline bool blk_rq_is_passthrough(struct request *rq)
-{
-	return blk_op_is_passthrough(req_op(rq));
-}
-
-static inline unsigned short req_get_ioprio(struct request *req)
-{
-	return req->ioprio;
-}
-
-struct bio_vec;
-
-enum blk_eh_timer_return {
-	BLK_EH_DONE,		/* drivers has completed the command */
-	BLK_EH_RESET_TIMER,	/* reset timer and try again */
-};
-
-#define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */
-#define BLK_TAG_ALLOC_RR 1 /* allocate starting from last allocated tag */
-
 /*
  * Zoned block device models (zoned limit).
  *
@@ -620,11 +415,6 @@ extern void blk_clear_pm_only(struct request_queue *q);
 
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
-#define rq_data_dir(rq)		(op_is_write(req_op(rq)) ? WRITE : READ)
-
-#define rq_dma_dir(rq) \
-	(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
-
 #define dma_map_bvec(dev, bv, dir, attrs) \
 	dma_map_page_attrs(dev, (bv)->bv_page, (bv)->bv_offset, (bv)->bv_len, \
 	(dir), (attrs))
@@ -740,11 +530,6 @@ static inline unsigned int queue_max_active_zones(const struct request_queue *q)
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
-static inline bool rq_is_sync(struct request *rq)
-{
-	return op_is_sync(rq->cmd_flags);
-}
-
 static inline unsigned int blk_queue_depth(struct request_queue *q)
 {
 	if (q->queue_depth)
@@ -759,83 +544,20 @@ static inline unsigned int blk_queue_depth(struct request_queue *q)
 #define BLK_DEFAULT_SG_TIMEOUT	(60 * HZ)
 #define BLK_MIN_SG_TIMEOUT	(7 * HZ)
 
-struct rq_map_data {
-	struct page **pages;
-	int page_order;
-	int nr_entries;
-	unsigned long offset;
-	int null_mapped;
-	int from_user;
-};
-
-struct req_iterator {
-	struct bvec_iter iter;
-	struct bio *bio;
-};
-
 /* This should not be used directly - use rq_for_each_segment */
 #define for_each_bio(_bio)		\
 	for (; _bio; _bio = _bio->bi_next)
-#define __rq_for_each_bio(_bio, rq)	\
-	if ((rq->bio))			\
-		for (_bio = (rq)->bio; _bio; _bio = _bio->bi_next)
-
-#define rq_for_each_segment(bvl, _rq, _iter)			\
-	__rq_for_each_bio(_iter.bio, _rq)			\
-		bio_for_each_segment(bvl, _iter.bio, _iter.iter)
 
-#define rq_for_each_bvec(bvl, _rq, _iter)			\
-	__rq_for_each_bio(_iter.bio, _rq)			\
-		bio_for_each_bvec(bvl, _iter.bio, _iter.iter)
-
-#define rq_iter_last(bvec, _iter)				\
-		(_iter.bio->bi_next == NULL &&			\
-		 bio_iter_last(bvec, _iter.iter))
-
-#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
-# error	"You should define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE for your platform"
-#endif
-#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
-extern void rq_flush_dcache_pages(struct request *rq);
-#else
-static inline void rq_flush_dcache_pages(struct request *rq)
-{
-}
-#endif
 
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 blk_qc_t submit_bio_noacct(struct bio *bio);
-extern void blk_rq_init(struct request_queue *q, struct request *rq);
-extern void blk_put_request(struct request *);
-extern struct request *blk_get_request(struct request_queue *, unsigned int op,
-				       blk_mq_req_flags_t flags);
+
 extern int blk_lld_busy(struct request_queue *q);
-extern int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
-			     struct bio_set *bs, gfp_t gfp_mask,
-			     int (*bio_ctr)(struct bio *, struct bio *, void *),
-			     void *data);
-extern void blk_rq_unprep_clone(struct request *rq);
-extern blk_status_t blk_insert_cloned_request(struct request_queue *q,
-				     struct request *rq);
-int blk_rq_append_bio(struct request *rq, struct bio *bio);
 extern void blk_queue_split(struct bio **);
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
 extern void blk_queue_exit(struct request_queue *q);
 extern void blk_sync_queue(struct request_queue *q);
-extern int blk_rq_map_user(struct request_queue *, struct request *,
-			   struct rq_map_data *, void __user *, unsigned long,
-			   gfp_t);
-extern int blk_rq_unmap_user(struct bio *);
-extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, unsigned int, gfp_t);
-extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
-			       struct rq_map_data *, const struct iov_iter *,
-			       gfp_t);
-extern void blk_execute_rq_nowait(struct gendisk *,
-				  struct request *, int, rq_end_io_fn *);
-
-blk_status_t blk_execute_rq(struct gendisk *bd_disk, struct request *rq,
-			    int at_head);
 
 /* Helper to convert REQ_OP_XXX to its string format XXX */
 extern const char *blk_op_str(unsigned int op);
@@ -867,47 +589,6 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 #define SECTOR_MASK		(PAGE_SECTORS - 1)
 
-/*
- * blk_rq_pos()			: the current sector
- * blk_rq_bytes()		: bytes left in the entire request
- * blk_rq_cur_bytes()		: bytes left in the current segment
- * blk_rq_err_bytes()		: bytes left till the next error boundary
- * blk_rq_sectors()		: sectors left in the entire request
- * blk_rq_cur_sectors()		: sectors left in the current segment
- * blk_rq_stats_sectors()	: sectors of the entire request used for stats
- */
-static inline sector_t blk_rq_pos(const struct request *rq)
-{
-	return rq->__sector;
-}
-
-static inline unsigned int blk_rq_bytes(const struct request *rq)
-{
-	return rq->__data_len;
-}
-
-static inline int blk_rq_cur_bytes(const struct request *rq)
-{
-	return rq->bio ? bio_cur_bytes(rq->bio) : 0;
-}
-
-extern unsigned int blk_rq_err_bytes(const struct request *rq);
-
-static inline unsigned int blk_rq_sectors(const struct request *rq)
-{
-	return blk_rq_bytes(rq) >> SECTOR_SHIFT;
-}
-
-static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
-{
-	return blk_rq_cur_bytes(rq) >> SECTOR_SHIFT;
-}
-
-static inline unsigned int blk_rq_stats_sectors(const struct request *rq)
-{
-	return rq->stats_sectors;
-}
-
 #ifdef CONFIG_BLK_DEV_ZONED
 
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
@@ -924,42 +605,8 @@ static inline unsigned int bio_zone_is_seq(struct bio *bio)
 	return blk_queue_zone_is_seq(bdev_get_queue(bio->bi_bdev),
 				     bio->bi_iter.bi_sector);
 }
-
-static inline unsigned int blk_rq_zone_no(struct request *rq)
-{
-	return blk_queue_zone_no(rq->q, blk_rq_pos(rq));
-}
-
-static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
-{
-	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
-}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
-/*
- * Some commands like WRITE SAME have a payload or data transfer size which
- * is different from the size of the request.  Any driver that supports such
- * commands using the RQF_SPECIAL_PAYLOAD flag needs to use this helper to
- * calculate the data transfer size.
- */
-static inline unsigned int blk_rq_payload_bytes(struct request *rq)
-{
-	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
-		return rq->special_vec.bv_len;
-	return blk_rq_bytes(rq);
-}
-
-/*
- * Return the first full biovec in the request.  The caller needs to check that
- * there are any bvecs before calling this helper.
- */
-static inline struct bio_vec req_bvec(struct request *rq)
-{
-	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
-		return rq->special_vec;
-	return mp_bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter);
-}
-
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 						     int op)
 {
@@ -999,30 +646,6 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
 	return min(q->limits.max_sectors, chunk_sectors);
 }
 
-static inline unsigned int blk_rq_count_bios(struct request *rq)
-{
-	unsigned int nr_bios = 0;
-	struct bio *bio;
-
-	__rq_for_each_bio(bio, rq)
-		nr_bios++;
-
-	return nr_bios;
-}
-
-void blk_steal_bios(struct bio_list *list, struct request *rq);
-
-/*
- * Request completion related functions.
- *
- * blk_update_request() completes given number of bytes and updates
- * the request without completing it.
- */
-extern bool blk_update_request(struct request *rq, blk_status_t error,
-			       unsigned int nr_bytes);
-
-extern void blk_abort_request(struct request *);
-
 /*
  * Access functions for manipulating queue properties
  */
@@ -1081,42 +704,6 @@ extern void blk_queue_required_elevator_features(struct request_queue *q,
 extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
 					      struct device *dev);
 
-/*
- * Number of physical segments as sent to the device.
- *
- * Normally this is the number of discontiguous data segments sent by the
- * submitter.  But for data-less command like discard we might have no
- * actual data segments submitted, but the driver might have to add it's
- * own special payload.  In that case we still return 1 here so that this
- * special payload will be mapped.
- */
-static inline unsigned short blk_rq_nr_phys_segments(struct request *rq)
-{
-	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
-		return 1;
-	return rq->nr_phys_segments;
-}
-
-/*
- * Number of discard segments (or ranges) the driver needs to fill in.
- * Each discard bio merged into a request is counted as one segment.
- */
-static inline unsigned short blk_rq_nr_discard_segments(struct request *rq)
-{
-	return max_t(unsigned short, rq->nr_phys_segments, 1);
-}
-
-int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
-		struct scatterlist *sglist, struct scatterlist **last_sg);
-static inline int blk_rq_map_sg(struct request_queue *q, struct request *rq,
-		struct scatterlist *sglist)
-{
-	struct scatterlist *last_sg = NULL;
-
-	return __blk_rq_map_sg(q, rq, sglist, &last_sg);
-}
-extern void blk_dump_rq_flags(struct request *, char *);
-
 bool __must_check blk_get_queue(struct request_queue *);
 extern void blk_put_queue(struct request_queue *);
 extern void blk_set_queue_dying(struct request_queue *);
@@ -1613,60 +1200,6 @@ extern int bdev_read_page(struct block_device *, sector_t, struct page *);
 extern int bdev_write_page(struct block_device *, sector_t, struct page *,
 						struct writeback_control *);
 
-#ifdef CONFIG_BLK_DEV_ZONED
-bool blk_req_needs_zone_write_lock(struct request *rq);
-bool blk_req_zone_write_trylock(struct request *rq);
-void __blk_req_zone_write_lock(struct request *rq);
-void __blk_req_zone_write_unlock(struct request *rq);
-
-static inline void blk_req_zone_write_lock(struct request *rq)
-{
-	if (blk_req_needs_zone_write_lock(rq))
-		__blk_req_zone_write_lock(rq);
-}
-
-static inline void blk_req_zone_write_unlock(struct request *rq)
-{
-	if (rq->rq_flags & RQF_ZONE_WRITE_LOCKED)
-		__blk_req_zone_write_unlock(rq);
-}
-
-static inline bool blk_req_zone_is_write_locked(struct request *rq)
-{
-	return rq->q->seq_zones_wlock &&
-		test_bit(blk_rq_zone_no(rq), rq->q->seq_zones_wlock);
-}
-
-static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
-{
-	if (!blk_req_needs_zone_write_lock(rq))
-		return true;
-	return !blk_req_zone_is_write_locked(rq);
-}
-#else
-static inline bool blk_req_needs_zone_write_lock(struct request *rq)
-{
-	return false;
-}
-
-static inline void blk_req_zone_write_lock(struct request *rq)
-{
-}
-
-static inline void blk_req_zone_write_unlock(struct request *rq)
-{
-}
-static inline bool blk_req_zone_is_write_locked(struct request *rq)
-{
-	return false;
-}
-
-static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
-{
-	return true;
-}
-#endif /* CONFIG_BLK_DEV_ZONED */
-
 static inline void blk_wake_io_task(struct task_struct *waiter)
 {
 	/*
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index a083e15df6087..22501a293fa54 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -2,7 +2,7 @@
 #ifndef BLKTRACE_H
 #define BLKTRACE_H
 
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/relay.h>
 #include <linux/compat.h>
 #include <uapi/linux/blktrace_api.h>
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index 96305a64a5a7b..c635c2e014e3d 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -3,7 +3,7 @@
 #define _LINUX_T10_PI_H
 
 #include <linux/types.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 
 /*
  * A T10 PI-capable target device can be formatted with different
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 09a17f6e93a79..76d9ee98f6c15 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -5,7 +5,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <scsi/scsi.h>
 #include <linux/atomic.h>
 #include <linux/sbitmap.h>
-- 
2.30.2

