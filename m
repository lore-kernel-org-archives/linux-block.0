Return-Path: <BATV+d9901c46b23ecc19815a+5342+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Bart.VanAssche@wdc.com,
	willy@infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/7] block: fix __get_request documentation
Date: Mon,  9 Apr 2018 17:39:11 +0200
Message-Id: <20180409153916.23901-3-hch@lst.de>
In-Reply-To: <20180409153916.23901-1-hch@lst.de>
References: <20180409153916.23901-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index abcb8684ba67..abde22c755ab 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1517,7 +1517,7 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
  * @bio: bio to allocate request for (can be %NULL)
  * @flags: BLK_MQ_REQ_* flags.
  *
- * Get a free request from @q.  If %__GFP_DIRECT_RECLAIM is set in @gfp_mask,
+ * Get a free request from @q.  If %BLK_MQ_REQ_NOWAIT is set in @flags,
  * this function keeps retrying under memory pressure and fails iff @q is dead.
  *
  * Must be called with @q->queue_lock held and,
-- 
2.16.3
