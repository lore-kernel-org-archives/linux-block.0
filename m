Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00DDC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiFWTAh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiFWTAH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:07 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CCBB85A5
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:37 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso3381546pjn.2
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QHWu52XVuAXLu6chRMhy7VHcbAW75xRVM1TfZ9/AmXE=;
        b=LrElEyF1lbaUu0br/YgfkSpEBsX925fM/1ScQsMfuwn0VvDRyorAbQvr/8GFcUDRjY
         P+S/i43HPS5XUezU2fSDCeo9EP/0dbDc6sp6DD+Fxqvf90zNBM1rdo2Sty9PzOFpDyi9
         zxZzfy6IIkEU5n6W6q4Dyq/+ndLRcRARyBVllYB9MsJ1Zrfua/OReneu0SvhxDwwNYQh
         dbCu7zRJ67kJp9DtmVVF9+t50x0xPTNWPmlbYD4GUVrMxMbBSYZA9AwgGZB/e1IiMcDp
         uD0ymm9KE+pycjV1iYmHgbik3wNDNCOJAQ/WBP3fdiquYsNFV53Y8R3JFqXYfU7kesh7
         PyBQ==
X-Gm-Message-State: AJIora8+E57dUrnzU1DR/FaZP8Bp3iDLnNKlRsRDAjFNgUBynS1+RNks
        kJ+2pRA0Gyf4Tkw9MlaYFx4=
X-Google-Smtp-Source: AGRyM1ulqVjbkg2BvkhJvPLdhzIklBQJZLzEmUyQqefHu3+A0QgU5tyhPEeU21uyzZTkixzIWMgtkw==
X-Received: by 2002:a17:90a:1485:b0:1ec:788e:a053 with SMTP id k5-20020a17090a148500b001ec788ea053mr5261841pja.16.1656007537193;
        Thu, 23 Jun 2022 11:05:37 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 02/51] block: Use enum req_op where appropriate
Date:   Thu, 23 Jun 2022 11:04:39 -0700
Message-Id: <20220623180528.3595304-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the type of the arguments that are used to pass a REQ_OP_* value
from int or unsigned int into enum req_op to improve static type
checking.

Note: the type of the blk_mq_alloc_request() 'op' argument is not
modified by this patch since at least once caller passes an operation
and flags in this argument.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c          | 6 +++---
 block/blk-mq-debugfs.c    | 2 +-
 block/blk-mq.c            | 2 +-
 block/blk-wbt.c           | 2 +-
 block/blk.h               | 2 +-
 include/linux/blk-mq.h    | 2 +-
 include/linux/blk_types.h | 2 +-
 include/linux/blkdev.h    | 6 +++---
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index eb86c756a7fd..9d420dff90f6 100644
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
 
@@ -1010,7 +1010,7 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 }
 
 unsigned long bdev_start_io_acct(struct block_device *bdev,
-				 unsigned int sectors, unsigned int op,
+				 unsigned int sectors, enum req_op op,
 				 unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
@@ -1051,7 +1051,7 @@ unsigned long bio_start_io_acct(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(bio_start_io_acct);
 
-void bdev_end_io_acct(struct block_device *bdev, unsigned int op,
+void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 		      unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7e4136a60e1c..df0b9a458f34 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -306,7 +306,7 @@ static const char *blk_mq_rq_state_name(enum mq_rq_state rq_state)
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 {
 	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
-	const unsigned int op = req_op(rq);
+	const enum req_op op = req_op(rq);
 	const char *op_str = blk_op_str(op);
 
 	seq_printf(m, "%p {.op=", rq);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f5cce377f1a8..50fc1194ebc0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -538,7 +538,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
-	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
+	enum req_op op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
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
index 8e79296ee97a..13b43fb28b9f 100644
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
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e2d9daf7e8dd..45d69cc46dc7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -713,7 +713,7 @@ enum {
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		blk_mq_req_flags_t flags);
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
-		unsigned int op, blk_mq_req_flags_t flags,
+		enum req_op op, blk_mq_req_flags_t flags,
 		unsigned int hctx_idx);
 
 /*
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
index 94ceed805e76..3f8ee0608d60 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -886,7 +886,7 @@ extern void blk_queue_exit(struct request_queue *q);
 extern void blk_sync_queue(struct request_queue *q);
 
 /* Helper to convert REQ_OP_XXX to its string format XXX */
-extern const char *blk_op_str(unsigned int op);
+extern const char *blk_op_str(enum req_op op);
 
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
@@ -1472,9 +1472,9 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 }
 
 unsigned long bdev_start_io_acct(struct block_device *bdev,
-				 unsigned int sectors, unsigned int op,
+				 unsigned int sectors, enum req_op op,
 				 unsigned long start_time);
-void bdev_end_io_acct(struct block_device *bdev, unsigned int op,
+void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 		unsigned long start_time);
 
 void bio_start_io_acct_time(struct bio *bio, unsigned long start_time);
