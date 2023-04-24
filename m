Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E01FC77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 20:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjDXUdq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDXUdo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 16:33:44 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CDC55AE
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:43 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-63b50a02bffso4230996b3a.2
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368422; x=1684960422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilT4dijW2lWeUw3tyb04PzSIETXm80SktmveCf7Njoo=;
        b=e+0L0VYgKANGmo75oqYJoHAYgsSyZ1jpsPHgqLXgwbQKC/BpEhZcR+mvzMCmSF/7s6
         6VL6lBTY7lzdtjhQOJW4hf4BZAaxTZ7eGfUsw2/CFweNVrL70rG1twRt5u3DAOvac2u6
         ZNhRyDnxIQcds0+p8pMHnMeEhH2h96PPJw793jugrREAFUyUxVuLBcE40Zo4Cva6Ia5k
         Wf+agJa0OO33ImiZzmhDFt4RBYDWwGqG4HwaakUOFD+W1sXC7TB0FEtiE7lwEruc3MXZ
         FphXeYNt1Hdkkj8IE/8BeZmbux4OvjSrZ5+dsu15kHJNka8VpvMhYbpo2xu4M6tLVAof
         R4aA==
X-Gm-Message-State: AAQBX9dgd0zO6ZsHhIwpKPfCpIDurSdoiD6QsDwWY2eRTd43EXKfNGbK
        GdRNUBJmXAgsVgQypawXM+DbGVJEBYE=
X-Google-Smtp-Source: AKy350ZgYr0ntNWl+NHjbtrkT0NaX4JH/WLl27yXpgpLAZ7pfbSNJNAuQR/xxuy3K1Czb1xKqZy2Og==
X-Received: by 2002:a05:6a00:2d0d:b0:63b:8f08:9af3 with SMTP id fa13-20020a056a002d0d00b0063b8f089af3mr21047480pfb.7.1682368422502;
        Mon, 24 Apr 2023 13:33:42 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:56cb:b39a:c8b:8c37])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b00625616f59a1sm7417505pff.73.2023.04.24.13.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:33:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 7/9] block: mq-deadline: Track the dispatch position
Date:   Mon, 24 Apr 2023 13:33:27 -0700
Message-ID: <20230424203329.2369688-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230424203329.2369688-1-bvanassche@acm.org>
References: <20230424203329.2369688-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Track the position (sector_t) of the most recently dispatched request
instead of tracking a pointer to the next request to dispatch. This
patch simplifies the code for inserting and removing a request from the
red-black tree.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index dbc0feca963e..bf1dfe9fe9c9 100644
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
