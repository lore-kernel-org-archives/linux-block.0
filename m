Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 25/51] block: blk-merge: remove unnecessary check
Date: Mon, 26 Jun 2017 20:10:08 +0800
Message-Id: <20170626121034.3051-26-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

In this case, 'sectors' can't be zero at all, so remove the check
and let the bio be splitted.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bf7a0fa0199f..c6fcc49b9aea 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -128,9 +128,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
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
2.9.4
