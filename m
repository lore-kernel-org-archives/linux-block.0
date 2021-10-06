Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9B5C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 16:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A192A610EA
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 16:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhJFQhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhJFQhT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 12:37:19 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3D9C061746
        for <linux-block@vger.kernel.org>; Wed,  6 Oct 2021 09:35:27 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d18so3468755iof.13
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D92mo8VYcxwjVjmxM/h2ve5D+9GkxfhceM60wlIx3b4=;
        b=E+GfbWWMXmsDWT1ogwtU30q//t/vlOXlOuj/o5tMJt43M+GGpeM/TxwdRmYmnmJZEN
         wopQgW68cvJpVAJYmZtyQyLXSQqqFYgBFjcV6x4BTTPQOCZVurMq741AiG7lgYYvYHEF
         w5+OI77lhBMgUn8PnJkx9P7/mVxfunYBDB4eFi1bvbbiRJQyv7ptkQGyeY8gSgAPzOcB
         Hyz9Q/gqntTQdLz96bbVcNDpizwxM/HOyLZsrvBi9+4PT4t2mwI6Fa6egpFs3G/XkD0F
         zodAmZADc5OALpJ9qK9uWSJ5dQPXZnN4bl+FqNyj6Oy8300BeD2xCIs5jRX4CqIAwdbv
         UzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D92mo8VYcxwjVjmxM/h2ve5D+9GkxfhceM60wlIx3b4=;
        b=BiL16/U3G5X9USGbojMkZvfGGjgBUpaRmH+FqeCqqMdmeUQPiW0jVBX68Yu2mYxai9
         pdV1svw0UNLNOh25aYkSDeIAWgWpClo38vDW/wEZK/ExIBGwsFGuTIJG+TlJGVT7c9jN
         /5L27s+22ggEX1mTz07uEE9nI8zNOF4r7CxhfF0Vvufxm4z9MnxejBDaJt94ktyghJZh
         D+/kpvbvq8q9qkDZUwKvtAKfy8r5NtpbiBb1aoJfw2clz1fBQPkpbD6B2351FvipZRZI
         REipdGJl73K/NM7/4aPN1Ai5HjRUsb8oPOrSuqKcm9CzdXQlWgkM2wA2uqVSlMsPGIGe
         ZJwA==
X-Gm-Message-State: AOAM533aVSQdJlSwlwAuMoUeFhsN0ox9onj1tA6I68Grf9ustjEutRKH
        lTD/rZKiF0HYF2Sjb2gTdLFtlqziDw7DqeC/xSE=
X-Google-Smtp-Source: ABdhPJx+2Wzi3P/iAzfuHm9ViGLmoPKg7r2SZwdPxNlkif6MKdkASooEAbDGI0cw2kT/EcirEvt4OQ==
X-Received: by 2002:a6b:fe18:: with SMTP id x24mr7242567ioh.119.1633538126433;
        Wed, 06 Oct 2021 09:35:26 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n17sm1911890ile.76.2021.10.06.09.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:35:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] block: pre-allocate requests if plug is started and is a batch
Date:   Wed,  6 Oct 2021 10:35:21 -0600
Message-Id: <20211006163522.450882-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006163522.450882-1-axboe@kernel.dk>
References: <20211006163522.450882-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The caller typically has a good (or even exact) idea of how many requests
it needs to submit. We can make the request/tag allocation a lot more
efficient if we just allocate N requests/tags upfront when we queue the
first bio from the batch.

Provide a new plug start helper that allows the caller to specify how many
IOs are expected. This sets plug->nr_ios, and we can use that for smarter
request allocation. The plug provides a holding spot for requests, and
request allocation will check it before calling into the normal request
allocation path.

The blk_finish_plug() is called, check if there are unused requests and
free them. This should not happen in normal operations. The exception is
if we get merging, then we may be left with requests that need freeing
when done.

This raises the per-core performance on my setup from ~5.8M to ~6.1M
IOPS.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c          | 47 +++++++++++++++-----------
 block/blk-mq.c            | 70 ++++++++++++++++++++++++++++++++-------
 block/blk-mq.h            |  5 +++
 include/linux/blk-mq.h    |  5 ++-
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    | 15 ++++++++-
 6 files changed, 110 insertions(+), 33 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d83e56b2f64e..9b8c70670190 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1624,6 +1624,31 @@ int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
 }
 EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
 
+void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
+{
+	struct task_struct *tsk = current;
+
+	/*
+	 * If this is a nested plug, don't actually assign it.
+	 */
+	if (tsk->plug)
+		return;
+
+	INIT_LIST_HEAD(&plug->mq_list);
+	plug->cached_rq = NULL;
+	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
+	plug->rq_count = 0;
+	plug->multiple_queues = false;
+	plug->nowait = false;
+	INIT_LIST_HEAD(&plug->cb_list);
+
+	/*
+	 * Store ordering should not be needed here, since a potential
+	 * preempt will imply a full memory barrier
+	 */
+	tsk->plug = plug;
+}
+
 /**
  * blk_start_plug - initialize blk_plug and track it inside the task_struct
  * @plug:	The &struct blk_plug that needs to be initialized
@@ -1649,25 +1674,7 @@ EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
  */
 void blk_start_plug(struct blk_plug *plug)
 {
-	struct task_struct *tsk = current;
-
-	/*
-	 * If this is a nested plug, don't actually assign it.
-	 */
-	if (tsk->plug)
-		return;
-
-	INIT_LIST_HEAD(&plug->mq_list);
-	INIT_LIST_HEAD(&plug->cb_list);
-	plug->rq_count = 0;
-	plug->multiple_queues = false;
-	plug->nowait = false;
-
-	/*
-	 * Store ordering should not be needed here, since a potential
-	 * preempt will imply a full memory barrier
-	 */
-	tsk->plug = plug;
+	blk_start_plug_nr_ios(plug, 1);
 }
 EXPORT_SYMBOL(blk_start_plug);
 
@@ -1719,6 +1726,8 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 
 	if (!list_empty(&plug->mq_list))
 		blk_mq_flush_plug_list(plug, from_schedule);
+	if (unlikely(!from_schedule && plug->cached_rq))
+		blk_mq_free_plug_rqs(plug);
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5327abbefbab..ced94eb8e297 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -352,6 +352,7 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 	struct request_queue *q = data->q;
 	struct elevator_queue *e = q->elevator;
 	u64 alloc_time_ns = 0;
+	struct request *rq;
 	unsigned int tag;
 
 	/* alloc_time includes depth and tag waits */
@@ -385,10 +386,21 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 	 * case just retry the hctx assignment and tag allocation as CPU hotplug
 	 * should have migrated us to an online CPU by now.
 	 */
-	tag = blk_mq_get_tag(data);
-	if (tag == BLK_MQ_NO_TAG) {
+	do {
+		tag = blk_mq_get_tag(data);
+		if (tag != BLK_MQ_NO_TAG) {
+			rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
+			if (!--data->nr_tags)
+				return rq;
+			if (e || data->hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+				return rq;
+			rq->rq_next = *data->cached_rq;
+			*data->cached_rq = rq;
+			data->flags |= BLK_MQ_REQ_NOWAIT;
+			continue;
+		}
 		if (data->flags & BLK_MQ_REQ_NOWAIT)
-			return NULL;
+			break;
 
 		/*
 		 * Give up the CPU and sleep for a random short time to ensure
@@ -397,8 +409,15 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 		 */
 		msleep(3);
 		goto retry;
+	} while (1);
+
+	if (data->cached_rq) {
+		rq = *data->cached_rq;
+		*data->cached_rq = rq->rq_next;
+		return rq;
 	}
-	return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
+
+	return NULL;
 }
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
@@ -408,6 +427,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		.q		= q,
 		.flags		= flags,
 		.cmd_flags	= op,
+		.nr_tags	= 1,
 	};
 	struct request *rq;
 	int ret;
@@ -436,6 +456,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		.q		= q,
 		.flags		= flags,
 		.cmd_flags	= op,
+		.nr_tags	= 1,
 	};
 	u64 alloc_time_ns = 0;
 	unsigned int cpu;
@@ -537,6 +558,18 @@ void blk_mq_free_request(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
+void blk_mq_free_plug_rqs(struct blk_plug *plug)
+{
+	while (plug->cached_rq) {
+		struct request *rq;
+
+		rq = plug->cached_rq;
+		plug->cached_rq = rq->rq_next;
+		percpu_ref_get(&rq->q->q_usage_counter);
+		blk_mq_free_request(rq);
+	}
+}
+
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
 	u64 now = 0;
@@ -2178,6 +2211,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
 	struct blk_mq_alloc_data data = {
 		.q		= q,
+		.nr_tags	= 1,
 	};
 	struct request *rq;
 	struct blk_plug *plug;
@@ -2204,13 +2238,26 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	hipri = bio->bi_opf & REQ_HIPRI;
 
-	data.cmd_flags = bio->bi_opf;
-	rq = __blk_mq_alloc_request(&data);
-	if (unlikely(!rq)) {
-		rq_qos_cleanup(q, bio);
-		if (bio->bi_opf & REQ_NOWAIT)
-			bio_wouldblock_error(bio);
-		goto queue_exit;
+	plug = blk_mq_plug(q, bio);
+	if (plug && plug->cached_rq) {
+		rq = plug->cached_rq;
+		plug->cached_rq = rq->rq_next;
+		INIT_LIST_HEAD(&rq->queuelist);
+		data.hctx = rq->mq_hctx;
+	} else {
+		data.cmd_flags = bio->bi_opf;
+		if (plug) {
+			data.nr_tags = plug->nr_ios;
+			plug->nr_ios = 1;
+			data.cached_rq = &plug->cached_rq;
+		}
+		rq = __blk_mq_alloc_request(&data);
+		if (unlikely(!rq)) {
+			rq_qos_cleanup(q, bio);
+			if (bio->bi_opf & REQ_NOWAIT)
+				bio_wouldblock_error(bio);
+			goto queue_exit;
+		}
 	}
 
 	trace_block_getrq(bio);
@@ -2229,7 +2276,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
-	plug = blk_mq_plug(q, bio);
 	if (unlikely(is_flush_fua)) {
 		/* Bypass scheduler for flush requests */
 		blk_insert_flush(rq);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 171e8cdcff54..5da970bb8865 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -125,6 +125,7 @@ extern int __blk_mq_register_dev(struct device *dev, struct request_queue *q);
 extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
+void blk_mq_free_plug_rqs(struct blk_plug *plug);
 
 void blk_mq_release(struct request_queue *q);
 
@@ -152,6 +153,10 @@ struct blk_mq_alloc_data {
 	unsigned int shallow_depth;
 	unsigned int cmd_flags;
 
+	/* allocate multiple requests/tags in one go */
+	unsigned int nr_tags;
+	struct request **cached_rq;
+
 	/* input & output parameter */
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 75d75657df21..0e941f217578 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -90,7 +90,10 @@ struct request {
 	struct bio *bio;
 	struct bio *biotail;
 
-	struct list_head queuelist;
+	union {
+		struct list_head queuelist;
+		struct request *rq_next;
+	};
 
 	/*
 	 * The hash is used inside the scheduler, and killed once the
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3b967053e9f5..4b2006ec8bf2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -22,6 +22,7 @@ struct bio_crypt_ctx;
 
 struct block_device {
 	sector_t		bd_start_sect;
+	sector_t		bd_nr_sectors;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
 	bool			bd_read_only;	/* read-only policy */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 534298ac73cc..39b58b223f84 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -722,10 +722,17 @@ extern void blk_set_queue_dying(struct request_queue *);
  */
 struct blk_plug {
 	struct list_head mq_list; /* blk-mq requests */
-	struct list_head cb_list; /* md requires an unplug callback */
+
+	/* if ios_left is > 1, we can batch tag/rq allocations */
+	struct request *cached_rq;
+	unsigned short nr_ios;
+
 	unsigned short rq_count;
+
 	bool multiple_queues;
 	bool nowait;
+
+	struct list_head cb_list; /* md requires an unplug callback */
 };
 #define BLK_MAX_REQUEST_COUNT 32
 #define BLK_PLUG_FLUSH_SIZE (128 * 1024)
@@ -740,6 +747,7 @@ struct blk_plug_cb {
 extern struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug,
 					     void *data, int size);
 extern void blk_start_plug(struct blk_plug *);
+extern void blk_start_plug_nr_ios(struct blk_plug *, unsigned short);
 extern void blk_finish_plug(struct blk_plug *);
 extern void blk_flush_plug_list(struct blk_plug *, bool);
 
@@ -774,6 +782,11 @@ long nr_blockdev_pages(void);
 struct blk_plug {
 };
 
+static inline void blk_start_plug_nr_ios(struct blk_plug *plug,
+					 unsigned short nr_ios)
+{
+}
+
 static inline void blk_start_plug(struct blk_plug *plug)
 {
 }
-- 
2.33.0

