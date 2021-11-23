Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD3AC433FE
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 17:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbhKWROM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbhKWROL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 12:14:11 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D2AC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:11:03 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z18so28857313iof.5
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=064ELPy97acrp52hALNERxgS/c5GK/HHcBvjHkrSoso=;
        b=OJkQkESVqccMeCZqVkmuvzLsQoArI0v8dMIhc5Rut7ULt7krDY+c9ZwfMKMHfbdS6E
         9I4/Ek78n+epvP3lmv8BZ03xebDeDzqp+gR168zDoKBc7EAjEMFX5rH+cQMERPmkr10r
         s08EJtAkbmrwAlDipJEbafCVDTZ10n4Jh2d0k1yaX3K2YRIVeNfY+8VbIgpKP68XKajA
         eL49ZKXmRsv+wQxShhm9zHK1oCQNmglNxfOJnsjl0bwbVvYGDfNeqgtVgB4SJTFnoXMm
         UTAv+9MiEqIu0qJsN2FpsMwYj8+ZtqTXgI6YkCQX85B3BK8G7ukTWZ47oLSnkd9wY3Tt
         RBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=064ELPy97acrp52hALNERxgS/c5GK/HHcBvjHkrSoso=;
        b=dARpLfmICCOpiM0A3h4h4ak5usb6+iYATMEQnTSpSqIDd1LtkjXaUoTKEyBhLFOH6P
         zU/rpFygwwlpmVzEkcc734bYdXSu773oCLxFCV2swRoM/z/bkiyLyFqbfXEJ2G5Q4sSJ
         qPZTP8o98kauSd+myGFbk1/7IyJtrOsqrc+sAZ/jJ6PMTRS95APi0AyDU6EFzjSzksr8
         6saMR66+up6DNuvDycOFBYfGf1KzuPFdb2xuceHAfzYMPEWzk37q2s4FGDsisr9MZ0Ap
         E20uHAr+ijfduCzXMWG6ytTYJgOw+MqfovinBsZewfb0r3VlG8sBMhUHGORli8g7w1bd
         xQXQ==
X-Gm-Message-State: AOAM533cm0zcz+xIjNdC4bkgP3v0BCFF8A+JYMC/+UMC5NdvD1sGWy48
        gmf9XmMkkw/WnKLQ9NiSg3+2hPnZ4PmpN0oS
X-Google-Smtp-Source: ABdhPJwOtdzHSFuEf+gUqwQCH9UCBi5QkGZUsBjv1K9DdRfyTUwd2tvGekVOagVI2qQIzUrrDjaosA==
X-Received: by 2002:a02:cc91:: with SMTP id s17mr8346541jap.3.1637687462276;
        Tue, 23 Nov 2021 09:11:02 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i20sm8251283iow.9.2021.11.23.09.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 09:11:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] block: only allocate poll_stats if there's a user of them
Date:   Tue, 23 Nov 2021 10:10:58 -0700
Message-Id: <20211123171058.346084-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123171058.346084-1-axboe@kernel.dk>
References: <20211123171058.346084-1-axboe@kernel.dk>
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
 block/blk-mq.c         | 23 +++++++++++++++++++----
 block/blk-stat.c       |  6 ------
 block/blk-sysfs.c      |  3 ++-
 include/linux/blkdev.h | 10 +++++++---
 5 files changed, 28 insertions(+), 15 deletions(-)

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
index 20a6445f6a01..4c59b24690d7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4577,9 +4577,25 @@ EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 /* Enable polling stats and return whether they were already enabled. */
 static bool blk_poll_stats_enable(struct request_queue *q)
 {
-	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
-	    blk_queue_flag_test_and_set(QUEUE_FLAG_POLL_STATS, q))
+	struct blk_rq_stat *poll_stat;
+
+	if (q->poll_stat)
 		return true;
+
+	poll_stat = kcalloc(BLK_MQ_POLL_STATS_BKTS, sizeof(*poll_stat),
+				GFP_ATOMIC);
+	if (!poll_stat)
+		return false;
+
+	spin_lock_irq(&q->stats->lock);
+	if (q->poll_stat) {
+		spin_unlock_irq(&q->stats->lock);
+		kfree(poll_stat);
+		return true;
+	}
+	q->poll_stat = poll_stat;
+	spin_unlock_irq(&q->stats->lock);
+
 	blk_stat_add_callback(q, q->poll_cb);
 	return false;
 }
@@ -4590,8 +4606,7 @@ static void blk_mq_poll_stats_start(struct request_queue *q)
 	 * We don't arm the callback if polling stats are not enabled or the
 	 * callback is already active.
 	 */
-	if (!test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
-	    blk_stat_is_active(q->poll_cb))
+	if (!q->poll_stat || blk_stat_is_active(q->poll_cb))
 		return;
 
 	blk_stat_activate_msecs(q->poll_cb, 100);
diff --git a/block/blk-stat.c b/block/blk-stat.c
index ae3dd1fb8e61..7ba504166d1b 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -12,12 +12,6 @@
 #include "blk-mq.h"
 #include "blk.h"
 
-struct blk_queue_stats {
-	struct list_head callbacks;
-	spinlock_t lock;
-	bool enable_accounting;
-};
-
 void blk_rq_stat_init(struct blk_rq_stat *stat)
 {
 	stat->min = -1ULL;
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
index bd4370baccca..90dac4a67cfc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -28,10 +28,15 @@ struct blk_flush_queue;
 struct kiocb;
 struct pr_ops;
 struct rq_qos;
-struct blk_queue_stats;
 struct blk_stat_callback;
 struct blk_crypto_profile;
 
+struct blk_queue_stats {
+	struct list_head callbacks;
+	spinlock_t lock;
+	bool enable_accounting;
+};
+
 /* Must be consistent with blk_mq_poll_stats_bkt() */
 #define BLK_MQ_POLL_STATS_BKTS 16
 
@@ -267,7 +272,7 @@ struct request_queue {
 	int			poll_nsec;
 
 	struct blk_stat_callback	*poll_cb;
-	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];
+	struct blk_rq_stat	*poll_stat;
 
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
@@ -397,7 +402,6 @@ struct request_queue {
 #define QUEUE_FLAG_FUA		18	/* device supports FUA writes */
 #define QUEUE_FLAG_DAX		19	/* device supports DAX */
 #define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
-#define QUEUE_FLAG_POLL_STATS	21	/* collecting stats for hybrid polling */
 #define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
-- 
2.34.0

