Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875AAC433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Dec 2021 06:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhLIGfT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhLIGfT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5DAC0617A2
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Bd9z/K9J51MQ3/y3VQdvbbhVD0yvnU/ecWD8GinK6Ic=; b=Xq7ubnhsCohe5TaCcmM7Ue265/
        9sMZALXmDbe3SrVkOlF8BA2EsFIS5gG8ETlwaMY9Rc5IDtWkw9Nknr3Y77tNdc3AuYND6JyIxirlN
        fKkBeFLUawkHyjmL/1PNU58S58EoBGVRxOsBj/y/RFnXnO1Ngk4GH2Zs6XWUwTt4gMrEk32zO/7PG
        lwM05NDKyLcD2342RwTawJyk+ZwzE4Ca6m+SLtax+b+j4sZUYrzFjwbkW85P1lHEJgFQa5dpDA1sc
        dfA8a0fLfrZgBXFBYe/KPndZys0euwTVthNGqmfTTZaW4D4HuFOlZqEHkLzJ3PP81I5r6iqwwJZhb
        wQr8R1lA==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCxy-0096UP-E5; Thu, 09 Dec 2021 06:31:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 08/11] block: fold get_task_io_context into set_task_ioprio
Date:   Thu,  9 Dec 2021 07:31:28 +0100
Message-Id: <20211209063131.18537-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold get_task_io_context into its only caller, and simplify the code
as no reference to the I/O context is required to just set the ioprio
field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c | 52 +++++++++++++------------------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index c25ce2f3eb191..1ba7cfedca2d9 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -268,41 +268,9 @@ static struct io_context *create_task_io_context(struct task_struct *task,
 	return ioc;
 }
 
-/**
- * get_task_io_context - get io_context of a task
- * @task: task of interest
- * @gfp_flags: allocation flags, used if allocation is necessary
- * @node: allocation node, used if allocation is necessary
- *
- * Return io_context of @task.  If it doesn't exist, it is created with
- * @gfp_flags and @node.  The returned io_context has its reference count
- * incremented.
- *
- * This function always goes through task_lock() and it's better to use
- * %current->io_context + get_io_context() for %current.
- */
-static struct io_context *get_task_io_context(struct task_struct *task,
-		gfp_t gfp_flags, int node)
-{
-	struct io_context *ioc;
-
-	might_sleep_if(gfpflags_allow_blocking(gfp_flags));
-
-	task_lock(task);
-	ioc = task->io_context;
-	if (unlikely(!ioc)) {
-		task_unlock(task);
-		return create_task_io_context(task, gfp_flags, node);
-	}
-	get_io_context(ioc);
-	task_unlock(task);
-	return ioc;
-}
-
 int set_task_ioprio(struct task_struct *task, int ioprio)
 {
 	int err;
-	struct io_context *ioc;
 	const struct cred *cred = current_cred(), *tcred;
 
 	rcu_read_lock();
@@ -318,13 +286,21 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 	if (err)
 		return err;
 
-	ioc = get_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
-	if (ioc) {
-		ioc->ioprio = ioprio;
-		put_io_context(ioc);
-	}
+	task_lock(task);
+	if (unlikely(!task->io_context)) {
+		struct io_context *ioc;
 
-	return err;
+		task_unlock(task);
+		ioc = create_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
+		if (ioc) {
+			ioc->ioprio = ioprio;
+			put_io_context(ioc);
+		}
+		return 0;
+	}
+	task->io_context->ioprio = ioprio;
+	task_unlock(task);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(set_task_ioprio);
 
-- 
2.30.2

