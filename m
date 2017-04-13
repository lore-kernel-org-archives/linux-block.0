Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdDMQIh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2017 12:08:37 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>, jth@kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: fix bio_will_gap()
Date: Fri, 14 Apr 2017 00:06:26 +0800
Message-Id: <20170413160626.14635-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now commit 729204ef49ec("block: relax check on sg gap")
allows us to merge bios if both are physically contiguous,
this change can merge huge of small bios in use case of mkfs,
for example, mkfs.ntfs running time can be decreased to ~1/10.

But if one rq starts with non-aligned buffer(the 1st bvec's
bv_offset isn't zero) and if we allow to merge, it is quite
difficult to respect sg gap limit, especially the segment
can't be at maximum segment size, otherwise the segment
ends in unaligned virt boundary. This patch trys to avoid the
issue by not allowing to merge if the req starts with non-aligned
buffer.

Also add comments to explain why the merged segment can't
end in unaligned virt boundary.

Fixes: 729204ef49ec ("block: relax check on sg gap")
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b75d6fe5a1b9..5eaf323de98b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1672,12 +1672,36 @@ static inline bool bios_segs_mergeable(struct request_queue *q,
 	return true;
 }
 
-static inline bool bio_will_gap(struct request_queue *q, struct bio *prev,
-			 struct bio *next)
+static inline bool bio_will_gap(struct request_queue *q,
+				struct request *prev_rq,
+				struct bio *prev,
+				struct bio *next)
 {
 	if (bio_has_data(prev) && queue_virt_boundary(q)) {
 		struct bio_vec pb, nb;
 
+		/*
+		 * don't merge if the 1st bio starts with non-zero
+		 * offset, otherwise it is quite difficult to respect
+		 * sg gap limit. We work hard to merge huge of small
+		 * single bios in case of mkfs.
+		 */
+		if (prev_rq)
+			bio_get_first_bvec(prev_rq->bio, &pb);
+		else
+			bio_get_first_bvec(prev, &pb);
+		if (pb.bv_offset)
+			return true;
+
+		/*
+		 * We don't need to worry about the situation that the
+		 * merged segment ends in unaligned virt boundary:
+		 *
+		 * - if 'pb' ends aligned, the merged segment ends aligned
+		 * - if 'pb' ends unaligned, the next bio must include
+		 *   one single bvec of 'nb', otherwise the 'nb' can't
+		 *   merge with 'pb'
+		 */
 		bio_get_last_bvec(prev, &pb);
 		bio_get_first_bvec(next, &nb);
 
@@ -1690,12 +1714,12 @@ static inline bool bio_will_gap(struct request_queue *q, struct bio *prev,
 
 static inline bool req_gap_back_merge(struct request *req, struct bio *bio)
 {
-	return bio_will_gap(req->q, req->biotail, bio);
+	return bio_will_gap(req->q, req, req->biotail, bio);
 }
 
 static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
 {
-	return bio_will_gap(req->q, bio, req->bio);
+	return bio_will_gap(req->q, NULL, bio, req->bio);
 }
 
 static inline void blk_dump_rq(const struct request *req, const char *msg)
-- 
2.9.3
