Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B8CC433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Dec 2021 06:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhLIGfV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhLIGfU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E6C061746
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BbwcJfFs7FZHVi3148KE8Q81pVxWSGby16CWGmlJlLQ=; b=fDDdcyeVFdHRfB0cXPiNPr58rx
        46IYzS24kLOZns8Zr/fYi3SyVm4a6ybbNkIJVc9QraPpAo5keTVYbwkVhjq3DLGb4TwC+OHr8oYuK
        GMF8Jrlazd0xGxOFkSxUBNk5IHW+FOH8Gm6MlzcO86uDy6YjCsPukaNvS4tFibbYF0i0AygpwE4KY
        d0bw1Yvs3pSWW/BgrY8SvJzmmaRFmf3uEy+agVo3W1jc6FYKkd9GxdG5jqD9OAlBeg1iE7HBFy9XQ
        /AJbwu+f3p1MqDcbqGST5MfnXZIzW8OGVP5OgbwHrr0lFElczPkA5WLHK3mlVl0t0McTOYHGS0ipS
        RkAlcLFw==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCy1-0096Uj-2T; Thu, 09 Dec 2021 06:31:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 10/11] block: fold create_task_io_context into ioc_find_get_icq
Date:   Thu,  9 Dec 2021 07:31:30 +0100
Message-Id: <20211209063131.18537-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold create_task_io_context into the only remaining caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c | 43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index cff0e3bdae53c..dc7fb064fd5f7 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -238,36 +238,6 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
 	return ioc;
 }
 
-static struct io_context *create_task_io_context(struct task_struct *task,
-		gfp_t gfp_flags, int node)
-{
-	struct io_context *ioc;
-
-	ioc = alloc_io_context(gfp_flags, node);
-	if (!ioc)
-		return NULL;
-
-	/*
-	 * Try to install.  ioc shouldn't be installed if someone else
-	 * already did or @task, which isn't %current, is exiting.  Note
-	 * that we need to allow ioc creation on exiting %current as exit
-	 * path may issue IOs from e.g. exit_files().  The exit path is
-	 * responsible for not issuing IO after exit_io_context().
-	 */
-	task_lock(task);
-	if (!task->io_context &&
-	    (task == current || !(task->flags & PF_EXITING)))
-		task->io_context = ioc;
-	else
-		kmem_cache_free(iocontext_cachep, ioc);
-
-	ioc = task->io_context;
-	if (ioc)
-		get_io_context(ioc);
-	task_unlock(task);
-	return ioc;
-}
-
 int set_task_ioprio(struct task_struct *task, int ioprio)
 {
 	int err;
@@ -426,9 +396,20 @@ struct io_cq *ioc_find_get_icq(struct request_queue *q)
 	struct io_cq *icq = NULL;
 
 	if (unlikely(!ioc)) {
-		ioc = create_task_io_context(current, GFP_ATOMIC, q->node);
+		ioc = alloc_io_context(GFP_ATOMIC, q->node);
 		if (!ioc)
 			return NULL;
+
+		task_lock(current);
+		if (current->io_context) {
+			kmem_cache_free(iocontext_cachep, ioc);
+			ioc = current->io_context;
+		} else {
+			current->io_context = ioc;
+		}
+
+		get_io_context(ioc);
+		task_unlock(current);
 	} else {
 		get_io_context(ioc);
 
-- 
2.30.2

