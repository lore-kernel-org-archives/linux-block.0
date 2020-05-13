Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97A0CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC675205ED
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNI5p2rF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388518AbgEMJ6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 05:58:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32648 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733173AbgEMJzN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 05:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589363712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPVkpvOQd8zPbtjxYB12SvjSZqx4lZQT/UJJotiJUDY=;
        b=iNI5p2rFfTQYkesFgoSE3tF0E/Q2Ao0l1gIQMNpnbbl/54n/foGfZuQd2ml6RailjjZ8f5
        UUpQVlXu18jSd0OyrRKfLHPcSYeTbi1ZfN96rx4TP+Vca7lJ3t8dbZ7pdkSysP1DF5BIzc
        H17P6zV5y4zVSZOsLLON1dpVK7kdM3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-FM0cUI_TMXKPCkuWbEUhtA-1; Wed, 13 May 2020 05:55:10 -0400
X-MC-Unique: FM0cUI_TMXKPCkuWbEUhtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1934107ACF2;
        Wed, 13 May 2020 09:55:08 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2349B1002395;
        Wed, 13 May 2020 09:55:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 3/9] blk-mq: don't predicate last flag in blk_mq_dispatch_rq_list
Date:   Wed, 13 May 2020 17:54:37 +0800
Message-Id: <20200513095443.2038859-4-ming.lei@redhat.com>
In-Reply-To: <20200513095443.2038859-1-ming.lei@redhat.com>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

.commit_rqs() is supposed to handle partial dispatch when driver may not
see .last of flag passed to .queue_rq().

We have added .commit_rqs() in case of partial dispatch and all consumers
of bd->last have implemented .commit_rqs() callback, so it is perfect to
pass real .last flag of the request list to .queue_rq() instead of faking
it by trying to allocate driver tag for next request in the batching list.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f064e7923ea5..f8c4b59022d7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1169,16 +1169,6 @@ static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
 static void blk_mq_handle_dev_resource(struct request *rq,
 				       struct list_head *list)
 {
-	struct request *next =
-		list_first_entry_or_null(list, struct request, queuelist);
-
-	/*
-	 * If an I/O scheduler has been configured and we got a driver tag for
-	 * the next request already, free it.
-	 */
-	if (next)
-		blk_mq_put_driver_tag(next);
-
 	list_add(&rq->queuelist, list);
 	__blk_mq_requeue_request(rq);
 }
@@ -1203,7 +1193,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			     bool got_budget)
 {
 	struct request_queue *q = hctx->queue;
-	struct request *rq, *nxt;
+	struct request *rq;
 	bool no_tag = false;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
@@ -1254,17 +1244,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		list_del_init(&rq->queuelist);
 
 		bd.rq = rq;
-
-		/*
-		 * Flag last if we have no more requests, or if we have more
-		 * but can't assign a driver tag to it.
-		 */
-		if (list_empty(list))
-			bd.last = true;
-		else {
-			nxt = list_first_entry(list, struct request, queuelist);
-			bd.last = !blk_mq_get_driver_tag(nxt);
-		}
+		bd.last = !!list_empty(list);
 
 		ret = q->mq_ops->queue_rq(hctx, &bd);
 		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
-- 
2.25.2

