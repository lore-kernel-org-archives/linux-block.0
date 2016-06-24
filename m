Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:51349 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbcFXHBE (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 24 Jun 2016 03:01:04 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: shli@fb.com, martin.petersen@oracle.com, snitzer@redhat.com,
	sitsofe@yahoo.com, linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: don't ignore -EOPNOTSUPP blkdev_issue_write_same
Date: Fri, 24 Jun 2016 09:00:51 +0200
Message-Id: <1466751651-9900-3-git-send-email-hch@lst.de>
In-Reply-To: <1466751651-9900-1-git-send-email-hch@lst.de>
References: <1466751651-9900-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

WRITE SAME is a data integrity operation and we can't simply ignore
errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 45b35b1..e371f83 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -178,7 +178,7 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 
 	if (bio)
 		ret = submit_bio_wait(bio);
-	return ret != -EOPNOTSUPP ? ret : 0;
+	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_write_same);
 
-- 
2.1.4

