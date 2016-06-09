Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57693 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbcFIOAo (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2016 10:00:44 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, mchristi@redhat.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: better packing for struct request
Date: Thu,  9 Jun 2016 16:00:35 +0200
Message-Id: <1465480836-32093-2-git-send-email-hch@lst.de>
In-Reply-To: <1465480836-32093-1-git-send-email-hch@lst.de>
References: <1465480836-32093-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Keep the 32-bit CPU and cmd_type flags together to avoid holes on 64-bit
architectures.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0c9f879..9746d22 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -96,12 +96,11 @@ struct request {
 	struct request_queue *q;
 	struct blk_mq_ctx *mq_ctx;
 
-	u64 cmd_flags;
+	int cpu;
 	unsigned cmd_type;
+	u64 cmd_flags;
 	unsigned long atomic_flags;
 
-	int cpu;
-
 	/* the following two fields are internal, NEVER access directly */
 	unsigned int __data_len;	/* total data len */
 	sector_t __sector;		/* sector cursor */
-- 
2.1.4

