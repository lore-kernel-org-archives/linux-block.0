Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDE1C433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 07:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8662F2073E
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 07:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlbErO/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgF3HLh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:11:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58118 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730744AbgF3HLf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 03:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593501094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xhoPutkyqbOsiH7sncGrGhfwZrWqqg6HbT1yyR71zA=;
        b=JlbErO/mpiBEZsIzJaHdkdFpCKY2dr1CxOoQe+rSP2v9RYyXakhQwOtJyHJk/pHP70YIJz
        zec2DfGxtP5tRDRJ1p/rmrvsZtGRLyYffXmaOzL1/MODdvb1mNMILAe6AoUWjiFM8U1I/Z
        XoTjWN+nJjEx1iNWe0GiIfNi4+UWLOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-uzQ0IDxUM4eZm9egcbhwIg-1; Tue, 30 Jun 2020 03:11:32 -0400
X-MC-Unique: uzQ0IDxUM4eZm9egcbhwIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D34B4800C64;
        Tue, 30 Jun 2020 07:11:30 +0000 (UTC)
Received: from localhost (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 570F71002397;
        Tue, 30 Jun 2020 07:11:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V2 2/3] blk-mq: move blk_mq_put_driver_tag() into blk-mq.c
Date:   Tue, 30 Jun 2020 15:11:07 +0800
Message-Id: <20200630071108.2192017-3-ming.lei@redhat.com>
In-Reply-To: <20200630071108.2192017-1-ming.lei@redhat.com>
References: <20200630071108.2192017-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

