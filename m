Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC580C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955972080D
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dxjTf4TO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955972080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeKRICP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 03:02:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36128 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeKRICP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 03:02:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so4943390pgm.3
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 13:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2NKbqnhR7MBhe3pEkuvFMU/yC7rDgMlxN/r5M6eW954=;
        b=dxjTf4TOJkGE3CaNtoTDTb5T1lMGBT8IpY7dT/X4CjJMejqHrzi3NaG2XA4QJAPP2n
         xfFBDJEjhzV22RIzT7JaVa0zsY7j4I6usTd6b7a2+Ktc7WDaBSPA+Y2mdNmh0kjCuZV6
         BjTMwMLlk3PabqkpK0cI1oIfbMjIXjMqG2Q9Xmv3ulv4zl2B/4zjGI/+4YFhps18WXdY
         K2g4pk5VPVdhpkHf4SWlK718D1t8K3Gv/xb3pMi22gR577yhXqUIeuElUYSzITbdaHvJ
         81paEf6UmoH+5IR9gymNPIueCK5ALejVJ+ruOiQq1bSXUeScdywnupmiU42oyrKF2JkP
         lmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2NKbqnhR7MBhe3pEkuvFMU/yC7rDgMlxN/r5M6eW954=;
        b=fZ+1//q18gykjCAh2X5LM6K1pxMz8XNlpWNpcaGyVf8q9kC9MzcKByvmTLynKnS/jM
         Zi8bGoEGdd9JJKQsxPSHtaeL9oiIrEAIUP+ThiFz4rxkaQWYPLv4XdyPoDTmfE3ru5p1
         hEBHsSZ/a9BiYAzY2ztFhrhc5yJfHO5WRcAR9YZsdmedm0H5H+fLPZOcUIYnxTKA7XaK
         4PUWlvw9bBALLPzyWAdUqN9jARHKrbN+tTs/ggtGLtrcxAQzIpe35F63Z+x5o4RaaauW
         xmkM/TgWhRRz1AxIghwL3RCrzeggAwz0dTjcQ8PDv7petUbF/N4y6xARpBGBMKoRFOQV
         wgIg==
X-Gm-Message-State: AGRZ1gJII5IQhwbfhrApxxrzzbe2ymhlk3JKrMZCf+L2y84aI72Y0HpQ
        YDtnauQFCER3skZnx36PHawNesf7kAc=
X-Google-Smtp-Source: AJdET5eSZbSqX/R/H7IgpJSmSFpRUdP4Jd/Ma6dx7PyGpcvpM8U3KEJg7sSyUDQcrnrH0IBVEXXj/g==
X-Received: by 2002:a63:e101:: with SMTP id z1mr14858719pgh.310.1542491051392;
        Sat, 17 Nov 2018 13:44:11 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o84sm29006501pfi.172.2018.11.17.13.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 13:44:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/7] block: make blk_poll() take a parameter on whether to spin or not
Date:   Sat, 17 Nov 2018 14:43:53 -0700
Message-Id: <20181117214354.822-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117214354.822-1-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_poll() has always kept spinning until it found an IO. This is
fine for SYNC polling, since we need to find one request we have
pending, but in preparation for ASYNC polling it can be beneficial
to just check if we have any entries available or not.

Existing callers are converted to pass in 'spin == true', to retain
the old behavior.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c                  |  4 ++--
 block/blk-mq.c                    | 10 +++++-----
 drivers/nvme/host/multipath.c     |  4 ++--
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 fs/block_dev.c                    |  4 ++--
 fs/direct-io.c                    |  2 +-
 fs/iomap.c                        |  2 +-
 include/linux/blkdev.h            |  4 ++--
 mm/page_io.c                      |  2 +-
 9 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 0b684a520a11..ccf40f853afd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1284,14 +1284,14 @@ blk_qc_t submit_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio);
 
-bool blk_poll(struct request_queue *q, blk_qc_t cookie)
+bool blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	if (!q->poll_fn || !blk_qc_t_valid(cookie))
 		return false;
 
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
-	return q->poll_fn(q, cookie);
+	return q->poll_fn(q, cookie, spin);
 }
 EXPORT_SYMBOL_GPL(blk_poll);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 10a14baa04ff..0a2847d9248b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -38,7 +38,7 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
-static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
+static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -3328,7 +3328,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
 }
 
-static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx)
+static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, bool spin)
 {
 	struct request_queue *q = hctx->queue;
 	long state;
@@ -3353,7 +3353,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx)
 
 		if (current->state == TASK_RUNNING)
 			return 1;
-		if (ret < 0)
+		if (ret < 0 || !spin)
 			break;
 		cpu_relax();
 	}
@@ -3362,7 +3362,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx)
 	return 0;
 }
 
-static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
+static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx;
 
@@ -3381,7 +3381,7 @@ static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 	if (blk_mq_poll_hybrid(q, hctx, cookie))
 		return 1;
 
-	return __blk_mq_poll(hctx);
+	return __blk_mq_poll(hctx, spin);
 }
 
 unsigned int blk_mq_rq_cpu(struct request *rq)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 65539c8df11d..c83bb3302684 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -220,7 +220,7 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 	return ret;
 }
 
-static int nvme_ns_head_poll(struct request_queue *q, blk_qc_t qc)
+static int nvme_ns_head_poll(struct request_queue *q, blk_qc_t qc, bool spin)
 {
 	struct nvme_ns_head *head = q->queuedata;
 	struct nvme_ns *ns;
@@ -230,7 +230,7 @@ static int nvme_ns_head_poll(struct request_queue *q, blk_qc_t qc)
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = srcu_dereference(head->current_path[numa_node_id()], &head->srcu);
 	if (likely(ns && nvme_path_is_optimized(ns)))
-		found = ns->queue->poll_fn(q, qc);
+		found = ns->queue->poll_fn(q, qc, spin);
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return found;
 }
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c1ec3475a140..f6971b45bc54 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -116,7 +116,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
 	cookie = submit_bio(bio);
 
-	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
+	blk_poll(bdev_get_queue(req->ns->bdev), cookie, true);
 }
 
 static void nvmet_bdev_execute_flush(struct nvmet_req *req)
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 64ba27b8b754..d233a59ea364 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -243,7 +243,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 			break;
 
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc))
+		    !blk_poll(bdev_get_queue(bdev), qc, true))
 			io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -423,7 +423,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			break;
 
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc))
+		    !blk_poll(bdev_get_queue(bdev), qc, true))
 			io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index ea07d5a34317..a5a4e5a1423e 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -518,7 +518,7 @@ static struct bio *dio_await_one(struct dio *dio)
 		dio->waiter = current;
 		spin_unlock_irqrestore(&dio->bio_lock, flags);
 		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(dio->bio_disk->queue, dio->bio_cookie))
+		    !blk_poll(dio->bio_disk->queue, dio->bio_cookie, true))
 			io_schedule();
 		/* wake up sets us TASK_RUNNING */
 		spin_lock_irqsave(&dio->bio_lock, flags);
diff --git a/fs/iomap.c b/fs/iomap.c
index c5df035ace6f..74c1f37f0fd6 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1896,7 +1896,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (!(iocb->ki_flags & IOCB_HIPRI) ||
 			    !dio->submit.last_queue ||
 			    !blk_poll(dio->submit.last_queue,
-					 dio->submit.cookie))
+					 dio->submit.cookie, true))
 				io_schedule();
 		}
 		__set_current_state(TASK_RUNNING);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e97c0a3b2262..c85ea63c6406 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -283,7 +283,7 @@ static inline unsigned short req_get_ioprio(struct request *req)
 struct blk_queue_ctx;
 
 typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
-typedef int (poll_q_fn) (struct request_queue *q, blk_qc_t);
+typedef int (poll_q_fn) (struct request_queue *q, blk_qc_t, bool spin);
 
 struct bio_vec;
 typedef int (dma_drain_needed_fn)(struct request *);
@@ -867,7 +867,7 @@ extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
-bool blk_poll(struct request_queue *q, blk_qc_t cookie);
+bool blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
diff --git a/mm/page_io.c b/mm/page_io.c
index a7271fa481f6..5bdfd21c1bd9 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -410,7 +410,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		if (!READ_ONCE(bio->bi_private))
 			break;
 
-		if (!blk_poll(disk->queue, qc))
+		if (!blk_poll(disk->queue, qc, true))
 			break;
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.17.1

