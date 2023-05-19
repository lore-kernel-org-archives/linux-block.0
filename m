Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E00C77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 04:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjESElB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 00:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESEk6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 00:40:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5B10D2
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 21:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Cdfhz/h6eobdkW1AXim37wZh3wblQAyf7df01SjVxb0=; b=YmYOw+T3x06KleF9Zpzok5XmmL
        tH3P1LNZsXSX8ga+HjFJB3Hfrz2jf5+rMoW9VzjDfZqNTR0NztefIf6STo1Rex8tcUyfAswkvXoA7
        8NpxWVA/hFSoKUJBjKs00rAJjI/Ahh/cgeXzsnArySAIrnLQhnZvmXGuuIILm5mGVI7cOSOEEWnhF
        SWC/nM0ItyZ8HcfCmzZEJkDD9pvcZIUCT4d8kUH1QfFtf62xbFNjFBoEeUssJcGBWKdF6xbN8TTZr
        id4gqAVYHR5kKJHXZJ8M8CPHenxctv/n5sQZ/7VaGJVyiCNoYIxWoIENYK5+bAhK5BIreDhttiKIW
        +SrsVRsg==;
Received: from [2001:4bb8:188:3dd5:8711:951c:9ab6:1400] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzrvE-00F4Wy-1C;
        Fri, 19 May 2023 04:40:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/7] blk-mq: factor out a blk_rq_init_flush helper
Date:   Fri, 19 May 2023 06:40:44 +0200
Message-Id: <20230519044050.107790-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519044050.107790-1-hch@lst.de>
References: <20230519044050.107790-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out a helper from blk_insert_flush that initializes the flush
machine related fields in struct request, and don't bother with the
full memset as there's just a few fields to initialize, and all but
one already have explicit initializers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-flush.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 04698ed9bcd4a9..ed37d272f787eb 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -376,6 +376,15 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 	return RQ_END_IO_NONE;
 }
 
+static void blk_rq_init_flush(struct request *rq)
+{
+	rq->flush.seq = 0;
+	INIT_LIST_HEAD(&rq->flush.list);
+	rq->rq_flags |= RQF_FLUSH_SEQ;
+	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
+	rq->end_io = mq_flush_data_end_io;
+}
+
 /**
  * blk_insert_flush - insert a new PREFLUSH/FUA request
  * @rq: request to insert
@@ -437,13 +446,7 @@ void blk_insert_flush(struct request *rq)
 	 * @rq should go through flush machinery.  Mark it part of flush
 	 * sequence and submit for further processing.
 	 */
-	memset(&rq->flush, 0, sizeof(rq->flush));
-	INIT_LIST_HEAD(&rq->flush.list);
-	rq->rq_flags |= RQF_FLUSH_SEQ;
-	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
-
-	rq->end_io = mq_flush_data_end_io;
-
+	blk_rq_init_flush(rq);
 	spin_lock_irq(&fq->mq_flush_lock);
 	blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
 	spin_unlock_irq(&fq->mq_flush_lock);
-- 
2.39.2

