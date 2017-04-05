Return-Path: <BATV+9cf0d970ddff402c2c33+4973+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	martin.petersen@oracle.com,
	agk@redhat.com,
	snitzer@redhat.com,
	shli@kernel.org,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	dm-devel@redhat.com,
	linux-raid@vger.kernel.org
Subject: [PATCH 03/27] block: implement splitting of REQ_OP_WRITE_ZEROES bios
Date: Wed,  5 Apr 2017 16:21:41 +0200
Message-Id: <20170405142205.6477-4-hch@lst.de>
In-Reply-To: <20170405142205.6477-1-hch@lst.de>
References: <20170405142205.6477-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Copy and past the REQ_OP_WRITE_SAME code to prepare to implementations
that limit the write zeroes size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-merge.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2afa262425d1..3990ae406341 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -54,6 +54,20 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 	return bio_split(bio, split_sectors, GFP_NOIO, bs);
 }
 
+static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
+		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
+{
+	*nsegs = 1;
+
+	if (!q->limits.max_write_zeroes_sectors)
+		return NULL;
+
+	if (bio_sectors(bio) <= q->limits.max_write_zeroes_sectors)
+		return NULL;
+
+	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
+}
+
 static struct bio *blk_bio_write_same_split(struct request_queue *q,
 					    struct bio *bio,
 					    struct bio_set *bs,
@@ -200,8 +214,7 @@ void blk_queue_split(struct request_queue *q, struct bio **bio,
 		split = blk_bio_discard_split(q, *bio, bs, &nsegs);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		split = NULL;
-		nsegs = (*bio)->bi_phys_segments;
+		split = blk_bio_write_zeroes_split(q, *bio, bs, &nsegs);
 		break;
 	case REQ_OP_WRITE_SAME:
 		split = blk_bio_write_same_split(q, *bio, bs, &nsegs);
-- 
2.11.0
