Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08B0C43219
	for <linux-block@archiver.kernel.org>; Thu,  9 Dec 2021 06:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhLIGfO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhLIGfO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F84BC061746
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0dxyvzdAnKCtvAEpDtHHybUjma01fV+7ipZLQ9VddE8=; b=J8nw0YBhfFgpHDPQxF5uLOQGiy
        FwbuYsBI7LwjRZN3bgDky17dvThhHvDADNgX2Y1YznLn+iPf0GgnMIJ0Wkj9a+62Oe6JywMGkBRvA
        twim1UhZxVTDoYJfOTvOP40pm6K07ujELLlzFs4fcukT3WVmKFWJX1V5Jan+04BYeYjFnsrSLQFfM
        /gMBul2tmmOsP8FfO3hhzl6FIMMoE9R3nRgc4CoEdrAp9QyrrPRSc3VsCcwobCPBeBfgzObg4p5N2
        5hdOYIvekbhb19Dsi3yDEpYOlVZNKkrpv7iepWrseQUbM856M+pFtTnkrFpXOSrd6aLz8v+v9hpAj
        J5+6H51g==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCxu-0096Ti-Ib; Thu, 09 Dec 2021 06:31:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 05/11] block: refactor put_io_context
Date:   Thu,  9 Dec 2021 07:31:25 +0100
Message-Id: <20211209063131.18537-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the code to delay freeing the icqs into a separate helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/blk-ioc.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 04f3d2b0ca7db..ca996214c10a6 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -143,6 +143,24 @@ static void ioc_release_fn(struct work_struct *work)
 	kmem_cache_free(iocontext_cachep, ioc);
 }
 
+/*
+ * Releasing icqs requires reverse order double locking and we may already be
+ * holding a queue_lock.  Do it asynchronously from a workqueue.
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

