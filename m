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
Subject: [PATCH V2 1/3] block: make sure discard bio is aligned with logical block size
Date: Mon, 29 Oct 2018 20:57:17 +0800
Message-Id: <20181029125719.4998-2-ming.lei@redhat.com>
In-Reply-To: <20181029125719.4998-1-ming.lei@redhat.com>
References: <20181029125719.4998-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Obviously the created discard bio has to be aligned with logical block size.

This patch introduces the helper of bio_allowed_max_sectors() for
this purpose.

Fixes: 744889b7cbb56a6 ("block: don't deal with discard limit in blkdev_issue_discard()")
Fixes: a22c4d7e34402cc ("block: re-add discard_granularity and alignment checks")
Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Xiao Ni <xni@redhat.com>
Cc: Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-lib.c   |  3 +--
 block/blk-merge.c |  3 ++-
 block/blk.h       | 10 ++++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 76f867ea9a9b..d56fd159d2e8 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -57,8 +57,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 		if (!req_sects)
 			goto fail;
-		if (req_sects > UINT_MAX >> 9)
-			req_sects = UINT_MAX >> 9;
+		req_sects = min(req_sects, bio_allowed_max_sectors(q));
 
 		end_sect = sector + req_sects;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 42a46744c11b..507fbaa6b4c0 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -90,7 +90,8 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 	/* Zero-sector (unknown) and one-sector granularities are the same.  */
 	granularity = max(q->limits.discard_granularity >> 9, 1U);
 
-	max_discard_sectors = min(q->limits.max_discard_sectors, UINT_MAX >> 9);
+	max_discard_sectors = min(q->limits.max_discard_sectors,
+			bio_allowed_max_sectors(q));
 	max_discard_sectors -= max_discard_sectors % granularity;
 
 	if (unlikely(!max_discard_sectors)) {
diff --git a/block/blk.h b/block/blk.h
index a1841b8ff129..2680aa4fcd88 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -396,6 +396,16 @@ static inline unsigned long blk_rq_deadline(struct request *rq)
 }
 
 /*
+ * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
+ * is defined as 'unsigned int', meantime it has to aligned to with logical
+ * block size which is the minimum accepted unit by hardware.
+ */
+static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
+{
+	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
+}
+
+/*
  * Internal io_context interface
  */
 void get_io_context(struct io_context *ioc);
-- 
2.9.5
