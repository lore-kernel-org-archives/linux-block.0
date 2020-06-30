Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFE1C433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 02:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC72D20722
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 02:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQ0Y8rke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgF3CY0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:24:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726288AbgF3CYZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 22:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593483865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+Dy1ZMcxmsCb2pxnoVi3wRRxemKqrRshy0emPRSqdI=;
        b=OQ0Y8rkeo1ecp37PkMuc8A5DE1J19eNTlS9ah6YYR3vUZZYlPq/aRn4/Q/UTjYnSWmNbEy
        478rcjBS676y2TN9u5TnhwEDvZEVFIoluRnDapShyFljcau/EigXfIKPva9dJiWr18jyag
        lsQk+Gi6ukhf8FC2ei0zr1+5YISBqJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-dBkBOcc0P0WdB2MJXEvZ9w-1; Mon, 29 Jun 2020 22:24:17 -0400
X-MC-Unique: dBkBOcc0P0WdB2MJXEvZ9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 363F5804001;
        Tue, 30 Jun 2020 02:24:16 +0000 (UTC)
Received: from localhost (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B3897166E;
        Tue, 30 Jun 2020 02:24:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 2/3] blk-mq: move blk_mq_put_driver_tag() into blk-mq.c
Date:   Tue, 30 Jun 2020 10:23:55 +0800
Message-Id: <20200630022356.2149607-3-ming.lei@redhat.com>
In-Reply-To: <20200630022356.2149607-1-ming.lei@redhat.com>
References: <20200630022356.2149607-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is used by blk-mq.c only, so move it to the source file.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 20 ++++++++++++++++++++
 block/blk-mq.h | 20 --------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0438bf388fde..cabeeeb3d56c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -670,6 +670,26 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
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
index b3ce0f3a2ad2..a62ca18b5bde 100644
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

