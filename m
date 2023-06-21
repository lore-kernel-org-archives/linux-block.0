Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0555EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 13:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjFUNXG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFUNXF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 09:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F077B6
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687353737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ovHtzVHjVMANu8Tm9937l2KbQq/OXmGVE+bIYJlM+C8=;
        b=ZPx8sAIA6ZLEW/z9ClQ/+o16JHtOeFwa4YH/1L2ar9SSr20+R/e/H1pHEt9c3XC+eAEF7+
        ctyOX7vY2kL7zzY/+660ITwPtpDvRgFK8gNFMVhcAiwcMkffadAr0gUBuVaarHWuDGLqdn
        J8fWIsabnpw5LA5Ug/Y286Nyc02Urcs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-PueVECu0MxWNE9rSQkeW1w-1; Wed, 21 Jun 2023 09:22:16 -0400
X-MC-Unique: PueVECu0MxWNE9rSQkeW1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1FD529DD98B;
        Wed, 21 Jun 2023 13:22:15 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26934112132C;
        Wed, 21 Jun 2023 13:22:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>
Subject: [PATCH] blk-mq: don't insert passthrough request into sw queue
Date:   Wed, 21 Jun 2023 21:22:08 +0800
Message-Id: <20230621132208.1142318-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of real io scheduler, q->elevator is set, so blk_mq_run_hw_queue()
may just check if scheduler queue has request to dispatch, see
__blk_mq_sched_dispatch_requests(). Then IO hang may be caused because
all passthorugh requests may stay in sw queue.

And any passthrough request should have been inserted to hctx->dispatch
always.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Fixes: d97217e7f024 ("blk-mq: don't queue plugged passthrough requests into scheduler")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c02c28b4835..1628873d7587 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2750,7 +2750,12 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 
 	percpu_ref_get(&this_hctx->queue->q_usage_counter);
 	/* passthrough requests should never be issued to the I/O scheduler */
-	if (this_hctx->queue->elevator && !is_passthrough) {
+	if (is_passthrough) {
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

