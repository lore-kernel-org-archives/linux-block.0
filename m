Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH v3 36/49] dm-crypt: convert to bio_for_each_segment_all_sp()
Date: Tue,  8 Aug 2017 16:45:35 +0800
Message-Id: <20170808084548.18963-37-ming.lei@redhat.com>
In-Reply-To: <20170808084548.18963-1-ming.lei@redhat.com>
References: <20170808084548.18963-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Cc: Mike Snitzer <snitzer@redhat.com>
Cc:dm-devel@redhat.com
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-crypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 664ba3504f48..0f2f44a73a32 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1446,8 +1446,9 @@ static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone)
 {
 	unsigned int i;
 	struct bio_vec *bv;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bv, clone, i) {
+	bio_for_each_segment_all_sp(bv, clone, i, bia) {
 		BUG_ON(!bv->bv_page);
 		mempool_free(bv->bv_page, cc->page_pool);
 	}
-- 
2.9.4
