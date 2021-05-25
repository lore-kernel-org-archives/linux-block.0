Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F35C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A88F613F9
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhEYIKm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 04:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232071AbhEYIJb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 04:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621930081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C3llJXoDuiPYylIMM8bn1rlkiA+EdyWLy+D4tXu3fjY=;
        b=TOkVlhDN7On4/twl4V5lsf6O6BC7w6xYv2Lq8gW+8YFr0CvfhfFoZYUKv1xaGSjUprj1VF
        wJIN1TnS64QGawiKONzJP4lFswLg+goSwEENyC967HKqnkcBvhQralEykHCTRvJlrxdaRq
        yU6nC3BH5xLKNn0w83sGVjESL4oldlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-oaR9eIkjMKWLRehCAXyp8g-1; Tue, 25 May 2021 04:05:02 -0400
X-MC-Unique: oaR9eIkjMKWLRehCAXyp8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5746A180FD61;
        Tue, 25 May 2021 08:05:01 +0000 (UTC)
Received: from localhost (ovpn-13-203.pek2.redhat.com [10.72.13.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A623219CBC;
        Tue, 25 May 2021 08:05:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 2/4] block: move wbt allocation into blk_alloc_queue
Date:   Tue, 25 May 2021 16:04:40 +0800
Message-Id: <20210525080442.1896417-3-ming.lei@redhat.com>
In-Reply-To: <20210525080442.1896417-1-ming.lei@redhat.com>
References: <20210525080442.1896417-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

wbt_init() calls wbt_alloc() which adds allocated wbt instance into
q->rq_qos. This way is very dangerous because q->rq_qos is accessed in
IO fast path.

So far wbt_init() is called in the two code paths:

1) blk_register_queue(), when the block device has been exposed to
usespace, so IO may come when adding wbt into q->rq_qos

2) sysfs attribute store, in which normal IO is definitely allowed

Move wbt allocation into blk_alloc_queue() for avoiding to add wbt
instance dynamically to q->rq_qos. And before calling wbt_init(), the
wbt is disabled, so functionally it works as expected.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       |  6 ++++++
 block/blk-mq-debugfs.c |  3 +++
 block/blk-sysfs.c      |  8 --------
 block/blk-wbt.c        | 21 ++++++---------------
 block/blk-wbt.h        | 10 +++++++---
 5 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 689aac2625d2..e7d9eac5d4c1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -51,6 +51,7 @@
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
 #include "blk-rq-qos.h"
+#include "blk-wbt.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -579,12 +580,17 @@ struct request_queue *blk_alloc_queue(int node_id)
 	if (blkcg_init_queue(q))
 		goto fail_ref;
 
+	if (wbt_alloc(q))
+		goto fail_blkcg;
+
 	blk_queue_dma_alignment(q, 511);
 	blk_set_default_limits(&q->limits);
 	q->nr_requests = BLKDEV_MAX_RQ;
 
 	return q;
 
+fail_blkcg:
+	blkcg_exit_queue(q);
 fail_ref:
 	percpu_ref_exit(&q->q_usage_counter);
 fail_bdi:
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2a75bc7401df..c1790f313479 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -948,6 +948,9 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 	struct request_queue *q = rqos->q;
 	const char *dir_name = rq_qos_id_to_name(rqos->id);
 
+	if (!q->debugfs_dir)
+		return;
+
 	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
 		return;
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f89e2fc3963b..7fd4ffadcdfa 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -481,7 +481,6 @@ static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
 static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 				  size_t count)
 {
-	struct rq_qos *rqos;
 	ssize_t ret;
 	s64 val;
 
@@ -491,13 +490,6 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	if (val < -1)
 		return -EINVAL;
 
-	rqos = wbt_rq_qos(q);
-	if (!rqos) {
-		ret = wbt_init(q);
-		if (ret)
-			return ret;
-	}
-
 	if (val == -1)
 		val = wbt_default_latency_nsec(q);
 	else if (val >= 0)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index efff1232446f..5da48294e3e9 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -421,16 +421,14 @@ static void wbt_update_limits(struct rq_wb *rwb)
 u64 wbt_get_min_lat(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
-	if (!rqos)
-		return 0;
+
 	return RQWB(rqos)->min_lat_nsec;
 }
 
 void wbt_set_min_lat(struct request_queue *q, u64 val)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
-	if (!rqos)
-		return;
+
 	RQWB(rqos)->min_lat_nsec = val;
 	RQWB(rqos)->enable_state = WBT_STATE_ON_MANUAL;
 	wbt_update_limits(RQWB(rqos));
@@ -637,7 +635,7 @@ void wbt_enable_default(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
 	/* Throttling already enabled? */
-	if (rqos)
+	if (rwb_enabled(RQWB(rqos)))
 		return;
 
 	/* Queue not registered? Maybe shutting down... */
@@ -809,7 +807,7 @@ static struct rq_qos_ops wbt_rqos_ops = {
 #endif
 };
 
-static int wbt_alloc(struct request_queue *q)
+int wbt_alloc(struct request_queue *q)
 {
 	struct rq_wb *rwb;
 	int i;
@@ -844,20 +842,13 @@ static int wbt_alloc(struct request_queue *q)
 	return 0;
 }
 
-int wbt_init(struct request_queue *q)
+void wbt_init(struct request_queue *q)
 {
-	int ret = wbt_alloc(q);
-	struct rq_wb *rwb;
-
-	if (ret)
-		return ret;
+	struct rq_wb *rwb = RQWB(wbt_rq_qos(q));
 
-	rwb = RQWB(wbt_rq_qos(q));
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
 
 	wbt_queue_depth_changed(&rwb->rqos);
 	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
-
-	return 0;
 }
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 16bdc85b8df9..de07963f3544 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -87,7 +87,8 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 #ifdef CONFIG_BLK_WBT
 
-int wbt_init(struct request_queue *);
+int wbt_alloc(struct request_queue *q);
+void wbt_init(struct request_queue *);
 void wbt_disable_default(struct request_queue *);
 void wbt_enable_default(struct request_queue *);
 
@@ -103,9 +104,12 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 static inline void wbt_track(struct request *rq, enum wbt_flags flags)
 {
 }
-static inline int wbt_init(struct request_queue *q)
+static inline int wbt_alloc(struct request_queue *q)
+{
+	return 0;
+}
+static inline void wbt_init(struct request_queue *q)
 {
-	return -EINVAL;
 }
 static inline void wbt_disable_default(struct request_queue *q)
 {
-- 
2.29.2

