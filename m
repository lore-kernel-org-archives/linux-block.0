Return-Path: <BATV+a3f5f3e6054314e6ea5e+5058+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Shaohua Li <shli@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/9] bio-integrity: bio_trim should truncate integrity vector accordingly
Date: Thu, 29 Jun 2017 11:31:08 -0700
Message-Id: <20170629183116.28685-2-hch@lst.de>
In-Reply-To: <20170629183116.28685-1-hch@lst.de>
References: <20170629183116.28685-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Dmitry Monakhov <dmonakhov@openvz.org>

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 9cf98b29588a..8cd995f7d3c0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1894,6 +1894,10 @@ void bio_trim(struct bio *bio, int offset, int size)
 	bio_advance(bio, offset << 9);
 
 	bio->bi_iter.bi_size = size;
+
+	if (bio_integrity(bio))
+		bio_integrity_trim(bio, 0, size);
+
 }
 EXPORT_SYMBOL_GPL(bio_trim);
 
-- 
2.11.0
