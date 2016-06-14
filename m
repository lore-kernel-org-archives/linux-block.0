Return-Path: <BATV+1815987b1c14acf14571+4678+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mst@redhat.com,
	ooo@electrozaur.com,
	nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: [PATCH 7/7] block: unexport various bio mapping helpers
Date: Tue, 14 Jun 2016 19:16:04 +0200
Message-Id: <1465924564-14503-8-git-send-email-hch@lst.de>
In-Reply-To: <1465924564-14503-1-git-send-email-hch@lst.de>
References: <1465924564-14503-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

They are unused and potential new users really should use the
blk_rq_map* versions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 848cd35..b88ed1c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1097,7 +1097,6 @@ int bio_uncopy_user(struct bio *bio)
 	bio_put(bio);
 	return ret;
 }
-EXPORT_SYMBOL(bio_uncopy_user);
 
 /**
  *	bio_copy_user_iov	-	copy user data to bio
@@ -1392,7 +1391,6 @@ void bio_unmap_user(struct bio *bio)
 	__bio_unmap_user(bio);
 	bio_put(bio);
 }
-EXPORT_SYMBOL(bio_unmap_user);
 
 static void bio_map_kern_endio(struct bio *bio)
 {
@@ -1538,7 +1536,6 @@ cleanup:
 	bio_put(bio);
 	return ERR_PTR(-ENOMEM);
 }
-EXPORT_SYMBOL(bio_copy_kern);
 
 /*
  * bio_set_pages_dirty() and bio_check_pages_dirty() are support functions
-- 
2.1.4
