Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B2EC77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 04:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjESElK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 00:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjESElJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 00:41:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760910F0
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zkFHrgMBKG3Lg2cEUpNdLBdgYFqJN3EbR5nFpx3gwEU=; b=SIu39xLnUEiSK1f6ruJjxE6ND2
        FHXHvv6gAnz7uUqQazGYm39XOYLvtd39EmJ7kmxDdnTIfDc8f4+SYDZzvmmYDT/DoAZoodraZ+BZX
        CkPwMOj2etb81c5NFEdVJTGc3JVYZTvuPX+0xtcrR5+1VGZO9tf4/BnLyh+0aE1sn67bI+o75R6hp
        SUp8x0By/jgfVp3iKTSo2yN3A6gd/viiEq1vd7ZyLPDTedM8Vgc/xHMO62bHdLZ5BbS2GTs5BtdH3
        JH+++ydrvPNVzWcNSVi0/SgkA/pBo0eXUWwlIIt84JWDb0P8wbTxX+qfLduODRNaZ/zTmswGPH+3e
        tkyGz5pA==;
Received: from [2001:4bb8:188:3dd5:8711:951c:9ab6:1400] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzrvN-00F4YL-0f;
        Fri, 19 May 2023 04:41:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/7] blk-mq: use the I/O scheduler for writes from the flush state machine
Date:   Fri, 19 May 2023 06:40:47 +0200
Message-Id: <20230519044050.107790-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519044050.107790-1-hch@lst.de>
References: <20230519044050.107790-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

Send write requests issued by the flush state machine through the normal
I/O submission path including the I/O scheduler (if present) so that I/O
scheduler policies are applied to writes with the FUA flag set.

Separate the I/O scheduler members from the flush members in struct
request since now a request may pass through both an I/O scheduler
and the flush machinery.

Note that the actual flush requests, which have no bio attached to the
request still bypass the I/O schedulers.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
[hch: rebased]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq.c         |  4 ++--
 include/linux/blk-mq.h | 27 +++++++++++----------------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c0b394096b6b6b..aac67bc3d3680c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -458,7 +458,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		 * Flush/passthrough requests are special and go directly to the
 		 * dispatch list.
 		 */
-		if (!op_is_flush(data->cmd_flags) &&
+		if ((data->cmd_flags & REQ_OP_MASK) != REQ_OP_FLUSH &&
 		    !blk_op_is_passthrough(data->cmd_flags)) {
 			struct elevator_mq_ops *ops = &q->elevator->type->ops;
 
@@ -2497,7 +2497,7 @@ static void blk_mq_insert_request(struct request *rq, blk_insert_t flags)
 		 * dispatch it given we prioritize requests in hctx->dispatch.
 		 */
 		blk_mq_request_bypass_insert(rq, flags);
-	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
+	} else if (req_op(rq) == REQ_OP_FLUSH) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
 		 * sw queue, meantime we add flush request to dispatch queue(
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 49d14b1acfa5df..935201c8974371 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -169,25 +169,20 @@ struct request {
 		void *completion_data;
 	};
 
-
 	/*
 	 * Three pointers are available for the IO schedulers, if they need
-	 * more they have to dynamically allocate it.  Flush requests are
-	 * never put on the IO scheduler. So let the flush fields share
-	 * space with the elevator data.
+	 * more they have to dynamically allocate it.
 	 */
-	union {
-		struct {
-			struct io_cq		*icq;
-			void			*priv[2];
-		} elv;
-
-		struct {
-			unsigned int		seq;
-			struct list_head	list;
-			rq_end_io_fn		*saved_end_io;
-		} flush;
-	};
+	struct {
+		struct io_cq		*icq;
+		void			*priv[2];
+	} elv;
+
+	struct {
+		unsigned int		seq;
+		struct list_head	list;
+		rq_end_io_fn		*saved_end_io;
+	} flush;
 
 	union {
 		struct __call_single_data csd;
-- 
2.39.2

