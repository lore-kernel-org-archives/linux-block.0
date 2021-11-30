Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5782C4167E
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 12:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhK3Mun (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 07:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhK3MuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 07:50:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937ECC061758
        for <linux-block@vger.kernel.org>; Tue, 30 Nov 2021 04:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iL5jVPLBFjqePJhzbCCqDcgjcEvuK8+6S3TmGqGptZw=; b=JHwZEpDugvXi8QTLNknIS+Jkar
        /Hvg13eiTERV65ru9e25M1MoMEnHd1Yf/VWzdqKs81DmC3isgGQxW7QjQrKbxbB5wbYIX7wZBwOhu
        EMlC/SOHolJVQ0pqna0rQsF+XtjRjyXQvBzFvGQEn6mMsSiik+e8GtqO0+9KVTYRlm6VyAIgdA+c0
        ovFiZlWz6aHFWWyBKgze6a+RbVFVQ0EM7+iXHConypDtcUw2SnG2UD8OaHsEDn1IytavctTx9hbbR
        wM07JR+zmqslzNd0rc49TGxhs604++nYgZDP0NitRxAAX8k0vyRioKQZP6PksnihX3GqKBJIgUWlT
        rNBjW38A==;
Received: from [2001:4bb8:184:4a23:f08:7851:5d49:c683] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms2X4-00CFcq-K2; Tue, 30 Nov 2021 12:46:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 6/7] block: cleanup ioc_clear_queue
Date:   Tue, 30 Nov 2021 13:46:35 +0100
Message-Id: <20211130124636.2505904-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130124636.2505904-1-hch@lst.de>
References: <20211130124636.2505904-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold __ioc_clear_queue into ioc_clear_queue, remove the spurious RCU
criticial section and unify the irq locking style.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 902bca2b273ba..32ae006e1b3e8 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -192,27 +192,6 @@ void exit_io_context(struct task_struct *task)
 	}
 }
 
-static void __ioc_clear_queue(struct list_head *icq_list)
-{
-	unsigned long flags;
-
-	rcu_read_lock();
-	while (!list_empty(icq_list)) {
-		struct io_cq *icq = list_entry(icq_list->next,
-						struct io_cq, q_node);
-		struct io_context *ioc = icq->ioc;
-
-		spin_lock_irqsave(&ioc->lock, flags);
-		if (icq->flags & ICQ_DESTROYED) {
-			spin_unlock_irqrestore(&ioc->lock, flags);
-			continue;
-		}
-		ioc_destroy_icq(icq);
-		spin_unlock_irqrestore(&ioc->lock, flags);
-	}
-	rcu_read_unlock();
-}
-
 /**
  * ioc_clear_queue - break any ioc association with the specified queue
  * @q: request_queue being cleared
@@ -227,7 +206,15 @@ void ioc_clear_queue(struct request_queue *q)
 	list_splice_init(&q->icq_list, &icq_list);
 	spin_unlock_irq(&q->queue_lock);
 
-	__ioc_clear_queue(&icq_list);
+	while (!list_empty(&icq_list)) {
+		struct io_cq *icq =
+			list_entry(icq_list.next, struct io_cq, q_node);
+
+		spin_lock_irq(&icq->ioc->lock);
+		if (!(icq->flags & ICQ_DESTROYED))
+			ioc_destroy_icq(icq);
+		spin_unlock_irq(&icq->ioc->lock);
+	}
 }
 
 static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
-- 
2.30.2

