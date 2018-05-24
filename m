Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 14/33] block: loop: pass segments to iov_iter
Date: Thu, 24 May 2018 17:01:19 +0800
Message-Id: <20180524090139.2150-15-ming.lei@redhat.com>
In-Reply-To: <20180524090139.2150-1-ming.lei@redhat.com>
References: <20180524090139.2150-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

iov_iter is implemented with bvec itererator, so it is safe to pass
segment to it, and this way is much more efficient than passing one
page in each bvec.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8d7d5581ca9c..e709c0380566 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -521,7 +521,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		struct bio_vec tmp;
 
 		__rq_for_each_bio(bio, rq)
-			segments += bio_pages(bio);
+			segments += bio_segments(bio);
 		bvec = kmalloc(sizeof(struct bio_vec) * segments, GFP_NOIO);
 		if (!bvec)
 			return -EIO;
@@ -533,7 +533,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		 * copy bio->bi_iov_vec to new bvec. The rq_for_each_page
 		 * API will take care of all details for us.
 		 */
-		rq_for_each_page(tmp, rq, iter) {
+		rq_for_each_segment(tmp, rq, iter) {
 			*bvec = tmp;
 			bvec++;
 		}
@@ -547,7 +547,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		 */
 		offset = bio->bi_iter.bi_bvec_done;
 		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
-		segments = bio_pages(bio);
+		segments = bio_segments(bio);
 	}
 	atomic_set(&cmd->ref, 2);
 
-- 
2.9.5
