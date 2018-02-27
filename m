Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43923 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752670AbeB0MKN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 07:10:13 -0500
From: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: [PATCH 1/4] block: fix the count of PGPGOUT for WRITE_SAME
To: Christoph Hellwig <hch@lst.de>, Shaohua Li <shli@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>,
        caspar@linux.alibaba.com, Joseph Qi <joseph.qi@linux.alibaba.com>
References: <014d8f0c-31db-c18b-855e-5e425b9499be@linux.alibaba.com>
Message-ID: <2e963c03-48c7-e3cf-03c1-4077b88eda46@linux.alibaba.com>
Date: Tue, 27 Feb 2018 20:10:03 +0800
MIME-Version: 1.0
In-Reply-To: <014d8f0c-31db-c18b-855e-5e425b9499be@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The vm counters is counted in sectors, so we should do the conversation
in submit_bio.

Fixes: 74d46992e0d9 ("block: replace bi_bdev with a gendisk pointer and partitions index")
Cc: stable@vger.kernel.org
Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
