Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA21FC4708B
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4CB613CC
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhE0BDd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 21:03:33 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:50931 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhE0BDc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 21:03:32 -0400
Received: by mail-pj1-f43.google.com with SMTP id t11so1797724pjm.0
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 18:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XnxiebgqyAoC7h8USczT5VXqx4IzpNayB9gs9NtLVgA=;
        b=pUthFMOyufepHcV1cGUkllEvCjjcYJU774afPxebVGm6Oq1VR+1KN27C34uJknCprB
         LnAgE7kdLtd/A9NaEdH9ETDPr+5jDhlOL1VnMmcANxsB7+SF+hM3veEw3JiL4EFYgkRT
         KyXCxgQ7tMq5Al5YfOhRiQpBpHXGmKEktKiBWoOURucOJp4gLIWHcRhXjK/VmsezXTKq
         2X9o6qfDCDWGNTpRlEhrl5c5W8Vtg8x16hF1ByNgfFqXywnGR52Sw8uFWY5Q7d05LGJG
         EHjAeZfoCGMWPNUDYnW8DdueQksofTqFgrRxYyWjzyv6TSBY/M/OlscG7PQpiEF4iFP4
         PD/g==
X-Gm-Message-State: AOAM533fUTnqH7JsxO/upwygD2TOQnp0fPsLnh+b71imSJBKyF8FST6M
        uKyITM+zmzoSw8baChveZoQ=
X-Google-Smtp-Source: ABdhPJxqa5MD/ZAZzUWczTewm1KMAAui6FgTyIwMCE0BRhZ5Kz/2dn/BybGh6wn2lntKb3YAO7qkaA==
X-Received: by 2002:a17:902:8ec4:b029:fb:33ad:e86f with SMTP id x4-20020a1709028ec4b02900fb33ade86fmr969761plo.4.1622077319009;
        Wed, 26 May 2021 18:01:59 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j22sm310707pfd.215.2021.05.26.18.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 18:01:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 8/9] block/mq-deadline: Add I/O priority support
Date:   Wed, 26 May 2021 18:01:33 -0700
Message-Id: <20210527010134.32448-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527010134.32448-1-bvanassche@acm.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Maintain one FIFO list per I/O priority: RT, BE and IDLE. Only dispatch
requests for a lower priority after all higher priority requests have
finished. Maintain statistics for each priority level. Split the debugfs
attributes per priority level as follows:

$ ls /sys/kernel/debug/block/.../sched/
async_depth  dispatch2        read_next_rq      write2_fifo_list
batching     read0_fifo_list  starved           write_next_rq
dispatch0    read1_fifo_list  write0_fifo_list
dispatch1    read2_fifo_list  write1_fifo_list

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 293 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 223 insertions(+), 70 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 81f487d77e09..5a703e1228fa 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -44,16 +44,27 @@ enum dd_data_dir {
 
 enum { DD_DIR_COUNT = 2 };
 
+enum dd_prio {
+	DD_RT_PRIO	= 0,
+	DD_BE_PRIO	= 1,
+	DD_IDLE_PRIO	= 2,
+	DD_PRIO_MAX	= 2,
+} __packed;
+
+enum { DD_PRIO_COUNT = 3 };
+
 struct deadline_data {
 	/*
 	 * run time data
 	 */
 
 	/*
-	 * requests (deadline_rq s) are present on both sort_list and fifo_list
+	 * Requests are present on both sort_list[] and fifo_list[][]. The
+	 * first index of fifo_list[][] is the I/O priority class (DD_*_PRIO).
+	 * The second index is the data direction (rq_data_dir(rq)).
 	 */
 	struct rb_root sort_list[DD_DIR_COUNT];
-	struct list_head fifo_list[DD_DIR_COUNT];
+	struct list_head fifo_list[DD_PRIO_COUNT][DD_DIR_COUNT];
 
 	/*
 	 * next in sort order. read, write or both are NULL
@@ -62,6 +73,12 @@ struct deadline_data {
 	unsigned int batching;		/* number of sequential requests made */
 	unsigned int starved;		/* times reads have starved writes */
 
+	/* statistics */
+	atomic_t inserted[DD_PRIO_COUNT];
+	atomic_t dispatched[DD_PRIO_COUNT];
+	atomic_t merged[DD_PRIO_COUNT];
+	atomic_t completed[DD_PRIO_COUNT];
+
 	/*
 	 * settings that change how the i/o scheduler behaves
 	 */
@@ -73,7 +90,15 @@ struct deadline_data {
 
 	spinlock_t lock;
 	spinlock_t zone_lock;
-	struct list_head dispatch;
+	struct list_head dispatch[DD_PRIO_COUNT];
+};
+
+/* Maps an I/O priority class to a deadline scheduler priority. */
+static const enum dd_prio ioprio_class_to_prio[] = {
+	[IOPRIO_CLASS_NONE]	= DD_BE_PRIO,
+	[IOPRIO_CLASS_RT]	= DD_RT_PRIO,
+	[IOPRIO_CLASS_BE]	= DD_BE_PRIO,
+	[IOPRIO_CLASS_IDLE]	= DD_IDLE_PRIO,
 };
 
 static inline struct rb_root *
@@ -149,12 +174,28 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
 	}
 }
 
+/* Returns the I/O class that has been assigned by dd_insert_request(). */
+static u8 dd_rq_ioclass(struct request *rq)
+{
+	return (uintptr_t)rq->elv.priv[1];
+}
+
 /*
  * Callback function that is invoked after @next has been merged into @req.
  */
 static void dd_merged_requests(struct request_queue *q, struct request *req,
 			       struct request *next)
 {
+	struct deadline_data *dd = q->elevator->elevator_data;
+	const u8 ioprio_class = dd_rq_ioclass(next);
+	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+
+	if (next->elv.priv[0]) {
+		atomic_inc(&dd->merged[prio]);
+	} else {
+		WARN_ON_ONCE(true);
+	}
+
 	/*
 	 * if next expires before rq, assign its expire time to rq
 	 * and move into next position (next will be deleted) in fifo
@@ -191,14 +232,22 @@ deadline_move_request(struct deadline_data *dd, struct request *rq)
 	deadline_remove_request(rq->q, rq);
 }
 
+/* Number of requests queued for a given priority level. */
+static u64 dd_queued(struct deadline_data *dd, enum dd_prio prio)
+{
+	return atomic_read(&dd->inserted[prio]) -
+		atomic_read(&dd->completed[prio]);
+}
+
 /*
  * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
  * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
  */
 static inline int deadline_check_fifo(struct deadline_data *dd,
+				      enum dd_prio prio,
 				      enum dd_data_dir data_dir)
 {
-	struct request *rq = rq_entry_fifo(dd->fifo_list[data_dir].next);
+	struct request *rq = rq_entry_fifo(dd->fifo_list[prio][data_dir].next);
 
 	/*
 	 * rq is expired!
@@ -214,15 +263,16 @@ static inline int deadline_check_fifo(struct deadline_data *dd,
  * dispatch using arrival ordered lists.
  */
 static struct request *
-deadline_fifo_request(struct deadline_data *dd, enum dd_data_dir data_dir)
+deadline_fifo_request(struct deadline_data *dd, enum dd_prio prio,
+		      enum dd_data_dir data_dir)
 {
 	struct request *rq;
 	unsigned long flags;
 
-	if (list_empty(&dd->fifo_list[data_dir]))
+	if (list_empty(&dd->fifo_list[prio][data_dir]))
 		return NULL;
 
-	rq = rq_entry_fifo(dd->fifo_list[data_dir].next);
+	rq = rq_entry_fifo(dd->fifo_list[prio][data_dir].next);
 	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
 		return rq;
 
@@ -231,7 +281,7 @@ deadline_fifo_request(struct deadline_data *dd, enum dd_data_dir data_dir)
 	 * an unlocked target zone.
 	 */
 	spin_lock_irqsave(&dd->zone_lock, flags);
-	list_for_each_entry(rq, &dd->fifo_list[DD_WRITE], queuelist) {
+	list_for_each_entry(rq, &dd->fifo_list[prio][DD_WRITE], queuelist) {
 		if (blk_req_can_dispatch_to_zone(rq))
 			goto out;
 	}
@@ -247,7 +297,8 @@ deadline_fifo_request(struct deadline_data *dd, enum dd_data_dir data_dir)
  * dispatch using sector position sorted lists.
  */
 static struct request *
-deadline_next_request(struct deadline_data *dd, enum dd_data_dir data_dir)
+deadline_next_request(struct deadline_data *dd, enum dd_prio prio,
+		      enum dd_data_dir data_dir)
 {
 	struct request *rq;
 	unsigned long flags;
@@ -278,15 +329,18 @@ deadline_next_request(struct deadline_data *dd, enum dd_data_dir data_dir)
  * deadline_dispatch_requests selects the best request according to
  * read/write expire, fifo_batch, etc
  */
-static struct request *__dd_dispatch_request(struct deadline_data *dd)
+static struct request *__dd_dispatch_request(struct deadline_data *dd,
+					     enum dd_prio prio)
 {
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
+	u8 ioprio_class;
 
 	lockdep_assert_held(&dd->lock);
 
-	if (!list_empty(&dd->dispatch)) {
-		rq = list_first_entry(&dd->dispatch, struct request, queuelist);
+	if (!list_empty(&dd->dispatch[prio])) {
+		rq = list_first_entry(&dd->dispatch[prio], struct request,
+				      queuelist);
 		list_del_init(&rq->queuelist);
 		goto done;
 	}
@@ -294,9 +348,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	/*
 	 * batches are currently reads XOR writes
 	 */
-	rq = deadline_next_request(dd, DD_WRITE);
+	rq = deadline_next_request(dd, prio, DD_WRITE);
 	if (!rq)
-		rq = deadline_next_request(dd, DD_READ);
+		rq = deadline_next_request(dd, prio, DD_READ);
 
 	if (rq && dd->batching < dd->fifo_batch)
 		/* we have a next request are still entitled to batch */
@@ -307,10 +361,10 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	 * data direction (read / write)
 	 */
 
-	if (!list_empty(&dd->fifo_list[DD_READ])) {
+	if (!list_empty(&dd->fifo_list[prio][DD_READ])) {
 		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_READ]));
 
-		if (deadline_fifo_request(dd, DD_WRITE) &&
+		if (deadline_fifo_request(dd, prio, DD_WRITE) &&
 		    (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
@@ -323,7 +377,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	 * there are either no reads or writes have been starved
 	 */
 
-	if (!list_empty(&dd->fifo_list[DD_WRITE])) {
+	if (!list_empty(&dd->fifo_list[prio][DD_WRITE])) {
 dispatch_writes:
 		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_WRITE]));
 
@@ -340,14 +394,14 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	/*
 	 * we are not running a batch, find best request for selected data_dir
 	 */
-	next_rq = deadline_next_request(dd, data_dir);
-	if (deadline_check_fifo(dd, data_dir) || !next_rq) {
+	next_rq = deadline_next_request(dd, prio, data_dir);
+	if (deadline_check_fifo(dd, prio, data_dir) || !next_rq) {
 		/*
 		 * A deadline has expired, the last request was in the other
 		 * direction, or we have run out of higher-sectored requests.
 		 * Start again from the request with the earliest expiry time.
 		 */
-		rq = deadline_fifo_request(dd, data_dir);
+		rq = deadline_fifo_request(dd, prio, data_dir);
 	} else {
 		/*
 		 * The last req was the same dir and we have a next request in
@@ -372,6 +426,13 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	dd->batching++;
 	deadline_move_request(dd, rq);
 done:
+	ioprio_class = dd_rq_ioclass(rq);
+	prio = ioprio_class_to_prio[ioprio_class];
+	if (rq->elv.priv[0]) {
+		atomic_inc(&dd->dispatched[prio]);
+	} else {
+		WARN_ON_ONCE(true);
+	}
 	/*
 	 * If the request needs its target zone locked, do it.
 	 */
@@ -392,9 +453,14 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
 	struct request *rq;
+	enum dd_prio prio;
 
 	spin_lock(&dd->lock);
-	rq = __dd_dispatch_request(dd);
+	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+		rq = __dd_dispatch_request(dd, prio);
+		if (rq || dd_queued(dd, prio))
+			break;
+	}
 	spin_unlock(&dd->lock);
 
 	return rq;
@@ -435,9 +501,12 @@ static int dd_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 static void dd_exit_sched(struct elevator_queue *e)
 {
 	struct deadline_data *dd = e->elevator_data;
+	enum dd_prio prio;
 
-	BUG_ON(!list_empty(&dd->fifo_list[DD_READ]));
-	BUG_ON(!list_empty(&dd->fifo_list[DD_WRITE]));
+	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_READ]));
+		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_WRITE]));
+	}
 
 	kfree(dd);
 }
@@ -449,6 +518,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 {
 	struct deadline_data *dd;
 	struct elevator_queue *eq;
+	enum dd_prio prio;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -461,8 +531,11 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	}
 	eq->elevator_data = dd;
 
-	INIT_LIST_HEAD(&dd->fifo_list[DD_READ]);
-	INIT_LIST_HEAD(&dd->fifo_list[DD_WRITE]);
+	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_READ]);
+		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_WRITE]);
+		INIT_LIST_HEAD(&dd->dispatch[prio]);
+	}
 	dd->sort_list[DD_READ] = RB_ROOT;
 	dd->sort_list[DD_WRITE] = RB_ROOT;
 	dd->fifo_expire[DD_READ] = blk_queue_nonrot(q) ? read_expire_nonrot :
@@ -473,7 +546,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	dd->fifo_batch = fifo_batch;
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
-	INIT_LIST_HEAD(&dd->dispatch);
 
 	q->elevator = eq;
 	return 0;
@@ -536,6 +608,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const enum dd_data_dir data_dir = rq_data_dir(rq);
+	u16 ioprio = req_get_ioprio(rq);
+	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
+	enum dd_prio prio;
 
 	lockdep_assert_held(&dd->lock);
 
@@ -545,13 +620,19 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 */
 	blk_req_zone_write_unlock(rq);
 
+	prio = ioprio_class_to_prio[ioprio_class];
+	atomic_inc(&dd->inserted[prio]);
+	WARN_ON_ONCE(rq->elv.priv[0]);
+	rq->elv.priv[0] = (void *)1ULL;
+	rq->elv.priv[1] = (void *)(uintptr_t)ioprio_class;
+
 	if (blk_mq_sched_try_insert_merge(q, rq))
 		return;
 
 	trace_block_rq_insert(rq);
 
 	if (at_head) {
-		list_add(&rq->queuelist, &dd->dispatch);
+		list_add(&rq->queuelist, &dd->dispatch[prio]);
 	} else {
 		deadline_add_rq_rb(dd, rq);
 
@@ -565,7 +646,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		 * set expire time and add to fifo list
 		 */
 		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
-		list_add_tail(&rq->queuelist, &dd->fifo_list[data_dir]);
+		list_add_tail(&rq->queuelist, &dd->fifo_list[prio][data_dir]);
 	}
 }
 
@@ -589,12 +670,10 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 	spin_unlock(&dd->lock);
 }
 
-/*
- * Nothing to do here. This is defined only to ensure that .finish_request
- * method is called upon request completion.
- */
+/* Callback function called from inside blk_mq_rq_ctx_init(). */
 static void dd_prepare_request(struct request *rq)
 {
+	rq->elv.priv[0] = NULL;
 }
 
 /*
@@ -616,26 +695,41 @@ static void dd_prepare_request(struct request *rq)
 static void dd_finish_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
+	struct deadline_data *dd = q->elevator->elevator_data;
+	const u8 ioprio_class = dd_rq_ioclass(rq);
+	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+
+	if (rq->elv.priv[0])
+		atomic_inc(&dd->completed[prio]);
 
 	if (blk_queue_is_zoned(q)) {
-		struct deadline_data *dd = q->elevator->elevator_data;
 		unsigned long flags;
 
 		spin_lock_irqsave(&dd->zone_lock, flags);
 		blk_req_zone_write_unlock(rq);
-		if (!list_empty(&dd->fifo_list[DD_WRITE]))
+		if (!list_empty(&dd->fifo_list[prio][DD_WRITE]))
 			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
 		spin_unlock_irqrestore(&dd->zone_lock, flags);
 	}
 }
 
+static bool dd_has_work_for_prio(struct deadline_data *dd, enum dd_prio prio)
+{
+	return !list_empty_careful(&dd->dispatch[prio]) ||
+		!list_empty_careful(&dd->fifo_list[prio][DD_READ]) ||
+		!list_empty_careful(&dd->fifo_list[prio][DD_WRITE]);
+}
+
 static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
 {
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
+	enum dd_prio prio;
+
+	for (prio = 0; prio <= DD_PRIO_MAX; prio++)
+		if (dd_has_work_for_prio(dd, prio))
+			return true;
 
-	return !list_empty_careful(&dd->dispatch) ||
-		!list_empty_careful(&dd->fifo_list[0]) ||
-		!list_empty_careful(&dd->fifo_list[1]);
+	return false;
 }
 
 /*
@@ -707,7 +801,7 @@ static struct elv_fs_entry deadline_attrs[] = {
 };
 
 #ifdef CONFIG_BLK_DEBUG_FS
-#define DEADLINE_DEBUGFS_DDIR_ATTRS(ddir, name)				\
+#define DEADLINE_DEBUGFS_DDIR_ATTRS(prio, data_dir, name)		\
 static void *deadline_##name##_fifo_start(struct seq_file *m,		\
 					  loff_t *pos)			\
 	__acquires(&dd->lock)						\
@@ -716,7 +810,7 @@ static void *deadline_##name##_fifo_start(struct seq_file *m,		\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
 									\
 	spin_lock(&dd->lock);						\
-	return seq_list_start(&dd->fifo_list[ddir], *pos);		\
+	return seq_list_start(&dd->fifo_list[prio][data_dir], *pos);	\
 }									\
 									\
 static void *deadline_##name##_fifo_next(struct seq_file *m, void *v,	\
@@ -725,7 +819,7 @@ static void *deadline_##name##_fifo_next(struct seq_file *m, void *v,	\
 	struct request_queue *q = m->private;				\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
 									\
-	return seq_list_next(v, &dd->fifo_list[ddir], pos);		\
+	return seq_list_next(v, &dd->fifo_list[prio][data_dir], pos);	\
 }									\
 									\
 static void deadline_##name##_fifo_stop(struct seq_file *m, void *v)	\
@@ -742,22 +836,31 @@ static const struct seq_operations deadline_##name##_fifo_seq_ops = {	\
 	.next	= deadline_##name##_fifo_next,				\
 	.stop	= deadline_##name##_fifo_stop,				\
 	.show	= blk_mq_debugfs_rq_show,				\
-};									\
-									\
+};
+
+#define DEADLINE_DEBUGFS_NEXT_RQ(data_dir, name)			\
 static int deadline_##name##_next_rq_show(void *data,			\
 					  struct seq_file *m)		\
 {									\
 	struct request_queue *q = data;					\
 	struct deadline_data *dd = q->elevator->elevator_data;		\
-	struct request *rq = dd->next_rq[ddir];				\
+	struct request *rq = dd->next_rq[data_dir];			\
 									\
 	if (rq)								\
 		__blk_mq_debugfs_rq_show(m, rq);			\
 	return 0;							\
 }
-DEADLINE_DEBUGFS_DDIR_ATTRS(DD_READ, read)
-DEADLINE_DEBUGFS_DDIR_ATTRS(DD_WRITE, write)
+
+DEADLINE_DEBUGFS_DDIR_ATTRS(DD_RT_PRIO, DD_READ, read0)
+DEADLINE_DEBUGFS_DDIR_ATTRS(DD_RT_PRIO, DD_WRITE, write0)
+DEADLINE_DEBUGFS_DDIR_ATTRS(DD_BE_PRIO, DD_READ, read1)
+DEADLINE_DEBUGFS_DDIR_ATTRS(DD_BE_PRIO, DD_WRITE, write1)
+DEADLINE_DEBUGFS_DDIR_ATTRS(DD_IDLE_PRIO, DD_READ, read2)
+DEADLINE_DEBUGFS_DDIR_ATTRS(DD_IDLE_PRIO, DD_WRITE, write2)
+DEADLINE_DEBUGFS_NEXT_RQ(DD_READ, read)
+DEADLINE_DEBUGFS_NEXT_RQ(DD_WRITE, write)
 #undef DEADLINE_DEBUGFS_DDIR_ATTRS
+#undef DEADLINE_DEBUGFS_NEXT_RQ
 
 static int deadline_batching_show(void *data, struct seq_file *m)
 {
@@ -786,50 +889,100 @@ static int dd_async_depth_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)
-	__acquires(&dd->lock)
+static int dd_queued_show(void *data, struct seq_file *m)
 {
-	struct request_queue *q = m->private;
+	struct request_queue *q = data;
 	struct deadline_data *dd = q->elevator->elevator_data;
 
-	spin_lock(&dd->lock);
-	return seq_list_start(&dd->dispatch, *pos);
+	seq_printf(m, "%llu %llu %llu\n", dd_queued(dd, DD_RT_PRIO),
+		   dd_queued(dd, DD_BE_PRIO),
+		   dd_queued(dd, DD_IDLE_PRIO));
+	return 0;
 }
 
-static void *deadline_dispatch_next(struct seq_file *m, void *v, loff_t *pos)
+/* Number of requests owned by the block driver for a given priority. */
+static u64 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio prio)
 {
-	struct request_queue *q = m->private;
-	struct deadline_data *dd = q->elevator->elevator_data;
-
-	return seq_list_next(v, &dd->dispatch, pos);
+	return atomic_read(&dd->dispatched[prio]) +
+		atomic_read(&dd->merged[prio]) -
+		atomic_read(&dd->completed[prio]);
 }
 
-static void deadline_dispatch_stop(struct seq_file *m, void *v)
-	__releases(&dd->lock)
+static int dd_owned_by_driver_show(void *data, struct seq_file *m)
 {
-	struct request_queue *q = m->private;
+	struct request_queue *q = data;
 	struct deadline_data *dd = q->elevator->elevator_data;
 
-	spin_unlock(&dd->lock);
+	seq_printf(m, "%llu %llu %llu\n", dd_owned_by_driver(dd, DD_RT_PRIO),
+		   dd_owned_by_driver(dd, DD_BE_PRIO),
+		   dd_owned_by_driver(dd, DD_IDLE_PRIO));
+	return 0;
 }
 
-static const struct seq_operations deadline_dispatch_seq_ops = {
-	.start	= deadline_dispatch_start,
-	.next	= deadline_dispatch_next,
-	.stop	= deadline_dispatch_stop,
-	.show	= blk_mq_debugfs_rq_show,
+#define DEADLINE_DISPATCH_ATTR(prio)					\
+static void *deadline_dispatch##prio##_start(struct seq_file *m,	\
+					     loff_t *pos)		\
+	__acquires(&dd->lock)						\
+{									\
+	struct request_queue *q = m->private;				\
+	struct deadline_data *dd = q->elevator->elevator_data;		\
+									\
+	spin_lock(&dd->lock);						\
+	return seq_list_start(&dd->dispatch[prio], *pos);		\
+}									\
+									\
+static void *deadline_dispatch##prio##_next(struct seq_file *m,		\
+					    void *v, loff_t *pos)	\
+{									\
+	struct request_queue *q = m->private;				\
+	struct deadline_data *dd = q->elevator->elevator_data;		\
+									\
+	return seq_list_next(v, &dd->dispatch[prio], pos);		\
+}									\
+									\
+static void deadline_dispatch##prio##_stop(struct seq_file *m, void *v)	\
+	__releases(&dd->lock)						\
+{									\
+	struct request_queue *q = m->private;				\
+	struct deadline_data *dd = q->elevator->elevator_data;		\
+									\
+	spin_unlock(&dd->lock);						\
+}									\
+									\
+static const struct seq_operations deadline_dispatch##prio##_seq_ops = { \
+	.start	= deadline_dispatch##prio##_start,			\
+	.next	= deadline_dispatch##prio##_next,			\
+	.stop	= deadline_dispatch##prio##_stop,			\
+	.show	= blk_mq_debugfs_rq_show,				\
 };
 
-#define DEADLINE_QUEUE_DDIR_ATTRS(name)						\
-	{#name "_fifo_list", 0400, .seq_ops = &deadline_##name##_fifo_seq_ops},	\
+DEADLINE_DISPATCH_ATTR(0);
+DEADLINE_DISPATCH_ATTR(1);
+DEADLINE_DISPATCH_ATTR(2);
+#undef DEADLINE_DISPATCH_ATTR
+
+#define DEADLINE_QUEUE_DDIR_ATTRS(name)					\
+	{#name "_fifo_list", 0400,					\
+			.seq_ops = &deadline_##name##_fifo_seq_ops}
+#define DEADLINE_NEXT_RQ_ATTR(name)					\
 	{#name "_next_rq", 0400, deadline_##name##_next_rq_show}
 static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
-	DEADLINE_QUEUE_DDIR_ATTRS(read),
-	DEADLINE_QUEUE_DDIR_ATTRS(write),
+	DEADLINE_QUEUE_DDIR_ATTRS(read0),
+	DEADLINE_QUEUE_DDIR_ATTRS(write0),
+	DEADLINE_QUEUE_DDIR_ATTRS(read1),
+	DEADLINE_QUEUE_DDIR_ATTRS(write1),
+	DEADLINE_QUEUE_DDIR_ATTRS(read2),
+	DEADLINE_QUEUE_DDIR_ATTRS(write2),
+	DEADLINE_NEXT_RQ_ATTR(read),
+	DEADLINE_NEXT_RQ_ATTR(write),
 	{"batching", 0400, deadline_batching_show},
 	{"starved", 0400, deadline_starved_show},
 	{"async_depth", 0400, dd_async_depth_show},
-	{"dispatch", 0400, .seq_ops = &deadline_dispatch_seq_ops},
+	{"dispatch0", 0400, .seq_ops = &deadline_dispatch0_seq_ops},
+	{"dispatch1", 0400, .seq_ops = &deadline_dispatch1_seq_ops},
+	{"dispatch2", 0400, .seq_ops = &deadline_dispatch2_seq_ops},
+	{"owned_by_driver", 0400, dd_owned_by_driver_show},
+	{"queued", 0400, dd_queued_show},
 	{},
 };
 #undef DEADLINE_QUEUE_DDIR_ATTRS
@@ -879,6 +1032,6 @@ static void __exit deadline_exit(void)
 module_init(deadline_init);
 module_exit(deadline_exit);
 
-MODULE_AUTHOR("Jens Axboe");
+MODULE_AUTHOR("Jens Axboe, Damien Le Moal and Bart Van Assche");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MQ deadline IO scheduler");
