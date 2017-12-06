Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754954AbdLFKsb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Dec 2017 05:48:31 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: print error via printk_ratelimited in blk_partition_remap()
Date: Wed,  6 Dec 2017 18:48:13 +0800
Message-Id: <20171206104813.4828-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If there are IOs running on one partition during remove disk, blk_partition_remap()
complains the partition is missed because it is removed by del_gendisk(),
and causes flood of this error messge, so this patch uses printk_ratelimited()
to avoid the issue.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b8881750a3ac..32878c2ccece 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2074,7 +2074,7 @@ static inline int blk_partition_remap(struct bio *bio)
 		trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
 				bio->bi_iter.bi_sector - p->start_sect);
 	} else {
-		printk("%s: fail for partition %d\n", __func__, bio->bi_partno);
+		printk_ratelimited("%s: fail for partition %d\n", __func__, bio->bi_partno);
 		ret = -EIO;
 	}
 	rcu_read_unlock();
-- 
2.9.5
