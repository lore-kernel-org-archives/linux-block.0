Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4705BC10F25
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134002464B
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNUTOezI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgCIU7q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:59:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45175 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIU7q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 16:59:46 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so4929111qke.12
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GtwZ5M19PthC3GsY6AmwjpoZsPKuSeMp+BzgI/nFZRs=;
        b=XNUTOezIeDePgG9Jm40hrbclUEL+w3L/qOSwm6efEgSjeSvkDmx0+9bwlG0+0T89+V
         WV10pC/3/efbrGMeuasamZ3fx81XUWYW7LXA344ibz3QUZyhgy8WOT+qlGw2AbzzHAW2
         wRZl8+z/X99XFpbnVdt47AV+Zv2OD22PHwxkbuzf2e0fi3JMA4VsrwrkKDVnhQz39RJ4
         WiPUd6allySWojMFL6KY5PqPadES8qHt3JwKI/6RzeW21HTlXCr5HCk4vV7tDPboBLp0
         Ikg8SCiyDTyQeMBvj+F4KGdpVvHI6TeUJnwUcCol9ZIEN2n8OKRPet7Nx8mbb6vrkgcm
         /0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GtwZ5M19PthC3GsY6AmwjpoZsPKuSeMp+BzgI/nFZRs=;
        b=FCZzfpl1QaY7GG2p5hyScir7VEhrKXkWFnYRmPabAG2NehjmgixaTkwbWo0C+ZKm/s
         XuZJSuCbrBSH4Fw2+WEEzjyrj1xhBC5Tpomiq1BJ4zk24Ktsy/b5ZQ1xoMkPuDGpXl8d
         ivOhysjpAyUsyRZn0bk4YxjOElcwK8eL8uecTbC5uAEdxbn36NshZiONKsfePxxb0ewa
         dSeMUbOZVDADCKdZqcDxMp7rq7bcoZNXaqnD7FafAD987bkccpxMWaHSFyg2m1P0bUxS
         u6Xxp8dmvS8XmvWCHaaaKLxZ10Q7HAE2/Vqv+YOEGzwoOPvOilVekrQRq91UUVvlbrvN
         nwFg==
X-Gm-Message-State: ANhLgQ2AtfnS0bb7fkeNh2hbSAYPwBFUF/CrDDfFeONcAvinOCWQMv4Q
        vJa4gvSsvpsfm2ZGCPBQVr2lRTaUPNU=
X-Google-Smtp-Source: ADFU+vuUwYLnDt6YLfzvWtvOOM+pfeBKNlXekTzC5cf6/iFz7vwY4RH9Yz/bM8FLEJBTZFbPlAkrxg==
X-Received: by 2002:a05:620a:13f6:: with SMTP id h22mr3752801qkl.372.1583787584544;
        Mon, 09 Mar 2020 13:59:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4078])
        by smtp.gmail.com with ESMTPSA id l3sm15270091qkl.100.2020.03.09.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:59:43 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, mmullins@fb.com, josef@toxicpanda.com,
        Jes Sorensen <jsorensen@fb.com>
Subject: [PATCH 2/7] block: Use blk-stat infrastructure to collect per queue request stats
Date:   Mon,  9 Mar 2020 16:59:26 -0400
Message-Id: <20200309205931.24256-3-Jes.Sorensen@gmail.com>
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

Track request sectors in 8 buckets for read, write, and discard.

Enable stats by writing 1 to /sys/block/<dev>/queue/reqstat, disable
by writing 0.

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 block/blk-mq.c         | 52 ++++++++++++++++++++++++++++++++++++++++++
 block/blk-stat.h       |  1 +
 block/blk-sysfs.c      | 40 ++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  7 ++++++
 4 files changed, 100 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d92088dec6c3..4aff0903546c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -60,6 +60,52 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 	return bucket;
 }
 
+/*
+ * 8 buckets for each of read, write, and discard
+ */
+static int blk_req_stats_bkt(const struct request *rq)
+{
+	int grp, bucket;
+
+	grp = op_stat_group(req_op(rq));
+
+	bucket = grp + 3 * ilog2(blk_rq_stats_sectors(rq));
+
+	if (bucket < 0)
+		return -1;
+	else if (bucket >= BLK_REQ_STATS_BKTS)
+		return grp + BLK_REQ_STATS_BKTS - 3;
+
+	return bucket;
+}
+
+/*
+ * Copy out the stats to their official location
+ */
+static void blk_req_stats_cb(struct blk_stat_callback *cb)
+{
+	struct request_queue *q = cb->data;
+	int bucket;
+
+	for (bucket = 0; bucket < BLK_REQ_STATS_BKTS; bucket++) {
+		if (cb->stat[bucket].nr_samples) {
+			q->req_stat[bucket].sectors +=
+				cb->stat[bucket].sectors;
+			q->req_stat[bucket].nr_samples +=
+				cb->stat[bucket].nr_samples;
+		}
+	}
+
+	if (!blk_stat_is_active(cb))
+		blk_stat_activate_msecs(cb, 100);
+}
+
+void blk_req_stats_free(struct request_queue *q)
+{
+	blk_stat_remove_callback(q, q->reqstat_cb);
+	blk_stat_free_callback(q->reqstat_cb);
+}
+
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
@@ -2910,6 +2956,12 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
+	q->reqstat_cb = blk_stat_alloc_callback(blk_req_stats_cb,
+						blk_req_stats_bkt,
+						BLK_REQ_STATS_BKTS, q);
+	if (!q->reqstat_cb)
+		goto err_hctxs;
+
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
diff --git a/block/blk-stat.h b/block/blk-stat.h
index ea893c4a9af1..e592bbf50d38 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -168,4 +168,5 @@ void blk_rq_stat_add(struct blk_rq_stat *, u64, u64);
 void blk_rq_stat_sum(struct blk_rq_stat *, struct blk_rq_stat *);
 void blk_rq_stat_init(struct blk_rq_stat *);
 
+void blk_req_stats_free(struct request_queue *q);
 #endif
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..8841146cad54 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -529,6 +529,37 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
+static ssize_t queue_reqstat_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(test_bit(QUEUE_FLAG_REQSTATS,
+				       &q->queue_flags), page);
+}
+
+static ssize_t queue_reqstat_store(struct request_queue *q, const char *page,
+				    size_t size)
+{
+	unsigned long reqstat_on;
+	ssize_t ret;
+
+	ret = queue_var_store(&reqstat_on, page, size);
+	if (ret < 0)
+		return ret;
+
+	if (reqstat_on) {
+		if (!blk_queue_flag_test_and_set(QUEUE_FLAG_REQSTATS, q))
+			blk_stat_add_callback(q, q->reqstat_cb);
+		if (!blk_stat_is_active(q->reqstat_cb))
+			blk_stat_activate_msecs(q->reqstat_cb, 100);
+	} else {
+		if (test_bit(QUEUE_FLAG_REQSTATS, &q->queue_flags)) {
+			blk_stat_remove_callback(q, q->reqstat_cb);
+			blk_queue_flag_clear(QUEUE_FLAG_REQSTATS, q);
+		}
+	}
+
+	return ret;
+}
+
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = 0644 },
 	.show = queue_requests_show,
@@ -727,6 +758,12 @@ static struct queue_sysfs_entry throtl_sample_time_entry = {
 };
 #endif
 
+static struct queue_sysfs_entry queue_reqstat_entry = {
+	.attr = {.name = "reqstat", .mode = 0644 },
+	.show = queue_reqstat_show,
+	.store = queue_reqstat_store,
+};
+
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -766,6 +803,7 @@ static struct attribute *queue_attrs[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
+	&queue_reqstat_entry.attr,
 	NULL,
 };
 
@@ -877,6 +915,8 @@ static void __blk_release_queue(struct work_struct *work)
 {
 	struct request_queue *q = container_of(work, typeof(*q), release_work);
 
+	blk_req_stats_free(q);
+
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 10455b2bbbb4..58abab51ed9f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -53,6 +53,9 @@ struct blk_stat_callback;
 /* Doing classic polling */
 #define BLK_MQ_POLL_CLASSIC -1
 
+/* Must be consistent with blk_part_stats_bkt() */
+#define BLK_REQ_STATS_BKTS (3 * 8)
+
 /*
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
@@ -480,6 +483,9 @@ struct request_queue {
 	struct blk_stat_callback	*poll_cb;
 	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];
 
+	struct blk_stat_callback	*reqstat_cb;
+	struct blk_rq_stat	req_stat[BLK_REQ_STATS_BKTS];
+
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 
@@ -612,6 +618,7 @@ struct request_queue {
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
+#define QUEUE_FLAG_REQSTATS	28	/* request stats enabled if set */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
-- 
2.17.1

