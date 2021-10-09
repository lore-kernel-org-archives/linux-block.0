Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C77CC433EF
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 03:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 556CE60EE2
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 03:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhJIDu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Oct 2021 23:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232387AbhJIDu2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Oct 2021 23:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633751311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91Ivbtcl5lbEwlAWg2XEl9eYPQ9eUKvnJ38fLDhz0JI=;
        b=WyRyCGsKdPabrnj/gf1ecxEeihyWpyPoeoDN+rsOVL02rBlAlsWAzJW2ydGEwsllQyTHG9
        NUueLiDQ7zGNAz3DKMWOG7vtWlo4bd8yUGJWU8WeZdBVfvDzguzlnY9t9PdOgu+AAjrfYF
        8suINqD/cRlXBB4q/RdRmfeuy5QTvmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-HUr-8sUkPp-pVbyKOiSzBg-1; Fri, 08 Oct 2021 23:48:30 -0400
X-MC-Unique: HUr-8sUkPp-pVbyKOiSzBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9DB5362F8;
        Sat,  9 Oct 2021 03:48:28 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58B465F4FF;
        Sat,  9 Oct 2021 03:48:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 6/6] blk-mq: support concurrent queue quiesce/unquiesce
Date:   Sat,  9 Oct 2021 11:47:13 +0800
Message-Id: <20211009034713.1489183-7-ming.lei@redhat.com>
In-Reply-To: <20211009034713.1489183-1-ming.lei@redhat.com>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 block/blk-mq.c         | 21 ++++++++++++++++++---
 include/linux/blkdev.h |  2 ++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 21bf4c3f0825..cb58f21c5be9 100644
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
 
@@ -250,10 +255,20 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+	unsigned long flags;
+	bool run_queue = false;
+
+	spin_lock_irqsave(&q->queue_lock, flags);
+	WARN_ON_ONCE(q->quiesce_depth <= 0);
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

