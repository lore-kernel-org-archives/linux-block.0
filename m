Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A6E376A12
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192331; cv=none; b=DW7Duq4StTfkE4HehjMZVQlwWstl1ny/Z5QODk7MKodk/FMJYRJLfWHUUMiLhoKRMjosL47S4SwIpmIpmLrc1GZm+8gEIFS7w7JpIlUHrMaqpOrnIKD/CsfIoYIXjeLrTtLA/hFdltVOaZ85bLBcUeYrhqnHRkkqifN5SFtwvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192331; c=relaxed/simple;
	bh=UO1x9W44PS+7u6QqApZLoL5x/udXIK+IMQV98DQf9ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LtBEuiGL0y8lEFAEEo5tExA3Jlejm8aBVVFEkK+ubILbW3qWHnTDjLUMlFLzq2VzmVShIYl8EEQ76rJog3s7iK9W/j1sp8epwjJOtsnaaPHv/b/kC8Vw1Q9S4bkJ8WBuQzG+iuFZslFHVBzjl+B98fwArUbZ9Qdg70XPkB5YgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hQRtb60SczKHMRP
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 10:18:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DC82F40677
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 10:18:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP2 (Coremail) with UTF8SMTPSA id Syh0CgCXAooFZIZq1z7qCw--.40897S5;
	Thu, 20 Aug 2026 10:18:45 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH 1/2] block/mq-deadline: disable I/O priority when prio_aging_expire is zero
Date: Thu, 20 Aug 2026 10:12:45 +0800
Message-Id: <20260820021246.2681624-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820021246.2681624-1-yebin@huaweicloud.com>
References: <20260820021246.2681624-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXAooFZIZq1z7qCw--.40897S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4fAFWUCF45ZFy3tw45trb_yoW3tw43pF
	43Ja1Yyr10qF17W3s7Jr1fZw1Sq393Ary7Jryft3yfKFnaqrn2vF10kF1FqFs3Ar4kCr4a
	qF4vva4kuF1jqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IUbdMa5UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Since the mq-deadline scheduler introduced support for I/O priorities,
if a process does not have an I/O priority configured, it becomes bound
to the process's scheduling priority. This change forces applications to
re-plan their I/O priorities. However, applications do not care about I/O
priorities, yet now they cannot disable priorities.

Setting prio_aging_expire to zero does not actually turn off I/O
priority in mq-deadline. Instead the priority aging path in
dd_dispatch_prio_aged_requests() is invoked with "now - 0 == now",
which causes best-effort and idle requests to be dispatched ahead of
pending real-time requests through the aging path -- a classic
priority inversion, not the "priority disabled" behavior users expect
when writing zero.

Treat a zero prio_aging_expire as an explicit request to disable I/O
priority:

  * dd_insert_request() and dd_request_merge() file every request in
    the DD_BE_PRIO bucket, so the scheduler no longer distinguishes
    between RT, BE and IDLE classes.

  * dd_dispatch_prio_aged_requests() short-circuits when
    prio_aging_expire is zero, closing the aging path that caused the
    inversion.

  * dd_request_merged() and dd_merged_requests() now look up the
    per-priority bucket from rq->elv.priv[0] instead of recomputing it
    from the request ioprio.  Once priority is disabled the request
    ioprio no longer reflects the bucket the request lives in, so the
    old computation would touch the wrong rb-tree and FIFO list.

Switching the mode while I/O is in flight could itself invert
priorities, because requests already queued in the RT or IDLE buckets
would keep being dispatched by priority until they drain.  Follow the
same sequence used by elevator_switch(): when the sysfs store observes
a transition from a non-zero value to zero it freezes the queue (which
blocks new upper-layer I/O in blk_queue_enter() and waits for every
outstanding request to complete, draining the scheduler), quiesces the
queue so that no dispatch is in progress, flips prio_aging_expire to
zero, then unquiesces and unfreezes.  New I/O arriving after the
switch lands in the best-effort bucket.  Writing a non-zero value
re-enables priority without draining.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/mq-deadline.c | 77 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 11 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 824bfc17b2c6..e3314f7aed8b 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -83,6 +83,7 @@ struct deadline_data {
 	 * run time data
 	 */
 
+	struct request_queue *q;	/* associated request queue */
 	struct list_head dispatch;
 	struct dd_per_prio per_prio[DD_PRIO_COUNT];
 
@@ -184,10 +185,7 @@ static void deadline_remove_request(struct request_queue *q,
 static void dd_request_merged(struct request_queue *q, struct request *req,
 			      enum elv_merge type)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(req);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
-	struct dd_per_prio *per_prio = &dd->per_prio[prio];
+	struct dd_per_prio *per_prio = req->elv.priv[0];
 
 	/*
 	 * if the merge was a front merge, we need to reposition request
@@ -205,12 +203,11 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 			       struct request *next)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(next);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	struct dd_per_prio *per_prio = next->elv.priv[0];
 
 	lockdep_assert_held(&dd->lock);
 
-	dd->per_prio[prio].stats.merged++;
+	per_prio->stats.merged++;
 
 	/*
 	 * if next expires before rq, assign its expire time to rq
@@ -227,7 +224,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 	/*
 	 * kill knowledge of next, this one is a goner
 	 */
-	deadline_remove_request(q, &dd->per_prio[prio], next);
+	deadline_remove_request(q, per_prio, next);
 }
 
 /*
@@ -426,6 +423,15 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
 
 	lockdep_assert_held(&dd->lock);
 
+	/*
+	 * A prio_aging_expire of zero disables I/O priority: all requests are
+	 * filed in the DD_BE_PRIO bucket and must never be dispatched ahead of
+	 * higher priority requests through this aging path, which would cause
+	 * priority inversion.
+	 */
+	if (dd->prio_aging_expire == 0)
+		return NULL;
+
 	prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) +
 		   !!dd_queued(dd, DD_IDLE_PRIO);
 	if (prio_cnt < 2)
@@ -536,6 +542,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 		return -ENOMEM;
 
 	eq->elevator_data = dd;
+	dd->q = q;
 
 	INIT_LIST_HEAD(&dd->dispatch);
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
@@ -573,7 +580,8 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const u8 ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	const enum dd_prio prio = dd->prio_aging_expire == 0 ? DD_BE_PRIO :
+					  ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 	sector_t sector = bio_end_sector(bio);
 	struct request *__rq;
@@ -633,7 +641,15 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	lockdep_assert_held(&dd->lock);
 
-	prio = ioprio_class_to_prio[ioprio_class];
+	/*
+	 * When prio_aging_expire is zero, I/O priority is disabled: file every
+	 * request in the best-effort bucket so that the dispatch path no longer
+	 * distinguishes between RT, BE and IDLE classes.
+	 */
+	if (dd->prio_aging_expire == 0)
+		prio = DD_BE_PRIO;
+	else
+		prio = ioprio_class_to_prio[ioprio_class];
 	per_prio = &dd->per_prio[prio];
 	if (!rq->elv.priv[0])
 		per_prio->stats.inserted++;
@@ -773,7 +789,6 @@ static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)
 	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, msecs_to_jiffies)
 STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX);
 STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX);
-STORE_JIFFIES(deadline_prio_aging_expire_store, &dd->prio_aging_expire, 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
 STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
@@ -781,6 +796,46 @@ STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #undef STORE_INT
 #undef STORE_JIFFIES
 
+/*
+ * Writing zero to prio_aging_expire disables I/O priority: all requests are
+ * treated as best-effort. To avoid priority inversion while the mode is being
+ * switched, first drain all in-flight I/O by following the same sequence used
+ * by elevator_switch(): freeze the queue so that new upper-layer I/O is
+ * blocked and all outstanding requests complete, quiesce the queue so that no
+ * dispatch is in progress, then flip prio_aging_expire to zero. New I/O
+ * queued after the switch lands in the best-effort bucket.
+ * Writing a non-zero value (re-)enables priority without draining.
+ */
+static ssize_t deadline_prio_aging_expire_store(struct elevator_queue *e,
+						 const char *page, size_t count)
+{
+	struct deadline_data *dd = e->elevator_data;
+	int val, ret;
+
+	ret = kstrtoint(page, 0, &val);
+	if (ret < 0)
+		return ret;
+	if (val < 0)
+		val = 0;
+	else if (val > INT_MAX)
+		val = INT_MAX;
+	val = msecs_to_jiffies(val);
+
+	if (val == 0 && dd->prio_aging_expire != 0) {
+		unsigned int memflags;
+
+		memflags = blk_mq_freeze_queue(dd->q);
+		blk_mq_quiesce_queue(dd->q);
+		dd->prio_aging_expire = 0;
+		blk_mq_unquiesce_queue(dd->q);
+		blk_mq_unfreeze_queue(dd->q, memflags);
+	} else {
+		dd->prio_aging_expire = val;
+	}
+
+	return count;
+}
+
 #define DD_ATTR(name) \
 	__ATTR(name, 0644, deadline_##name##_show, deadline_##name##_store)
 
-- 
2.34.1

