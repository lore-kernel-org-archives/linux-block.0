Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8DAC433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 13:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbhLCNMm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:12:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235590AbhLCNMl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Dec 2021 08:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638536957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TmOIQBksLkT7R8p7+ee0zAkHVNTm6XmAsopTrzKJikE=;
        b=BtMh8hKqzkKjQLWKVaniANlSJV4kJNmuz5H8YZ0imwfeXc1QbU/QHvtTJCv8ZCRRB/CJC8
        LW4k3U9Wviff8YbK0Wd/zC5jOf8Q9qL45vE7jSSy/bKXNz4EnQl5p+Kh9u7vvuqYdRxmNz
        +anfoC6TT2FQ8eU2VmFTKWokuyzqCzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-Km-kX8L7P2KpEZfjwQGAdg-1; Fri, 03 Dec 2021 08:09:14 -0500
X-MC-Unique: Km-kX8L7P2KpEZfjwQGAdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15AFE101AFCB;
        Fri,  3 Dec 2021 13:09:13 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C2B67E11F;
        Fri,  3 Dec 2021 13:09:11 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH V2] null_blk: allow zero poll queues
Date:   Fri,  3 Dec 2021 21:09:07 +0800
Message-Id: <20211203130907.3667775-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There isn't any reason to not allow zero poll queues from user
viewpoint.

Also sometimes we need to compare io poll between poll mode and irq
mode, so not allowing poll queues is bad.

Fixes: 15dfc662ef31 ("null_blk: Fix handling of submit_queues and poll_queues attributes")
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- fix divide zero fault as reported by Shin'ichiro

 drivers/block/null_blk/main.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 54f7d490f8eb..c73e69ab77ed 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -340,9 +340,9 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 		return 0;
 
 	/*
-	 * Make sure at least one queue exists for each of submit and poll.
+	 * Make sure at least one submit queue exists.
 	 */
-	if (!submit_queues || !poll_queues)
+	if (!submit_queues)
 		return -EINVAL;
 
 	/*
@@ -1878,8 +1878,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	set->nr_hw_queues = nullb ? nullb->dev->submit_queues :
 						g_submit_queues;
 	poll_queues = nullb ? nullb->dev->poll_queues : g_poll_queues;
-	if (poll_queues)
-		set->nr_hw_queues += poll_queues;
+	set->nr_hw_queues += poll_queues;
 	set->queue_depth = nullb ? nullb->dev->hw_queue_depth :
 						g_hw_queue_depth;
 	set->numa_node = nullb ? nullb->dev->home_node : g_home_node;
@@ -1890,7 +1889,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	if (g_shared_tag_bitmap)
 		set->flags |= BLK_MQ_F_TAG_HCTX_SHARED;
 	set->driver_data = nullb;
-	if (g_poll_queues)
+	if (poll_queues)
 		set->nr_maps = 3;
 	else
 		set->nr_maps = 1;
@@ -1917,8 +1916,6 @@ static int null_validate_conf(struct nullb_device *dev)
 
 	if (dev->poll_queues > g_poll_queues)
 		dev->poll_queues = g_poll_queues;
-	else if (dev->poll_queues == 0)
-		dev->poll_queues = 1;
 	dev->prev_poll_queues = dev->poll_queues;
 
 	dev->queue_mode = min_t(unsigned int, dev->queue_mode, NULL_Q_MQ);
-- 
2.31.1

