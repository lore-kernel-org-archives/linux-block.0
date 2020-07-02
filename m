Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C6AC433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1BC20890
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 13:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QY6pKMA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgGBNs5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:48:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52070 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729051AbgGBNs5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Jul 2020 09:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593697735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+rksHFjV0yadIZIcVMvp6y2JPFf0rgZafnB/VI5t9Uc=;
        b=QY6pKMA+0VBnF2MGKZWemat8v1Y+fZbk05PCZu7and+eblBQ4r18/INt4aonhPlAKDiBtp
        2Ignh0ZiSVShuxWFS5QcT5MrlsWH2W7ItwJ8T8BiHqoigNRJAtD24aC9cKJMNMAC83VQUC
        llQ3vNpyDHwIoBwIsES+ZWhsSlxSse0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-Dtl6b2BROZqxbZ00Wy-r7w-1; Thu, 02 Jul 2020 09:48:51 -0400
X-MC-Unique: Dtl6b2BROZqxbZ00Wy-r7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3937EC1A0;
        Thu,  2 Jul 2020 13:48:50 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91C1F5C1C5;
        Thu,  2 Jul 2020 13:48:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] blk-mq: release driver tag before freeing request via .end_io
Date:   Thu,  2 Jul 2020 21:48:38 +0800
Message-Id: <20200702134838.2822844-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The built-in flush request shares tag with the request inserted to flush
machinery, turns out its .end_io callback has to touch the built-in
flush request's internal tag or tag.

On the other hand, we have to make sure that driver tag is released
from __blk_mq_end_request(), since this request may not be completed
via blk_mq_complete_request().

Given we have moved blk_mq_put_driver_tag() out of header file, fix this
issue by releasing driver tag before calling .end_io().

Cc: Christoph Hellwig <hch@lst.de>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 36a3df5a4574("blk-mq: put driver tag when this request is completed")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 948987e9b6ab..6b36969220c1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -532,6 +532,26 @@ void blk_mq_free_request(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
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
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
 	u64 now = 0;
@@ -551,6 +571,7 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 
 	if (rq->end_io) {
 		rq_qos_done(rq->q, rq);
+		blk_mq_put_driver_tag(rq);
 		rq->end_io(rq, error);
 	} else {
 		blk_mq_free_request(rq);
@@ -660,26 +681,6 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	return cpu_online(rq->mq_ctx->cpu);
 }
 
-static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
-		struct request *rq)
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
 bool blk_mq_complete_request_remote(struct request *rq)
 {
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
@@ -983,9 +984,10 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	if (blk_mq_req_expired(rq, next))
 		blk_mq_rq_timed_out(rq, reserved);
 
-	if (is_flush_rq(rq, hctx))
+	if (is_flush_rq(rq, hctx)) {
+		blk_mq_put_driver_tag(rq);
 		rq->end_io(rq, 0);
-	else if (refcount_dec_and_test(&rq->ref))
+	} else if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 
 	return true;
-- 
2.25.2

