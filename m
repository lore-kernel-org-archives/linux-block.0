Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751491AbdFZMMC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:12:02 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 02/51] block: loop: comment on direct access to bvec table
Date: Mon, 26 Jun 2017 20:09:45 +0800
Message-Id: <20170626121034.3051-3-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0de11444e317..88063ab17e9a 100644
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
