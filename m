Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34341 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934173AbcJ2INC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:13:02 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        Mike Christie <mchristi@redhat.com>,
        Minfei Huang <mnghuan@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 15/60] block: loop: comment on direct access to bvec table
Date: Sat, 29 Oct 2016 16:08:14 +0800
Message-Id: <1477728600-12938-16-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fa1b7a90ba11..55ce4226590d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -485,6 +485,11 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
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
2.7.4

