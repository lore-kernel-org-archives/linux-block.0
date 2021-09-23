Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA9FC4332F
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F39A60F43
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 23:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhIWX2p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 19:28:45 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:42719 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhIWX2m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 19:28:42 -0400
Received: by mail-pf1-f173.google.com with SMTP id q23so7094792pfs.9
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 16:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=si6HPCfg/Ypj+bmffkM8AdCDkbALXADHLYIVZZgh8+A=;
        b=2u8m+w5sW0u1vBXx+MpMIqvmormmDWHrzAjGlkwmmj3zarBYs45X2JdQGjjdEE0+02
         2IcLGbAWjSknP9DtSq320Soaf9kIWD7KYmENh8xs60MjmxSy1xjvZHq/9JFEj+vRaqA0
         KQjCKVX9sKlBO4NA9C5kUXqgxcs4LbeJHECdSp6dJ9H56P1C6QUBppDpXAWHPQZvQiRJ
         V0ElmDzv/uG7fFM/8TP6fuD2dy1DJpTmF3QhVk8+GX7hBMwHeZ6c5AUYItTU3oYCJepM
         biN0hkJuZwkvhwHACu8/zydSpZSQYAU8DupScXO8qYbSUho7krHAY+dHkWv+yKLK1gZy
         wNLw==
X-Gm-Message-State: AOAM532rXh6gHH/pwFqdS0ZQzLVzQ5d+wQ1RoEwtqE938X3LVstyWDZs
        oSfGWcVFI2mTV5qrRStFUe8q6kZK+Uc=
X-Google-Smtp-Source: ABdhPJxWPPMM9OJ2AusoVlz5M2HgDSLHcu+sPCal5D1y11kOJVHQoVJ+XK9Dw58ca/NgUAOG1rokjg==
X-Received: by 2002:a62:64d3:0:b0:43d:ba3:1e2c with SMTP id y202-20020a6264d3000000b0043d0ba31e2cmr6713880pfb.5.1632439629688;
        Thu, 23 Sep 2021 16:27:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:bf91:ebe7:eabf:7473])
        by smtp.gmail.com with ESMTPSA id o14sm6969807pfh.84.2021.09.23.16.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 16:27:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/4] block/mq-deadline: Prioritize high-priority requests
Date:   Thu, 23 Sep 2021 16:26:55 -0700
Message-Id: <20210923232655.3907383-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210923232655.3907383-1-bvanassche@acm.org>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In addition to reverting commit 7b05bf771084 ("Revert "block/mq-deadline:
Prioritize high-priority requests""), this patch uses 'jiffies' instead
of ktime_get() in the code for aging lower priority requests.

This patch has been tested as follows:

Measured QD=1/jobs=1 IOPS for nullb with the mq-deadline scheduler.
Result without and with this patch: 555 K IOPS.

Measured QD=1/jobs=8 IOPS for nullb with the mq-deadline scheduler.
Result without and with this patch: about 380 K IOPS.

Ran the following script:

set -e
scriptdir=$(dirname "$0")
if [ -e /sys/module/scsi_debug ]; then modprobe -r scsi_debug; fi
modprobe scsi_debug ndelay=1000000 max_queue=16
sd=''
while [ -z "$sd" ]; do
  sd=$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*)
done
echo $((100*1000)) > "/sys/block/$sd/queue/iosched/aging_expire"
if [ -e /sys/fs/cgroup/io.prio.class ]; then
  cd /sys/fs/cgroup
  echo restrict-to-be >io.prio.class
  echo +io > cgroup.subtree_control
else
  cd /sys/fs/cgroup/blkio/
  echo restrict-to-be >blkio.prio.class
fi
echo $$ >cgroup.procs
mkdir -p hipri
cd hipri
if [ -e io.prio.class ]; then
  echo none-to-rt >io.prio.class
else
  echo none-to-rt >blkio.prio.class
fi
{ "${scriptdir}/max-iops" -a1 -d32 -j1 -e mq-deadline "/dev/$sd" >& ~/low-pri.txt & }
echo $$ >cgroup.procs
"${scriptdir}/max-iops" -a1 -d32 -j1 -e mq-deadline "/dev/$sd" >& ~/hi-pri.txt

Result:
* 11000 IOPS for the high-priority job
*    40 IOPS for the low-priority job

If the aging expiry time is changed from 100s into 0, the IOPS results change
into 6712 and 6796 IOPS.

The max-iops script is a script that runs fio with the following arguments:
--bs=4K --gtod_reduce=1 --ioengine=libaio --ioscheduler=${arg_e} --runtime=60
--norandommap --rw=read --thread --buffered=0 --numjobs=${arg_j}
--iodepth=${arg_d} --iodepth_batch_submit=${arg_a}
--iodepth_batch_complete=$((arg_d / 2)) --name=${positional_argument_1}
--filename=${positional_argument_1}

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 78 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b0cfc84a4e6b..37440786fdbb 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -31,6 +31,11 @@
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
@@ -96,6 +101,7 @@ struct deadline_data {
 	int writes_starved;
 	int front_merges;
 	u32 async_depth;
+	int aging_expire;
 
 	spinlock_t lock;
 	spinlock_t zone_lock;
@@ -338,12 +344,27 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	return rq;
 }
 
+/*
+ * Returns true if and only if @rq started after @latest_start where
+ * @latest_start is in jiffies.
+ */
+static bool started_after(struct deadline_data *dd, struct request *rq,
+			  unsigned long latest_start)
+{
+	unsigned long start_time = (unsigned long)rq->fifo_time;
+
+	start_time -= dd->fifo_expire[rq_data_dir(rq)];
+
+	return time_after(start_time, latest_start);
+}
+
 /*
  * deadline_dispatch_requests selects the best request according to
- * read/write expire, fifo_batch, etc
+ * read/write expire, fifo_batch, etc and with a start time <= @latest.
  */
 static struct request *__dd_dispatch_request(struct deadline_data *dd,
-					     struct dd_per_prio *per_prio)
+					     struct dd_per_prio *per_prio,
+					     unsigned long latest_start)
 {
 	struct request *rq, *next_rq;
 	enum dd_data_dir data_dir;
@@ -355,6 +376,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	if (!list_empty(&per_prio->dispatch)) {
 		rq = list_first_entry(&per_prio->dispatch, struct request,
 				      queuelist);
+		if (started_after(dd, rq, latest_start))
+			return NULL;
 		list_del_init(&rq->queuelist);
 		goto done;
 	}
@@ -432,6 +455,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	dd->batching = 0;
 
 dispatch_request:
+	if (started_after(dd, rq, latest_start))
+		return NULL;
 	/*
 	 * rq is the selected appropriate request.
 	 */
@@ -449,6 +474,34 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	return rq;
 }
 
+/*
+ * Check whether there are any requests with a deadline that expired more than
+ * aging_expire jiffies ago.
+ */
+static struct request *dd_dispatch_aged_requests(struct deadline_data *dd,
+						 unsigned long now)
+{
+	struct request *rq;
+	enum dd_prio prio;
+	int prio_cnt;
+
+	lockdep_assert_held(&dd->lock);
+
+	prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) +
+		   !!dd_queued(dd, DD_IDLE_PRIO);
+	if (prio_cnt < 2)
+		return NULL;
+
+	for (prio = DD_BE_PRIO; prio <= DD_PRIO_MAX; prio++) {
+		rq = __dd_dispatch_request(dd, &dd->per_prio[prio],
+					   now - dd->aging_expire);
+		if (rq)
+			return rq;
+	}
+
+	return NULL;
+}
+
 /*
  * Called from blk_mq_run_hw_queue() -> __blk_mq_sched_dispatch_requests().
  *
@@ -460,15 +513,26 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
-	struct request *rq;
+	const unsigned long now = jiffies;
+	struct request *rq = NULL;
 	enum dd_prio prio;
 
 	spin_lock(&dd->lock);
+	rq = dd_dispatch_aged_requests(dd, now);
+	if (rq)
+		goto unlock;
+
+	/*
+	 * Next, dispatch requests in priority order. Ignore lower priority
+	 * requests if any higher priority requests are pending.
+	 */
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
-		rq = __dd_dispatch_request(dd, &dd->per_prio[prio]);
-		if (rq)
+		rq = __dd_dispatch_request(dd, &dd->per_prio[prio], now);
+		if (rq || dd_queued(dd, prio))
 			break;
 	}
+
+unlock:
 	spin_unlock(&dd->lock);
 
 	return rq;
@@ -573,6 +637,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	dd->front_merges = 1;
 	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
+	dd->aging_expire = aging_expire;
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
 
@@ -796,6 +861,7 @@ static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
 #define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__VAR))
 SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);
 SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
+SHOW_JIFFIES(deadline_aging_expire_show, dd->aging_expire);
 SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
 SHOW_INT(deadline_front_merges_show, dd->front_merges);
 SHOW_INT(deadline_async_depth_show, dd->front_merges);
@@ -825,6 +891,7 @@ static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)
 	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, msecs_to_jiffies)
 STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX);
 STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX);
+STORE_JIFFIES(deadline_aging_expire_store, &dd->aging_expire, 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
 STORE_INT(deadline_async_depth_store, &dd->front_merges, 1, INT_MAX);
@@ -843,6 +910,7 @@ static struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(front_merges),
 	DD_ATTR(async_depth),
 	DD_ATTR(fifo_batch),
+	DD_ATTR(aging_expire),
 	__ATTR_NULL
 };
 
