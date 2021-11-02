Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ACEC433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB76B60F58
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhKBPjd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233656AbhKBPj3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 11:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635867414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31Ok66XEPhp9sqd8nMCvsKKB7GAcyygHCzpmKib6YqM=;
        b=TwQ68n87kXzywZYrIIBEAEJNxj/LnhwXYcmnJCDAdwB7PbbfV51bFfSYQrp97ERC30uBZ0
        LukOPZREHGak85R5q2CSyxFYbarti1kgJKDeUO8OsoEzcpHkLLNrKArDXx4As4QFNlvnH/
        +F5BFDiz9x6Yh+I+d9le5GCHC7OkgJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-bqWTCSBSNyWS2HruLB_NxA-1; Tue, 02 Nov 2021 11:36:50 -0400
X-MC-Unique: bqWTCSBSNyWS2HruLB_NxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8E7A100D684;
        Tue,  2 Nov 2021 15:36:49 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56CB060BE5;
        Tue,  2 Nov 2021 15:36:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH V2 3/3] blk-mq: update hctx->nr_active in blk_mq_end_request_batch()
Date:   Tue,  2 Nov 2021 23:36:19 +0800
Message-Id: <20211102153619.3627505-4-ming.lei@redhat.com>
In-Reply-To: <20211102153619.3627505-1-ming.lei@redhat.com>
References: <20211102153619.3627505-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 block/blk-mq.c |  7 +++++++
 block/blk-mq.h | 12 +++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 07eb1412760b..2a2c57c98bbd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -815,6 +815,13 @@ static inline void blk_mq_flush_tag_batch(struct blk_mq_hw_ctx *hctx,
 {
 	struct request_queue *q = hctx->queue;
 
+	/*
+	 * All requests should have been marked as RQF_MQ_INFLIGHT, so
+	 * update hctx->nr_active in batch
+	 */
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_sub_active_requests(hctx, nr_tags);
+
 	blk_mq_put_tags(hctx->tags, tag_array, nr_tags);
 	percpu_ref_put_many(&q->q_usage_counter, nr_tags);
 }
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

