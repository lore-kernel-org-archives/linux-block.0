Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF60C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 08:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177DC61152
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 08:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJNIUj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 04:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230032AbhJNIUj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 04:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634199514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/kvozVUbaeY+snlBIvQUQ6zEskRm3LgqfriGB6wA7o=;
        b=iXtQVuhWLHXS6NFM5f2xVKtP9ESkHHUOMgmJy/kSlT++Jysb00+0Gp5JJ/pzCEUChbHa61
        tGPN3KgmKjm1maknKSvXFMyq8NriMnRy27O108Bnm8uz5QnxIHSA8783N/wk71QZMtuX41
        c0GpC6pwR774XDtM9jnG7QQtwg6IxR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-ubuILikANEycPgv86f-wfA-1; Thu, 14 Oct 2021 04:18:30 -0400
X-MC-Unique: ubuILikANEycPgv86f-wfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 749A51015DA0;
        Thu, 14 Oct 2021 08:18:29 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBE7260936;
        Thu, 14 Oct 2021 08:18:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai3@huawei.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 6/6] blk-mq: support concurrent queue quiesce/unquiesce
Date:   Thu, 14 Oct 2021 16:17:10 +0800
Message-Id: <20211014081710.1871747-7-ming.lei@redhat.com>
In-Reply-To: <20211014081710.1871747-1-ming.lei@redhat.com>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_quiesce_queue() has been used a bit wide now, so far we don't support
concurrent/nested quiesce. One biggest issue is that unquiesce can happen
unexpectedly in case that quiesce/unquiesce are run concurrently from
more than one context.

This patch introduces q->mq_quiesce_depth to deal concurrent quiesce,
and we only unquiesce queue when it is the last/outer-most one of all
contexts.

Several kernel panic issue has been reported[1][2][3] when running stress
quiesce test. And this patch has been verified in these reports.

[1] https://lore.kernel.org/linux-block/9b21c797-e505-3821-4f5b-df7bf9380328@huawei.com/T/#m1fc52431fad7f33b1ffc3f12c4450e4238540787
[2] https://lore.kernel.org/linux-block/9b21c797-e505-3821-4f5b-df7bf9380328@huawei.com/T/#m10ad90afeb9c8cc318334190a7c24c8b5c5e0722
[3] https://listman.redhat.com/archives/dm-devel/2021-September/msg00189.html

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 22 +++++++++++++++++++---
 include/linux/blkdev.h |  2 ++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 68cccb2d1f8c..360e8eaee4dc 100644
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
 
@@ -250,10 +255,21 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+	unsigned long flags;
+	bool run_queue = false;
+
+	spin_lock_irqsave(&q->queue_lock, flags);
+	if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
+		;
+	} else if (!--q->quiesce_depth) {
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
index 17705c970d7e..52020fae665c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -314,6 +314,8 @@ struct request_queue {
 	 */
 	struct mutex		mq_freeze_lock;
 
+	int			quiesce_depth;
+
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
-- 
2.31.1

