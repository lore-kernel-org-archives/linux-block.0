Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AF6C43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE7120865
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ni/CP0J1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE7120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395280AbeKXFTt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:19:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35871 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391577AbeKXFTr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Nov 2018 00:19:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so3379879pgm.3
        for <linux-block@vger.kernel.org>; Fri, 23 Nov 2018 10:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B1nsWSJKOOcjQaULw0z7/oVTYVRfudblENSpnK7eGZ8=;
        b=ni/CP0J18Ys2Y8Be+uFtJHaiJHvMlJV8XtELpONKtAwgqtlClEr774LIpwrAVp2NJH
         gCWRzROAcHGXH0slnUJNFtVPbA858SMnoK7itKTPFYYnZhkxqFy0flSqAJjAVHMXRJWc
         2nuoqBjPNnmW4C5wlyhnhURMJttDrcUjzD9JBf6Aa+eMASqwrRh5JB/lmfE+SGjtFd6h
         LGLbOZUytVkcZfgv3MFCChGwT2TpOSCa+4L5wzKGdxQbzRzOnW3awicc0Hg5sQN/djqj
         zyK1Ck4vnpy+nMICyTQbYzOFOEyHHdDI81C815GmLH/EzVbwHCausK4W7APl5OovqyL2
         4AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B1nsWSJKOOcjQaULw0z7/oVTYVRfudblENSpnK7eGZ8=;
        b=gT9KimL3IhKrdhtUZ6MKVoWbwOUwtXi+axW/qbqH6l0lkVuvX6K+C8rJaxh8GSxNFD
         Nha2V7hNBWwiCBJv16VN0fGql8HUA8fNT0SyOGehCnooQ3iAEoo86CZZ7UGlzA9neBFp
         7FEP+7FrprJWVcwyp/I1vVUhb6L/h8jdnv6JZRsKnlh0w1XOOR7fHyLgMzv3INTSfx/l
         RSedck2Cnb1VaZENAjZCeOeHDCDdljDK5FnSvqYw9HNVxH69K/aN9GdwzNIqyEFVmeGT
         klliXhmKo+irkr+I7tNzDWXR4fnqEqO6rdrzc15VeiXw5XAGX3fsFs+j253fDEOp5K5n
         U2mA==
X-Gm-Message-State: AGRZ1gLn4R7LmrkTTXxYulYiqk3Ff9wQeq3grMt9aisl5mZpk8VhCLOk
        6df9iBUzLhZCYq/8065Klrb4R3WeGD4=
X-Google-Smtp-Source: AJdET5fUOAwSrW4W2e9e/RDDwvMn2DWaEOz38DUDgkT/XMJdVRSdh1tTTglFjd1GmX/jSQcj4Nnk0w==
X-Received: by 2002:a62:528e:: with SMTP id g136mr17814574pfb.111.1542998062297;
        Fri, 23 Nov 2018 10:34:22 -0800 (PST)
Received: from x1.thefacebook.com (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s37sm52294260pgm.19.2018.11.23.10.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:34:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] block: make blk_poll() take a parameter on whether to spin or not
Date:   Fri, 23 Nov 2018 11:34:09 -0700
Message-Id: <20181123183411.8708-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123183411.8708-1-axboe@kernel.dk>
References: <20181123183411.8708-1-axboe@kernel.dk>
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
 block/blk-core.c              | 4 ++--
 block/blk-mq.c                | 6 +++---
 drivers/nvme/host/multipath.c | 4 ++--
 fs/block_dev.c                | 4 ++--
 fs/direct-io.c                | 2 +-
 fs/iomap.c                    | 2 +-
 include/linux/blkdev.h        | 4 ++--
 mm/page_io.c                  | 2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9e99aa852d6e..f7ffc43ada14 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1273,14 +1273,14 @@ blk_qc_t submit_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio);
 
-int blk_poll(struct request_queue *q, blk_qc_t cookie)
+int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
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
index b66cca3ce1e5..c2751f0a3ccc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -38,7 +38,7 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
-static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
+static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -3352,7 +3352,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
 }
 
-static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
+static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx;
 	long state;
@@ -3392,7 +3392,7 @@ static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 
 		if (current->state == TASK_RUNNING)
 			return 1;
-		if (ret < 0)
+		if (ret < 0 || !spin)
 			break;
 		cpu_relax();
 	}
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f9eeb3b58632..ffebdd0ae34b 100644
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
index f3015e9b5ae3..e3c0a8ec16a7 100644
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
 
-int blk_poll(struct request_queue *q, blk_qc_t cookie);
+int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
 
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

