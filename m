Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9D7C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 13:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352195AbhLCNTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:19:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352205AbhLCNTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Dec 2021 08:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638537388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5L34vCBxXxbCUbwvcEKUuee7nqESnn4K1ksjXFvRoI=;
        b=i1buKTIpXfPrLM+ZADBp6E73RL5Ryn55qBLdgVLVnq9jxCy3lMGX7VNHdmg8s2NGMGPtNw
        ZmWM/JmBm/VgSNSW3ay+pY+0yoGDAB1Sy+m+KdPYPpH4Mv/bQF8RGCoiwtgJ/tRonY3lvX
        VZYOeGndGMHsQwsWYxQ1xconl1AutOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-XZGSCsdYN4mYAPn9JublTQ-1; Fri, 03 Dec 2021 08:16:27 -0500
X-MC-Unique: XZGSCsdYN4mYAPn9JublTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0EF5760D0;
        Fri,  3 Dec 2021 13:16:21 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA8A77AB41;
        Fri,  3 Dec 2021 13:16:20 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] blk-mq: run dispatch lock once in case of issuing from list
Date:   Fri,  3 Dec 2021 21:15:34 +0800
Message-Id: <20211203131534.3668411-5-ming.lei@redhat.com>
In-Reply-To: <20211203131534.3668411-1-ming.lei@redhat.com>
References: <20211203131534.3668411-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It isn't necessary to call blk_mq_run_dispatch_ops() once for issuing
single request directly, and enough to do it one time when issuing from
whole list.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c |  3 ++-
 block/blk-mq.c       | 14 ++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 0d7257848f7e..55488ba97823 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -475,7 +475,8 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 		 * us one extra enqueue & dequeue to sw queue.
 		 */
 		if (!hctx->dispatch_busy && !run_queue_async) {
-			blk_mq_try_issue_list_directly(hctx, list);
+			blk_mq_run_dispatch_ops(hctx->queue,
+				blk_mq_try_issue_list_directly(hctx, list));
 			if (list_empty(list))
 				goto out;
 		}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 03dc76f92555..fa464a3e2f9a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2464,12 +2464,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 {
-	blk_status_t ret;
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
-
-	blk_mq_run_dispatch_ops(rq->q,
-		ret = __blk_mq_try_issue_directly(hctx, rq, true, last));
-	return ret;
+	return __blk_mq_try_issue_directly(rq->mq_hctx, rq, true, last);
 }
 
 static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
@@ -2526,7 +2521,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	plug->rq_count = 0;
 
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
-		blk_mq_plug_issue_direct(plug, false);
+		blk_mq_run_dispatch_ops(plug->mq_list->q,
+				blk_mq_plug_issue_direct(plug, false));
 		if (rq_list_empty(plug->mq_list))
 			return;
 	}
@@ -2867,7 +2863,9 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	 * bypass a potential scheduler on the bottom device for
 	 * insert.
 	 */
-	return blk_mq_request_issue_directly(rq, true);
+	blk_mq_run_dispatch_ops(rq->q,
+			ret = blk_mq_request_issue_directly(rq, true));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
 
-- 
2.31.1

