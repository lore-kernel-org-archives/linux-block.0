Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFD5C433FE
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 19:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhKWTSg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhKWTSf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 14:18:35 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF226C061714
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:15:26 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e8so112594ilu.9
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nm1qMacmBceV3JBZZMYl1Rvq6U0y1m4JEVtKJzgRDes=;
        b=3Hxf4pMY2uglk29fht7qSEXd72tKfDpX6L/lg4s4nfzRTp4BkPfKDLi7XlrtU37TNG
         YdsTddvOHdIGjICfUmv7N88YtB7L8CvOHQ4d4rCvkZvbTSlzkDD/Y8zHzAH9OLNSMqyI
         4B2sweguSYJLLpWo6SFw5EsWXVTWaQzwJrBVN2hBoOuciEu7SsImzT5D8/iSf/hly8b9
         T4t8ndjRKj+yBkTzFibqJC1yEu74e3SvLrcnEN3U61HpGDkpugZJ6R1SbWcevHolWuve
         DaGwf8cc20ymemTmtdVk6HLX+VLQRQ3C6zh+O4XVX4nliGMh5lNzI7ZYFtdpUYQpkmMj
         y5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nm1qMacmBceV3JBZZMYl1Rvq6U0y1m4JEVtKJzgRDes=;
        b=7gwI7QWgtukdyvEjEgrtOaqKL0EDD1LXUJWdi4TFHgigDzgiuoeIL4ZQVSqXgnXodh
         HRPoN/knd+nc8uLFDc2xal+n2I6FxdK0z0iYFKBBrhOqG+RXMfTU15YAsvqE4b4PpTF4
         1YCDfGfSvHnbnSkJvTQ+/G8Ct0ibttG7ss1JvxtAn8L9QBC6vqlLzEy+N/1zQhSJXlYx
         D+oMiasJaYaVl7XdDP7vp83Ln/H8JTJ23rqUrMXjJyqreY4/pUFzoSqfj7FaB1AXsLjP
         U72zVLRhnIioWf0wIxHArVRhvoTvGImJxXuvoMfxaYfplCodn7TJFUdBbavIb62RyPEs
         gH0Q==
X-Gm-Message-State: AOAM532/aEdcVse/6BHnVDBudDWzGEL6dnUCcRPvi8duRokLydFzqyi2
        gaPqtiYDWkVN0mDlKj6mKGemqwZnJdExoSg6
X-Google-Smtp-Source: ABdhPJyy96G5HeZr2ddKo+ozRpdrvyX7rR0fZ6g39ff8EPv3YUG4LEGTKtyU7iHKIAHcJHheULhNAQ==
X-Received: by 2002:a05:6e02:188a:: with SMTP id o10mr8459447ilu.296.1637694926021;
        Tue, 23 Nov 2021 11:15:26 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v62sm8050399iof.31.2021.11.23.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:15:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: only allocate poll_stats if there's a user of them
Date:   Tue, 23 Nov 2021 12:15:18 -0700
Message-Id: <20211123191518.413917-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123191518.413917-1-axboe@kernel.dk>
References: <20211123191518.413917-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is essentially never used, yet it's about 1/3rd of the total
queue size. Allocate it when needed, and don't embed it in the queue.

Kill the queue flag for this while at it, since we can just check the
assigned pointer now.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 10 ++++------
 block/blk-stat.c       | 18 ++++++++++++++++++
 block/blk-stat.h       |  1 +
 block/blk-sysfs.c      |  3 ++-
 include/linux/blkdev.h |  3 +--
 6 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4f2cf8399f3d..f4022b198580 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -122,7 +122,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(FUA),
 	QUEUE_FLAG_NAME(DAX),
 	QUEUE_FLAG_NAME(STATS),
-	QUEUE_FLAG_NAME(POLL_STATS),
 	QUEUE_FLAG_NAME(REGISTERED),
 	QUEUE_FLAG_NAME(QUIESCED),
 	QUEUE_FLAG_NAME(PCI_P2PDMA),
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c00b22590cc..9d29245511ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4580,11 +4580,10 @@ EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 /* Enable polling stats and return whether they were already enabled. */
 static bool blk_poll_stats_enable(struct request_queue *q)
 {
-	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
-	    blk_queue_flag_test_and_set(QUEUE_FLAG_POLL_STATS, q))
+	if (q->poll_stat)
 		return true;
-	blk_stat_add_callback(q, q->poll_cb);
-	return false;
+
+	return blk_stats_alloc_enable(q);
 }
 
 static void blk_mq_poll_stats_start(struct request_queue *q)
@@ -4593,8 +4592,7 @@ static void blk_mq_poll_stats_start(struct request_queue *q)
 	 * We don't arm the callback if polling stats are not enabled or the
 	 * callback is already active.
 	 */
-	if (!test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
-	    blk_stat_is_active(q->poll_cb))
+	if (!q->poll_stat || blk_stat_is_active(q->poll_cb))
 		return;
 
 	blk_stat_activate_msecs(q->poll_cb, 100);
diff --git a/block/blk-stat.c b/block/blk-stat.c
index ae3dd1fb8e61..1b927b6e49bc 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -219,3 +219,21 @@ void blk_free_queue_stats(struct blk_queue_stats *stats)
 
 	kfree(stats);
 }
+
+bool blk_stats_alloc_enable(struct request_queue *q)
+{
+	struct blk_rq_stat *poll_stat;
+
+	poll_stat = kcalloc(BLK_MQ_POLL_STATS_BKTS, sizeof(*poll_stat),
+				GFP_ATOMIC);
+	if (!poll_stat)
+		return false;
+
+	if (cmpxchg(&q->poll_stat, poll_stat, NULL) != poll_stat) {
+		kfree(poll_stat);
+		return true;
+	}
+
+	blk_stat_add_callback(q, q->poll_cb);
+	return false;
+}
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 17b47a86eefb..58f029af49e5 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -64,6 +64,7 @@ struct blk_stat_callback {
 
 struct blk_queue_stats *blk_alloc_queue_stats(void);
 void blk_free_queue_stats(struct blk_queue_stats *);
+bool blk_stats_alloc_enable(struct request_queue *q);
 
 void blk_stat_add(struct request *rq, u64 now);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index cd75b0f73dc6..c079be1c58a3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -785,11 +785,12 @@ static void blk_release_queue(struct kobject *kobj)
 
 	might_sleep();
 
-	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
+	if (q->poll_stat)
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
 
 	blk_free_queue_stats(q->stats);
+	kfree(q->poll_stat);
 
 	blk_exit_queue(q);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bd4370baccca..74118e67f649 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -267,7 +267,7 @@ struct request_queue {
 	int			poll_nsec;
 
 	struct blk_stat_callback	*poll_cb;
-	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];
+	struct blk_rq_stat	*poll_stat;
 
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
@@ -397,7 +397,6 @@ struct request_queue {
 #define QUEUE_FLAG_FUA		18	/* device supports FUA writes */
 #define QUEUE_FLAG_DAX		19	/* device supports DAX */
 #define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
-#define QUEUE_FLAG_POLL_STATS	21	/* collecting stats for hybrid polling */
 #define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
-- 
2.34.0

