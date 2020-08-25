Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F283C433DF
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 14:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7A620786
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 14:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHdy0Muw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHYOR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbgHYOR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 10:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598365076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VQLEy+RHe/UI9QRIV9ZvERAtc7O+yLWquOSUeipGEdU=;
        b=fHdy0Muwf3MP0NoTUP/R5UI2PioGbz4dGPVQ62+mT43rGp3Y4bOAxAb0PkEWABXH7Mk8Q4
        iqB1PQr+fCjCsXYEL+8VDEKvOeexXcG+ecFnYXgRkcdGhgXKb7oWgI2P+RGlfZKQR59XdP
        6jiGd17RZdiZBAZqoUUda65jRmyw1v0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-tujGqJbJPF21WciJjHWsBQ-1; Tue, 25 Aug 2020 10:17:51 -0400
X-MC-Unique: tujGqJbJPF21WciJjHWsBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B16A44236C;
        Tue, 25 Aug 2020 14:17:49 +0000 (UTC)
Received: from localhost (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 473875D9CA;
        Tue, 25 Aug 2020 14:17:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
Subject: [PATCH V2 1/2] blk-mq: serialize queue quiesce and unquiesce by mutex
Date:   Tue, 25 Aug 2020 22:17:33 +0800
Message-Id: <20200825141734.115879-2-ming.lei@redhat.com>
In-Reply-To: <20200825141734.115879-1-ming.lei@redhat.com>
References: <20200825141734.115879-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add .mq_quiesce_mutext to request queue, so that queue quiesce and
unquiesce can be serialized. Meantime we can avoid unnecessary
synchronize_rcu() in case that queue has been quiesced already.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>
---
 block/blk-core.c       |  2 ++
 block/blk-mq.c         | 11 +++++++++++
 include/linux/blkdev.h |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index d9d632639bd1..ffc57df70064 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -561,6 +561,8 @@ struct request_queue *blk_alloc_queue(int node_id)
 	init_waitqueue_head(&q->mq_freeze_wq);
 	mutex_init(&q->mq_freeze_lock);
 
+	mutex_init(&q->mq_quiesce_lock);
+
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
 	 * See blk_register_queue() for details.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b3d2785eefe9..817e016ef886 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -224,6 +224,11 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	unsigned int i;
 	bool rcu = false;
 
+	mutex_lock(&q->mq_quiesce_lock);
+
+	if (blk_queue_quiesced(q))
+		goto exit;
+
 	blk_mq_quiesce_queue_nowait(q);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
@@ -234,6 +239,8 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	}
 	if (rcu)
 		synchronize_rcu();
+ exit:
+	mutex_unlock(&q->mq_quiesce_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
@@ -246,10 +253,14 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
+	mutex_lock(&q->mq_quiesce_lock);
+
 	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
 
 	/* dispatch requests which are inserted during quiescing */
 	blk_mq_run_hw_queues(q, true);
+
+	mutex_unlock(&q->mq_quiesce_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d8dba550ecac..5ed03066b33e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -569,6 +569,8 @@ struct request_queue {
 	 */
 	struct mutex		mq_freeze_lock;
 
+	struct mutex		mq_quiesce_lock;
+
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
-- 
2.25.2

