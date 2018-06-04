Return-Path: <BATV+f3425a2e9bbdb5bc872a+5398+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: bio_set_pages_dirty can't see NULL bv_page in a valid bio_vec
Date: Mon,  4 Jun 2018 15:58:52 +0200
Message-Id: <20180604135853.30972-3-hch@lst.de>
In-Reply-To: <20180604135853.30972-1-hch@lst.de>
References: <20180604135853.30972-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

So don't bother handling it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 50941c1c9118..d95fab72acb5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1578,10 +1578,8 @@ void bio_set_pages_dirty(struct bio *bio)
 	int i;
 
 	bio_for_each_segment_all(bvec, bio, i) {
-		struct page *page = bvec->bv_page;
-
-		if (page && !PageCompound(page))
-			set_page_dirty_lock(page);
+		if (!PageCompound(bvec->bv_page))
+			set_page_dirty_lock(bvec->bv_page);
 	}
 }
 
-- 
2.14.2
