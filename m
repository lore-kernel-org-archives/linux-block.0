Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BC7C433EF
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 17:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbiAERF1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242091AbiAERF1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jan 2022 12:05:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90C8C061245
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 09:05:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E5C61831
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 17:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507CCC36AF4;
        Wed,  5 Jan 2022 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641402325;
        bh=Qlt2OE4vBZMSSLU8g7PiBjCMLnPFQzuT5v6qcILkaNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZdJtwlt9qiDvxF0WoV0FjauqJqwUXn2qhPWAJBTzo66PosVGsYA5nqyH9Huvr3oc
         5BbFVgnVKBG4uoiZRC2pDt6ojcffQ53ALnokZng84gQ/eRzihCWyBW7XaqhQC7xUt1
         YwvwNkrBV4ZfR+IC/XWAuG0LlP6Sa72/M1Wvc8yWtyzsb4f7ReRb/zTBY/Lhd9/xsT
         YWRjqcwtTMR7sUMo7TzUrWLFJE9vUQiQJ+zVmprwiNWTjTo9Ft7a/cTqoHLyoqlpvm
         3JM7i5uYSPIkaX45DF8OCGGtcs40fH/iqHDimgU5O86qL6vblUNBI9+a03Q9dSaL6e
         Cus5R4uOxvtnw==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/4] block: move rq_list macros to blk-mq.h
Date:   Wed,  5 Jan 2022 09:05:15 -0800
Message-Id: <20220105170518.3181469-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220105170518.3181469-1-kbusch@kernel.org>
References: <20220105170518.3181469-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the request list macros to the header file that defines that struct
they operate on.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/io_uring.c          |  2 +-
 include/linux/blk-mq.h | 29 +++++++++++++++++++++++++++++
 include/linux/blkdev.h | 29 -----------------------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 90002bb3fdf4..33f72b3b302c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -57,7 +57,7 @@
 #include <linux/mman.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/bvec.h>
 #include <linux/net.h>
 #include <net/sock.h>
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 550996cf419c..bf64b94cd64e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -216,6 +216,35 @@ static inline unsigned short req_get_ioprio(struct request *req)
 #define rq_dma_dir(rq) \
 	(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
 
+#define rq_list_add(listptr, rq)	do {		\
+	(rq)->rq_next = *(listptr);			\
+	*(listptr) = rq;				\
+} while (0)
+
+#define rq_list_pop(listptr)				\
+({							\
+	struct request *__req = NULL;			\
+	if ((listptr) && *(listptr))	{		\
+		__req = *(listptr);			\
+		*(listptr) = __req->rq_next;		\
+	}						\
+	__req;						\
+})
+
+#define rq_list_peek(listptr)				\
+({							\
+	struct request *__req = NULL;			\
+	if ((listptr) && *(listptr))			\
+		__req = *(listptr);			\
+	__req;						\
+})
+
+#define rq_list_for_each(listptr, pos)			\
+	for (pos = rq_list_peek((listptr)); pos; pos = rq_list_next(pos))
+
+#define rq_list_next(rq)	(rq)->rq_next
+#define rq_list_empty(list)	((list) == (struct request *) NULL)
+
 enum blk_eh_timer_return {
 	BLK_EH_DONE,		/* drivers has completed the command */
 	BLK_EH_RESET_TIMER,	/* reset timer and try again */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22746b2d6825..9c95df26fc26 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1339,33 +1339,4 @@ struct io_comp_batch {
 
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
 
-#define rq_list_add(listptr, rq)	do {		\
-	(rq)->rq_next = *(listptr);			\
-	*(listptr) = rq;				\
-} while (0)
-
-#define rq_list_pop(listptr)				\
-({							\
-	struct request *__req = NULL;			\
-	if ((listptr) && *(listptr))	{		\
-		__req = *(listptr);			\
-		*(listptr) = __req->rq_next;		\
-	}						\
-	__req;						\
-})
-
-#define rq_list_peek(listptr)				\
-({							\
-	struct request *__req = NULL;			\
-	if ((listptr) && *(listptr))			\
-		__req = *(listptr);			\
-	__req;						\
-})
-
-#define rq_list_for_each(listptr, pos)			\
-	for (pos = rq_list_peek((listptr)); pos; pos = rq_list_next(pos))
-
-#define rq_list_next(rq)	(rq)->rq_next
-#define rq_list_empty(list)	((list) == (struct request *) NULL)
-
 #endif /* _LINUX_BLKDEV_H */
-- 
2.25.4

