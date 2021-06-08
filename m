Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAF3C4743F
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1767261361
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhFHXJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:09:33 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:43964 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhFHXJc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 19:09:32 -0400
Received: by mail-pj1-f42.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso244454pjp.2
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 16:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+8O8o+tE8LH0yHV6I53G6dFgrWnWaOANTEONxgpi80=;
        b=fdGCtm+6Eel0k9q+J1LZtCFKzQyyeX25uWD/5sxfiJLpTzm61UgpH1q7FQlVPDW+5R
         8oFYbhBiuq6YgsGgLl4WbFg8RgyoCQ85en7OTma/zU67SHcfFv/RqWu1+kR2bOSpJTNy
         Y7xzzeR4W0Qx5IOi1CQ6drq62oh/UwaSNe4ML4RgcqdqgzBF8OZw50oaThCPRMOV3X6I
         hzKOYbLw8T63St/csB/OtDYTo8vqs0elTUJEHC0suziH3WoM8NFftVL/bErAcaCzN7A6
         HGPPgTYnSo5jYbXhe+eYjEkN1g6Flg1+h/OX5ilCAg7m0aZaSUQ71Eb6uuMg+YduS+o2
         hzyQ==
X-Gm-Message-State: AOAM530pRuLb52VlLy6P24DnRDiErKMseQwgsmhl9x4kWt0R+DG0mar5
        KF0lKuUC5IUwbnNuinouUno=
X-Google-Smtp-Source: ABdhPJx6HDS2zzoW+VbZsj3aaZSYdlZHwpuEUAAneKvpqxb06vGS5Jdv1vrfvDt5Mrl5atv6uLvcRw==
X-Received: by 2002:a17:90a:1141:: with SMTP id d1mr28874970pje.56.1623193652341;
        Tue, 08 Jun 2021 16:07:32 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s21sm11395838pfw.57.2021.06.08.16.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:07:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 14/14] block/mq-deadline: Prioritize high-priority requests
Date:   Tue,  8 Jun 2021 16:07:03 -0700
Message-Id: <20210608230703.19510-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608230703.19510-1-bvanassche@acm.org>
References: <20210608230703.19510-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While one or more requests with a certain I/O priority are pending, do not
dispatch lower priority requests. Dispatch lower priority requests anyway
after the "aging" time has expired.

This patch has been tested as follows:

modprobe scsi_debug ndelay=1000000 max_queue=16 &&
sd='' &&
while [ -z "$sd" ]; do
  sd=/dev/$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*)
done &&
echo $((100*1000)) > /sys/block/$sd/queue/iosched/aging_expire &&
cd /sys/fs/cgroup/blkio/ &&
echo $$ >cgroup.procs &&
echo 2 >blkio.prio.class &&
mkdir -p hipri &&
cd hipri &&
echo 1 >blkio.prio.class &&
{ max-iops -a1 -d32 -j1 -e mq-deadline $sd >& ~/low-pri.txt & } &&
echo $$ >cgroup.procs &&
max-iops -a1 -d32 -j1 -e mq-deadline $sd >& ~/hi-pri.txt

Result:
* 11000 IOPS for the high-priority job
*   400 IOPS for the low-priority job

If the aging expiry time is changed from 100s into 0, the IOPS results change
into 6712 and 6796 IOPS.

The max-iops script is a script that runs fio with the following arguments:
--bs=4K --gtod_reduce=1 --ioengine=libaio --ioscheduler=${arg_e} --runtime=60
--norandommap --rw=read --thread --buffered=0 --numjobs=${arg_j}
--iodepth=${arg_d} --iodepth_batch_submit=${arg_a}
--iodepth_batch_complete=$((arg_d / 2)) --name=${positional_argument_1}
--filename=${positional_argument_1}

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline-main.c | 42 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
index 1b2b6c1de5b8..cecdb475a610 100644
--- a/block/mq-deadline-main.c
+++ b/block/mq-deadline-main.c
@@ -32,6 +32,11 @@
  */
 static const int read_expire = HZ / 2;  /* max time before a read is submitted. */
 static const int write_expire = 5 * HZ; /* ditto for writes, these limits are SOFT! */
+/*
+ * Time after which to dispatch lower priority requests even if higher
+ * priority requests are pending.
+ */
+static const int aging_expire = 10 * HZ;
 static const int writes_starved = 2;    /* max times reads can starve a write */
 static const int fifo_batch = 16;       /* # of sequential requests treated as one
 				     by the above parameters. For throughput. */
@@ -90,6 +95,7 @@ struct deadline_data {
 	int writes_starved;
 	int front_merges;
 	u32 async_depth;
+	int aging_expire;
 
 	spinlock_t lock;
 	spinlock_t zone_lock;
@@ -363,10 +369,10 @@ deadline_next_request(struct deadline_data *dd, enum dd_prio prio,
 
 /*
  * deadline_dispatch_requests selects the best request according to
- * read/write expire, fifo_batch, etc
+ * read/write expire, fifo_batch, etc and with a start time <= @latest.
  */
 static struct request *__dd_dispatch_request(struct deadline_data *dd,
-					     enum dd_prio prio)
+					enum dd_prio prio, u64 latest_start_ns)
 {
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
@@ -378,6 +384,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	if (!list_empty(&dd->dispatch[prio])) {
 		rq = list_first_entry(&dd->dispatch[prio], struct request,
 				      queuelist);
+		if (rq->start_time_ns > latest_start_ns)
+			return NULL;
 		list_del_init(&rq->queuelist);
 		goto done;
 	}
@@ -457,6 +465,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	dd->batching = 0;
 
 dispatch_request:
+	if (rq->start_time_ns > latest_start_ns)
+		return NULL;
 	/*
 	 * rq is the selected appropriate request.
 	 */
@@ -493,15 +503,32 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
-	struct request *rq;
+	const u64 now_ns = ktime_get_ns();
+	struct request *rq = NULL;
 	enum dd_prio prio;
 
 	spin_lock(&dd->lock);
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
-		rq = __dd_dispatch_request(dd, prio);
+	/*
+	 * Start with dispatching requests whose deadline expired more than
+	 * aging_expire jiffies ago.
+	 */
+	for (prio = DD_BE_PRIO; prio <= DD_PRIO_MAX; prio++) {
+		rq = __dd_dispatch_request(dd, prio, now_ns -
+					   jiffies_to_nsecs(dd->aging_expire));
 		if (rq)
+			goto unlock;
+	}
+	/*
+	 * Next, dispatch requests in priority order. Ignore lower priority
+	 * requests if any higher priority requests are pending.
+	 */
+	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+		rq = __dd_dispatch_request(dd, prio, now_ns);
+		if (rq || dd_queued(dd, prio))
 			break;
 	}
+
+unlock:
 	spin_unlock(&dd->lock);
 
 	return rq;
@@ -607,6 +634,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	dd->writes_starved = writes_starved;
 	dd->front_merges = 1;
 	dd->fifo_batch = fifo_batch;
+	dd->aging_expire = aging_expire;
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
 
@@ -725,6 +753,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	trace_block_rq_insert(rq);
 
 	if (at_head) {
+		rq->fifo_time = jiffies;
 		list_add(&rq->queuelist, &dd->dispatch[prio]);
 	} else {
 		deadline_add_rq_rb(dd, rq);
@@ -841,6 +870,7 @@ static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
 #define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__VAR))
 SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);
 SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
+SHOW_JIFFIES(deadline_aging_expire_show, dd->aging_expire);
 SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
 SHOW_INT(deadline_front_merges_show, dd->front_merges);
 SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
@@ -869,6 +899,7 @@ static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)
 	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, msecs_to_jiffies)
 STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX);
 STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX);
+STORE_JIFFIES(deadline_aging_expire_store, &dd->aging_expire, 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
 STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
@@ -885,6 +916,7 @@ static struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(writes_starved),
 	DD_ATTR(front_merges),
 	DD_ATTR(fifo_batch),
+	DD_ATTR(aging_expire),
 	__ATTR_NULL
 };
 
