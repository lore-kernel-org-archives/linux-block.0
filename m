Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77200C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCDA610E8
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhKBNjI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhKBNjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 09:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635860192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXWPLvmIvIpWpYQNoCyN9Hr6YVEJhoAqMIWqGgjnxIc=;
        b=cLkffM3aQNx/DZ+xVe6ce1MggAznACQx75rG+HwiJjF5kwouhmsJmzb7nmGybt0L1c7K1W
        +Fhdj1dqufEQUpDQ/2GBcL+2V7W+0OmENhDyvB4y5j2O5NjSxv5J7sVe/i5MS10deP/BI3
        ON02kbzdHeTUy/z4CLi5wQ4dR1Q59gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-tsenJyHJOzidNQMig2iG9w-1; Tue, 02 Nov 2021 09:36:29 -0400
X-MC-Unique: tsenJyHJOzidNQMig2iG9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79AB9A40C5;
        Tue,  2 Nov 2021 13:36:28 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8F3B652AC;
        Tue,  2 Nov 2021 13:36:27 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 3/3] blk-mq: update hctx->nr_active in blk_mq_end_request_batch()
Date:   Tue,  2 Nov 2021 21:35:02 +0800
Message-Id: <20211102133502.3619184-4-ming.lei@redhat.com>
In-Reply-To: <20211102133502.3619184-1-ming.lei@redhat.com>
References: <20211102133502.3619184-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of shared tags and none io sched, batched completion still may
be run into, and hctx->nr_active is accounted when getting driver tag,
so it has to be updated in blk_mq_end_request_batch().

Otherwise, hctx->nr_active may become same with queue depth, then
hctx_may_queue() always return false, then io hang is caused.

Fixes the issue by updating the counter in batched way.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 15 +++++++++++++--
 block/blk-mq.h | 12 +++++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 07eb1412760b..0dbe75034f61 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -825,6 +825,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 	struct blk_mq_hw_ctx *cur_hctx = NULL;
 	struct request *rq;
 	u64 now = 0;
+	int active = 0;
 
 	if (iob->need_ts)
 		now = ktime_get_ns();
@@ -846,16 +847,26 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 		rq_qos_done(rq->q, rq);
 
 		if (nr_tags == TAG_COMP_BATCH || cur_hctx != rq->mq_hctx) {
-			if (cur_hctx)
+			if (cur_hctx) {
+				if (active)
+					__blk_mq_sub_active_requests(cur_hctx,
+							active);
 				blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
+			}
 			nr_tags = 0;
+			active = 0;
 			cur_hctx = rq->mq_hctx;
 		}
 		tags[nr_tags++] = rq->tag;
+		if (rq->rq_flags & RQF_MQ_INFLIGHT)
+			active++;
 	}
 
-	if (nr_tags)
+	if (nr_tags) {
+		if (active)
+			__blk_mq_sub_active_requests(cur_hctx, active);
 		blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_end_request_batch);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 28859fc5faee..cb0b5482ca5e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -225,12 +225,18 @@ static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
 		atomic_inc(&hctx->nr_active);
 }
 
-static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
+static inline void __blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx,
+		int val)
 {
 	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_dec(&hctx->queue->nr_active_requests_shared_tags);
+		atomic_sub(val, &hctx->queue->nr_active_requests_shared_tags);
 	else
-		atomic_dec(&hctx->nr_active);
+		atomic_sub(val, &hctx->nr_active);
+}
+
+static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
+{
+	__blk_mq_sub_active_requests(hctx, 1);
 }
 
 static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
-- 
2.31.1

