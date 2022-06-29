Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51319C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiF2Xb7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiF2Xb7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:31:59 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E1C30B
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:31:58 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 23so16760983pgc.8
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2M6F9KmEO+yMNJj82Qa5ULtMPr21seW20m1eGnWRL0=;
        b=RPrEiWxS3MPBjQrrd9tnbBXqUwn0e8edwFO0jIA7Kxx336idfnVr/3uXGKSHA05F3o
         KXrlj9ioC/SBIihTG2B5U5+xOUpj5UsOJeNnE3Yt+OLTjk9af6vgA1jpYQJ6sh7+RR05
         MSTf6ozXBkbz38IUJ51pAJfmk67dSEKBQ4iM3chtCag5rrtC6pTMKg1G7VRPYP08thKI
         KvzLALHn+ECq4B3Xyilt4P2u5EFSQLuiT1SgUsxfzU6f/U+P4LTssXuIoCVmsWxRe82h
         u8RKJY/hEdzVV+acw3WXBySerL1OGemE1lkhELdmE6bKj2OXbKxOUlZ2Gi/OpwWy8b9W
         MTdA==
X-Gm-Message-State: AJIora/SbyM01HDL6eokQNQDUWA75OiFtOhUNAIxFQ3Q08Fu+g9Q0i6r
        Vg60ihur22/XVf2Of1xI7ZU=
X-Google-Smtp-Source: AGRyM1uEAGLgCC9Y/JX6ieaEFlR9NHeL/sv4bQES9I3tfYwLGeR+2Ca80rG99btiKQ8mKFwjoD+Uvg==
X-Received: by 2002:a63:cd52:0:b0:3fe:30ec:825d with SMTP id a18-20020a63cd52000000b003fe30ec825dmr4881924pgj.82.1656545517824;
        Wed, 29 Jun 2022 16:31:57 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:31:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 02/63] block: Use enum req_op where appropriate
Date:   Wed, 29 Jun 2022 16:30:44 -0700
Message-Id: <20220629233145.2779494-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the type of the arguments that are used to pass a REQ_OP_* value
from int or unsigned int into enum req_op to improve static type
checking.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c          | 6 +++---
 block/blk-mq-debugfs.c    | 2 +-
 block/blk-throttle.c      | 7 ++++---
 block/blk-wbt.c           | 2 +-
 block/blk.h               | 2 +-
 include/linux/blk_types.h | 2 +-
 include/linux/blkdev.h    | 6 +++---
 7 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5ad7bd93077c..d11945207bcf 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -136,7 +136,7 @@ static const char *const blk_op_name[] = {
  * string format. Useful in the debugging and tracing bio or request. For
  * invalid REQ_OP_XXX it returns string "UNKNOWN".
  */
-inline const char *blk_op_str(unsigned int op)
+inline const char *blk_op_str(enum req_op op)
 {
 	const char *op_str = "UNKNOWN";
 
@@ -954,7 +954,7 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 }
 
 unsigned long bdev_start_io_acct(struct block_device *bdev,
-				 unsigned int sectors, unsigned int op,
+				 unsigned int sectors, enum req_op op,
 				 unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
@@ -995,7 +995,7 @@ unsigned long bio_start_io_acct(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(bio_start_io_acct);
 
-void bdev_end_io_acct(struct block_device *bdev, unsigned int op,
+void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 		      unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b80fae7ab1d9..745a78f412d1 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -304,7 +304,7 @@ static const char *blk_mq_rq_state_name(enum mq_rq_state rq_state)
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 {
 	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
-	const unsigned int op = req_op(rq);
+	const enum req_op op = req_op(rq);
 	const char *op_str = blk_op_str(op);
 
 	seq_printf(m, "%p {.op=", rq);
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 139b2d7a99e2..9f5fe62afff9 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2203,8 +2203,9 @@ bool __blk_throtl_bio(struct bio *bio)
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 static void throtl_track_latency(struct throtl_data *td, sector_t size,
-	int op, unsigned long time)
+				 enum req_op op, unsigned long time)
 {
+	const bool rw = op_is_write(op);
 	struct latency_bucket *latency;
 	int index;
 
@@ -2215,10 +2216,10 @@ static void throtl_track_latency(struct throtl_data *td, sector_t size,
 
 	index = request_bucket_index(size);
 
-	latency = get_cpu_ptr(td->latency_buckets[op]);
+	latency = get_cpu_ptr(td->latency_buckets[rw]);
 	latency[index].total_latency += time;
 	latency[index].samples++;
-	put_cpu_ptr(td->latency_buckets[op]);
+	put_cpu_ptr(td->latency_buckets[rw]);
 }
 
 void blk_throtl_stat_add(struct request *rq, u64 time_ns)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0c119be0e813..7bf09ae06577 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -670,7 +670,7 @@ u64 wbt_default_latency_nsec(struct request_queue *q)
 
 static int wbt_data_dir(const struct request *rq)
 {
-	const int op = req_op(rq);
+	const enum req_op op = req_op(rq);
 
 	if (op == REQ_OP_READ)
 		return READ;
diff --git a/block/blk.h b/block/blk.h
index 58ad50cacd2d..6eeddab066a1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -160,7 +160,7 @@ static inline bool blk_discard_mergable(struct request *req)
 }
 
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
-						     int op)
+						     enum req_op op)
 {
 	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
 		return min(q->limits.max_discard_sectors,
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 0e6a2af7ed3d..cce8768bc00b 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -522,7 +522,7 @@ static inline bool op_is_zone_mgmt(enum req_op op)
 	}
 }
 
-static inline int op_stat_group(unsigned int op)
+static inline int op_stat_group(enum req_op op)
 {
 	if (op_is_discard(op))
 		return STAT_DISCARD;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a8378cae93d9..bd395daa057c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -881,7 +881,7 @@ extern void blk_queue_exit(struct request_queue *q);
 extern void blk_sync_queue(struct request_queue *q);
 
 /* Helper to convert REQ_OP_XXX to its string format XXX */
-extern const char *blk_op_str(unsigned int op);
+extern const char *blk_op_str(enum req_op op);
 
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
@@ -1466,9 +1466,9 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 }
 
 unsigned long bdev_start_io_acct(struct block_device *bdev,
-				 unsigned int sectors, unsigned int op,
+				 unsigned int sectors, enum req_op op,
 				 unsigned long start_time);
-void bdev_end_io_acct(struct block_device *bdev, unsigned int op,
+void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 		unsigned long start_time);
 
 void bio_start_io_acct_time(struct bio *bio, unsigned long start_time);
