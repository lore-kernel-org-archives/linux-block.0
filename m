Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2486DC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 14:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiGOO27 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 10:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGOO27 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 10:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97D881A813
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657895337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RgqPdhJrbE8x/N7mVojPWIch7EXtoMheO7kgzkBGauY=;
        b=hwtyyeSVfoZ2aZ9JXIdQcJ7QwJJo3x1fCLnWwLcKwUwHR5q03St7j1dKtml847vO8l0bz7
        iyTnbou6+01sgV7gTShYXR2e/FLGK30H2PIxbtdPRi7a+r7FGjq9dYrRSRSaWXxr5QCO45
        jUwWnBuxJblA/bEWlgIytdP9IhQgVoY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-W-H9GccSNJeK6jmUMp5wjw-1; Fri, 15 Jul 2022 10:28:56 -0400
X-MC-Unique: W-H9GccSNJeK6jmUMp5wjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29404811E81;
        Fri, 15 Jul 2022 14:28:56 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1803340CF8E2;
        Fri, 15 Jul 2022 14:28:54 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH V2] null_blk: cleanup null_init_tag_set
Date:   Fri, 15 Jul 2022 22:28:47 +0800
Message-Id: <20220715142847.188275-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The passed 'nullb' can be NULL, so cause null ptr reference.

Fix the issue, meantime cleanup null_init_tag_set for avoiding to add
similar issue in future.

Meantime set BLK_MQ_F_NO_SCHED if g_no_sched is true in case of NULL
device, same with BLK_MQ_F_TAG_HCTX_SHARED.

Cc: Vincent Fu <vincent.fu@samsung.com>
Fixes: 37ae152c7a0d ("null_blk: add configfs variables for 2 options")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- set BLK_MQ_F_NO_SCHED & BLK_MQ_F_TAG_HCTX_SHARED correctly in case
	of null device, as suggested by Vincent Fu

 drivers/block/null_blk/main.c | 53 +++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c955a07dba2d..1501c85fc9e4 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1898,31 +1898,48 @@ static int null_gendisk_register(struct nullb *nullb)
 
 static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 {
+	unsigned int flags = BLK_MQ_F_SHOULD_MERGE;
+	int hw_queues, numa_node;
+	unsigned int queue_depth;
 	int poll_queues;
 
+	if (nullb) {
+		hw_queues = nullb->dev->submit_queues;
+		poll_queues = nullb->dev->poll_queues;
+		queue_depth = nullb->dev->hw_queue_depth;
+		numa_node = nullb->dev->home_node;
+		if (nullb->dev->no_sched)
+			flags |= BLK_MQ_F_NO_SCHED;
+		if (nullb->dev->shared_tag_bitmap)
+			flags |= BLK_MQ_F_TAG_HCTX_SHARED;
+		if (nullb->dev->blocking)
+			flags |= BLK_MQ_F_BLOCKING;
+	} else {
+		hw_queues = g_submit_queues;
+		poll_queues = g_poll_queues;
+		queue_depth = g_hw_queue_depth;
+		numa_node = g_home_node;
+		if (g_no_sched)
+			flags |= BLK_MQ_F_NO_SCHED;
+		if (g_shared_tag_bitmap)
+			flags |= BLK_MQ_F_TAG_HCTX_SHARED;
+		if (g_blocking)
+			flags |= BLK_MQ_F_BLOCKING;
+	}
+
 	set->ops = &null_mq_ops;
-	set->nr_hw_queues = nullb ? nullb->dev->submit_queues :
-						g_submit_queues;
-	poll_queues = nullb ? nullb->dev->poll_queues : g_poll_queues;
-	if (poll_queues)
-		set->nr_hw_queues += poll_queues;
-	set->queue_depth = nullb ? nullb->dev->hw_queue_depth :
-						g_hw_queue_depth;
-	set->numa_node = nullb ? nullb->dev->home_node : g_home_node;
 	set->cmd_size	= sizeof(struct nullb_cmd);
-	set->flags = BLK_MQ_F_SHOULD_MERGE;
-	if (nullb->dev->no_sched)
-		set->flags |= BLK_MQ_F_NO_SCHED;
-	if (nullb->dev->shared_tag_bitmap)
-		set->flags |= BLK_MQ_F_TAG_HCTX_SHARED;
+	set->flags = flags;
 	set->driver_data = nullb;
-	if (poll_queues)
+	set->nr_hw_queues = hw_queues;
+	set->queue_depth = queue_depth;
+	set->numa_node = numa_node;
+	if (poll_queues) {
+		set->nr_hw_queues += poll_queues;
 		set->nr_maps = 3;
-	else
+	} else {
 		set->nr_maps = 1;
-
-	if ((nullb && nullb->dev->blocking) || g_blocking)
-		set->flags |= BLK_MQ_F_BLOCKING;
+	}
 
 	return blk_mq_alloc_tag_set(set);
 }
-- 
2.31.1

