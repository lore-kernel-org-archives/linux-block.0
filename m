Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: linux-block@vger.kernel.org,
	axboe@kernel.dk,
	kernel-team@fb.com
Subject: [PATCH][v2] block: don't account for split bio's size in cgroup stats
Date: Mon, 30 Jul 2018 09:58:46 -0400
Message-Id: <20180730135846.18828-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

We need to check in blkcg_bio_issue_check if the bio is flagged as
QUEUE_ENTERED, because if it is then we've already accounted for the
size of the IO in the cgroup stats.  We can still however account for
the extra IO since it'll be another request.

Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- added a comment per Jens's suggestion.
- changed it so we only skip the size stat change, we are technically adding
  another request so keep that part of the stats.

 include/linux/blk-cgroup.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 3bed5e02a873..45877776b183 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -769,8 +769,14 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 
 	if (!throtl) {
 		blkg = blkg ?: q->root_blkg;
-		blkg_rwstat_add(&blkg->stat_bytes, bio->bi_opf,
-				bio->bi_iter.bi_size);
+		/*
+		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this
+		 * is a split bio and we would have already accounted for the
+		 * size of the bio.
+		 */
+		if (!bio_flagged(bio, BIO_QUEUE_ENTERED)) {
+			blkg_rwstat_add(&blkg->stat_bytes, bio->bi_opf,
+					bio->bi_iter.bi_size);
 		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
 	}
 
-- 
2.14.3
