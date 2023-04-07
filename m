Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2172C77B6C
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDGX6p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDGX6o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:58:44 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719BECA1C
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:43 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id kx12so2288235plb.12
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911923; x=1683503923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqHrajTxO4No+Knsk0F9iORrtB37kJDx2LKjrju7sMM=;
        b=NnTbs2xJZPrf4wxLolq65Pm/h4JRzfk8l1Dc+OSor4aQGOk6gU/KDAr7ISbn0HCKoi
         Kl2WhCXxlXvIMZ2nNQPxD5PgcqPSYRvvS9MZ7EcmmOdh4XVDLAegPSa5njfudDXS4u2u
         MPtp0v95zpc/JMqoGN/ntr9ftcCHDoZO6wvxKzAK1JeqK1VVjFH6I7KOFZximILwZP7s
         Tmplk/LyLlJk4Z6iW1V5j7W8sibbrW6k7ke2OMDtKfO78UcOBvuGYOzo/GJpHEzDHsrk
         GJv/dtRwFxu/tanayqqm6b0iu0hQwMxBeFPreC6zRYozB27u3Lq/zoIELSrNYhIVCDcK
         fuTg==
X-Gm-Message-State: AAQBX9dBJLPz1iTYqb3zBGlol4lZRy0f+l4JjCfMo/Aa2ipEHHWfXdMH
        UqYnFMi0yIgVzB8mcZPFkx0=
X-Google-Smtp-Source: AKy350YxlQa0ByUh4V6oq64xSWNWHESbibZvMkzxNtpQq2HQ4Tw9Cl7w52DsUXh80jGbvTnE6MflRg==
X-Received: by 2002:a05:6a20:4a27:b0:d5:2f2a:ead4 with SMTP id fr39-20020a056a204a2700b000d52f2aead4mr92613pzb.47.1680911922719;
        Fri, 07 Apr 2023 16:58:42 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 02/12] block: Send flush requests to the I/O scheduler
Date:   Fri,  7 Apr 2023 16:58:12 -0700
Message-Id: <20230407235822.1672286-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407235822.1672286-1-bvanassche@acm.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
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
