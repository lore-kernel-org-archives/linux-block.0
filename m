Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FF5C77B61
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 20:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjDPUJp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 16:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDPUJp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 16:09:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E54726B0
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fzYb0ZZTYB62fhL/WjHIfj4UELaiG2TKKNw8z705kzE=; b=DI74zLJOiySV5JYaWIFqfEw0oW
        XylS0X1t8oVfta1uYYGBylppEqBEfoK6cPC3CR8tjJ9cJNtxetrMzQ8OwsBRvEZ+553CWKD7xt1M0
        9WKkwPmCHY1WsmRalj7bkCezmKzohR+JW+W8oHp+JsEXVnTAnIQIi0o8MsN5UEDM81bvB1/MzdRA+
        24HjX5iAerS6qQ6F3o4ozIUeGDkA1LR8tJ/FAWHl8spbFaFlkISFzV4xTJY4le6BsTfvq3KO6YxCw
        W+6ynBEaErUzXcJzeBx0dpP2ZvVrB7Iv5HvkVHif1nidOJ7y0CCAiwJqLcnWXPYkX6qtoXuS+URO4
        2aL0X8HQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1po8gv-00EOHo-1z;
        Sun, 16 Apr 2023 20:09:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/7] blk-mq: factor out a blk_rq_init_flush helper
Date:   Sun, 16 Apr 2023 22:09:24 +0200
Message-Id: <20230416200930.29542-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416200930.29542-1-hch@lst.de>
References: <20230416200930.29542-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out a helper from blk_insert_flush that initializes the flush
machine related fields in struct request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 04698ed9bcd4a9..422a6d5446d1c5 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -376,6 +376,15 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 	return RQ_END_IO_NONE;
 }
 
+static void blk_rq_init_flush(struct request *rq)
+{
+	memset(&rq->flush, 0, sizeof(rq->flush));
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

