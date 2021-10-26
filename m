Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC000C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 07:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69E7610C7
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 07:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhJZHeS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 03:34:18 -0400
Received: from verein.lst.de ([213.95.11.211]:60757 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232626AbhJZHeR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 03:34:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 47F4F6732D; Tue, 26 Oct 2021 09:31:52 +0200 (CEST)
Date:   Tue, 26 Oct 2021 09:31:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/8] loop: remove always true check
Message-ID: <20211026073152.GB31967@lst.de>
References: <20211025094437.2837701-1-ming.lei@redhat.com> <20211025094437.2837701-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025094437.2837701-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

lo_complete_rq is still a complete mess.  I'd suggest something like
this instead:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8f140d6374356..1648d30a8cb4a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -517,40 +517,37 @@ static void lo_flush_dcache_for_read(struct request *rq)
 static void lo_complete_rq(struct request *rq)
 {
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
-	blk_status_t ret = BLK_STS_OK;
+
+	if (cmd->ret < 0) {
+		blk_mq_end_request(rq, errno_to_blk_status(cmd->ret));
+		return;
+	}
 
 	/* Kernel wrote to our pages, call flush_dcache_page */
 	if (req_op(rq) == REQ_OP_READ && !cmd->use_aio && cmd->ret >= 0)
 		lo_flush_dcache_for_read(rq);
 
-	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
-	    req_op(rq) != REQ_OP_READ) {
-		if (cmd->ret < 0)
-			ret = errno_to_blk_status(cmd->ret);
-		goto end_io;
-	}
-
 	/*
-	 * Short READ - if we got some data, advance our request and
-	 * retry it. If we got no data, end the rest with EIO.
+	 * Short READ - if we got some data, advance our request and retry it.
+	 * If we got no data, end the rest with EIO.
 	 */
-	if (cmd->ret) {
-		blk_update_request(rq, BLK_STS_OK, cmd->ret);
-		cmd->ret = 0;
-		blk_mq_requeue_request(rq, true);
-	} else {
-		if (cmd->use_aio) {
-			struct bio *bio = rq->bio;
+	if (req_op(rq) == REQ_OP_READ && cmd->use_aio &&
+	    cmd->ret != blk_rq_bytes(rq)) {
+		if (cmd->ret) {
+			blk_update_request(rq, BLK_STS_OK, cmd->ret);
+			cmd->ret = 0;
+			blk_mq_requeue_request(rq, true);
+		} else {
+			struct bio *bio;
 
-			while (bio) {
+			for (bio = rq->bio; bio; bio = bio->bi_next)
 				zero_fill_bio(bio);
-				bio = bio->bi_next;
-			}
+			blk_mq_end_request(rq, BLK_STS_IOERR);
 		}
-		ret = BLK_STS_IOERR;
-end_io:
-		blk_mq_end_request(rq, ret);
+		return;
 	}
+
+	blk_mq_end_request(rq, BLK_STS_OK);
 }
 
 static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
