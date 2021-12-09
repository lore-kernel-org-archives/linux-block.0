Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F357CC4321E
	for <linux-block@archiver.kernel.org>; Thu,  9 Dec 2021 06:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhLIGfQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhLIGfP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3D9C061746
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DKyAgkD26W4zSEU5xRn5bUDxWx2ejX7cIBm+0DK9RZM=; b=AQMfyDfAdHjU6RrM6d6uCyjKel
        nzwXYXcrO3hNXr06PGKkv/vn25nRkmq97q+I06tLpmh1edPvwF9ItaGJbOqWtygzjni4qejCu0yxu
        m94GvOcgsdgLC5n5ZuXIJEd782PqdOGMyZmeQRIQC4ntyWRHMM1vHPtChmXXK8J9rRG4PLPmg1xhE
        JylLZsBXrfjObpmXMC+TrKjs0Oypp/2fFths73zY5q7ZNy3OSjQ3VFle41IJsWEp2Nl3oXQ206mde
        ZS3MEkG7RdS0n2C3MU98gAA9HrOh9F9ywaOjGMmuhk1DAlbgDU5kMIuqBDVDXxyExuxDTVrNYbgHO
        sWT2Tkyg==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCxv-0096U2-QK; Thu, 09 Dec 2021 06:31:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 06/11] block: cleanup ioc_clear_queue
Date:   Thu,  9 Dec 2021 07:31:26 +0100
Message-Id: <20211209063131.18537-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold __ioc_clear_queue into ioc_clear_queue and switch to always
use plain _irq locking instead of the more expensive _irqsave that
is not needed here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index ca996214c10a6..f98a29ee8f362 100644
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
@@ -227,7 +206,17 @@ void ioc_clear_queue(struct request_queue *q)
 	list_splice_init(&q->icq_list, &icq_list);
 	spin_unlock_irq(&q->queue_lock);
 
-	__ioc_clear_queue(&icq_list);
+	rcu_read_lock();
+	while (!list_empty(&icq_list)) {
+		struct io_cq *icq =
+			list_entry(icq_list.next, struct io_cq, q_node);
+
+		spin_lock_irq(&icq->ioc->lock);
+		if (!(icq->flags & ICQ_DESTROYED))
+			ioc_destroy_icq(icq);
+		spin_unlock_irq(&icq->ioc->lock);
+	}
+	rcu_read_unlock();
 }
 
 static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
-- 
2.30.2

