Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD74C7EE2C
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 14:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjEOOtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 10:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjEOOtF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 10:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3F310E7
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684162092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BezdMmFur1+mPESSTDe8haOWPaj4BeqZewTpb/LMRkE=;
        b=BzEcBtZAz6XuSCRLG/ZUVgdUBE7QpylBRHsovZmysWY9+JvXHEp+yUPpLE2cMh3Wnczc0u
        gCtZAmGD+TK5OHW4OUSBifT3d/Das48YSmjQOmNL1kRK83yXWGpvk8vbGd+MzKUiX/h3JC
        rrRFJNxeHf/xBbenqd1IF7yTwtkI0UE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-olr1CMTLOBm86LuZ1YXqLA-1; Mon, 15 May 2023 10:48:06 -0400
X-MC-Unique: olr1CMTLOBm86LuZ1YXqLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DDC61C0513D;
        Mon, 15 May 2023 14:48:06 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A69B1121314;
        Mon, 15 May 2023 14:48:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Subject: [PATCH V2 1/2] blk-mq: don't queue plugged passthrough requests into scheduler
Date:   Mon, 15 May 2023 22:46:00 +0800
Message-Id: <20230515144601.52811-2-ming.lei@redhat.com>
In-Reply-To: <20230515144601.52811-1-ming.lei@redhat.com>
References: <20230515144601.52811-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Passthrough(pt) request shouldn't be queued to scheduler, especially some
schedulers(such as bfq) supposes that req->bio is always available, then
blk-cgroup can be retrieved via bio.

We never let passthrough request cross scheduler before commit 1c2d2fff6dc0
("block: wire-up support for passthrough plugging").

Fix this issue by queuing pt request from plug list to hctx->dispatch
directly.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAGS2=YosaYaUTEMU3uaf+y=8MqSrhL7sYsJn8EwbaM=76p_4Qg@mail.gmail.com/
Investigated-by: Yu Kuai <yukuai1@huaweicloud.com>
Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6dad0886a2f..b4aaf42f1125 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2711,6 +2711,7 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 	struct request *requeue_list = NULL;
 	struct request **requeue_lastp = &requeue_list;
 	unsigned int depth = 0;
+	bool pt = false;
 	LIST_HEAD(list);
 
 	do {
@@ -2719,7 +2720,14 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 		if (!this_hctx) {
 			this_hctx = rq->mq_hctx;
 			this_ctx = rq->mq_ctx;
-		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx) {
+			pt = blk_rq_is_passthrough(rq);
+		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
+				pt != blk_rq_is_passthrough(rq)) {
+			/*
+			 * Both passthrough and flush request don't belong to
+			 * scheduler, but flush request won't be added to plug
+			 * list, so needn't handle here.
+			 */
 			rq_list_add_tail(&requeue_lastp, rq);
 			continue;
 		}
@@ -2731,7 +2739,13 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 	trace_block_unplug(this_hctx->queue, depth, !from_sched);
 
 	percpu_ref_get(&this_hctx->queue->q_usage_counter);
-	if (this_hctx->queue->elevator) {
+	/* passthrough requests don't belong to scheduler */
+	if (pt) {
+		spin_lock(&this_hctx->lock);
+		list_splice_tail_init(&list, &this_hctx->dispatch);
+		spin_unlock(&this_hctx->lock);
+		blk_mq_run_hw_queue(this_hctx, from_sched);
+	} else if (this_hctx->queue->elevator) {
 		this_hctx->queue->elevator->type->ops.insert_requests(this_hctx,
 				&list, 0);
 		blk_mq_run_hw_queue(this_hctx, from_sched);
-- 
2.40.1

