Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967DCC4332F
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 12:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhK3Mum (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 07:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhK3MuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 07:50:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D05C06174A
        for <linux-block@vger.kernel.org>; Tue, 30 Nov 2021 04:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U10Z8+JHPFXXgLEhho7zQZjwErerxfS6SmCDmVZWe3k=; b=JZUsWnie9IPLz40CzqAizcr/U8
        ZhPjMlCKR8C+5lhFzwX+ba48LzhK2+bc67W4X39ihBz0ITsZ/O/4rlONBrSbmLCjRuZheIHPdQ7mA
        uMaNFjbfzBeQTHv5V7b9MYT2zho+pw7/sXE3TxaZ11jWeNXooMDdRKaXHvQqLCTjDcywAQjknvhZu
        tLgRBS2KhV5TDHZAsCFhQPQtoDni4113uMmK4GRWVi5sW3ECL7JRyIGMP8HMhgESkO7VjPBiKQpQ0
        iKOFm1y1zJrpMc4RotBE6XROTCQcUJsmY2QG7fB4JDkFJ97AtWnAuQ1WTyWHW5bglA9o44Xs+TrjO
        mWmvQNSg==;
Received: from [2001:4bb8:184:4a23:f08:7851:5d49:c683] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms2X0-00CFbm-PQ; Tue, 30 Nov 2021 12:46:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 3/7] block: refactor put_iocontext_active
Date:   Tue, 30 Nov 2021 13:46:32 +0100
Message-Id: <20211130124636.2505904-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130124636.2505904-1-hch@lst.de>
References: <20211130124636.2505904-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out a ioc_exit_icqs helper to tear down the icqs and the fold
the rest of put_iocontext_active into exit_io_context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 9cde3906be3c6..0380e33930e31 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -54,6 +54,16 @@ static void ioc_exit_icq(struct io_cq *icq)
 	icq->flags |= ICQ_EXITED;
 }
 
+static void ioc_exit_icqs(struct io_context *ioc)
+{
+	struct io_cq *icq;
+
+	spin_lock_irq(&ioc->lock);
+	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node)
+		ioc_exit_icq(icq);
+	spin_unlock_irq(&ioc->lock);
+}
+
 /*
  * Release an icq. Called with ioc locked for blk-mq, and with both ioc
  * and queue locked for legacy.
@@ -169,32 +179,6 @@ void put_io_context(struct io_context *ioc)
 }
 EXPORT_SYMBOL_GPL(put_io_context);
 
-/**
- * put_io_context_active - put active reference on ioc
- * @ioc: ioc of interest
- *
- * Put an active reference to an ioc.  If active reference reaches zero after
- * put, @ioc can never issue further IOs and ioscheds are notified.
- */
-static void put_io_context_active(struct io_context *ioc)
-{
-	struct io_cq *icq;
-
-	if (!atomic_dec_and_test(&ioc->active_ref))
-		return;
-
-	spin_lock_irq(&ioc->lock);
-	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
-		if (icq->flags & ICQ_EXITED)
-			continue;
-
-		ioc_exit_icq(icq);
-	}
-	spin_unlock_irq(&ioc->lock);
-
-	put_io_context(ioc);
-}
-
 /* Called by the exiting task */
 void exit_io_context(struct task_struct *task)
 {
@@ -205,7 +189,10 @@ void exit_io_context(struct task_struct *task)
 	task->io_context = NULL;
 	task_unlock(task);
 
-	put_io_context_active(ioc);
+	if (atomic_dec_and_test(&ioc->active_ref)) {
+		ioc_exit_icqs(ioc);
+		put_io_context(ioc);
+	}
 }
 
 static void __ioc_clear_queue(struct list_head *icq_list)
-- 
2.30.2

