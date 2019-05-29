Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F8FC28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 22:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75132425E
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 22:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhk9evoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2WID (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 18:08:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34481 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2WID (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 18:08:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id t64so2592550qkh.1
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqKCk9D+PwGPh+KwbMyo42xi4G79ccnKSg24YFNeUPw=;
        b=nhk9evohDvYqB1SYRqonC7WyVS5E3/RyeRJcZ+DlG+XM7AnH4LXcmdWVRZLDif55TA
         tNpNGHZO4czslW5nPcyQKWugk7VDdSekFcFn0Z1JAh9nQBHY+18ZuandmSN1KRymspxH
         ZAVvq6pRnfog1UTL1CQ3uF/HYUhREkVcbuv8jDpv5W09qpLW//CPbTz5wnsBgKjEWJvi
         kQRJZVWH9P/yQqctn7CJTtErz/Nil3MvRd6mFrZJxY4RThvUq6i2sKxFfbNc9lEU2auW
         +CMxpXcPqLWXeucOE/HahhjynYXkSkRQuUjXJsjLQ3hQs+3wulHb2gULas9WhRMeH51W
         D/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqKCk9D+PwGPh+KwbMyo42xi4G79ccnKSg24YFNeUPw=;
        b=tkpw+NjW3ed1LZtoZp6MOcPObKRT54G1+4ZhR0Gl+1g3UKFYfoAKXj6waRL+M6Ugky
         koIeVzKJInx6Pnlsj5lZ+rvf34h3YTqrZDzDIN3avpUT1JxbejVzzya8afenNa28o0XB
         RKkaUBkuGW7DH46UegDeuo19mHxLb/Ic+DQKo4dPNruO1jhYGp5Q9Pok3d89LlMv0ijB
         HNRC+q3h79DYlJ3jz7ZUjyiBpaPMtqgcnbGDx8rSjD2bUpD6ilnOW4TBHD1D7+USCKUs
         83kfoJ97OL7dXgXm9jHwcbIdAMeu1WOJKZ6LCsHSoFYWzUVCsNKeY4xQxhqr1R6uQnNn
         4KUQ==
X-Gm-Message-State: APjAAAXg5BTie3EXrtNmN3l+biMaCjR3AFfks1Vzz/x46zzc/INtlzqQ
        6XGwmmA7DmemJ2xxJMG/czmI18y4
X-Google-Smtp-Source: APXvYqywTHPtkD8DOjV/uuIo8fGstEL5l5C+iDgz9ldgMDTB5kfZo3/foe0N4cdcbpmPc5Kuv5A/Ug==
X-Received: by 2002:a05:620a:16b4:: with SMTP id s20mr183415qkj.34.1559167681299;
        Wed, 29 May 2019 15:08:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:60e4])
        by smtp.gmail.com with ESMTPSA id c18sm333003qkl.78.2019.05.29.15.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 15:08:00 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, jbacik@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH 3/5] Use blk-stat infrastructure to collect per queue device stats
Date:   Wed, 29 May 2019 18:07:28 -0400
Message-Id: <20190529220730.28014-4-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529220730.28014-1-Jes.Sorensen@gmail.com>
References: <20190529220730.28014-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

Put request bytes into 8 buckets of requests, for read, write, and
discard.

Enable stats by writing 1 to /sys/block/<dev>/queue/histstat, disable
by writing 0.

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 block/blk-mq.c         | 52 ++++++++++++++++++++++++++++++++++++++++++
 block/blk-stat.h       |  1 +
 block/blk-sysfs.c      | 40 ++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  7 ++++++
 4 files changed, 100 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8a59bc0410a6..942ef6e1ed86 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -59,6 +59,52 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 	return bucket;
 }
 
+/*
+ * 8 buckets for each of read, write, and discard
+ */
+static int blk_dev_stats_bkt(const struct request *rq)
+{
+	int grp, bucket;
+
+	grp = op_stat_group(req_op(rq));
+
+	bucket = grp + 3*(ilog2(rq->io_bytes) - 9);
+
+	if (bucket < 0)
+		return -1;
+	else if (bucket >= BLK_DEV_STATS_BKTS)
+		return grp + BLK_DEV_STATS_BKTS - 3;
+
+	return bucket;
+}
+
+/*
+ * Copy out the stats to their official location
+ */
+static void blk_dev_stats_cb(struct blk_stat_callback *cb)
+{
+	struct request_queue *q = cb->data;
+	int bucket;
+
+	for (bucket = 0; bucket < BLK_DEV_STATS_BKTS; bucket++) {
+		if (cb->stat[bucket].nr_samples) {
+			q->dev_stat[bucket].size +=
+				cb->stat[bucket].size;
+			q->dev_stat[bucket].nr_samples +=
+				cb->stat[bucket].nr_samples;
+		}
+	}
+
+	if (!blk_stat_is_active(cb))
+		blk_stat_activate_msecs(cb, 100);
+}
+
+void blk_dev_stats_free(struct request_queue *q)
+{
+	blk_stat_remove_callback(q, q->dev_cb);
+	blk_stat_free_callback(q->dev_cb);
+}
+
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
@@ -2881,6 +2927,12 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
+	q->dev_cb = blk_stat_alloc_callback(blk_dev_stats_cb,
+					    blk_dev_stats_bkt,
+					    BLK_DEV_STATS_BKTS, q);
+	if (!q->dev_cb)
+		goto err_hctxs;
+
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
diff --git a/block/blk-stat.h b/block/blk-stat.h
index ea893c4a9af1..7f0c8b737a9d 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -168,4 +168,5 @@ void blk_rq_stat_add(struct blk_rq_stat *, u64, u64);
 void blk_rq_stat_sum(struct blk_rq_stat *, struct blk_rq_stat *);
 void blk_rq_stat_init(struct blk_rq_stat *);
 
+void blk_dev_stats_free(struct request_queue *q);
 #endif
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a16a02c52a85..81566432828d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -530,6 +530,37 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
+static ssize_t queue_histstat_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(test_bit(QUEUE_FLAG_HISTSTATS,
+				       &q->queue_flags), page);
+}
+
+static ssize_t queue_histstat_store(struct request_queue *q, const char *page,
+				    size_t size)
+{
+	unsigned long histstat_on;
+	ssize_t ret;
+
+	ret = queue_var_store(&histstat_on, page, size);
+	if (ret < 0)
+		return ret;
+
+	if (histstat_on) {
+		if (!blk_queue_flag_test_and_set(QUEUE_FLAG_HISTSTATS, q))
+			blk_stat_add_callback(q, q->dev_cb);
+		if (!blk_stat_is_active(q->dev_cb))
+			blk_stat_activate_msecs(q->dev_cb, 100);
+	} else {
+		if (test_bit(QUEUE_FLAG_HISTSTATS, &q->queue_flags)) {
+			blk_stat_remove_callback(q, q->dev_cb);
+			blk_queue_flag_clear(QUEUE_FLAG_HISTSTATS, q);
+		}
+	}
+
+	return ret;
+}
+
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = 0644 },
 	.show = queue_requests_show,
@@ -728,6 +759,12 @@ static struct queue_sysfs_entry throtl_sample_time_entry = {
 };
 #endif
 
+static struct queue_sysfs_entry queue_histstat_entry = {
+	.attr = {.name = "histstat", .mode = 0644 },
+	.show = queue_histstat_show,
+	.store = queue_histstat_store,
+};
+
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -767,6 +804,7 @@ static struct attribute *queue_attrs[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
+	&queue_histstat_entry.attr,
 	NULL,
 };
 
@@ -856,6 +894,8 @@ static void __blk_release_queue(struct work_struct *work)
 {
 	struct request_queue *q = container_of(work, typeof(*q), release_work);
 
+	blk_dev_stats_free(q);
+
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2716f239b56d..ed57518a15fb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -53,6 +53,9 @@ struct blk_stat_callback;
 /* Doing classic polling */
 #define BLK_MQ_POLL_CLASSIC -1
 
+/* Must be consistent with blk_part_stats_bkt() */
+#define BLK_DEV_STATS_BKTS (3 * 8)
+
 /*
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
@@ -478,6 +481,9 @@ struct request_queue {
 	struct blk_stat_callback	*poll_cb;
 	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];
 
+	struct blk_stat_callback	*dev_cb;
+	struct blk_rq_stat	dev_stat[BLK_DEV_STATS_BKTS];
+
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 
@@ -605,6 +611,7 @@ struct request_queue {
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
+#define QUEUE_FLAG_HISTSTATS	26	/* Hist stats enabled if set */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
-- 
2.17.1

