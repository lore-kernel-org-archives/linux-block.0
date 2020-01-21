Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD06C33CAF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 20:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36E924656
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 20:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rubrik.com header.i=@rubrik.com header.b="HqMKzLjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgAUUK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:10:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39131 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgAUUK5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 15:10:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so2047199pfs.6
        for <linux-block@vger.kernel.org>; Tue, 21 Jan 2020 12:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7x1RRyGfuYglkor9RuyO4Y73p0EzGbXZRnd3Ti6cGk=;
        b=HqMKzLjJyGF7uLhsUEWIf0GkZfXWx042LzYroOD4Cq6h3/yCsKKUdgVSw6B1idneRI
         wCoWZ32LCQucJzca9JnqcowR2pkPjgtz8uuUbhG40AQhpkdryyoxBeHa3zLkXKXZyVu1
         JLMalQZMeF9FhmqajVbKKHbm3gR2D0RHWSoK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7x1RRyGfuYglkor9RuyO4Y73p0EzGbXZRnd3Ti6cGk=;
        b=o4fR2g8gk5GnBN+rq5bbBo6XIN6g2M2WYZFStNIeO2lcerij3QcT+sIa9mjc7oXK99
         axxPBYy4YiDuVYWYg9tM04zMJq/LnVNmW6t8fw/AxDnWmWL5mUjV4atmPQze5bCOZM0a
         BPv+TgI8zPHn/9MZ0x/eyxjjL6GhXuwqB8QK74dkJzZP3sVg0qU/CscyD1oYvWP4Oo3x
         CMbZpbKNnIAFrPWLgV6BEpdERzxl5G+E7Yjf08PKmKKYGyuefJL+9r1jzFHCmGMn/0iy
         HiiA5AdmsPIaxJl9uXhcHuyQWjbrHLH0IX6T0uVG6qQJb2jkT3qiAq2dLYa9wgmTIFfS
         +wuw==
X-Gm-Message-State: APjAAAWz70zQi+W+1oDNTZiltKUCIQexTVhE76Xw0nyZRP1yhaoGeHYy
        l974ucgAsyCJgJ7yhCzkxzWL
X-Google-Smtp-Source: APXvYqxrwBvo3xOpapumFEXc7IagIyCzeX7NrbqfHbdzUfll2f5sCHBMRkkel7JSq/2rvo9sAAvmKQ==
X-Received: by 2002:a63:e4f:: with SMTP id 15mr6927609pgo.398.1579637455722;
        Tue, 21 Jan 2020 12:10:55 -0800 (PST)
Received: from fa2cb4acc48b.colo.rubrik.com ([4.7.92.14])
        by smtp.gmail.com with ESMTPSA id b1sm34490612pfp.44.2020.01.21.12.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 12:10:55 -0800 (PST)
From:   "muraliraja.muniraju" <muraliraja.muniraju@rubrik.com>
Cc:     Chaitanya.Kulkarni@wdc.com,
        "muraliraja.muniraju" <muraliraja.muniraju@rubrik.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re [PATCH] Adding multiple workers to the loop device.
Date:   Tue, 21 Jan 2020 20:10:12 +0000
Message-Id: <20200121201014.52345-1-muraliraja.muniraju@rubrik.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <DM6PR04MB5754D8E261B4200AA62D442D860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <DM6PR04MB5754D8E261B4200AA62D442D860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Below is the dd results that I ran with the worker and without the worker changes.
Enhanced Loop has the changes and ran with 1,2,3,4 workers with 4 dds running on the same loop device.
Normal Loop is 1 worker(the existing code) with 4 dd's running on the same loop device.
Enhanced loop
1 - READ: io=21981MB, aggrb=187558KB/s, minb=187558KB/s, maxb=187558KB/s, mint=120008msec, maxt=120008msec
2 - READ: io=41109MB, aggrb=350785KB/s, minb=350785KB/s, maxb=350785KB/s, mint=120004msec, maxt=120004msec
3 - READ: io=45927MB, aggrb=391802KB/s, minb=391802KB/s, maxb=391802KB/s, mint=120033msec, maxt=120033msec
4 - READ: io=45771MB, aggrb=390543KB/s, minb=390543KB/s, maxb=390543KB/s, mint=120011msec, maxt=120011msec
Normal loop
1 - READ: io=18432MB, aggrb=157201KB/s, minb=157201KB/s, maxb=157201KB/s, mint=120065msec, maxt=120065msec
2 - READ: io=18762MB, aggrb=160035KB/s, minb=160035KB/s, maxb=160035KB/s, mint=120050msec, maxt=120050msec
3 - READ: io=18174MB, aggrb=155058KB/s, minb=155058KB/s, maxb=155058KB/s, mint=120020msec, maxt=120020msec
4 - READ: io=20559MB, aggrb=175407KB/s, minb=175407KB/s, maxb=175407KB/s, mint=120020msec, maxt=120020msec

The Enhanced loop is the current patch with number of workers to be 4. Beyond 4 workers I did not see a significant changes.

Current loop device implementation has a single kthread worker and
drains one request at a time to completion. If the underneath device is
slow then this reduces the concurrency significantly. To help in these
cases, adding multiple loop workers increases the concurrency. Also to
retain the old behaviour the default number of loop workers is 1 and can
be tuned via the ioctl.
---
 drivers/block/loop.c      | 68 +++++++++++++++++++++++++++++++++------
 drivers/block/loop.h      |  9 ++++--
 include/uapi/linux/loop.h |  1 +
 3 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..97ec9485140c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -793,6 +793,13 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 	return ret;
 }
 
+static ssize_t loop_attr_num_loop_workers_show(struct loop_device *lo,
+						char *buf)
+{
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)lo->num_loop_workers);
+}
+
 static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 {
 	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_offset);
@@ -830,6 +837,7 @@ LOOP_ATTR_RO(sizelimit);
 LOOP_ATTR_RO(autoclear);
 LOOP_ATTR_RO(partscan);
 LOOP_ATTR_RO(dio);
+LOOP_ATTR_RO(num_loop_workers);
 
 static struct attribute *loop_attrs[] = {
 	&loop_attr_backing_file.attr,
@@ -838,6 +846,7 @@ static struct attribute *loop_attrs[] = {
 	&loop_attr_autoclear.attr,
 	&loop_attr_partscan.attr,
 	&loop_attr_dio.attr,
+	&loop_attr_num_loop_workers.attr,
 	NULL,
 };
 
@@ -889,10 +898,19 @@ static void loop_config_discard(struct loop_device *lo)
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 }
 
+static void loop_queue_cleanup(struct loop_device *lo, int num_workers)
+{
+	int i;
+
+	for (i = 0; i < num_workers; i++)
+		kthread_flush_worker(&(lo->workers[i]));
+	for (i = 0; i < num_workers; i++)
+		kthread_stop(lo->worker_tasks[i]);
+}
+
 static void loop_unprepare_queue(struct loop_device *lo)
 {
-	kthread_flush_worker(&lo->worker);
-	kthread_stop(lo->worker_task);
+	loop_queue_cleanup(lo, lo->num_loop_workers);
 }
 
 static int loop_kthread_worker_fn(void *worker_ptr)
@@ -903,13 +921,22 @@ static int loop_kthread_worker_fn(void *worker_ptr)
 
 static int loop_prepare_queue(struct loop_device *lo)
 {
-	kthread_init_worker(&lo->worker);
-	lo->worker_task = kthread_run(loop_kthread_worker_fn,
-			&lo->worker, "loop%d", lo->lo_number);
-	if (IS_ERR(lo->worker_task))
-		return -ENOMEM;
-	set_user_nice(lo->worker_task, MIN_NICE);
+	int i = 0;
+
+	for (i = 0; i < lo->num_loop_workers; i++) {
+		kthread_init_worker(&(lo->workers[i]));
+		lo->worker_tasks[i] = kthread_run(
+				loop_kthread_worker_fn, &(lo->workers[i]),
+				"loop%d(%d)", lo->lo_number, i);
+		if (IS_ERR((lo->worker_tasks[i])))
+			goto err;
+		set_user_nice(lo->worker_tasks[i], MIN_NICE);
+	}
 	return 0;
+err:
+	// Cleanup the previous indices, 0 to i-1
+	loop_queue_cleanup(lo, i);
+	return -ENOMEM;
 }
 
 static void loop_update_rotational(struct loop_device *lo)
@@ -1529,6 +1556,16 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 	return error;
 }
 
+static int loop_set_num_workers(struct loop_device *lo, unsigned long arg)
+{
+	if (lo->lo_state != Lo_unbound)
+		return -ENXIO;
+	if (arg < 1 || arg > MAX_LOOP_WORKER_THREADS)
+		return -EINVAL;
+	lo->num_loop_workers = arg;
+	return 0;
+}
+
 static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
 	int err = 0;
@@ -1584,6 +1621,9 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 	case LOOP_SET_BLOCK_SIZE:
 		err = loop_set_block_size(lo, arg);
 		break;
+	case LOOP_SET_WORKERS:
+		err = loop_set_num_workers(lo, arg);
+		break;
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
@@ -1907,6 +1947,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq = bd->rq;
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct loop_device *lo = rq->q->queuedata;
+	unsigned int inx;
 
 	blk_mq_start_request(rq);
 
@@ -1932,7 +1973,14 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	} else
 #endif
 		cmd->css = NULL;
-	kthread_queue_work(&lo->worker, &cmd->work);
+
+	// Round robin the incoming requests across multiple threads
+	// by having a monitorically increasing number indexing
+	// by modulo number of workers.
+	inx = lo->current_queue_inx;
+	inx = inx % lo->num_loop_workers;
+	kthread_queue_work(&lo->workers[inx], &cmd->work);
+	lo->current_queue_inx += 1;
 
 	return BLK_STS_OK;
 }
@@ -2014,6 +2062,8 @@ static int loop_add(struct loop_device **l, int i)
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
 	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	lo->tag_set.driver_data = lo;
+	lo->num_loop_workers = DEFAULT_LOOP_WORKERS;
+	lo->current_queue_inx = 0;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
 	if (err)
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index af75a5ee4094..09d1cc4f9b6b 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -26,6 +26,9 @@ enum {
 
 struct loop_func_table;
 
+#define MAX_LOOP_WORKER_THREADS 8
+#define DEFAULT_LOOP_WORKERS 1
+
 struct loop_device {
 	int		lo_number;
 	atomic_t	lo_refcnt;
@@ -54,8 +57,10 @@ struct loop_device {
 
 	spinlock_t		lo_lock;
 	int			lo_state;
-	struct kthread_worker	worker;
-	struct task_struct	*worker_task;
+	struct kthread_worker	workers[MAX_LOOP_WORKER_THREADS];
+	struct task_struct	*worker_tasks[MAX_LOOP_WORKER_THREADS];
+	unsigned int		current_queue_inx;
+	int			num_loop_workers;
 	bool			use_dio;
 	bool			sysfs_inited;
 
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 080a8df134ef..a1b689832bb4 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -90,6 +90,7 @@ struct loop_info64 {
 #define LOOP_SET_CAPACITY	0x4C07
 #define LOOP_SET_DIRECT_IO	0x4C08
 #define LOOP_SET_BLOCK_SIZE	0x4C09
+#define LOOP_SET_WORKERS	0x4C0A
 
 /* /dev/loop-control interface */
 #define LOOP_CTL_ADD		0x4C80
-- 
2.17.1

