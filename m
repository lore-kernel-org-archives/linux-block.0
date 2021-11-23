Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BD1C433FE
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbhKWQV0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbhKWQV0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:21:26 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3ECC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:18:17 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z18so28637876iof.5
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=moELeGt6WK+VFN+ZdytMO9/BkmVHzLZ2ioec9HfZZP0=;
        b=uxHYO8o50dX92uCdpvKFsU6xC9jabWNzLBo9PcTycK/kin1Yrwo1/nHTbxOEdgb8ms
         wbRks2epH7uDPMhAVkRMVvtZmSHxpTKu9k7vRAeU64r1/whuMeIrRfxX8PqwPeJ6sXTM
         bbFVdMCnFIV+dVqMIbhNZ4N4PldSTBc3WdjSTWXXEoVyHuadz/3kBZUWVk1jvqF7plpo
         xcCQhVmcgnogT2v4XKqnsmQ1cGp43F0kPRXVAnRdbjXQL6Jk/zKNEOBVnEklRVrnMQkz
         +odNFbp2F4xQjx36qxvJwMDJ+OUNokGt0VV+FxPrjqaxmcFW80hE/mvIUK3EnqIzMALt
         isCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=moELeGt6WK+VFN+ZdytMO9/BkmVHzLZ2ioec9HfZZP0=;
        b=mMAE60lR4bALhsAfuuBI79GkrLWZyew0ms3iUW7q0fqmSCk/3snzMQN5mWcXrGIeD/
         kkEg8oBSHV2DX850293mSkXJG5SQmjvULtL/vkVd1bB2EAbCbUkUTlKheXA5wc5QFObk
         oo8KuIoDEItsumKa/yCYnaCtOltbA8/LgTSQD4cZ+7tHCwcdM/th99qIKTckojLu8GS4
         FUzBVFifn6ji6gBabWVpNW1E3JIo1piJnI180GukH1xanFBc1c9/DMA/OXoB3WPlYUS4
         Zu5V4mtipfAnYk8JShDhp86XXReL5YDHIRI+RvYDutoLlc40gu1D4sZTBGKaefWYIYKT
         gc+g==
X-Gm-Message-State: AOAM532ipawW8c/9iQHnG8IMD2djG5IdMfXiplSugnd/lHOwurD1Vw/B
        jN1Bz/nzg21JqUy3HnZFzE4PARqMzb0B1PRb
X-Google-Smtp-Source: ABdhPJwy4dDODwHFFjUNXF1VATa+Coi1DIpKDOYmkaHAHPvE0lZDI9AZd/0xLCW6klIeSaHmwFc3Yw==
X-Received: by 2002:a05:6602:1484:: with SMTP id a4mr7333595iow.35.1637684297118;
        Tue, 23 Nov 2021 08:18:17 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t188sm7858034iof.5.2021.11.23.08.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:18:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] block: only allocate poll_stats if there's a user of them
Date:   Tue, 23 Nov 2021 09:18:13 -0700
Message-Id: <20211123161813.326307-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123161813.326307-1-axboe@kernel.dk>
References: <20211123161813.326307-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is essentially never used, yet it's about 1/3rd of the total
queue size. Allocate it when needed, and don't embed it in the queue.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 20 ++++++++++++++++++--
 block/blk-stat.c       |  6 ------
 block/blk-sysfs.c      |  1 +
 include/linux/blkdev.h |  9 +++++++--
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 20a6445f6a01..cb41c441aa8f 100644
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
+	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		return true;
+
+	poll_stat = kzalloc(BLK_MQ_POLL_STATS_BKTS * sizeof(*poll_stat),
+				GFP_ATOMIC);
+	if (!poll_stat)
+		return false;
+
+	spin_lock_irq(&q->stats->lock);
+	if (blk_queue_flag_test_and_set(QUEUE_FLAG_POLL_STATS, q)) {
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
index cd75b0f73dc6..e1b846ec58cb 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -790,6 +790,7 @@ static void blk_release_queue(struct kobject *kobj)
 	blk_stat_free_callback(q->poll_cb);
 
 	blk_free_queue_stats(q->stats);
+	kfree(q->poll_stat);
 
 	blk_exit_queue(q);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bd4370baccca..b46fd2a80062 100644
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
-- 
2.34.0

