Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BB5C001DC
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 19:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGZTfG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 15:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGZTfG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 15:35:06 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91E5212D
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:04 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-686f0d66652so53245b3a.2
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690400104; x=1691004904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3oGvYfH0cU7md9y+FMhEYGBL6XNBYy8/TQQQlpG39Q=;
        b=ZAfGeQ7FPty9vbmrE2rhkFdf1noUSwD0N9/bHDjm6swKHD6GKxD/IBuyE4DF2ja2lV
         KLp0T8xP0n9pMx2VUlSBVHzmKoXTPL2E2jGBUP6nOyMiTnjegtAtGgjn2WjHuERdZ81T
         2RZLjCBZ7ZeCtixJ5//phC9d4gXaZV0cCaaxALbwb1DYQk9n94tBxQcZ1rH85c0UIggc
         o5gCpVld7AGMouCMXmCbLTPLmhK380ZNOZ7Qh/xcfIyGi5q0yRCISZlzFkYRHgptlRCM
         7Tp+Ps1CfI1L7EpB0AK+pZa1R43vtr02L/hk52bIBH9fP3hMaJjCytJjhhiChfH6cvAz
         fVCA==
X-Gm-Message-State: ABy/qLYPIJHxvg+YjNVq5d1yiq1D6gusMmrfpHgRnqdQyVervvw9MK11
        rU3My2Rq8llDXCzMelEXlys=
X-Google-Smtp-Source: APBJJlFelBAEVPoBu10uzOA25sUJObjVXGPmSfPjcBVgY5zC51qyNlBAeBM8vmeDeAiFsuXK0twn6Q==
X-Received: by 2002:a05:6a00:1ad3:b0:682:5634:3df1 with SMTP id f19-20020a056a001ad300b0068256343df1mr3721388pfv.10.1690400103909;
        Wed, 26 Jul 2023 12:35:03 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:32d2:d535:b137:7ba3])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b00682ba300cd1sm11846685pfu.29.2023.07.26.12.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:35:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 2/7] block: Introduce the flag REQ_NO_ZONE_WRITE_LOCK
Date:   Wed, 26 Jul 2023 12:34:06 -0700
Message-ID: <20230726193440.1655149-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726193440.1655149-1-bvanassche@acm.org>
References: <20230726193440.1655149-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not all software that supports zoned storage allocates and submits zoned
writes in LBA order per zone. Introduce the REQ_NO_WRITE_LOCK flag such
that submitters of zoned writes can indicate that zoned writes are
allocated and submitted in LBA order per zone.

Introduce the blk_no_zone_write_lock() function to make it easy to test
whether both QUEUE_FLAG_NO_ZONE_WRITE_LOCK and REQ_NO_ZONE_WRITE_LOCK
are set.

Make flush requests inherit the REQ_NO_ZONE_WRITE_LOCK flag from the
request they are derived from.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-flush.c         |  3 ++-
 include/linux/blk-mq.h    | 11 +++++++++++
 include/linux/blk_types.h |  8 ++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index e73dc22d05c1..038350ed7cce 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -336,7 +336,8 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 		flush_rq->internal_tag = first_rq->internal_tag;
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
-	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
+	flush_rq->cmd_flags |= flags &
+		(REQ_FAILFAST_MASK | REQ_NO_ZONE_WRITE_LOCK | REQ_DRV);
 	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
 	flush_rq->end_io = flush_end_io;
 	/*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 01e8c31db665..dc8ec26ba2d0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1170,6 +1170,12 @@ static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
 		blk_rq_zone_is_seq(rq);
 }
 
+static inline bool blk_no_zone_write_lock(struct request *rq)
+{
+	return blk_queue_no_zone_write_lock(rq->q) &&
+		rq->cmd_flags & REQ_NO_ZONE_WRITE_LOCK;
+}
+
 bool blk_req_needs_zone_write_lock(struct request *rq);
 bool blk_req_zone_write_trylock(struct request *rq);
 void __blk_req_zone_write_lock(struct request *rq);
@@ -1205,6 +1211,11 @@ static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
 	return false;
 }
 
+static inline bool blk_no_zone_write_lock(struct request *rq)
+{
+	return true;
+}
+
 static inline bool blk_req_needs_zone_write_lock(struct request *rq)
 {
 	return false;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 0bad62cca3d0..68f7934d8fa6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -416,6 +416,12 @@ enum req_flag_bits {
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
+	/*
+	 * Do not use zone write locking. Setting this flag is only safe if
+	 * the request submitter allocates and submit requests in LBA order per
+	 * zone.
+	 */
+	__REQ_NO_ZONE_WRITE_LOCK,
 	__REQ_NOWAIT,           /* Don't wait if request will block */
 	__REQ_POLLED,		/* caller polls for completion using bio_poll */
 	__REQ_ALLOC_CACHE,	/* allocate IO from cache if available */
@@ -448,6 +454,8 @@ enum req_flag_bits {
 #define REQ_PREFLUSH	(__force blk_opf_t)(1ULL << __REQ_PREFLUSH)
 #define REQ_RAHEAD	(__force blk_opf_t)(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND	(__force blk_opf_t)(1ULL << __REQ_BACKGROUND)
+#define REQ_NO_ZONE_WRITE_LOCK	\
+			(__force blk_opf_t)(1ULL << __REQ_NO_ZONE_WRITE_LOCK)
 #define REQ_NOWAIT	(__force blk_opf_t)(1ULL << __REQ_NOWAIT)
 #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
 #define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)
