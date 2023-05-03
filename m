Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BBFC77B78
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 22:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjECWw2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 18:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjECWw0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:26 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735437D9B
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:25 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1aaef97652fso32958725ad.0
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154345; x=1685746345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PNHTA2TJaiV8MHw8Xe7x5V35kk/xVBm629j778VyPY=;
        b=g2Fjg4SJyEp/ooQHnssLvSwbpvdXjQcGPls5BdLCZ0XUXxa4/F9lGU7xCwkH2aHxu/
         LOywQ9sVnqdISyUPpKsgyr8dLxG/9MjmDFyPynvWX765IB7EaYgta0+yQ84w4ueGW7Rg
         anBp3czSgQfl0a2SOccsQ2EhRz3iAuw1Nrv5sbRRwl4yZoE6pylHX+xXQ2N5WxdCPH7W
         ITLyp1JLytMqDDAHNTxnRY1ky1Csbji2nBvG1BdrtJVsVeNxF0jw35dzdyMfBh55C7yy
         A/fYJVVeYxgdCVpEXFa4fo8jDik/JVMTpW7mUB0et4AppfKA9yPoKfejvOptZ4zjiU0P
         bjzA==
X-Gm-Message-State: AC+VfDyxfNPaR/SzSUS+4giVZd5GaMIeSTbSueUxjiUh6KmhbrZW0GAn
        D+b5h/1P5O3tKV3IthT96XSWizhDvtc=
X-Google-Smtp-Source: ACHHUZ6gQo6ZPpRPAL590tgnBJOst89kupWyKKz478CniZzF4cEKbt9ZDfu5qsumtOOTTN/lk9gUrw==
X-Received: by 2002:a17:902:bd86:b0:1ab:ef3:73e5 with SMTP id q6-20020a170902bd8600b001ab0ef373e5mr1523818pls.61.1683154344693;
        Wed, 03 May 2023 15:52:24 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 09/11] block: mq-deadline: Track the dispatch position
Date:   Wed,  3 May 2023 15:52:06 -0700
Message-ID: <20230503225208.2439206-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230503225208.2439206-1-bvanassche@acm.org>
References: <20230503225208.2439206-1-bvanassche@acm.org>
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

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 56cc29953e15..b482b707cb37 100644
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
 		/* we have a next request are still entitled to batch */
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
@@ -1029,8 +1044,10 @@ static int deadline_##name##_next_rq_show(void *data,			\
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
