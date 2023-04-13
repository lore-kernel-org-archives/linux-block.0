Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CCDC77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjDMGlf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDMGla (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB078A5A
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=680CeXglMv8DQ62WMg6HFDJcEEm+WqsUMqL7NyHYRW8=; b=u+RaB3bkYOJLkipTQ0UfrNJek4
        /W+O4nMFz/b70bgvRHjHLouC7/AuLR4G1cMYqL5SGAOzbvB4xhU8NtkIBeVYJd3F81T0D8aDZ04t4
        m8KWr8602xJnoK8YV/G17IlqtvFHaeAVVYnfnY4Lxz2rNNG9tieHj7RQP/W/FBKo82D3CdV/IOHug
        fMA2GPoMyuNbsmIHSj4qFESEhvkkb5i8xvbQjwf3GkodJSu76/Fiy3muI6XzytsrER1l9cRNO4LVz
        M80lTPZblRWv8I2tmLhsN0pPKFni56gNx/jvbnaZfWhoK7o7IZvgPl9WjRhVTaOFT20ZVNA4ILyDS
        MqVogjWg==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqe2-005BUY-1A;
        Thu, 13 Apr 2023 06:41:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 09/20] blk-mq: remove blk_flush_queue_rq
Date:   Thu, 13 Apr 2023 08:40:46 +0200
Message-Id: <20230413064057.707578-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just call blk_mq_add_to_requeue_list directly from the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-flush.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 3c81b0af5b3964..62ef98f604fbf9 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -136,11 +136,6 @@ static void blk_flush_restore_request(struct request *rq)
 	rq->end_io = rq->flush.saved_end_io;
 }
 
-static void blk_flush_queue_rq(struct request *rq, bool add_front)
-{
-	blk_mq_add_to_requeue_list(rq, add_front, true);
-}
-
 static void blk_account_io_flush(struct request *rq)
 {
 	struct block_device *part = rq->q->disk->part0;
@@ -193,7 +188,7 @@ static void blk_flush_complete_seq(struct request *rq,
 
 	case REQ_FSEQ_DATA:
 		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
-		blk_flush_queue_rq(rq, true);
+		blk_mq_add_to_requeue_list(rq, true, true);
 		break;
 
 	case REQ_FSEQ_DONE:
@@ -350,7 +345,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	smp_wmb();
 	req_ref_set(flush_rq, 1);
 
-	blk_flush_queue_rq(flush_rq, false);
+	blk_mq_add_to_requeue_list(flush_rq, false, true);
 }
 
 static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
-- 
2.39.2

