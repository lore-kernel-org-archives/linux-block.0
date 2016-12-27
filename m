Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34126 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933114AbcL0QHk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:07:40 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        Mike Christie <mchristi@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Minfei Huang <mnghuan@gmail.com>,
        Omar Sandoval <osandov@fb.com>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v1 02/54] block: loop: comment on direct access to bvec table
Date: Tue, 27 Dec 2016 23:55:51 +0800
Message-Id: <1482854250-13481-3-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f347285c67ec..be1cc51815ac 100644
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

