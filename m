Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F3CC2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8496141B
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhEYIJj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 04:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232043AbhEYIJP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 04:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621930039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAV4w3sWqpWD8znrzsx5RFjgMg+JBp27Mp120boUdJU=;
        b=CiLZvUbfQGcHGiWmO3dbnvJzEIWW0dP4M9ZkVjQOQWx/NKNEcDutwd0mqDPwVkq2vaHp/6
        UAzYdEevxkpo+r0+8p9NS5t0dIs+/hKoxeHw/83VE5XkNJa6YIm7nfJx1/Pqdctlj1mj22
        FYe6+m/DzGhtR0AXr4MEOupBg9fuqDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-moOgLD9rNsSQxMgIQhsHwA-1; Tue, 25 May 2021 04:05:14 -0400
X-MC-Unique: moOgLD9rNsSQxMgIQhsHwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 704DB800FF0;
        Tue, 25 May 2021 08:05:13 +0000 (UTC)
Received: from localhost (ovpn-13-203.pek2.redhat.com [10.72.13.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA56B2ED8E;
        Tue, 25 May 2021 08:05:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 3/4] block: reuse wbt_set_min_lat for setting wbt->min_lat_nsec
Date:   Tue, 25 May 2021 16:04:41 +0800
Message-Id: <20210525080442.1896417-4-ming.lei@redhat.com>
In-Reply-To: <20210525080442.1896417-1-ming.lei@redhat.com>
References: <20210525080442.1896417-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to freeze queue when setting wbt->min_lat_nsec because
wbt enabled state can be changed, so reuse wbt_set_min_lat() for doing
that for users of wbt_init().

Meantime move wbt_enable_default() out of q->sysfs_lock, since we
don't need that lock for enabling wbt.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 16 +++-------------
 block/blk-wbt.c   | 29 ++++++++++++++++++++++-------
 block/blk-wbt.h   |  4 ++--
 3 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 7fd4ffadcdfa..925043f926c5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -498,18 +498,7 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	if (wbt_get_min_lat(q) == val)
 		return count;
 
-	/*
-	 * Ensure that the queue is idled, in case the latency update
-	 * ends up either enabling or disabling wbt completely. We can't
-	 * have IO inflight if that happens.
-	 */
-	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
-
-	wbt_set_min_lat(q, val);
-
-	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
+	wbt_set_min_lat(q, val, true);
 
 	return count;
 }
@@ -918,7 +907,6 @@ int blk_register_queue(struct gendisk *disk)
 	}
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
-	wbt_enable_default(q);
 	blk_throtl_register_queue(q);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
@@ -927,6 +915,8 @@ int blk_register_queue(struct gendisk *disk)
 		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
 	mutex_unlock(&q->sysfs_lock);
 
+	wbt_enable_default(q);
+
 	ret = 0;
 unlock:
 	mutex_unlock(&q->sysfs_dir_lock);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 5da48294e3e9..5d2db197cce6 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/swap.h>
+#include <linux/blk-mq.h>
 
 #include "blk-wbt.h"
 #include "blk-rq-qos.h"
@@ -425,13 +426,27 @@ u64 wbt_get_min_lat(struct request_queue *q)
 	return RQWB(rqos)->min_lat_nsec;
 }
 
-void wbt_set_min_lat(struct request_queue *q, u64 val)
+void wbt_set_min_lat(struct request_queue *q, u64 val, bool manual)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
 
+	/*
+	 * Ensure that the queue is idled, in case the latency update
+	 * ends up either enabling or disabling wbt completely. We can't
+	 * have IO inflight if that happens.
+	 */
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+
 	RQWB(rqos)->min_lat_nsec = val;
-	RQWB(rqos)->enable_state = WBT_STATE_ON_MANUAL;
+	if (manual)
+		RQWB(rqos)->enable_state = WBT_STATE_ON_MANUAL;
+	else
+		RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
 	wbt_update_limits(RQWB(rqos));
+
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
 }
 
 
@@ -844,11 +859,11 @@ int wbt_alloc(struct request_queue *q)
 
 void wbt_init(struct request_queue *q)
 {
-	struct rq_wb *rwb = RQWB(wbt_rq_qos(q));
-
-	rwb->enable_state = WBT_STATE_ON_DEFAULT;
-	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
+	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_wb *rwb = RQWB(rqos);
 
-	wbt_queue_depth_changed(&rwb->rqos);
+	rwb->rq_depth.queue_depth = blk_queue_depth(rqos->q);
 	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
+
+	wbt_set_min_lat(q, wbt_default_latency_nsec(q), false);
 }
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index de07963f3544..d9b643a55407 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -93,7 +93,7 @@ void wbt_disable_default(struct request_queue *);
 void wbt_enable_default(struct request_queue *);
 
 u64 wbt_get_min_lat(struct request_queue *q);
-void wbt_set_min_lat(struct request_queue *q, u64 val);
+void wbt_set_min_lat(struct request_queue *q, u64 val, bool manual);
 
 void wbt_set_write_cache(struct request_queue *, bool);
 
@@ -124,7 +124,7 @@ static inline u64 wbt_get_min_lat(struct request_queue *q)
 {
 	return 0;
 }
-static inline void wbt_set_min_lat(struct request_queue *q, u64 val)
+static inline void wbt_set_min_lat(struct request_queue *q, u64 val, bool manual)
 {
 }
 static inline u64 wbt_default_latency_nsec(struct request_queue *q)
-- 
2.29.2

