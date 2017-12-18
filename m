Return-Path: <linux-fsdevel-owner@vger.kernel.org>
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
Subject: [PATCH V4 14/45] block: blk-merge: remove unnecessary check
Date: Mon, 18 Dec 2017 20:22:16 +0800
Message-Id: <20171218122247.3488-15-ming.lei@redhat.com>
In-Reply-To: <20171218122247.3488-1-ming.lei@redhat.com>
References: <20171218122247.3488-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

In this case, 'sectors' can't be zero at all, so remove the check
and let the bio be splitted.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 42ceb89bc566..39f2c1113423 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -129,9 +129,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
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
2.9.5
