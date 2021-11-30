Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA7BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 12:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbhK3Mul (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 07:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhK3MuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 07:50:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972A4C061574
        for <linux-block@vger.kernel.org>; Tue, 30 Nov 2021 04:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i6BSDgSOKIl95ryb5Puqf0SnBy2urheC/nx+MGMFmxc=; b=hHEaAdTjDEkBSbSgQOB3tePXMa
        xyQ7DXHLvDyJ4ntPR4+bKakCCzzycVHH69ZzijE2vC58OLCGFCOyGCeXcDCZrjN63Yk89gGRILuPQ
        t6h8JZSqfJtPrzwoBmfN32rXF6ahay/coPKAqhQ4zcqpvuZKMZ7nDFfy86gswJ3S7i6brSCOPFL+8
        eCY67N+ZseMBCqQAG4yYcehb/7BvplzpDy0rFKz3rM9Kf6KSkC8+HY+t3PvY7bSOSI7Ccxol/rPac
        pyois1pKcP9SYykktI9z2K1qXtRU1bxJxmxJ9SHtMkzjjPOZPpq5+1f0fytwO9Rmrjtfw6Gv5A/YO
        rPtCrPQQ==;
Received: from [2001:4bb8:184:4a23:f08:7851:5d49:c683] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms2Wx-00CFan-9j; Tue, 30 Nov 2021 12:46:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/7] block: remove the nr_task field from struct io_context
Date:   Tue, 30 Nov 2021 13:46:30 +0100
Message-Id: <20211130124636.2505904-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130124636.2505904-1-hch@lst.de>
References: <20211130124636.2505904-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nothing ever looks at ->nr_tasks, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

