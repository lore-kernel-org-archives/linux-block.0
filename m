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
Subject: [PATCH 20/27] rsxx: remove the discard_zeroes_data flag
Date: Wed,  5 Apr 2017 19:21:18 +0200
Message-Id: <20170405172125.22600-21-hch@lst.de>
In-Reply-To: <20170405172125.22600-1-hch@lst.de>
References: <20170405172125.22600-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

rsxx only supports discarding on large alignments, so the zeroing code
would always fall back to explicit writings of zeroes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/block/rsxx/dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index f81d70b39d10..9c566364ac9c 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -300,7 +300,6 @@ int rsxx_setup_dev(struct rsxx_cardinfo *card)
 						RSXX_HW_BLK_SIZE >> 9);
 		card->queue->limits.discard_granularity = RSXX_HW_BLK_SIZE;
 		card->queue->limits.discard_alignment   = RSXX_HW_BLK_SIZE;
-		card->queue->limits.discard_zeroes_data = 1;
 	}
 
 	card->queue->queuedata = card;
-- 
2.11.0
