Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	stable@vger.kernel.org,
	Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Xiao Ni <xni@redhat.com>,
	Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Subject: [PATCH V2 3/3] block: make sure writesame bio is aligned with logical block size
Date: Mon, 29 Oct 2018 20:57:19 +0800
Message-Id: <20181029125719.4998-4-ming.lei@redhat.com>
In-Reply-To: <20181029125719.4998-1-ming.lei@redhat.com>
References: <20181029125719.4998-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Obviously the created writesame bio has to be aligned with logical block
size, and use bio_allowed_max_sectors() to retrieve this number.

Fixes: b49a0871be31a745b2ef ("block: remove split code in blkdev_issue_{discard,write_same}")
Cc: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Xiao Ni <xni@redhat.com>
Cc: Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index d58d5d87dd88..e8b3bb9bf375 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -149,7 +149,7 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		return -EOPNOTSUPP;
 
 	/* Ensure that max_write_same_sectors doesn't overflow bi_size */
-	max_write_same_sectors = UINT_MAX >> 9;
+	max_write_same_sectors = bio_allowed_max_sectors(q);
 
 	while (nr_sects) {
 		bio = blk_next_bio(bio, 1, gfp_mask);
-- 
2.9.5
