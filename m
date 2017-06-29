Return-Path: <BATV+a3f5f3e6054314e6ea5e+5058+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Shaohua Li <shli@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/9] bio-integrity: bio_integrity_advance must update integrity seed
Date: Thu, 29 Jun 2017 11:31:09 -0700
Message-Id: <20170629183116.28685-3-hch@lst.de>
In-Reply-To: <20170629183116.28685-1-hch@lst.de>
References: <20170629183116.28685-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Dmitry Monakhov <dmonakhov@openvz.org>

SCSI drivers do care about bip_seed so we must update it accordingly.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index b8a3a65f7364..8c2253c59edb 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -425,6 +425,7 @@ void bio_integrity_advance(struct bio *bio, unsigned int bytes_done)
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 	unsigned bytes = bio_integrity_bytes(bi, bytes_done >> 9);
 
+	bip->bip_iter.bi_sector += bytes_done >> 9;
 	bvec_iter_advance(bip->bip_vec, &bip->bip_iter, bytes);
 }
 EXPORT_SYMBOL(bio_integrity_advance);
-- 
2.11.0
