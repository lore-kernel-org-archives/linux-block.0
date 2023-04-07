Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC1DC77B6C
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjDGARV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjDGARU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:20 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FF08A55
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:19 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id km16so697270plb.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826638; x=1683418638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqHrajTxO4No+Knsk0F9iORrtB37kJDx2LKjrju7sMM=;
        b=HLOeaG/y2lFYtdupNBSzjQbkPAU39g3Cj2pF/THLiYb1CThRuc03G0CUxbOq7Or7Bw
         rcByIpG6LDYH886nlhvqsBwUYiSp0ylpWkOZhpkddsjprqWftId5chu1kgMj1+UBlpjG
         PVx4fi6tH4CbuznLJcL8skzO5BcsyozoQtJscBFmXiqB2EeakAwURIi3RiWrA0dzEMKZ
         fXsghFB8scXvY61ebTfZCzmU2JpahfyHDYe+b5cpPpRymm3xr9ozGcNX5set9Gm9nFgd
         u9fMbY8Rn/NveKjZPjZQGobtARNIJxa08vGcuMO92hSyK6Qn9nTkUZ80hRzC+GKo91P8
         MSKQ==
X-Gm-Message-State: AAQBX9eevjuTswWKvFBFYO8bvkSSyuRh0WUDD7oWuRmZo+TTQZ3AJxwq
        Deyzav/5emxbPgR1FGlgJ3qo80GMrbk=
X-Google-Smtp-Source: AKy350ZwR8s27lwAb8InZYq1ofNVQuGEjdLTKVjPz7Qs940ROBsCzVRTvyWfliB89C3HJTt8Dt5xhA==
X-Received: by 2002:a17:903:249:b0:1a2:1513:44bf with SMTP id j9-20020a170903024900b001a2151344bfmr1104328plh.1.1680826638311;
        Thu, 06 Apr 2023 17:17:18 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 02/12] block: Send flush requests to the I/O scheduler
Date:   Thu,  6 Apr 2023 17:17:00 -0700
Message-Id: <20230407001710.104169-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prevent that zoned writes with the FUA flag set are reordered against each
other or against other zoned writes. Separate the I/O scheduler members
from the flush members in struct request since with this patch applied a
request may pass through both an I/O scheduler and the flush machinery.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-flush.c      |  3 ++-
 block/blk-mq.c         | 11 ++++-------
 block/mq-deadline.c    |  2 +-
 include/linux/blk-mq.h | 27 +++++++++++----------------
 4 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53202eff545e..e0cf153388d8 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -432,7 +432,8 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		blk_mq_request_bypass_insert(rq, false, true);
+		blk_mq_sched_insert_request(rq, /*at_head=*/false,
+					    /*run_queue=*/true, /*async=*/true);
 		return;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fefc9a728e0e..250556546bbf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -390,8 +390,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		INIT_HLIST_NODE(&rq->hash);
 		RB_CLEAR_NODE(&rq->rb_node);
 
-		if (!op_is_flush(data->cmd_flags) &&
-		    e->type->ops.prepare_request) {
+		if (e->type->ops.prepare_request) {
 			e->type->ops.prepare_request(rq);
 			rq->rq_flags |= RQF_ELVPRIV;
 		}
@@ -452,13 +451,11 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		data->rq_flags |= RQF_ELV;
 
 		/*
-		 * Flush/passthrough requests are special and go directly to the
-		 * dispatch list. Don't include reserved tags in the
-		 * limiting, as it isn't useful.
+		 * Do not limit the depth for passthrough requests nor for
+		 * requests with a reserved tag.
 		 */
-		if (!op_is_flush(data->cmd_flags) &&
+		if (e->type->ops.limit_depth &&
 		    !blk_op_is_passthrough(data->cmd_flags) &&
-		    e->type->ops.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.limit_depth(data->cmd_flags, data);
 	}
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f10c2a0d18d4..d885ccf49170 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -789,7 +789,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	prio = ioprio_class_to_prio[ioprio_class];
 	per_prio = &dd->per_prio[prio];
-	if (!rq->elv.priv[0]) {
+	if (!rq->elv.priv[0] && !(rq->rq_flags & RQF_FLUSH_SEQ)) {
 		per_prio->stats.inserted++;
 		rq->elv.priv[0] = (void *)(uintptr_t)1;
 	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed6..5e6c79ad83d2 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -169,25 +169,20 @@ struct request {
 		void *completion_data;
 	};
 
-
 	/*
 	 * Three pointers are available for the IO schedulers, if they need
-	 * more they have to dynamically allocate it.  Flush requests are
-	 * never put on the IO scheduler. So let the flush fields share
-	 * space with the elevator data.
+	 * more they have to dynamically allocate it.
 	 */
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
+	struct {
+		struct io_cq		*icq;
+		void			*priv[2];
+	} elv;
+
+	struct {
+		unsigned int		seq;
+		struct list_head	list;
+		rq_end_io_fn		*saved_end_io;
+	} flush;
 
 	union {
 		struct __call_single_data csd;
