Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47707 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932561AbcLINTM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2016 08:19:12 -0500
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] blk-wbt: don't throttle discard or write zeroes
Date: Fri,  9 Dec 2016 14:19:06 +0100
Message-Id: <1481289546-2397-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Both of these are metadata only commands that are not issued by the
writeback code and not directly relevant to the writeback bandwith.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-wbt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index d500e43..6e82769 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -575,10 +575,9 @@ static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
 	const int op = bio_op(bio);
 
 	/*
-	 * If not a WRITE (or a discard or write zeroes), do nothing
+	 * If not a WRITE, do nothing
 	 */
-	if (!(op == REQ_OP_WRITE || op == REQ_OP_DISCARD ||
-				op == REQ_OP_WRITE_ZEROES))
+	if (op != REQ_OP_WRITE)
 		return false;
 
 	/*
-- 
2.1.4

