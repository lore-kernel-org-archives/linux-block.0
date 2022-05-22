Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722BBC433EF
	for <linux-block@archiver.kernel.org>; Sun, 22 May 2022 12:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiEVMYD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 May 2022 08:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiEVMYC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 May 2022 08:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D18C3BBDE
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 05:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653222240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vGe10+KvALtqKSJJ4vZvOXErApf4ZIk806K3vNO5L8A=;
        b=hVA0T3pkKSXE0HT6+reMMJgn8RVlY/S/Bg9ra4zZB4vsR7+pQz4lUztONby0jL7I3L1aGp
        6xeGeltydpW/nC5Pjp9UPn43lUoG2IquCEBMREVIIOfNWP9GoX2SJ1bmSOZ51NIux7h+RR
        icv544VE68iZR4UviYLsQ7b1LHb19bo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-FaPG7--JMVW6u2rxeb7b9A-1; Sun, 22 May 2022 08:23:57 -0400
X-MC-Unique: FaPG7--JMVW6u2rxeb7b9A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D70243831C40;
        Sun, 22 May 2022 12:23:56 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4270492C14;
        Sun, 22 May 2022 12:23:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH] blk-mq: don't touch ->tagset in blk_mq_get_sq_hctx
Date:   Sun, 22 May 2022 20:23:50 +0800
Message-Id: <20220522122350.743103-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_run_hw_queues() could be run when there isn't queued request and
after queue is cleaned up, at that time tagset is freed, because tagset
lifetime is covered by driver, and often freed after blk_cleanup_queue()
returns.

So don't touch ->tagset for figuring out current default hctx by the mapping
built in request queue, so use-after-free on tagset can be avoided. Meantime
this way should be fast than retrieving mapping from tagset.

Cc: "yukuai (C)" <yukuai3@huawei.com>
Cc: Jan Kara <jack@suse.cz>
Fixes: b6e68ee82585 ("blk-mq: Improve performance of non-mq IO schedulers with multiple HW queues")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ed1869a305c4..5789e971ac83 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2174,8 +2174,7 @@ static bool blk_mq_has_sqsched(struct request_queue *q)
  */
 static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-
+	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
 	/*
 	 * If the IO scheduler does not respect hardware queues when
 	 * dispatching, we just don't bother with multiple HW queues and
@@ -2183,8 +2182,8 @@ static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
 	 * just causes lock contention inside the scheduler and pointless cache
 	 * bouncing.
 	 */
-	hctx = blk_mq_map_queue_type(q, HCTX_TYPE_DEFAULT,
-				     raw_smp_processor_id());
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, 0, ctx);
+
 	if (!blk_mq_hctx_stopped(hctx))
 		return hctx;
 	return NULL;
-- 
2.31.1

