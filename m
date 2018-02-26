Return-Path: <jiufei.xue@linux.alibaba.com>
Subject: [PATCH 1/4] block: fix the count of PGPGOUT for WRITE_SAME
From: Jiufei Xue <jiufei.xue@linux.alibaba.com>
To: hch@lst.de, Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, caspar@linux.alibaba.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
Message-ID: <ccd2433b-c197-bce3-fec7-14467f864d19@linux.alibaba.com>
Date: Mon, 26 Feb 2018 20:04:35 +0800
MIME-Version: 1.0
In-Reply-To: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

The vm counters is counted in sectors, so we should do the conversation
in submit_bio.

Fixes: 74d46992e0d9 ("block: replace bi_bdev with a gendisk pointer and
partitions index")

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2d1a7bb..6d82c4f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2434,7 +2434,7 @@ blk_qc_t submit_bio(struct bio *bio)
 		unsigned int count;
 
 		if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
-			count = queue_logical_block_size(bio->bi_disk->queue);
+			count = queue_logical_block_size(bio->bi_disk->queue) >> 9;
 		else
 			count = bio_sectors(bio);
 
-- 
1.9.4
