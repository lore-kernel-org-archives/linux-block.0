Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2943DC433E2
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 08:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE9E21D79
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 08:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haDFEOTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgIHIQL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:16:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40993 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729257AbgIHIQG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Sep 2020 04:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599552964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83PJp1bmkd+3bLlWb714ZK7BDlxe8tnA5gs4HbPmR/M=;
        b=haDFEOTWi2auZ8sv6OHAS9tvKtzenTmRr23zIAJHZ/qbUQL/fKM+IUK92um6O6mfrrBAOc
        uVRg11w3fEfCP1OxynoQHRgnWh1u0wKM8MQFG8A29L7kkxjkBIlPKG/MfBHWjP5p6LDj/6
        eKkG0R5/9/DJjGDQFAdAvRB7ofmFGGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-CcaXg9OeNeW9nXbiwR4mNg-1; Tue, 08 Sep 2020 04:16:00 -0400
X-MC-Unique: CcaXg9OeNeW9nXbiwR4mNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A9F218B9F0B;
        Tue,  8 Sep 2020 08:15:59 +0000 (UTC)
Received: from localhost (ovpn-12-217.pek2.redhat.com [10.72.12.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A5B05C1C4;
        Tue,  8 Sep 2020 08:15:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
Subject: [PATCH V3 1/4] blk-mq: serialize queue quiesce and unquiesce by mutex
Date:   Tue,  8 Sep 2020 16:15:35 +0800
Message-Id: <20200908081538.1434936-2-ming.lei@redhat.com>
In-Reply-To: <20200908081538.1434936-1-ming.lei@redhat.com>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add .mq_quiesce_mutext to request queue, so that queue quiesce and
unquiesce can be serialized. Meantime we can avoid unnecessary
synchronize_rcu() in case that queue has been quiesced already.

Prepare for replace SRCU with percpu-refcount, so that we can avoid
warning in percpu_ref_kill_and_confirm() in case that blk_mq_quiesce_queue()
is run on already-quiesced request queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       |  2 ++
 block/blk-mq.c         | 11 +++++++++++
 include/linux/blkdev.h |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 093649bd252e..e7e787ea77be 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -564,6 +564,8 @@ struct request_queue *blk_alloc_queue(int node_id)
 	init_waitqueue_head(&q->mq_freeze_wq);
 	mutex_init(&q->mq_freeze_lock);
 
+	mutex_init(&q->mq_quiesce_lock);
+
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
 	 * See blk_register_queue() for details.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4abb71459f94..13cc10b89629 100644
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
index 7b1e53084799..cc6fb4d0d078 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -572,6 +572,8 @@ struct request_queue {
 	 */
 	struct mutex		mq_freeze_lock;
 
+	struct mutex		mq_quiesce_lock;
+
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
-- 
2.25.2

