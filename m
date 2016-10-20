Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934018AbcJTNM1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2016 09:12:27 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/7] block: move REQ_RAHEAD to common flags
Date: Thu, 20 Oct 2016 15:12:11 +0200
Message-Id: <1476969135-32732-4-git-send-email-hch@lst.de>
In-Reply-To: <1476969135-32732-1-git-send-email-hch@lst.de>
References: <1476969135-32732-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The information that am I/O is a read-ahead can be useful for drivers.
In fact the NVMe driver already checks it, even if it won't ever be set
at the moment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index b541425..44f9bca 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -163,9 +163,9 @@ enum rq_flag_bits {
 	__REQ_INTEGRITY,	/* I/O includes block integrity payload */
 	__REQ_FUA,		/* forced unit access */
 	__REQ_PREFLUSH,		/* request for cache flush */
+	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 
 	/* bio only flags */
-	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_THROTTLED,	/* This bio has already been subjected to
 				 * throttling rules. Don't do it again. */
 
@@ -205,7 +205,7 @@ enum rq_flag_bits {
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
 #define REQ_COMMON_MASK \
 	(REQ_FAILFAST_MASK | REQ_SYNC | REQ_META | REQ_PRIO | REQ_NOIDLE | \
-	 REQ_PREFLUSH | REQ_FUA | REQ_INTEGRITY | REQ_NOMERGE)
+	 REQ_PREFLUSH | REQ_FUA | REQ_INTEGRITY | REQ_NOMERGE | REQ_RAHEAD)
 #define REQ_CLONE_MASK		REQ_COMMON_MASK
 
 /* This mask is used for both bio and request merge checking */
-- 
2.1.4

