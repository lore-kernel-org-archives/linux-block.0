Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934018AbcJTNMY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2016 09:12:24 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/7] block: REQ_NOMERGE is common to the bio and request
Date: Thu, 20 Oct 2016 15:12:10 +0200
Message-Id: <1476969135-32732-3-git-send-email-hch@lst.de>
In-Reply-To: <1476969135-32732-1-git-send-email-hch@lst.de>
References: <1476969135-32732-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

So move it into the common setion of the request flags.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dd50dce..b541425 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -158,6 +158,7 @@ enum rq_flag_bits {
 	__REQ_META,		/* metadata io request */
 	__REQ_PRIO,		/* boost priority in cfq */
 
+	__REQ_NOMERGE,		/* don't touch this for merging */
 	__REQ_NOIDLE,		/* don't anticipate more IO after this one */
 	__REQ_INTEGRITY,	/* I/O includes block integrity payload */
 	__REQ_FUA,		/* forced unit access */
@@ -171,7 +172,6 @@ enum rq_flag_bits {
 	/* request only flags */
 	__REQ_SORTED,		/* elevator knows about this request */
 	__REQ_SOFTBARRIER,	/* may not be passed by ioscheduler */
-	__REQ_NOMERGE,		/* don't touch this for merging */
 	__REQ_STARTED,		/* drive already may have started this one */
 	__REQ_DONTPREP,		/* don't call prep for this one */
 	__REQ_QUEUED,		/* uses queueing */
-- 
2.1.4

