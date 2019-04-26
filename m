Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A672EC43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB70206BA
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeZOWhvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfDZAV0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:21:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:32802 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfDZAV0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 20:21:26 -0400
Received: by mail-yw1-f68.google.com with SMTP id q11so590288ywb.0
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2019 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iN/ceYqNGPSDkakr9QvuBsL28MVNsT42sKDm8nAFabI=;
        b=EeZOWhvLGBBj6VZjg3y080RQx1JZYxPiE0EQhnImIWQFsqMo6kwPwpvUH1vLBJ36CJ
         XAv6eJzZaJuAIUOQUNrFHHl8LbNjc00lWD2fl97ljhsqstRmJXjwDPTvH7zRPfnClznH
         KNRWRLVUSNzleYBdBx1g1R4XIMO2C7oMy1/jb9LIQwObLikx9CNGXd4aOqepnK0WGgBY
         DaujbDJx1JLGksQQRcGVkous/O6IWqUKOGcQfCcCcm308l4iGr3SHSXX9oDOIxGk+VIe
         Z3rHs5H22QKbaXVYddCDHpJd+WAeAlzYwHUMsvrjzfYBgKKExZZRBve32ppDZuHMSufq
         dBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iN/ceYqNGPSDkakr9QvuBsL28MVNsT42sKDm8nAFabI=;
        b=PjwtiKTcIevtSgnae+xL/RWtDqanlgVeSqZUdq77mxdLlXa1vQQrwNbSWuQi6H3GMm
         kX9UdG5BKOerUx7ukEige3uhLrLen3anenxf+9DDshidWclLI9mc5rR4RhfKMJnix4LN
         UW1GdyI/xktsGdNPlxhUivWxQsmSzYXofZfd7hiqpmaPFLSvl+QW7ZJLDFRSPPQQ1ydL
         I4yGTgNBHgKxaLI3x0UGWbZI7DN3FblCDcALXZp3d8ZkdWe8OZzxYczNheKQD0S6sh2v
         i6BLi+wNKEGgpMnhqQCoXbhR9G966IRddpjhmvGtEZLqVyUv0mmydr/kg4/hcwfVB1kJ
         Bo+w==
X-Gm-Message-State: APjAAAVGj2mM6JK6bhgOFZ99EBTZoZGyTNgmojr3xCvlFaOGlAgICoZI
        zB8vnS81jtXYhujKuNB+HEbAt1QB
X-Google-Smtp-Source: APXvYqyEbKmWD9lQ4z6Gp8Ga9XdHXdwvlZ8z53SOz7rwew/RfTnQiiDCMVIAt42O0p6Fy8bxFg4AwQ==
X-Received: by 2002:a81:388b:: with SMTP id f133mr4161383ywa.408.1556238085254;
        Thu, 25 Apr 2019 17:21:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::5484])
        by smtp.gmail.com with ESMTPSA id x126sm6775497ywa.13.2019.04.25.17.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 17:21:24 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     josef@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH 3/5] Use blk-stat infrastructure to collect per queue device stats
Date:   Thu, 25 Apr 2019 20:20:48 -0400
Message-Id: <20190426002050.15499-4-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426002050.15499-1-Jes.Sorensen@gmail.com>
References: <20190426002050.15499-1-Jes.Sorensen@gmail.com>
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
index e8cd2028745a..3b36e8e26feb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -58,6 +58,52 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
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
@@ -2851,6 +2897,12 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
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
index 422327089e0f..394760754bfc 100644
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
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -767,6 +804,7 @@ static struct attribute *default_attrs[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
+	&queue_histstat_entry.attr,
 	NULL,
 };
 
@@ -837,6 +875,8 @@ static void __blk_release_queue(struct work_struct *work)
 {
 	struct request_queue *q = container_of(work, typeof(*q), release_work);
 
+	blk_dev_stats_free(q);
+
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a2291b1d1cb0..54f7718cd6a2 100644
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
 
@@ -593,6 +599,7 @@ struct request_queue {
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
+#define QUEUE_FLAG_HISTSTATS	26	/* Hist stats enabled if set */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
-- 
2.17.1

