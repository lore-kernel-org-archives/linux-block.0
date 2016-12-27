Return-Path: <tom.leiming@gmail.com>
Return-Path: <tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v1 26/54] block: blk-merge: remove unnecessary check
Date: Tue, 27 Dec 2016 23:56:15 +0800
Message-Id: <1482854250-13481-27-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

In this case, 'sectors' can't be zero at all, so remove the check.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-merge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a801f62a104b..05b6a3ef63f6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -136,9 +136,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 				nsegs++;
 				sectors = max_sectors;
 			}
-			if (sectors)
-				goto split;
-			/* Make this single bvec as the 1st segment */
+			goto split;
 		}
 
 		if (bvprvp && blk_queue_cluster(q)) {
-- 
2.7.4
