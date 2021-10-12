Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B92C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A369660C4B
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhJLSTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhJLSTt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:19:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FB1C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:47 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id i189so16998132ioa.1
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7vZjDgeauo5FzeWcQNWxt7bHslhgDBADGVxfKZuB1I=;
        b=6yFuR3c2jQRfLmkuSZMYCATeG6k9GNZUyGdTvT5+ww2XXFk5V6VeCc1UWvk0gbkhvR
         YswjMfKDTDfY8ThBT5JgR/bhLtEi3YrSUHJHKF+JOIoRCVs5yC4/e1wKVKEXz/OnfO5X
         c21SaXLwryknnS5OLzsYD8nnGAPDnJJ3aJZnhDbjVDjdX4VjjM7NE4APMQrMJP2RcqZy
         qENrLPUNrXC2fK7O24FcVMK7J4bNgCMJzIiCEkgGWxaPjQ4FhaNIkw1hicXPJBA3gFru
         KC8qH7X+lm/J3B0GZiH0JG/2A+FbKUFv1WR4ZUgCqbnOXxAnYR+1BkJ9rHHdt2C+tqW3
         TI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7vZjDgeauo5FzeWcQNWxt7bHslhgDBADGVxfKZuB1I=;
        b=iD4kI9iRf5bdNS+7VPZGweADFWsA+ieQVctCwa4o4Vav+kqhl/jisKA8tRJqafMSrc
         3JugObly+9oYemRCeE+RO1kahN/AEfV7vexu9V3rLPEIxvc0C7BZVX+z0hez/zHk/+aT
         2eDpR8GPhqHDi8eI8dTHlHdCEXAhR8Ci9nctkI44nMpAaz4WD0GOq0WsSvPrEGVuCtbF
         +7smBH8KRM6q/LqaLywYnXRneJ4bmfj5twJ49x3ks7WZNO62hkLFlFCVtST83FiXDhm6
         otwKzfLEAyIs5/Nsb084hi6c5wSKynjaSONLU+Q5NFGPJaNdV0XDH0a+NnL9eg0jQ6tD
         nofw==
X-Gm-Message-State: AOAM531TyJ00CxLtcgSGbCoFWjnjTvZps29jG72LbQj6dGRnStVIRaTi
        yNeOwfb/HHk8mcRxDUVHoYZIVeJWkidX4g==
X-Google-Smtp-Source: ABdhPJxU6ykg4CAKrj+q+pYz08ucBOvhqMCYumych1dZBv5ndJlhZDHX7f8s+JxqYUMqpdiY6ehnOA==
X-Received: by 2002:a6b:fd05:: with SMTP id c5mr5111107ioi.15.1634062665585;
        Tue, 12 Oct 2021 11:17:45 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm2242476ioh.23.2021.10.12.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:17:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/9] block: add a struct io_batch argument to fops->iopoll()
Date:   Tue, 12 Oct 2021 12:17:34 -0600
Message-Id: <20211012181742.672391-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012181742.672391-1-axboe@kernel.dk>
References: <20211012181742.672391-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

struct io_batch contains a list head and a completion handler, which will
allow completions to more effciently completed batches of IO.

For now, no functional changes in this patch, we just add the argument to
the file_operations iopoll handler

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c              | 8 ++++----
 block/blk-exec.c              | 2 +-
 block/blk-mq.c                | 9 +++++----
 block/blk-mq.h                | 3 ++-
 block/fops.c                  | 4 ++--
 drivers/block/null_blk/main.c | 2 +-
 drivers/block/rnbd/rnbd-clt.c | 2 +-
 drivers/nvme/host/pci.c       | 4 ++--
 drivers/nvme/host/rdma.c      | 2 +-
 drivers/nvme/host/tcp.c       | 2 +-
 drivers/scsi/scsi_lib.c       | 2 +-
 fs/io_uring.c                 | 2 +-
 fs/iomap/direct-io.c          | 2 +-
 include/linux/blk-mq.h        | 2 +-
 include/linux/blkdev.h        | 4 ++--
 include/linux/fs.h            | 8 +++++++-
 mm/page_io.c                  | 2 +-
 17 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d5b0258dd218..877c345936a0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1099,7 +1099,7 @@ EXPORT_SYMBOL(submit_bio);
  * Note: the caller must either be the context that submitted @bio, or
  * be in a RCU critical section to prevent freeing of @bio.
  */
-int bio_poll(struct bio *bio, unsigned int flags)
+int bio_poll(struct bio *bio, struct io_batch *ib, unsigned int flags)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
 	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
@@ -1117,7 +1117,7 @@ int bio_poll(struct bio *bio, unsigned int flags)
 	if (WARN_ON_ONCE(!queue_is_mq(q)))
 		ret = 0;	/* not yet implemented, should not happen */
 	else
-		ret = blk_mq_poll(q, cookie, flags);
+		ret = blk_mq_poll(q, cookie, ib, flags);
 	blk_queue_exit(q);
 	return ret;
 }
@@ -1127,7 +1127,7 @@ EXPORT_SYMBOL_GPL(bio_poll);
  * Helper to implement file_operations.iopoll.  Requires the bio to be stored
  * in iocb->private, and cleared before freeing the bio.
  */
-int iocb_bio_iopoll(struct kiocb *kiocb, unsigned int flags)
+int iocb_bio_iopoll(struct kiocb *kiocb, struct io_batch *ib, unsigned int flags)
 {
 	struct bio *bio;
 	int ret = 0;
@@ -1155,7 +1155,7 @@ int iocb_bio_iopoll(struct kiocb *kiocb, unsigned int flags)
 	rcu_read_lock();
 	bio = READ_ONCE(kiocb->private);
 	if (bio && bio->bi_bdev)
-		ret = bio_poll(bio, flags);
+		ret = bio_poll(bio, ib, flags);
 	rcu_read_unlock();
 
 	return ret;
diff --git a/block/blk-exec.c b/block/blk-exec.c
index 55f0cd34b37b..1b8b47f6e79b 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -77,7 +77,7 @@ static bool blk_rq_is_poll(struct request *rq)
 static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 {
 	do {
-		bio_poll(rq->bio, 0);
+		bio_poll(rq->bio, NULL, 0);
 		cond_resched();
 	} while (!completion_done(wait));
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7027a25c5271..a38412dcb55f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4030,7 +4030,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q, blk_qc_t qc)
 }
 
 static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
-		unsigned int flags)
+			       struct io_batch *ib, unsigned int flags)
 {
 	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, cookie);
 	long state = get_current_state();
@@ -4041,7 +4041,7 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
 	do {
 		hctx->poll_invoked++;
 
-		ret = q->mq_ops->poll(hctx);
+		ret = q->mq_ops->poll(hctx, ib);
 		if (ret > 0) {
 			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
@@ -4062,14 +4062,15 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
 	return 0;
 }
 
-int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_batch *ib,
+		unsigned int flags)
 {
 	if (!(flags & BLK_POLL_NOSLEEP) &&
 	    q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
 		if (blk_mq_poll_hybrid(q, cookie))
 			return 1;
 	}
-	return blk_mq_poll_classic(q, cookie, flags);
+	return blk_mq_poll_classic(q, cookie, ib, flags);
 }
 
 unsigned int blk_mq_rq_cpu(struct request *rq)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8be447995106..861c5cb076a9 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -38,7 +38,8 @@ struct blk_mq_ctx {
 } ____cacheline_aligned_in_smp;
 
 void blk_mq_submit_bio(struct bio *bio);
-int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags);
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_batch *ib,
+		unsigned int flags);
 void blk_mq_exit_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
diff --git a/block/fops.c b/block/fops.c
index ce1255529ba2..30487bf6d5e4 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -106,7 +106,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio.bi_private))
 			break;
-		if (!(iocb->ki_flags & IOCB_HIPRI) || !bio_poll(&bio, 0))
+		if (!(iocb->ki_flags & IOCB_HIPRI) || !bio_poll(&bio, NULL, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -288,7 +288,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!do_poll || !bio_poll(bio, 0))
+		if (!do_poll || !bio_poll(bio, NULL, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 7ce911e2289d..744601f1704d 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1494,7 +1494,7 @@ static int null_map_queues(struct blk_mq_tag_set *set)
 	return 0;
 }
 
-static int null_poll(struct blk_mq_hw_ctx *hctx)
+static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *ib)
 {
 	struct nullb_queue *nq = hctx->driver_data;
 	LIST_HEAD(list);
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index bd4a41afbbfc..7bd18aef1086 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1176,7 +1176,7 @@ static blk_status_t rnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static int rnbd_rdma_poll(struct blk_mq_hw_ctx *hctx)
+static int rnbd_rdma_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *ib)
 {
 	struct rnbd_queue *q = hctx->driver_data;
 	struct rnbd_clt_dev *dev = q->dev;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0dd4b44b59cd..4ad63bb9f415 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1092,7 +1092,7 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 }
 
-static int nvme_poll(struct blk_mq_hw_ctx *hctx)
+static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *ib)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	bool found;
@@ -1274,7 +1274,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 * Did we miss an interrupt?
 	 */
 	if (test_bit(NVMEQ_POLLED, &nvmeq->flags))
-		nvme_poll(req->mq_hctx);
+		nvme_poll(req->mq_hctx, NULL);
 	else
 		nvme_poll_irqdisable(nvmeq);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 40317e1b9183..4987cfbf5dd4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2106,7 +2106,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
+static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *ib)
 {
 	struct nvme_rdma_queue *queue = hctx->driver_data;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3c1c29dd3020..7bc321ceec72 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2429,7 +2429,7 @@ static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 	return 0;
 }
 
-static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx)
+static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *ib)
 {
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 	struct sock *sk = queue->sock->sk;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 33fd9a01330c..de3fffc447da 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1784,7 +1784,7 @@ static void scsi_mq_exit_request(struct blk_mq_tag_set *set, struct request *rq,
 }
 
 
-static int scsi_mq_poll(struct blk_mq_hw_ctx *hctx)
+static int scsi_mq_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *ib)
 {
 	struct Scsi_Host *shost = hctx->driver_data;
 
diff --git a/fs/io_uring.c b/fs/io_uring.c
index e43e130a0e92..082ff64c1bcb 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2412,7 +2412,7 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 		if (READ_ONCE(req->iopoll_completed))
 			break;
 
-		ret = kiocb->ki_filp->f_op->iopoll(kiocb, poll_flags);
+		ret = kiocb->ki_filp->f_op->iopoll(kiocb, NULL, poll_flags);
 		if (unlikely(ret < 0))
 			return ret;
 		else if (ret)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8efab177011d..83ecfba53abe 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -630,7 +630,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 				break;
 
 			if (!dio->submit.poll_bio ||
-			    !bio_poll(dio->submit.poll_bio, 0))
+			    !bio_poll(dio->submit.poll_bio, NULL, 0))
 				blk_io_schedule();
 		}
 		__set_current_state(TASK_RUNNING);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f86e28828a95..29555673090d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -538,7 +538,7 @@ struct blk_mq_ops {
 	/**
 	 * @poll: Called to poll for completion of a specific tag.
 	 */
-	int (*poll)(struct blk_mq_hw_ctx *);
+	int (*poll)(struct blk_mq_hw_ctx *, struct io_batch *);
 
 	/**
 	 * @complete: Mark the request as complete.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2a8689e949b4..96e1261c4846 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -569,8 +569,8 @@ blk_status_t errno_to_blk_status(int errno);
 #define BLK_POLL_ONESHOT		(1 << 0)
 /* do not sleep to wait for the expected completion time */
 #define BLK_POLL_NOSLEEP		(1 << 1)
-int bio_poll(struct bio *bio, unsigned int flags);
-int iocb_bio_iopoll(struct kiocb *kiocb, unsigned int flags);
+int bio_poll(struct bio *bio, struct io_batch *ib, unsigned int flags);
+int iocb_bio_iopoll(struct kiocb *kiocb, struct io_batch *ib, unsigned int flags);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f98a361a6752..70986a1d62db 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -48,6 +48,7 @@
 struct backing_dev_info;
 struct bdi_writeback;
 struct bio;
+struct request;
 struct export_operations;
 struct fiemap_extent_info;
 struct hd_geometry;
@@ -2068,6 +2069,11 @@ struct dir_context {
 
 struct iov_iter;
 
+struct io_batch {
+	struct request *req_list;
+	void (*complete)(struct io_batch *);
+};
+
 struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
@@ -2075,7 +2081,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
-	int (*iopoll)(struct kiocb *kiocb, unsigned int flags);
+	int (*iopoll)(struct kiocb *kiocb, struct io_batch *, unsigned int flags);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
diff --git a/mm/page_io.c b/mm/page_io.c
index a68faab5b310..6010fb07f231 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -424,7 +424,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		if (!READ_ONCE(bio->bi_private))
 			break;
 
-		if (!bio_poll(bio, 0))
+		if (!bio_poll(bio, NULL, 0))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.33.0

