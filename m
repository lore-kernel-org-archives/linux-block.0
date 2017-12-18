Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759251AbdLRMaD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Dec 2017 07:30:03 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 28/45] block: loop: pass segments to iov_iter
Date: Mon, 18 Dec 2017 20:22:30 +0800
Message-Id: <20171218122247.3488-29-ming.lei@redhat.com>
In-Reply-To: <20171218122247.3488-1-ming.lei@redhat.com>
References: <20171218122247.3488-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

iov_iter is implemented with bvec itererator, so it is safe to pass
segment to it, and this way is much more efficient than passing one
page in each bvec.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8e30d081ad2a..90e3f402af62 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -499,7 +499,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		struct bio_vec tmp;
 
 		__rq_for_each_bio(bio, rq)
-			segments += bio_pages(bio);
+			segments += bio_segments(bio);
 		bvec = kmalloc(sizeof(struct bio_vec) * segments, GFP_NOIO);
 		if (!bvec)
 			return -EIO;
@@ -511,7 +511,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		 * copy bio->bi_iov_vec to new bvec. The rq_for_each_page
 		 * API will take care of all details for us.
 		 */
-		rq_for_each_page(tmp, rq, iter) {
+		rq_for_each_segment(tmp, rq, iter) {
 			*bvec = tmp;
 			bvec++;
 		}
@@ -525,7 +525,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		 */
 		offset = bio->bi_iter.bi_bvec_done;
 		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
-		segments = bio_pages(bio);
+		segments = bio_segments(bio);
 	}
 	atomic_set(&cmd->ref, 2);
 
-- 
2.9.5
