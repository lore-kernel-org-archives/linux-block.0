Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81642C433ED
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 15:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466A3615FF
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 15:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhEKPYf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 11:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231846AbhEKPY2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 11:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620746602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLavhOpUkDv3roiIt3N0fP9ZRDeZ486JE8ZzUDkfpV0=;
        b=cd2cZrT50ua7jpIhszs8/PjvHXrZ2lM7CXBpto2viGiX1HY13cyg6LW2RiSXzraWPSzMlJ
        xSTmB991n9EYgZWISPDC7er5pSHV0UGb0Uel8dWgu7GwCdpqTKh1R6m6eJCTqm2kENMGjj
        kx4NkJI8sRoeJiZIpdSOxcXCLQKQtsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-Lai-tkM2MgC_zqmPEdnILA-1; Tue, 11 May 2021 11:23:18 -0400
X-MC-Unique: Lai-tkM2MgC_zqmPEdnILA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74D7E8C8653;
        Tue, 11 May 2021 15:23:17 +0000 (UTC)
Received: from localhost (ovpn-12-205.pek2.redhat.com [10.72.12.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A3F866840;
        Tue, 11 May 2021 15:23:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        David Jeffery <djeffery@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 4/4] blk-mq: clearing flush request reference in tags->rqs[]
Date:   Tue, 11 May 2021 23:22:36 +0800
Message-Id: <20210511152236.763464-5-ming.lei@redhat.com>
In-Reply-To: <20210511152236.763464-1-ming.lei@redhat.com>
References: <20210511152236.763464-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before we free request queue, clearing flush request reference in
tags->rqs[], so that potential UAF can be avoided.

Based on one patch written by David Jeffery.

Tested-by: John Garry <john.garry@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 626b4483e006..41b64bbf2154 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2642,16 +2642,49 @@ static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 					    &hctx->cpuhp_dead);
 }
 
+/*
+ * Before freeing hw queue, clearing the flush request reference in
+ * tags->rqs[] for avoiding potential UAF.
+ */
+static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
+		unsigned int queue_depth, struct request *flush_rq)
+{
+	int i;
+	unsigned long flags;
+
+	/* The hw queue may not be mapped yet */
+	if (!tags)
+		return;
+
+	WARN_ON_ONCE(refcount_read(&flush_rq->ref) != 0);
+
+	for (i = 0; i < queue_depth; i++)
+		cmpxchg(&tags->rqs[i], flush_rq, NULL);
+
+	/*
+	 * Wait until all pending iteration is done.
+	 *
+	 * Request reference is cleared and it is guaranteed to be observed
+	 * after the ->lock is released.
+	 */
+	spin_lock_irqsave(&tags->lock, flags);
+	spin_unlock_irqrestore(&tags->lock, flags);
+}
+
 /* hctx->ctxs will be freed in queue's release handler */
 static void blk_mq_exit_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
+	struct request *flush_rq = hctx->fq->flush_rq;
+
 	if (blk_mq_hw_queue_mapped(hctx))
 		blk_mq_tag_idle(hctx);
 
+	blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
+			set->queue_depth, flush_rq);
 	if (set->ops->exit_request)
-		set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
+		set->ops->exit_request(set, flush_rq, hctx_idx);
 
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
-- 
2.29.2

