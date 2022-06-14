Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E5C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 06:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiFNGpQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 02:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352551AbiFNGoi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 02:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A04D1381BB
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 23:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655189076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7PZXphSdNxsfqi/MBHasDOkGld5QCAvYkBM5CvKaDZk=;
        b=Jv6UiBipeo8lZUS5d3g0TPnhXA8LpoK1OVpkyPzoHxpysTwzwg6FqmcilSxUJojBDLLTYx
        tszglZKs6yjwULlWD3M2v0slB7VOgx43S0r6HRkPqoGdLYvg9W9K2+LEkkGL7ql9/mmAum
        XBfwsMIRkEB/6WRJ4c0SSCipg2d0a9g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-28fwUQYsPZuo5ytZxn1mCQ-1; Tue, 14 Jun 2022 02:44:33 -0400
X-MC-Unique: 28fwUQYsPZuo5ytZxn1mCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C96038041BD;
        Tue, 14 Jun 2022 06:44:32 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0152C2026D07;
        Tue, 14 Jun 2022 06:44:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] block: fix rq_qos leak for bio based queue
Date:   Tue, 14 Jun 2022 14:44:26 +0800
Message-Id: <20220614064426.552843-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 5ca7546fe317 ("block: move rq_qos_exit() into disk_release()")
moves rq_qos_exit() to disk_release(), but only done for blk-mq queue.

However, now rq qos can be created via blkcg_init_queue() for bio based
queue, so we need to call rq_qos_exit() for bio queue too.

In theory, so far, rq_qos is only implemented for request based queue,
and we should only add it for blk-mq queue. However, if using blk-mq
during allocating queue may not be known, fix the rq qos leak issue by
always releasing rq qos for both two kinds of queues.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: 285d5731a0cb ('Revert "block: release rq qos structures for queue without disk"')
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 556d6e4b38d9..6e7ca8c302aa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1120,9 +1120,10 @@ static const struct attribute_group *disk_attr_groups[] = {
 	NULL
 };
 
-static void disk_release_mq(struct request_queue *q)
+static void disk_release_queue(struct request_queue *q)
 {
-	blk_mq_cancel_work_sync(q);
+	if (queue_is_mq(q))
+		blk_mq_cancel_work_sync(q);
 
 	/*
 	 * There can't be any non non-passthrough bios in flight here, but
@@ -1166,8 +1167,7 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
-	if (queue_is_mq(disk->queue))
-		disk_release_mq(disk->queue);
+	disk_release_queue(disk->queue);
 
 	blkcg_exit_queue(disk->queue);
 
-- 
2.31.1

