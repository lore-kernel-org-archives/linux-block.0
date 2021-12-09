Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B0DC433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Dec 2021 06:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhLIGfN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhLIGfM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187CEC0617A2
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6IzcJQvZovsZ2clicXD2awD7x9wJVlwZfro4iZj+y9Y=; b=hXyuHLJtqu5zdVAFjhgX/rT/GO
        oT1Bfr2HFNpP4N1k9WcmEoTRHVLk/8SZTTEeW4E/805U2b8DFdzFhiwl29OR7txfRXRQoZVqjidtj
        vjpLVu9jE3VFp3OQCkmzuywAiD1Ds4lWi+G0HSn4r/nQN+R3XkM93i9D1OSTVvI+AJjzsaAv6IiSE
        Ddu2eW4ScG0izefWCH1Sg00McFOon6MqJdb4XRetyu0AK4EyHEQIQnn2XQRfVfqTWJN/kd4tzWtea
        ivZ+INxEWr81iJCfp22ga6Ok5GDZfI/UplobX8HQcHqdaUbTXZ8lZUa2cv8uAUI/3GEoWiOYBCrLH
        z0vuvTAw==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCxs-0096TH-1q; Thu, 09 Dec 2021 06:31:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 03/11] block: refactor put_iocontext_active
Date:   Thu,  9 Dec 2021 07:31:23 +0100
Message-Id: <20211209063131.18537-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out a ioc_exit_icqs helper to tear down the icqs and the fold
the rest of put_iocontext_active into exit_io_context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
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

