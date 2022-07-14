Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498D8C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiGNSHl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbiGNSHk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:40 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D965474DB
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:39 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id b2so1116137plx.7
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0uhXXYc08ayQNzNKSJEspnpLygydGYC6ZAg6zFpr8o=;
        b=vWFRBJneWx+P00Km9vQR9wwTE+lm5i/Zot9nqhb8dKR5nyU5URO8X1UtSljbIo8Tpd
         Ne8aEH8QFJ6UjctJoZVNU+YQuVZoCQQSJJs5659/Wi/DTVpqbnU2MRrBKN8vb0KpWxHh
         JGBJPvpZn6E7OZK42bpOqdZBpKEX72I5c+vla3YFC3vyY4t0LMrjwLjyhe8m0GU4Ez1v
         5R6LvjANMdKh/haers+j2LgqXLO8ohNiKyUgfxa762OJ78wtsl63jEaXZfdY37Kw1ge7
         jsBAY5pzNU5+ghM0QPTVlbp5umg6g/XscXcmrZFJvZGffk7Hy2uLxt4DxVVa31bHUrf3
         rRNg==
X-Gm-Message-State: AJIora9BTXooQoslcVeshPD6W9vgZ8aDTR08FNOZy+wxL2h6El6lY7YP
        hi4bJd5GfGqwKnXPMj/i/30=
X-Google-Smtp-Source: AGRyM1uprSkf2OZ6vN2mK18f4xjqfe6LtzpiB2KB8WhvJYZNjStP05cljhvqisy+faL+nA54pD/HTA==
X-Received: by 2002:a17:902:e946:b0:16b:d4e1:a405 with SMTP id b6-20020a170902e94600b0016bd4e1a405mr9408801pll.16.1657822058733;
        Thu, 14 Jul 2022 11:07:38 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:38 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 02/63] block: Use enum req_op where appropriate
Date:   Thu, 14 Jul 2022 11:06:28 -0700
Message-Id: <20220714180729.1065367-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
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
Cc: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
index 8365996a8ef8..67b8bcfa27f0 100644
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
 
@@ -953,7 +953,7 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 }
 
 unsigned long bdev_start_io_acct(struct block_device *bdev,
-				 unsigned int sectors, unsigned int op,
+				 unsigned int sectors, enum req_op op,
 				 unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
@@ -994,7 +994,7 @@ unsigned long bio_start_io_acct(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(bio_start_io_acct);
 
-void bdev_end_io_acct(struct block_device *bdev, unsigned int op,
+void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 		      unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7ee1b13380d0..6cc2411e2d26 100644
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
index b71e22c97d77..c4b084bfe87c 100644
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
index ec072a5129bf..2f13f0062192 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -872,7 +872,7 @@ extern void blk_queue_exit(struct request_queue *q);
 extern void blk_sync_queue(struct request_queue *q);
 
 /* Helper to convert REQ_OP_XXX to its string format XXX */
-extern const char *blk_op_str(unsigned int op);
+extern const char *blk_op_str(enum req_op op);
 
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
@@ -1434,9 +1434,9 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 }
 
 unsigned long bdev_start_io_acct(struct block_device *bdev,
-				 unsigned int sectors, unsigned int op,
+				 unsigned int sectors, enum req_op op,
 				 unsigned long start_time);
-void bdev_end_io_acct(struct block_device *bdev, unsigned int op,
+void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 		unsigned long start_time);
 
 void bio_start_io_acct_time(struct bio *bio, unsigned long start_time);
