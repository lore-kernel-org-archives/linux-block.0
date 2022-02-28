Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC4FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 09:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiB1JGd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiB1JGc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 04:06:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB89D33EBF
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 01:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646039153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qkuwlvhLObS1dBGr9zr0uuYo9uicpGy4djEbruXb6c=;
        b=ecGaplhtF3P0vB5nNNTyj+iGu3ihTW2Ya2mlm4gP+3T/1kFRUoyamJsT4qtx1wbTmk1w6e
        Nfl4/LTCI2recgDWwucGyeojlrP488kjV6oPBkMyAH4/0tZ1VczK0JrJu2B/gLVO0ssa7R
        uhl1i+8BgDagbYEyiK80ORdDMagxFQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-mVmIXTnnO3G8Q-8pJImThQ-1; Mon, 28 Feb 2022 04:05:49 -0500
X-MC-Unique: mVmIXTnnO3G8Q-8pJImThQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 482CD835DE1;
        Mon, 28 Feb 2022 09:05:48 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6666A27CD3;
        Mon, 28 Feb 2022 09:05:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/6] blk-mq: add helper of blk_mq_get_hctx to retrieve hctx via its index
Date:   Mon, 28 Feb 2022 17:04:29 +0800
Message-Id: <20220228090430.1064267-6-ming.lei@redhat.com>
In-Reply-To: <20220228090430.1064267-1-ming.lei@redhat.com>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for managing hctx mapping via xarray by adding one helper of
blk_mq_get_hctx().

No functional change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c   | 2 +-
 block/blk-mq.c         | 4 ++--
 block/blk-mq.h         | 2 +-
 include/linux/blk-mq.h | 8 +++++++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 674786574075..22950e764536 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -279,7 +279,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 unreg:
 	while (--i >= 0)
-		blk_mq_unregister_hctx(q->queue_hw_ctx[i]);
+		blk_mq_unregister_hctx(blk_mq_get_hctx(q, i));
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ce6a8289cff..d01c1693a3d4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -71,7 +71,7 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
 		blk_qc_t qc)
 {
-	return q->queue_hw_ctx[(qc & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT];
+	return blk_mq_get_hctx(q, (qc & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT);
 }
 
 static inline struct request *blk_qc_to_rq(struct blk_mq_hw_ctx *hctx,
@@ -573,7 +573,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * If not tell the caller that it should skip this queue.
 	 */
 	ret = -EXDEV;
-	data.hctx = q->queue_hw_ctx[hctx_idx];
+	data.hctx = blk_mq_get_hctx(q, hctx_idx);
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 948791ea2a3e..804668457f88 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -83,7 +83,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
 							  enum hctx_type type,
 							  unsigned int cpu)
 {
-	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
+	return blk_mq_get_hctx(q, q->tag_set->map[type].mq_map[cpu]);
 }
 
 static inline enum hctx_type blk_mq_get_hctx_type(unsigned int flags)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3a41d50b85d3..3d949b1968f3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -916,9 +916,15 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	return rq + 1;
 }
 
+static inline struct blk_mq_hw_ctx *blk_mq_get_hctx(struct request_queue *q,
+		unsigned int hctx_idx)
+{
+	return q->queue_hw_ctx[hctx_idx];
+}
+
 #define queue_for_each_hw_ctx(q, hctx, i)				\
 	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
-	     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
+	     ({ hctx = blk_mq_get_hctx((q), (i)); 1; }); (i)++)
 
 #define hctx_for_each_ctx(hctx, ctx, i)					\
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
-- 
2.31.1

