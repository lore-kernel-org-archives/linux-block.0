Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC9EC77B7F
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241143AbjELPHP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbjELPHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039E11FC7
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683903991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3tzsnv4sZBdT54STtzEztQmvQ7FmzobkD/NnhEhEZgw=;
        b=Ue1x75YmGrOmZ84xggYR8YjHWiTafc4+jCYpJlLgd+7A2tzXncPy9zPzZhU3396Fl+3383
        ni4CDigbhKlTQEFAry1d5sbIvHEABRgigTwyrM+HDO8P8M0RZxthQt+A4n9mdJCYW0pV0D
        Y7b55CXJdvHjlC9FmT9AhMpl1lNXDUQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-1Zc5zByRM0Wd4o4XBL92TA-1; Fri, 12 May 2023 11:06:28 -0400
X-MC-Unique: 1Zc5zByRM0Wd4o4XBL92TA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEAF01C06901;
        Fri, 12 May 2023 15:06:27 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF9020268C4;
        Fri, 12 May 2023 15:06:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Subject: [PATCH] blk-mq: don't queue passthrough request into scheduler
Date:   Fri, 12 May 2023 23:03:28 +0800
Message-Id: <20230512150328.192908-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Passthrough(pt) request shouldn't be queued to scheduler, especially some
schedulers(such as bfq) supposes that req->bio is always available and
blk-cgroup can be retrieved via bio.

Sometimes pt request could be part of error handling, so it is better to always
queue it into hctx->dispatch directly.

Fix this issue by queuing pt request from plug list to hctx->dispatch
directly.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Investigated-by: Yu Kuai <yukuai1@huaweicloud.com>
Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
Guang Wu, please test this patch and provide us the result.

 block/blk-mq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6dad0886a2f..11efaefa26c3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2711,6 +2711,7 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 	struct request *requeue_list = NULL;
 	struct request **requeue_lastp = &requeue_list;
 	unsigned int depth = 0;
+	bool pt = false;
 	LIST_HEAD(list);
 
 	do {
@@ -2719,7 +2720,9 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 		if (!this_hctx) {
 			this_hctx = rq->mq_hctx;
 			this_ctx = rq->mq_ctx;
-		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx) {
+			pt = blk_rq_is_passthrough(rq);
+		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
+				pt != blk_rq_is_passthrough(rq)) {
 			rq_list_add_tail(&requeue_lastp, rq);
 			continue;
 		}
@@ -2731,10 +2734,15 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 	trace_block_unplug(this_hctx->queue, depth, !from_sched);
 
 	percpu_ref_get(&this_hctx->queue->q_usage_counter);
-	if (this_hctx->queue->elevator) {
+	if (this_hctx->queue->elevator && !pt) {
 		this_hctx->queue->elevator->type->ops.insert_requests(this_hctx,
 				&list, 0);
 		blk_mq_run_hw_queue(this_hctx, from_sched);
+	} else if (pt) {
+		spin_lock(&this_hctx->lock);
+		list_splice_tail_init(&list, &this_hctx->dispatch);
+		spin_unlock(&this_hctx->lock);
+		blk_mq_run_hw_queue(this_hctx, from_sched);
 	} else {
 		blk_mq_insert_requests(this_hctx, this_ctx, &list, from_sched);
 	}
-- 
2.38.1

