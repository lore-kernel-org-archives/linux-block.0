Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0135C47082
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD18C613CC
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhE0BD1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 21:03:27 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:43594 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbhE0BD1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 21:03:27 -0400
Received: by mail-pl1-f172.google.com with SMTP id v12so1489699plo.10
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 18:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/9lr2FlM8aPVNr8W5stKehP5sCAwrhh9DM0XcB/Dpj4=;
        b=atiasqZzlSmlHBkTyjSeLxo6f0d3JtZS5r9BZWQQ6h1gmt76MaUqdnzmMHJd7+HHyU
         3mIoubKpbVo0eKrTzP+3U2w/YLZaBCvwxEbbEiwBCl3P8Hc1ODBKTiuBfJ3LQHZNWq37
         NthZh6at5Saoa59fW06i454XvDHtrNXNtdoVQ/h/q7uclIDxwY4VqZBwpzqovxTqa512
         lNIQV2U/j4EpzSjXEmDxO4OiFL+TU1MetB/HRE202KcBIAvXasBt/8NfTkXwWDXSqwUn
         iCZdqpAoUp8CFM9LMJbjJG9yUdpBajf3smdWkCkU+9dVY4WigpyXt6+ySpOkQaGF1nMO
         RtSA==
X-Gm-Message-State: AOAM5331VS5zUHHbhUN7visyuntDTvKP90ACjin4fSAdFjaqLG8HCQz+
        Bp/4iD9ozjpsqqSJQPn9r9Y=
X-Google-Smtp-Source: ABdhPJy1dXqu6+8aniIUpGofx4tJknaZ/a5UT7JWbpeKof3OAafdfLV/u1MzJWAYi4bj7oKA2OcbXw==
X-Received: by 2002:a17:90a:3041:: with SMTP id q1mr6693684pjl.191.1622077313874;
        Wed, 26 May 2021 18:01:53 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j22sm310707pfd.215.2021.05.26.18.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 18:01:53 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/9] block/mq-deadline: Improve compile-time argument checking
Date:   Wed, 26 May 2021 18:01:30 -0700
Message-Id: <20210527010134.32448-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527010134.32448-1-bvanassche@acm.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Modern compilers complain if an out-of-range value is passed to a function
argument that has an enumeration type. Let the compiler detect out-of-range
data direction arguments instead of verifying the data_dir argument at
runtime.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 96 +++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 47 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index c4f51e7884fb..dfbc6b77fa71 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -35,6 +35,13 @@ static const int writes_starved = 2;    /* max times reads can starve a write */
 static const int fifo_batch = 16;       /* # of sequential requests treated as one
 				     by the above parameters. For throughput. */
 
+enum dd_data_dir {
+	DD_READ		= READ,
+	DD_WRITE	= WRITE,
+} __packed;
+
+enum { DD_DIR_COUNT = 2 };
+
 struct deadline_data {
 	/*
 	 * run time data
@@ -43,20 +50,20 @@ struct deadline_data {
 	/*
 	 * requests (deadline_rq s) are present on both sort_list and fifo_list
 	 */
-	struct rb_root sort_list[2];
-	struct list_head fifo_list[2];
+	struct rb_root sort_list[DD_DIR_COUNT];
+	struct list_head fifo_list[DD_DIR_COUNT];
 
 	/*
 	 * next in sort order. read, write or both are NULL
 	 */
-	struct request *next_rq[2];
+	struct request *next_rq[DD_DIR_COUNT];
 	unsigned int batching;		/* number of sequential requests made */
 	unsigned int starved;		/* times reads have starved writes */
 
 	/*
 	 * settings that change how the i/o scheduler behaves
 	 */
-	int fifo_expire[2];
+	int fifo_expire[DD_DIR_COUNT];
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
@@ -97,7 +104,7 @@ deadline_add_rq_rb(struct deadline_data *dd, struct request *rq)
 static inline void
 deadline_del_rq_rb(struct deadline_data *dd, struct request *rq)
 {
-	const int data_dir = rq_data_dir(rq);
+	const enum dd_data_dir data_dir = rq_data_dir(rq);
 
 	if (dd->next_rq[data_dir] == rq)
 		dd->next_rq[data_dir] = deadline_latter_request(rq);
@@ -169,10 +176,10 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 static void
 deadline_move_request(struct deadline_data *dd, struct request *rq)
 {
-	const int data_dir = rq_data_dir(rq);
+	const enum dd_data_dir data_dir = rq_data_dir(rq);
 
-	dd->next_rq[READ] = NULL;
-	dd->next_rq[WRITE] = NULL;
+	dd->next_rq[DD_READ] = NULL;
+	dd->next_rq[DD_WRITE] = NULL;
 	dd->next_rq[data_dir] = deadline_latter_request(rq);
 
 	/*
@@ -185,9 +192,10 @@ deadline_move_request(struct deadline_data *dd, struct request *rq)
  * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
  * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
  */
-static inline int deadline_check_fifo(struct deadline_data *dd, int ddir)
+static inline int deadline_check_fifo(struct deadline_data *dd,
+				      enum dd_data_dir data_dir)
 {
-	struct request *rq = rq_entry_fifo(dd->fifo_list[ddir].next);
+	struct request *rq = rq_entry_fifo(dd->fifo_list[data_dir].next);
 
 	/*
 	 * rq is expired!
@@ -203,19 +211,16 @@ static inline int deadline_check_fifo(struct deadline_data *dd, int ddir)
  * dispatch using arrival ordered lists.
  */
 static struct request *
-deadline_fifo_request(struct deadline_data *dd, int data_dir)
+deadline_fifo_request(struct deadline_data *dd, enum dd_data_dir data_dir)
 {
 	struct request *rq;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(data_dir != READ && data_dir != WRITE))
-		return NULL;
-
 	if (list_empty(&dd->fifo_list[data_dir]))
 		return NULL;
 
 	rq = rq_entry_fifo(dd->fifo_list[data_dir].next);
-	if (data_dir == READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
 		return rq;
 
 	/*
@@ -223,7 +228,7 @@ deadline_fifo_request(struct deadline_data *dd, int data_dir)
 	 * an unlocked target zone.
 	 */
 	spin_lock_irqsave(&dd->zone_lock, flags);
-	list_for_each_entry(rq, &dd->fifo_list[WRITE], queuelist) {
+	list_for_each_entry(rq, &dd->fifo_list[DD_WRITE], queuelist) {
 		if (blk_req_can_dispatch_to_zone(rq))
 			goto out;
 	}
@@ -239,19 +244,16 @@ deadline_fifo_request(struct deadline_data *dd, int data_dir)
  * dispatch using sector position sorted lists.
  */
 static struct request *
-deadline_next_request(struct deadline_data *dd, int data_dir)
+deadline_next_request(struct deadline_data *dd, enum dd_data_dir data_dir)
 {
 	struct request *rq;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(data_dir != READ && data_dir != WRITE))
-		return NULL;
-
 	rq = dd->next_rq[data_dir];
 	if (!rq)
 		return NULL;
 
-	if (data_dir == READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
 		return rq;
 
 	/*
@@ -276,7 +278,7 @@ deadline_next_request(struct deadline_data *dd, int data_dir)
 static struct request *__dd_dispatch_request(struct deadline_data *dd)
 {
 	struct request *rq, *next_rq;
-	int data_dir;
+	enum dd_data_dir data_dir;
 
 	lockdep_assert_held(&dd->lock);
 
@@ -289,9 +291,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	/*
 	 * batches are currently reads XOR writes
 	 */
-	rq = deadline_next_request(dd, WRITE);
+	rq = deadline_next_request(dd, DD_WRITE);
 	if (!rq)
-		rq = deadline_next_request(dd, READ);
+		rq = deadline_next_request(dd, DD_READ);
 
 	if (rq && dd->batching < dd->fifo_batch)
 		/* we have a next request are still entitled to batch */
@@ -302,14 +304,14 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	 * data direction (read / write)
 	 */
 
-	if (!list_empty(&dd->fifo_list[READ])) {
-		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[READ]));
+	if (!list_empty(&dd->fifo_list[DD_READ])) {
+		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_READ]));
 
-		if (deadline_fifo_request(dd, WRITE) &&
+		if (deadline_fifo_request(dd, DD_WRITE) &&
 		    (dd->starved++ >= dd->writes_starved))
 			goto dispatch_writes;
 
-		data_dir = READ;
+		data_dir = DD_READ;
 
 		goto dispatch_find_request;
 	}
@@ -318,13 +320,13 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	 * there are either no reads or writes have been starved
 	 */
 
-	if (!list_empty(&dd->fifo_list[WRITE])) {
+	if (!list_empty(&dd->fifo_list[DD_WRITE])) {
 dispatch_writes:
-		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[WRITE]));
+		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_WRITE]));
 
 		dd->starved = 0;
 
-		data_dir = WRITE;
+		data_dir = DD_WRITE;
 
 		goto dispatch_find_request;
 	}
@@ -399,8 +401,8 @@ static void dd_exit_sched(struct elevator_queue *e)
 {
 	struct deadline_data *dd = e->elevator_data;
 
-	BUG_ON(!list_empty(&dd->fifo_list[READ]));
-	BUG_ON(!list_empty(&dd->fifo_list[WRITE]));
+	BUG_ON(!list_empty(&dd->fifo_list[DD_READ]));
+	BUG_ON(!list_empty(&dd->fifo_list[DD_WRITE]));
 
 	kfree(dd);
 }
@@ -424,12 +426,12 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	}
 	eq->elevator_data = dd;
 
-	INIT_LIST_HEAD(&dd->fifo_list[READ]);
-	INIT_LIST_HEAD(&dd->fifo_list[WRITE]);
-	dd->sort_list[READ] = RB_ROOT;
-	dd->sort_list[WRITE] = RB_ROOT;
-	dd->fifo_expire[READ] = read_expire;
-	dd->fifo_expire[WRITE] = write_expire;
+	INIT_LIST_HEAD(&dd->fifo_list[DD_READ]);
+	INIT_LIST_HEAD(&dd->fifo_list[DD_WRITE]);
+	dd->sort_list[DD_READ] = RB_ROOT;
+	dd->sort_list[DD_WRITE] = RB_ROOT;
+	dd->fifo_expire[DD_READ] = read_expire;
+	dd->fifo_expire[DD_WRITE] = write_expire;
 	dd->writes_starved = writes_starved;
 	dd->front_merges = 1;
 	dd->fifo_batch = fifo_batch;
@@ -497,7 +499,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 {
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const int data_dir = rq_data_dir(rq);
+	const enum dd_data_dir data_dir = rq_data_dir(rq);
 
 	lockdep_assert_held(&dd->lock);
 
@@ -585,7 +587,7 @@ static void dd_finish_request(struct request *rq)
 
 		spin_lock_irqsave(&dd->zone_lock, flags);
 		blk_req_zone_write_unlock(rq);
-		if (!list_empty(&dd->fifo_list[WRITE]))
+		if (!list_empty(&dd->fifo_list[DD_WRITE]))
 			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
 		spin_unlock_irqrestore(&dd->zone_lock, flags);
 	}
@@ -626,8 +628,8 @@ static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
 		__data = jiffies_to_msecs(__data);			\
 	return deadline_var_show(__data, (page));			\
 }
-SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[READ], 1);
-SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[WRITE], 1);
+SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[DD_READ], 1);
+SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[DD_WRITE], 1);
 SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);
 SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);
 SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);
@@ -649,8 +651,8 @@ static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)
 		*(__PTR) = __data;					\
 	return count;							\
 }
-STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[READ], 0, INT_MAX, 1);
-STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[WRITE], 0, INT_MAX, 1);
+STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX, 1);
+STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX, 1);
 STORE_FUNCTION(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX, 0);
 STORE_FUNCTION(deadline_front_merges_store, &dd->front_merges, 0, 1, 0);
 STORE_FUNCTION(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX, 0);
@@ -717,8 +719,8 @@ static int deadline_##name##_next_rq_show(void *data,			\
 		__blk_mq_debugfs_rq_show(m, rq);			\
 	return 0;							\
 }
-DEADLINE_DEBUGFS_DDIR_ATTRS(READ, read)
-DEADLINE_DEBUGFS_DDIR_ATTRS(WRITE, write)
+DEADLINE_DEBUGFS_DDIR_ATTRS(DD_READ, read)
+DEADLINE_DEBUGFS_DDIR_ATTRS(DD_WRITE, write)
 #undef DEADLINE_DEBUGFS_DDIR_ATTRS
 
 static int deadline_batching_show(void *data, struct seq_file *m)
