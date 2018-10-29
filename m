Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Xiao Ni <xni@redhat.com>,
	Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Subject: [PATCH V2 2/3] block: cleanup __blkdev_issue_discard()
Date: Mon, 29 Oct 2018 20:57:18 +0800
Message-Id: <20181029125719.4998-3-ming.lei@redhat.com>
In-Reply-To: <20181029125719.4998-1-ming.lei@redhat.com>
References: <20181029125719.4998-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Cleanup __blkdev_issue_discard() a bit:

- remove local variable of 'end_sect'
- remove code block of 'fail'

Cc: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Xiao Ni <xni@redhat.com>
Cc: Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-lib.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index d56fd159d2e8..d58d5d87dd88 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -51,15 +51,12 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
 
-	while (nr_sects) {
-		unsigned int req_sects = nr_sects;
-		sector_t end_sect;
-
-		if (!req_sects)
-			goto fail;
-		req_sects = min(req_sects, bio_allowed_max_sectors(q));
+	if (!nr_sects)
+		return -EINVAL;
 
-		end_sect = sector + req_sects;
+	while (nr_sects) {
+		unsigned int req_sects = min_t(unsigned int, nr_sects,
+				bio_allowed_max_sectors(q));
 
 		bio = blk_next_bio(bio, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
@@ -67,8 +64,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		bio_set_op_attrs(bio, op, 0);
 
 		bio->bi_iter.bi_size = req_sects << 9;
+		sector += req_sects;
 		nr_sects -= req_sects;
-		sector = end_sect;
 
 		/*
 		 * We can loop for a long time in here, if someone does
@@ -81,14 +78,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 	*biop = bio;
 	return 0;
-
-fail:
-	if (bio) {
-		submit_bio_wait(bio);
-		bio_put(bio);
-	}
-	*biop = NULL;
-	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(__blkdev_issue_discard);
 
-- 
2.9.5
