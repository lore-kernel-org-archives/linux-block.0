Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCE6C433E1
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 14:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D09B2072D
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 14:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOlYI/7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgF3OGK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:06:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27113 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727796AbgF3OGK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 10:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593525969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbTRV9MsJQXIzJlQjpMUH7twG0bNBZyKPOlpoJXSEpc=;
        b=bOlYI/7xx8uoJxiBU6VkKzTYQRbsANXfMjc+tGTJBGHI+kzXxnKbUSlX9YBzx4dnXnwGBg
        IhLmmZcsnbpLxP74cfikjwnTaP2rHyC0rCIhqGxhz7sxSe8nd3byNcDV8FhKM4tVTGT/4Z
        47HRxGYsb4XoZ0NZRoaX3FmywKvBpH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-zalfAWSFOM6VmxhFLg97rg-1; Tue, 30 Jun 2020 10:06:00 -0400
X-MC-Unique: zalfAWSFOM6VmxhFLg97rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DD278064B4;
        Tue, 30 Jun 2020 14:04:19 +0000 (UTC)
Received: from localhost (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 983A85DD64;
        Tue, 30 Jun 2020 14:04:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 2/3] blk-mq: move blk_mq_put_driver_tag() into blk-mq.c
Date:   Tue, 30 Jun 2020 22:03:56 +0800
Message-Id: <20200630140357.2251174-3-ming.lei@redhat.com>
In-Reply-To: <20200630140357.2251174-1-ming.lei@redhat.com>
References: <20200630140357.2251174-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is used by blk-mq.c only, so move it to the source file.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 20 ++++++++++++++++++++
 block/blk-mq.h | 20 --------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6ed033b1f1e0..e7a2d2d44b51 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -666,6 +666,26 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	return cpu_online(rq->mq_ctx->cpu);
 }
 
+static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
+		struct request *rq)
+{
+	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
+	rq->tag = BLK_MQ_NO_TAG;
+
+	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
+		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
+		atomic_dec(&hctx->nr_active);
+	}
+}
+
+static inline void blk_mq_put_driver_tag(struct request *rq)
+{
+	if (rq->tag == BLK_MQ_NO_TAG || rq->internal_tag == BLK_MQ_NO_TAG)
+		return;
+
+	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
+}
+
 bool blk_mq_complete_request_remote(struct request *rq)
 {
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index c6330335767c..a2b5cf6bac90 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -196,26 +196,6 @@ static inline bool blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
 	return true;
 }
 
-static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
-					   struct request *rq)
-{
-	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
-	rq->tag = BLK_MQ_NO_TAG;
-
-	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
-		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
-		atomic_dec(&hctx->nr_active);
-	}
-}
-
-static inline void blk_mq_put_driver_tag(struct request *rq)
-{
-	if (rq->tag == BLK_MQ_NO_TAG || rq->internal_tag == BLK_MQ_NO_TAG)
-		return;
-
-	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
-}
-
 static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 {
 	int cpu;
-- 
2.25.2

