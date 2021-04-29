Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F11CC433B4
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 02:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCE561450
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 02:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhD2CgN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 22:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230072AbhD2CgM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 22:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619663726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQXeoS+XaQ76hbsBjxk9BFiNKkyWO53pTF0K8Fb40zY=;
        b=SSFPctuBmlfgjYiIFUleZVo8p8bXNeiEeKca2zYcCFmrvxcei5EECZtSJqyGvUE6nF/XKJ
        5FrVTEuhdiptfvrza067+mk2cw75TH0MsE3qfkw4D2i5ntEmCWxKdfIs79bbJb2xPsKbE7
        WIrXeEE7/sqzfsCIJZwTtjVzqewG0Kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-Rj56b4DFMYSuzICu-qcWDA-1; Wed, 28 Apr 2021 22:35:23 -0400
X-MC-Unique: Rj56b4DFMYSuzICu-qcWDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D019801106;
        Thu, 29 Apr 2021 02:35:21 +0000 (UTC)
Received: from localhost (ovpn-12-135.pek2.redhat.com [10.72.12.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC842E09A;
        Thu, 29 Apr 2021 02:35:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 4/4] blk-mq: clearing flush request reference in tags->rqs[]
Date:   Thu, 29 Apr 2021 10:34:58 +0800
Message-Id: <20210429023458.3044317-5-ming.lei@redhat.com>
In-Reply-To: <20210429023458.3044317-1-ming.lei@redhat.com>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before we free request queue, clearing flush request reference in
tags->rqs[], so that potential UAF can be avoided.

Based on one patch written by David Jeffery.

Cc: John Garry <john.garry@huawei.com>
Cc: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index abd0f7a9d052..e320d9798715 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2620,16 +2620,38 @@ static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
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
+	WARN_ON_ONCE(refcount_read(&flush_rq->ref) != 0);
+
+	spin_lock_irqsave(&tags->lock, flags);
+	for (i = 0; i < queue_depth; i++)
+		cmpxchg(&tags->rqs[i], flush_rq, NULL);
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

