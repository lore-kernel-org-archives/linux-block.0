Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E73CC4167B
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 12:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhK3Mun (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 07:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhK3MuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 07:50:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B9DC061757
        for <linux-block@vger.kernel.org>; Tue, 30 Nov 2021 04:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9vrej7Co0BS/WRJ/OE2xz0kPr8K/dbE1m0sG5liWbX8=; b=CvKzYQ2qTiQQ8ffKeEpBPsJKhb
        8SVQ3eP2lK+HdlvtKcLQG4IlHXV7Wc59ulfjaUHUg/mDv2Z0zwiG6qHLaJLQFw2mFbx1BbltCUF84
        oFXlPMSUJKasvG5zY0GA7Fin4PhvQ6n6rlEGEA5m15CaB6hnEI4WiNrI+D7AzmHRrFZibRHEuN7EC
        jjaD5Q/a2mcMUkaxfiiVot1dBO1cPLn/QUkH5NUPo/rOs0K0QxUL129zsUuLkMSUQtWbwXZ239lUW
        TXkJqKJCnuXRUXW/+if7uvvemdnsHxCYIeiPjc5FC81WnIlvJu/pieytJwfb22UUWwi2X89+eo/Ox
        DNaqENQw==;
Received: from [2001:4bb8:184:4a23:f08:7851:5d49:c683] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms2X3-00CFcR-BL; Tue, 30 Nov 2021 12:46:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 5/7] block: refactor put_io_context
Date:   Tue, 30 Nov 2021 13:46:34 +0100
Message-Id: <20211130124636.2505904-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130124636.2505904-1-hch@lst.de>
References: <20211130124636.2505904-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the code to delay freeing the icqs into a separate helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 04f3d2b0ca7db..902bca2b273ba 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -143,6 +143,24 @@ static void ioc_release_fn(struct work_struct *work)
 	kmem_cache_free(iocontext_cachep, ioc);
 }
 
+/*
+ * Releasing icqs requires reverse order double locking and we may already be
+ ( holding a queue_lock.  Do it asynchronously from a workqueue.
+ */
+static bool ioc_delay_free(struct io_context *ioc)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioc->lock, flags);
+	if (!hlist_empty(&ioc->icq_list)) {
+		queue_work(system_power_efficient_wq, &ioc->release_work);
+		spin_unlock_irqrestore(&ioc->lock, flags);
+		return true;
+	}
+	spin_unlock_irqrestore(&ioc->lock, flags);
+	return false;
+}
+
 /**
  * put_io_context - put a reference of io_context
  * @ioc: io_context to put
@@ -152,26 +170,8 @@ static void ioc_release_fn(struct work_struct *work)
  */
 void put_io_context(struct io_context *ioc)
 {
-	unsigned long flags;
-	bool free_ioc = false;
-
 	BUG_ON(atomic_long_read(&ioc->refcount) <= 0);
-
-	/*
-	 * Releasing ioc requires reverse order double locking and we may
-	 * already be holding a queue_lock.  Do it asynchronously from wq.
-	 */
-	if (atomic_long_dec_and_test(&ioc->refcount)) {
-		spin_lock_irqsave(&ioc->lock, flags);
-		if (!hlist_empty(&ioc->icq_list))
-			queue_work(system_power_efficient_wq,
-					&ioc->release_work);
-		else
-			free_ioc = true;
-		spin_unlock_irqrestore(&ioc->lock, flags);
-	}
-
-	if (free_ioc)
+	if (atomic_long_dec_and_test(&ioc->refcount) && !ioc_delay_free(ioc))
 		kmem_cache_free(iocontext_cachep, ioc);
 }
 EXPORT_SYMBOL_GPL(put_io_context);
-- 
2.30.2

