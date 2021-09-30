Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E2C433F5
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 12:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6608561452
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 12:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348613AbhI3M7Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Sep 2021 08:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348276AbhI3M7P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Sep 2021 08:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633006652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jN4b3GyfHa+amFzmyGSuIhBG2KY0aTYefQa+d6RG6DE=;
        b=a0IoCJ4NaidwnFaMwe37QXKBDvth89f14WFdX3tMzo4j0ZtOoljA4plPh5u8/9DMmC4+Jy
        69sTgwOfUkswahmtGCt8d7oyNbLOZOxC0M5S6VXBdIIni0zdZiEYlUuf9ZS3BId72izIru
        1lXSajzRpVrXw34KI0MJIw5PBK3FwE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-k1bzz9uhOOW80irEMUyeKQ-1; Thu, 30 Sep 2021 08:57:28 -0400
X-MC-Unique: k1bzz9uhOOW80irEMUyeKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0753B1060D71;
        Thu, 30 Sep 2021 12:57:06 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B58AA88EF8;
        Thu, 30 Sep 2021 12:57:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/5] blk-mq: support concurrent queue quiesce/unquiesce
Date:   Thu, 30 Sep 2021 20:56:21 +0800
Message-Id: <20210930125621.1161726-6-ming.lei@redhat.com>
In-Reply-To: <20210930125621.1161726-1-ming.lei@redhat.com>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Turns out that blk_mq_freeze_queue() isn't stronger[1] than
blk_mq_quiesce_queue() because dispatch may still be in-progress after
queue is frozen, and in several cases, such as switching io scheduler,
updating nr_requests & wbt latency, we still need to quiesce queue as a
supplement of freezing queue.

As we need to extend uses of blk_mq_quiesce_queue(), it is inevitable
for us to need support nested quiesce, especially we can't let
unquiesce happen when there is quiesce originated from other contexts.

This patch introduces q->mq_quiesce_depth to deal concurrent quiesce,
and we only unquiesce queue when it is the last/outer-most one of all
contexts.

One kernel panic issue has been reported[2] when running stress test on
dm-mpath's updating nr_requests and suspending queue, and the similar
issue should exist on almost all drivers which use quiesce/unquiesce.

[1] https://marc.info/?l=linux-block&m=150993988115872&w=2
[2] https://listman.redhat.com/archives/dm-devel/2021-September/msg00189.html

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 20 +++++++++++++++++---
 include/linux/blkdev.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 21bf4c3f0825..10f8a3d4e3a1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,7 +209,12 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-	blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->queue_lock, flags);
+	if (!q->quiesce_depth++)
+		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
+	spin_unlock_irqrestore(&q->queue_lock, flags);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -250,10 +255,19 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+	unsigned long flags;
+	bool run_queue = false;
+
+	spin_lock_irqsave(&q->queue_lock, flags);
+	if (q->quiesce_depth > 0 && !--q->quiesce_depth) {
+		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+		run_queue = true;
+	}
+	spin_unlock_irqrestore(&q->queue_lock, flags);
 
 	/* dispatch requests which are inserted during quiescing */
-	blk_mq_run_hw_queues(q, true);
+	if (run_queue)
+		blk_mq_run_hw_queues(q, true);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0e960d74615e..74c60e2d61f9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -315,6 +315,8 @@ struct request_queue {
 	 */
 	struct mutex		mq_freeze_lock;
 
+	int			quiesce_depth;
+
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
-- 
2.31.1

