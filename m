Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424351AbcKANke (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:40:34 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/16] block: remove the CONFIG_BLOCK ifdef in blk_types.h
Date: Tue,  1 Nov 2016 07:40:17 -0600
Message-Id: <1478007617-18715-17-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now that we have a separate header for struct bio_vec there is absolutely
no excuse for including this header from non-block I/O code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 63b750a..bb92102 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -17,7 +17,6 @@ struct io_context;
 struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
 
-#ifdef CONFIG_BLOCK
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
@@ -126,8 +125,6 @@ struct bio {
 #define BVEC_POOL_OFFSET	(16 - BVEC_POOL_BITS)
 #define BVEC_POOL_IDX(bio)	((bio)->bi_flags >> BVEC_POOL_OFFSET)
 
-#endif /* CONFIG_BLOCK */
-
 /*
  * Operations and flags common to the bio and request structures.
  * We use 8 bits for encoding the operation, and the remaining 24 for flags.
-- 
2.1.4

