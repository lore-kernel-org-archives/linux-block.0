Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932312AbeF0Mtr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jun 2018 08:49:47 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 19/24] block: loop: pass multipage bvec to iov_iter
Date: Wed, 27 Jun 2018 20:45:43 +0800
Message-Id: <20180627124548.3456-20-ming.lei@redhat.com>
In-Reply-To: <20180627124548.3456-1-ming.lei@redhat.com>
References: <20180627124548.3456-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

iov_iter is implemented with bvec itererator, so it is safe to pass
multipage bvec to it, and this way is much more efficient than
passing one page in each bvec.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d6b6f434fd4b..a350b323e891 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -515,16 +515,16 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	struct bio *bio = rq->bio;
 	struct file *file = lo->lo_backing_file;
 	unsigned int offset;
-	int segments = 0;
+	int nr_bvec = 0;
 	int ret;
 
 	if (rq->bio != rq->biotail) {
-		struct req_iterator iter;
+		struct bvec_iter iter;
 		struct bio_vec tmp;
 
 		__rq_for_each_bio(bio, rq)
-			segments += bio_segments(bio);
-		bvec = kmalloc_array(segments, sizeof(struct bio_vec),
+			nr_bvec += bio_bvecs(bio);
+		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				     GFP_NOIO);
 		if (!bvec)
 			return -EIO;
@@ -533,13 +533,14 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		/*
 		 * The bios of the request may be started from the middle of
 		 * the 'bvec' because of bio splitting, so we can't directly
-		 * copy bio->bi_iov_vec to new bvec. The rq_for_each_segment
+		 * copy bio->bi_iov_vec to new bvec. The bio_for_each_bvec
 		 * API will take care of all details for us.
 		 */
-		rq_for_each_segment(tmp, rq, iter) {
-			*bvec = tmp;
-			bvec++;
-		}
+		__rq_for_each_bio(bio, rq)
+			bio_for_each_bvec(tmp, bio, iter) {
+				*bvec = tmp;
+				bvec++;
+			}
 		bvec = cmd->bvec;
 		offset = 0;
 	} else {
@@ -550,12 +551,11 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		 */
 		offset = bio->bi_iter.bi_bvec_done;
 		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
-		segments = bio_segments(bio);
+		nr_bvec = bio_bvecs(bio);
 	}
 	atomic_set(&cmd->ref, 2);
 
-	iov_iter_bvec(&iter, ITER_BVEC | rw, bvec,
-		      segments, blk_rq_bytes(rq));
+	iov_iter_bvec(&iter, ITER_BVEC | rw, bvec, nr_bvec, blk_rq_bytes(rq));
 	iter.iov_offset = offset;
 
 	cmd->iocb.ki_pos = pos;
-- 
2.9.5
