Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE032C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjDLFdU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDLFdT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:33:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04418B9
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vBgXElBOaxfhiTFjKvWRrg8JxlqmQv+zuBrVmZgl5+Y=; b=RA7zHbxN18ke5bl8CMcQr6LeM6
        nt47x65Xd5uJLGih856off/sPdCwz6+oE+64Z1Lmo9C5wbmTEgb5r/08BS3AkoxKGa+hnhk1OCYpa
        YlWYZ++3bec2lZDOOQ15HBEC7Gjj3YdDLVBy4m43IX2fjM1rLIMBYPnInv5lDillAGes2CPzrxF6G
        VtkMysaF38DjU/zjAZlfO7lRp85DA87zrZo4kRXcWAGsHMD1BSz5GJ+T2AT3yExBNRMYyoINEzEUN
        1ISS5Pqxbk0Mc0Mawxmsnh0K0E0VExBrtel51uci7pTZUg9g2FUSEZS39sCCYvJ/OQUy3Hx5krt4D
        IrdLpbTg==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6Y-001rIm-2y;
        Wed, 12 Apr 2023 05:33:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 09/18] blk-mq: remove blk_flush_queue_rq
Date:   Wed, 12 Apr 2023 07:32:39 +0200
Message-Id: <20230412053248.601961-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just call blk_mq_add_to_requeue_list directly from the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

