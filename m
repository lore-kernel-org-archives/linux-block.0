Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/5] block: warn on un-aligned DMA IO buffer
Date: Thu, 18 Oct 2018 21:18:13 +0800
Message-Id: <20181018131817.11813-2-ming.lei@redhat.com>
In-Reply-To: <20181018131817.11813-1-ming.lei@redhat.com>
References: <20181018131817.11813-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Now we only check if DMA IO buffer is aligned to queue_dma_alignment()
for pass-through request, and it isn't done for normal IO request.

Given the check has to be done on each bvec, it isn't efficient to add the
check in generic_make_request_checks().

This patch addes one WARN in blk_queue_split() for capturing this issue.

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: xfs@vger.kernel.org
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 42a46744c11b..d2dbd508cb6d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -174,6 +174,8 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	const unsigned max_sectors = get_max_io_size(q, bio);
 
 	bio_for_each_segment(bv, bio, iter) {
+		WARN_ON_ONCE(queue_dma_alignment(q) & bv.bv_offset);
+
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
-- 
2.9.5
