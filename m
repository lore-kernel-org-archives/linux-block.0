Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5167C77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjEPWdq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjEPWdp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:45 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A8872A7
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:40 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ae50da739dso417835ad.1
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276419; x=1686868419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EO/K03PaxOhxpK8taM5yLo5Sd/gHkP9xk7+LydZTQV0=;
        b=JmcsGeL2mbDoEGV4P1CXKib8U2hAEasbrT6L++ZxB1qNzzsJTEJaAN58m1YXJn9Vs7
         eaEsZaGMyqgbvCudurHde1I336VPqNvNzmc/dyrAak9Q0eR8UlPeSYAHd2YfDnUe7hd5
         8xnVXiB2EJPTHHO33iwKSaMQRqAfQ9Q7LT/oi6p1loFKaMyqRT2rvcq7JPinrxZ5UHlY
         Uc/cr9oL6FhKQZzjBqMCDn+ZDKM0AhH5O1PXmRI+e/3oHJH2hZ/7eq3M02UbbbYOyjEN
         eB4phIuzQYs8FdRlqyosmssbkm2JVVUzR2BQxfFDxHGnUeXb/IN48N3WkSRc+Z7bj2yU
         vaOQ==
X-Gm-Message-State: AC+VfDx2Fg/a10/Yq3xqXJfQdNz7s++0rOEODFyWCZYOhna2RXt/auyJ
        yrht+STUcZ4gAozm63B390YWagYuuFk=
X-Google-Smtp-Source: ACHHUZ6SWlK36rQLQOHms/QNCuHezKiaQ2vYXerRS0m1EQ+As6DUFkD0UJ9bLuszrri/AWLZBez37Q==
X-Received: by 2002:a17:903:1247:b0:1ac:3605:97ec with SMTP id u7-20020a170903124700b001ac360597ecmr51261510plh.62.1684276419168;
        Tue, 16 May 2023 15:33:39 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:38 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 09/11] block: mq-deadline: Track the dispatch position
Date:   Tue, 16 May 2023 15:33:18 -0700
Message-ID: <20230516223323.1383342-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230516223323.1383342-1-bvanassche@acm.org>
References: <20230516223323.1383342-1-bvanassche@acm.org>
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
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 06af9c28a3bf..6d0b99042c96 100644
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
