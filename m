Return-Path: <gedwards@ddn.com>
From: Greg Edwards <gedwards@ddn.com>
To: <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Greg Edwards
	<gedwards@ddn.com>
Subject: [PATCH] block: bvec_nr_vecs() returns value for wrong slab
Date: Wed, 8 Aug 2018 13:27:53 -0600
Message-ID: <20180808192753.817-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: gedwards@ddn.com
List-ID: <linux-block@vger.kernel.org>

In commit ed996a52c868 ("block: simplify and cleanup bvec pool
handling"), the value of the slab index is incremented by one in
bvec_alloc() after the allocation is done to indicate an index value of
0 does not need to be later freed.

bvec_nr_vecs() was not updated accordingly, and thus returns the wrong
value.  Decrement idx before performing the lookup.

Fixes: ed996a52c868 ("block: simplify and cleanup bvec pool handling")
Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 047c5dca6d90..ff94640bc734 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -156,7 +156,7 @@ static void bio_put_slab(struct bio_set *bs)
 
 unsigned int bvec_nr_vecs(unsigned short idx)
 {
-	return bvec_slabs[idx].nr_vecs;
+	return bvec_slabs[--idx].nr_vecs;
 }
 
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned int idx)
-- 
2.17.1
