Return-Path: <elfring@users.sourceforge.net>
Subject: [PATCH] block: Delete unnecessary checks before the function call
 "mempool_destroy"
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <01dfd682-7b3e-c847-3e67-d859db3341cc@users.sourceforge.net>
Date: Fri, 22 Jul 2016 21:51:26 +0200
MIME-Version: 1.0
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 22 Jul 2016 21:45:26 +0200

The mempool_destroy() function tests whether its argument is NULL
and then returns immediately. Thus the test around the calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 block/bio-integrity.c | 7 ++-----
 block/bio.c           | 8 ++------
 block/blk-core.c      | 3 +--
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index f70cc3b..7506a3e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -499,11 +499,8 @@ EXPORT_SYMBOL(bioset_integrity_create);
 
 void bioset_integrity_free(struct bio_set *bs)
 {
-	if (bs->bio_integrity_pool)
-		mempool_destroy(bs->bio_integrity_pool);
-
-	if (bs->bvec_integrity_pool)
-		mempool_destroy(bs->bvec_integrity_pool);
+	mempool_destroy(bs->bio_integrity_pool);
+	mempool_destroy(bs->bvec_integrity_pool);
 }
 EXPORT_SYMBOL(bioset_integrity_free);
 
diff --git a/block/bio.c b/block/bio.c
index 54ee384..21a2222 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1843,12 +1843,8 @@ void bioset_free(struct bio_set *bs)
 	if (bs->rescue_workqueue)
 		destroy_workqueue(bs->rescue_workqueue);
 
-	if (bs->bio_pool)
-		mempool_destroy(bs->bio_pool);
-
-	if (bs->bvec_pool)
-		mempool_destroy(bs->bvec_pool);
-
+	mempool_destroy(bs->bio_pool);
+	mempool_destroy(bs->bvec_pool);
 	bioset_integrity_free(bs);
 	bio_put_slab(bs);
 
diff --git a/block/blk-core.c b/block/blk-core.c
index a687e9c..db8c6b4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -636,8 +636,7 @@ int blk_init_rl(struct request_list *rl, struct request_queue *q,
 
 void blk_exit_rl(struct request_list *rl)
 {
-	if (rl->rq_pool)
-		mempool_destroy(rl->rq_pool);
+	mempool_destroy(rl->rq_pool);
 }
 
 struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
-- 
2.9.2
