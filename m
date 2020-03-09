Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DF7C10F25
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1673524655
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwY51pQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgCIVAI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:00:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38414 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 17:00:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id e20so8148355qto.5
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 14:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eo8BqRWS0MDAd2X0hX24tFqp+etLwq4ENOt+rs73JAE=;
        b=CwY51pQeCKqR2U2VMRLihY3CyeG73e6jt1E3yChROfsUK3i+ZB1it4L4miriI8O/5X
         RNe4/KezMPxafmp0Dx/az2gElONR8d78BUjQCqtXPIkh3kCDhY5ICzkQsgjKl4hTtEX8
         j5OVBuLndQqDYdKkuqpwzRcvjk6drIC+dUXlpUtK5rnE1QejD3vhclwfFOGHmYn/ji0X
         JWksPCOi0gfc/veyq5OuCiIflwtZLf1Av4jfw5dLK7Brh+Mhd0XcctWMLgKtSqp6zuA+
         jrdCisXxAlGV5/Sl3KxBDzfcZ4yP2rWDlSeZeyByj1tMg/KAZUI3qaIDvuQ17DZwvsKn
         0SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eo8BqRWS0MDAd2X0hX24tFqp+etLwq4ENOt+rs73JAE=;
        b=nwW2kxt7gf12MpKGfQUa4GhDq0oW4zKei1vUmRuD5DWjpgH9t51gNRMk/5Va8Edydj
         UAti6hxR4swibW0I3GInmlZwyR9p+IWpXw7xkg7u+yk//HwcVOlntrZg33b9pV1IVSyO
         FgzVcetAI94tkcGfoKCw7l2H5pUA7S5hjyduKkx0TAASG8J9IwiQfDw/hRL2/DNgctz0
         74NuZisN2ZNLVvkw9Bx31JaXVCwdm0lcBlU7jElewKZIpjDUaT750UZOTtkEW3w0akYS
         krIIYl0XdeQ+PGRAVybWcw2jUt4SuYlIcpOIIAvHN3cggeB/aW/D9twHTJ0kBL2ns789
         r+mg==
X-Gm-Message-State: ANhLgQ2iy5hN2feeZUbNfKHLZiltNZn5ktY3zRYuik/mTqo9tYnWU4Jv
        u9DeNNqSNtM3DzECab0wBA7Mb6BSuD8=
X-Google-Smtp-Source: ADFU+vvQuVwfNpBVRXOWcZqbnnm3ZmeunIqyJ54duIElRuqtJb/gzEj0Zjhdw9gSEEF+L37JC+H59w==
X-Received: by 2002:ac8:7cb0:: with SMTP id z16mr16506051qtv.276.1583787604875;
        Mon, 09 Mar 2020 14:00:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4078])
        by smtp.gmail.com with ESMTPSA id 207sm3967594qkf.69.2020.03.09.14.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:00:04 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, mmullins@fb.com, josef@toxicpanda.com,
        Jes Sorensen <jsorensen@fb.com>
Subject: [PATCH 7/7] block: Introduce blk-mq latency stats
Date:   Mon,  9 Mar 2020 16:59:31 -0400
Message-Id: <20200309205931.24256-8-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
References: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

This uses the blk-stat infrastructure to collect latency statistics
for read/write/discard requests. Stats are accounted in us using 32
buckets, which should give up to approximately 35 minutes for the
highest bucket.

Stats are only collecting once enabled, and the data structures are
released again if stats for the device are disabled.

This is enabled on a per device level by
 $ echo 1 > /sys/block/<device>/queue/latstat
Latency stats are read from /sys/block/<device>/queue/latency
 $ cat /sys/block/sda/queue/latency
 read: 0 0 0 1 1 29 97 119 120 99 113 126 165 226 266 116 19 17 4 1 0 0 0 0 0 0 0 0 0 0 0 0
 write: 0 0 0 0 0 12 259 91 234 218 347 448 285 564 263 211 319 205 36 6 15 0 0 0 0 0 0 0 0 0 0 0
 discard: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 block/blk-mq.c         | 54 ++++++++++++++++++++++++
 block/blk-stat.h       |  3 ++
 block/blk-sysfs.c      | 96 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  6 +++
 4 files changed, 159 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a1e4c444a10b..5472842f6077 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -112,6 +112,60 @@ void blk_req_stats_free(struct request_queue *q)
 	}
 }
 
+/*
+ * With 32 buckets for latencies, kernel counts latency in ns, but
+ * bucket on us. This should give us roughly 35 minutes of range.
+ * If we reduce to 28 buckets and the limit would be about 2 minutes.
+ */
+int blk_latency_stats_bkt(const struct request *rq, u64 value)
+{
+	int grp, bucket, index;
+
+	if (!value)
+		return -1;
+
+	grp = op_stat_group(req_op(rq));
+
+	index = ilog2(value / NSEC_PER_USEC);
+	if (index >= (BLK_LATENCY_STATS_BKTS / 3))
+		index = (BLK_LATENCY_STATS_BKTS / 3) - 1;
+
+	bucket = 3 * index + grp;
+
+	return bucket;
+}
+
+/*
+ * Copy out the stats to their official location
+ */
+void blk_latency_stats_cb(struct blk_stat_callback *cb)
+{
+	struct request_queue *q = cb->data;
+	int bucket;
+
+	for (bucket = 0; bucket < BLK_LATENCY_STATS_BKTS; bucket++) {
+		if (cb->stat[bucket].nr_samples) {
+			q->latency_stat[bucket].nr_samples +=
+				cb->stat[bucket].nr_samples;
+		}
+	}
+
+	if (!blk_stat_is_active(cb))
+		blk_stat_activate_msecs(cb, 200);
+}
+
+void blk_latency_stats_free(struct request_queue *q)
+{
+	if (test_bit(QUEUE_FLAG_LATENCYSTATS, &q->queue_flags)) {
+		blk_stat_remove_callback(q, q->latency_cb);
+		blk_queue_flag_clear(QUEUE_FLAG_LATENCYSTATS, q);
+		blk_stat_free_callback(q->latency_cb);
+		q->latency_cb = NULL;
+		kfree(q->latency_stat);
+		q->latency_stat = NULL;
+	}
+}
+
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 51abad3775a9..4b991b95271c 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -171,4 +171,7 @@ void blk_rq_stat_init(struct blk_rq_stat *);
 int blk_req_stats_bkt(const struct request *rq, u64 value);
 void blk_req_stats_cb(struct blk_stat_callback *cb);
 void blk_req_stats_free(struct request_queue *q);
+int blk_latency_stats_bkt(const struct request *rq, u64 value);
+void blk_latency_stats_cb(struct blk_stat_callback *cb);
+void blk_latency_stats_free(struct request_queue *q);
 #endif
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b1469b3ce511..96ec0191e748 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -613,6 +613,88 @@ static ssize_t queue_reqstat_store(struct request_queue *q, const char *page,
 	goto out;
 }
 
+static ssize_t queue_latency_show(struct request_queue *q, char *p)
+{
+	char name[3][8] = {"read", "write", "discard"};
+	int bkt, off, i;
+
+	if (!q->latency_stat)
+		return -ENODEV;
+
+	/*
+	 * 64 bit decimal is max 20 characters + 1 whitespace, which
+	 * totals a max of 672 characters per read/write/discard line,
+	 * not counting the prefix. This easily keeps us within a 4KB
+	 * page of output.
+	 */
+	off = 0;
+	for (i = 0; i < 3; i++) {
+		off += sprintf(p + off, "%s: ", name[i]);
+		for (bkt = 0; bkt < (BLK_LATENCY_STATS_BKTS / 3); bkt++) {
+			off += sprintf(p + off, "%u ",
+				       q->latency_stat[i + 3 * bkt].nr_samples);
+		}
+
+		off += sprintf(p + off, "\n");
+	}
+	return off;
+}
+
+static ssize_t queue_latstat_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(test_bit(QUEUE_FLAG_LATENCYSTATS,
+				       &q->queue_flags), page);
+}
+
+static ssize_t queue_latstat_store(struct request_queue *q, const char *page,
+				    size_t size)
+{
+	unsigned long latstat_on;
+	ssize_t ret;
+
+	ret = queue_var_store(&latstat_on, page, size);
+	if (ret < 0)
+		return ret;
+
+	if (latstat_on) {
+		if (!q->latency_stat) {
+			q->latency_stat = kcalloc(BLK_LATENCY_STATS_BKTS,
+						  sizeof(struct blk_rq_stat),
+						  GFP_KERNEL);
+			if (!q->latency_stat) {
+				ret = -ENOMEM;
+				goto err_out;
+			}
+			q->latency_cb =
+				blk_stat_alloc_callback(blk_latency_stats_cb,
+							blk_latency_stats_bkt,
+							BLK_LATENCY_STATS_BKTS,
+							q);
+			if (!q->latency_cb) {
+				ret = -ENOMEM;
+				goto err_out;
+			}
+		}
+		if (!blk_queue_flag_test_and_set(QUEUE_FLAG_LATENCYSTATS, q))
+			blk_stat_add_callback(q, q->latency_cb);
+		if (!blk_stat_is_active(q->latency_cb))
+			blk_stat_activate_msecs(q->latency_cb, 100);
+	} else {
+		blk_latency_stats_free(q);
+	}
+
+ out:
+	return ret;
+ err_out:
+	if (q->latency_cb) {
+		blk_stat_free_callback(q->latency_cb);
+		q->latency_cb = NULL;
+	}
+	kfree(q->latency_stat);
+	q->latency_stat = NULL;
+	goto out;
+}
+
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = 0644 },
 	.show = queue_requests_show,
@@ -822,6 +904,17 @@ static struct queue_sysfs_entry queue_stat_entry = {
 	.show = queue_stat_show,
 };
 
+static struct queue_sysfs_entry queue_latency_entry = {
+	.attr = {.name = "latency", .mode = 0444 },
+	.show = queue_latency_show,
+};
+
+static struct queue_sysfs_entry queue_latstat_entry = {
+	.attr = {.name = "latstat", .mode = 0644 },
+	.show = queue_latstat_show,
+	.store = queue_latstat_store,
+};
+
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -863,6 +956,8 @@ static struct attribute *queue_attrs[] = {
 #endif
 	&queue_reqstat_entry.attr,
 	&queue_stat_entry.attr,
+	&queue_latency_entry.attr,
+	&queue_latstat_entry.attr,
 	NULL,
 };
 
@@ -974,6 +1069,7 @@ static void __blk_release_queue(struct work_struct *work)
 {
 	struct request_queue *q = container_of(work, typeof(*q), release_work);
 
+	blk_latency_stats_free(q);
 	blk_req_stats_free(q);
 
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1731c4ec4d34..fd5fab43bda3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -56,6 +56,8 @@ struct blk_stat_callback;
 /* Must be consistent with blk_part_stats_bkt() */
 #define BLK_REQ_STATS_BKTS (3 * 8)
 
+#define BLK_LATENCY_STATS_BKTS (3 * 32)
+
 /*
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
@@ -486,6 +488,9 @@ struct request_queue {
 	struct blk_stat_callback	*reqstat_cb;
 	struct blk_rq_stat	*req_stat;
 
+	struct blk_stat_callback	*latency_cb;
+	struct blk_rq_stat	*latency_stat;
+
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 
@@ -619,6 +624,7 @@ struct request_queue {
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_REQSTATS	28	/* request stats enabled if set */
+#define QUEUE_FLAG_LATENCYSTATS	29	/* latency stats enabled if set */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
-- 
2.17.1

