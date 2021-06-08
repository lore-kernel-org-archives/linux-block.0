Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B850BC47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 07:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C36661184
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 07:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFHHVf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229923AbhFHHVf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 03:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623136782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8nKU7UnSp5v/Pw/LbxaxGvU7HBGXpGdDckUuWp0QKM=;
        b=LBrjSdmVcKa/2np1WDJA9TSGsoIGe/e2y2i8kBpbkYdOzgltRBnafjC3O6f3TJb46xRrjd
        ASPj4TSLLc1NNzewgn9zRPiDY/R+WNRvX0f4V+bTopjCmt1BN6tGe3aFNtOQDd2rtrzu7q
        rDbaR28ZZWEIyLHuznMjAJGy83pF+sc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-n327yI-xNeuSFXB6CfxD0A-1; Tue, 08 Jun 2021 03:19:40 -0400
X-MC-Unique: n327yI-xNeuSFXB6CfxD0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 284426F303;
        Tue,  8 Jun 2021 07:19:39 +0000 (UTC)
Received: from localhost (ovpn-12-142.pek2.redhat.com [10.72.12.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67F905D6D3;
        Tue,  8 Jun 2021 07:19:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2 2/2] block: mark queue init done at the end of blk_register_queue
Date:   Tue,  8 Jun 2021 15:19:03 +0800
Message-Id: <20210608071903.431195-3-ming.lei@redhat.com>
In-Reply-To: <20210608071903.431195-1-ming.lei@redhat.com>
References: <20210608071903.431195-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mark queue init done when everything is done well in blk_register_queue(),
so that wbt_enable_default() can be run quickly without any RCU period
involved since adding rq qos requires to freeze queue.

Also no any side effect by delaying to mark queue init done.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f89e2fc3963b..370d83c18057 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -866,20 +866,6 @@ int blk_register_queue(struct gendisk *disk)
 		  "%s is registering an already registered queue\n",
 		  kobject_name(&dev->kobj));
 
-	/*
-	 * SCSI probing may synchronously create and destroy a lot of
-	 * request_queues for non-existent devices.  Shutting down a fully
-	 * functional queue takes measureable wallclock time as RCU grace
-	 * periods are involved.  To avoid excessive latency in these
-	 * cases, a request_queue starts out in a degraded mode which is
-	 * faster to shut down and is made fully functional here as
-	 * request_queues for non-existent devices never get registered.
-	 */
-	if (!blk_queue_init_done(q)) {
-		blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
-		percpu_ref_switch_to_percpu(&q->q_usage_counter);
-	}
-
 	blk_queue_update_readahead(q);
 
 	ret = blk_trace_init_sysfs(dev);
@@ -938,6 +924,21 @@ int blk_register_queue(struct gendisk *disk)
 	ret = 0;
 unlock:
 	mutex_unlock(&q->sysfs_dir_lock);
+
+	/*
+	 * SCSI probing may synchronously create and destroy a lot of
+	 * request_queues for non-existent devices.  Shutting down a fully
+	 * functional queue takes measureable wallclock time as RCU grace
+	 * periods are involved.  To avoid excessive latency in these
+	 * cases, a request_queue starts out in a degraded mode which is
+	 * faster to shut down and is made fully functional here as
+	 * request_queues for non-existent devices never get registered.
+	 */
+	if (!blk_queue_init_done(q)) {
+		blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
+		percpu_ref_switch_to_percpu(&q->q_usage_counter);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_register_queue);
-- 
2.31.1

