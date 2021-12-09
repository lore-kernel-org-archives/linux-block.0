Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E351C433F5
	for <linux-block@archiver.kernel.org>; Thu,  9 Dec 2021 06:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhLIGfU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhLIGfT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EF3C061746
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=drI1On1WuIXJ2d/KKGn67Vq3kynpYNiWrBe+DnpIjNA=; b=uRceimOZv5zgF5pHDWBFU1nilG
        /CDy/OHsuzoTjNN/M3ttXWmJyPTsl7XvZLH5ec054+P2277bxLvd/Awl/bcea8Z5/iUVFcxRBIoY8
        8zMUqXMcniEK7TCFN+/AbMeEN5v9hmWiYCyYMHuGDUNIfKnv18s1WCxxAFThPOFbyOupc3BqQcuN4
        6x1QDim7QwjCtrhUeGP8JPWkNbPw29Ne2p3cNUmaRhBnN6xoNnLPLU4xnwzkmUuWi44sHtdVqr9Kh
        WZcaK5Zwe9uMkgfmFEbSGwgEqGgfO1slY9IeswbNImLpCZsqNsxNPkp71Z3XWGgCTFA+PXQ+bKypl
        f01Oa/8Q==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCxz-0096UZ-Ph; Thu, 09 Dec 2021 06:31:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 09/11] block: open code create_task_io_context in set_task_ioprio
Date:   Thu,  9 Dec 2021 07:31:29 +0100
Message-Id: <20211209063131.18537-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The flow in set_task_ioprio can be simplified by simply open coding
create_task_io_context, which removes a refcount roundtrip on the I/O
context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 1ba7cfedca2d9..cff0e3bdae53c 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -291,12 +291,18 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 		struct io_context *ioc;
 
 		task_unlock(task);
-		ioc = create_task_io_context(task, GFP_ATOMIC, NUMA_NO_NODE);
-		if (ioc) {
-			ioc->ioprio = ioprio;
-			put_io_context(ioc);
+
+		ioc = alloc_io_context(GFP_ATOMIC, NUMA_NO_NODE);
+		if (!ioc)
+			return -ENOMEM;
+
+		task_lock(task);
+		if (task->io_context || (task->flags & PF_EXITING)) {
+			kmem_cache_free(iocontext_cachep, ioc);
+			ioc = task->io_context;
+		} else {
+			task->io_context = ioc;
 		}
-		return 0;
 	}
 	task->io_context->ioprio = ioprio;
 	task_unlock(task);
-- 
2.30.2

