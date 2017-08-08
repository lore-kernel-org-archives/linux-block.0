Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752278AbdHHIqg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Aug 2017 04:46:36 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 02/49] block: loop: comment on direct access to bvec table
Date: Tue,  8 Aug 2017 16:45:01 +0800
Message-Id: <20170808084548.18963-3-ming.lei@redhat.com>
In-Reply-To: <20170808084548.18963-1-ming.lei@redhat.com>
References: <20170808084548.18963-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ef8334949b42..58df9ed70328 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -487,6 +487,11 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	/* nomerge for loop request queue */
 	WARN_ON(cmd->rq->bio != cmd->rq->biotail);
 
+	/*
+	 * For multipage bvec support, it is safe to pass the bvec
+	 * table to iov iterator, because iov iter still uses bvec
+	 * iter helpers to travese bvec.
+	 */
 	bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
 	iov_iter_bvec(&iter, ITER_BVEC | rw, bvec,
 		      bio_segments(bio), blk_rq_bytes(cmd->rq));
-- 
2.9.4
