Return-Path: <devtimhansen@gmail.com>
Return-Path: <devtimhansen@gmail.com>
Date: Fri, 6 Oct 2017 14:45:13 -0400
From: Tim Hansen <devtimhansen@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexander.levin@one.verizon.com, devtimhansen@gmail.com
Subject: [PATCH] block/bio: Remove null checks before mempool_destroy in
 bioset_free
Message-ID: <20171006184513.GA78611@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

This patch removes redundant checks for null values on bio_pool and bvec_pool.

Found using make coccicheck M=block/ on linux-net tree on the next-20170929 tag.

Related to patch 9987695 that removed similar checks in bio-integrity. 

Signed-off-by: Tim Hansen <devtimhansen@gmail.com>
---
 block/bio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8338304..bf0dbe8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1928,11 +1928,8 @@ void bioset_free(struct bio_set *bs)
 	if (bs->rescue_workqueue)
 		destroy_workqueue(bs->rescue_workqueue);
 
-	if (bs->bio_pool)
-		mempool_destroy(bs->bio_pool);
-
-	if (bs->bvec_pool)
-		mempool_destroy(bs->bvec_pool);
+	mempool_destroy(bs->bio_pool);
+	mempool_destroy(bs->bvec_pool);
 
 	bioset_integrity_free(bs);
 	bio_put_slab(bs);
-- 
2.1.4
