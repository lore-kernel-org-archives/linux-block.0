Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E6CC7EE2A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEQRph (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjEQRpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:33 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7395FDF
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:02 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-643990c5319so787146b3a.2
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345483; x=1686937483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POypCGiWuApqDM19tE3Eviu4RKO/A7PZnM2IaNLHCrQ=;
        b=l6EY0pLXF60w7sdUGiHjzTmaaS+ejjoDoks+3pB9Xw5P2g+CMxpDFu6dd1Yytyd90N
         2W0qmdBBBHq34cDKESL2F2fSgg9ZV2SNHolpSJfw7Dwol9cDU8l6IqfMfVRiSVKCC5Yk
         ucSdF+1cU6A2Xx77rUI4htDaxpbtI5HZ/vO30slS9VGooR3QhkRNoMEmMooJhxZ/Yynu
         BYdP1a6ZuGxyzIWtvNMTglew1vd4ue3qO31YTTobDokOifJG9eHlt7tcTRuJRg1Xn/08
         epF9kBVp0rdx6vBCPHUL+z/cvm19E6FkdaH/g2WTViQWgtwiPjePnwDqUrKOMkfCBZ35
         EMMA==
X-Gm-Message-State: AC+VfDzwjTIF8TfrTcYIfSPqA5JSPAPypFX4K1cilY9yLj90MGWu0U87
        XRfiC2t6L0brtwB9PNsg3Jc=
X-Google-Smtp-Source: ACHHUZ7i42svQSYzBtQw/Hfg7xTrA17FOZfO7jlC4nMoeDmgUksCjrg+YrsXESbbp9L5ldQx3/2UNg==
X-Received: by 2002:a05:6a00:1252:b0:638:7e00:3737 with SMTP id u18-20020a056a00125200b006387e003737mr526104pfi.23.1684345482951;
        Wed, 17 May 2023 10:44:42 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6 09/11] block: mq-deadline: Track the dispatch position
Date:   Wed, 17 May 2023 10:42:27 -0700
Message-ID: <20230517174230.897144-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Track the position (sector_t) of the most recently dispatched request
instead of tracking a pointer to the next request to dispatch. This
patch is the basis for patch "Handle requeued requests correctly".
Without this patch it would be significantly more complicated to make
sure that zoned writes are dispatched in LBA order per zone.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 44222d18f6d4..91b689261d30 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -74,8 +74,8 @@ struct dd_per_prio {
 	struct list_head dispatch;
 	struct rb_root sort_list[DD_DIR_COUNT];
 	struct list_head fifo_list[DD_DIR_COUNT];
-	/* Next request in FIFO order. Read, write or both are NULL. */
-	struct request *next_rq[DD_DIR_COUNT];
+	/* Position of the most recently dispatched request. */
+	sector_t latest_pos[DD_DIR_COUNT];
 	struct io_stats_per_prio stats;
 };
 
@@ -156,6 +156,25 @@ deadline_latter_request(struct request *rq)
 	return NULL;
 }
 
+/* Return the first request for which blk_rq_pos() >= pos. */
+static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
+				enum dd_data_dir data_dir, sector_t pos)
+{
+	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
+	struct request *rq, *res = NULL;
+
+	while (node) {
+		rq = rb_entry_rq(node);
+		if (blk_rq_pos(rq) >= pos) {
+			res = rq;
+			node = node->rb_left;
+		} else {
+			node = node->rb_right;
+		}
+	}
+	return res;
+}
+
 static void
 deadline_add_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
 {
@@ -167,11 +186,6 @@ deadline_add_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
 static inline void
 deadline_del_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
 {
-	const enum dd_data_dir data_dir = rq_data_dir(rq);
-
-	if (per_prio->next_rq[data_dir] == rq)
-		per_prio->next_rq[data_dir] = deadline_latter_request(rq);
-
 	elv_rb_del(deadline_rb_root(per_prio, rq), rq);
 }
 
@@ -251,10 +265,6 @@ static void
 deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		      struct request *rq)
 {
-	const enum dd_data_dir data_dir = rq_data_dir(rq);
-
-	per_prio->next_rq[data_dir] = deadline_latter_request(rq);
-
 	/*
 	 * take it off the sort and fifo list
 	 */
@@ -363,7 +373,8 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	struct request *rq;
 	unsigned long flags;
 
-	rq = per_prio->next_rq[data_dir];
+	rq = deadline_from_pos(per_prio, data_dir,
+			       per_prio->latest_pos[data_dir]);
 	if (!rq)
 		return NULL;
 
@@ -426,6 +437,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 		if (started_after(dd, rq, latest_start))
 			return NULL;
 		list_del_init(&rq->queuelist);
+		data_dir = rq_data_dir(rq);
 		goto done;
 	}
 
@@ -433,9 +445,11 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	 * batches are currently reads XOR writes
 	 */
 	rq = deadline_next_request(dd, per_prio, dd->last_dir);
-	if (rq && dd->batching < dd->fifo_batch)
+	if (rq && dd->batching < dd->fifo_batch) {
 		/* we have a next request and are still entitled to batch */
+		data_dir = rq_data_dir(rq);
 		goto dispatch_request;
+	}
 
 	/*
 	 * at this point we are not running a batch. select the appropriate
@@ -513,6 +527,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 done:
 	ioprio_class = dd_rq_ioclass(rq);
 	prio = ioprio_class_to_prio[ioprio_class];
+	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
 	dd->per_prio[prio].stats.dispatched++;
 	/*
 	 * If the request needs its target zone locked, do it.
@@ -1026,8 +1041,10 @@ static int deadline_##name##_next_rq_show(void *data,			\
 	struct request_queue *q = data;					\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
-	struct request *rq = per_prio->next_rq[data_dir];		\
+	struct request *rq;						\
 									\
+	rq = deadline_from_pos(per_prio, data_dir,			\
+			       per_prio->latest_pos[data_dir]);		\
 	if (rq)								\
 		__blk_mq_debugfs_rq_show(m, rq);			\
 	return 0;							\
