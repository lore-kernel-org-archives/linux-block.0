Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50199 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424299AbcKANkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:40:23 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/16] umem: use op_is_sync to check for synchronous requests
Date: Tue,  1 Nov 2016 07:40:04 -0600
Message-Id: <1478007617-18715-4-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/umem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index be90e15..46f4c71 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -535,7 +535,7 @@ static blk_qc_t mm_make_request(struct request_queue *q, struct bio *bio)
 	*card->biotail = bio;
 	bio->bi_next = NULL;
 	card->biotail = &bio->bi_next;
-	if (bio->bi_opf & REQ_SYNC || !mm_check_plugged(card))
+	if (op_is_sync(bio->bi_opf) || !mm_check_plugged(card))
 		activate(card);
 	spin_unlock_irq(&card->lock);
 
-- 
2.1.4

