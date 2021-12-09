Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E919EC4332F
	for <linux-block@archiver.kernel.org>; Thu,  9 Dec 2021 06:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhLIGfN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhLIGfM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E022C061746
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fvu+h3prIu+X6cxxAPCyHu/wxHG/MPG9/dV7pIxX8xY=; b=Jl6cdIh6x8C7OiAGG96C8HKjgD
        Hljow/Zb3ZhgwGG2QvkdGNegtAWDmOPJ/+XHfXbmFmCOqhhrYQ7u9o/eIdmSRBzElrqaLio9Vob+w
        rYkWvu4dmIt24tZB3S5tfi+8ARwTQoKRpV8DbWXRz1lIbXCYgtdiBBWVW9hqVG/HHbw8ZVUJkp9r7
        aWt22viJMTGUqwG3PaVcnxWY1PVb3kGmm7BUiWKNq1KxXLTfM2O0TqZ4lgSqXoiNiOqTM34iY9JwN
        6U4l0f/KH8OGMeb9PEKkReJWjc9x0KTkIntWpSESYiR6aKs5AmRRV2XwK2/VakYICNEzV2WMnbr9a
        F9BNdN7Q==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCxp-0096SY-Hx; Thu, 09 Dec 2021 06:31:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 01/11] block: remove the nr_task field from struct io_context
Date:   Thu,  9 Dec 2021 07:31:21 +0100
Message-Id: <20211209063131.18537-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nothing ever looks at ->nr_tasks, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/blk-ioc.c           | 3 ---
 include/linux/iocontext.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 536fb496ad763..96336c2134efa 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -207,7 +207,6 @@ void exit_io_context(struct task_struct *task)
 	task->io_context = NULL;
 	task_unlock(task);
 
-	atomic_dec(&ioc->nr_tasks);
 	put_io_context_active(ioc);
 }
 
@@ -259,7 +258,6 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
 		return NULL;
 
 	atomic_long_set(&ioc->refcount, 1);
-	atomic_set(&ioc->nr_tasks, 1);
 	atomic_set(&ioc->active_ref, 1);
 	spin_lock_init(&ioc->lock);
 	INIT_RADIX_TREE(&ioc->icq_tree, GFP_ATOMIC);
@@ -339,7 +337,6 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_IO) {
 		atomic_long_inc(&ioc->refcount);
 		atomic_inc(&ioc->active_ref);
-		atomic_inc(&ioc->nr_tasks);
 		tsk->io_context = ioc;
 	} else if (ioprio_valid(ioc->ioprio)) {
 		tsk->io_context = alloc_io_context(GFP_KERNEL, NUMA_NO_NODE);
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index c1229fbd6691c..82c7f4f5f4f59 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -99,7 +99,6 @@ struct io_cq {
 struct io_context {
 	atomic_long_t refcount;
 	atomic_t active_ref;
-	atomic_t nr_tasks;
 
 	/* all the fields below are protected by this lock */
 	spinlock_t lock;
-- 
2.30.2

