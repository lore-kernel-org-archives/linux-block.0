Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB17C77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDKNeN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjDKNeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:34:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253011BC
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Tz3zxQDFwcp3lrBBd1Cz+ghFGozr0lNR7N52ZukZuC4=; b=M3RAIBpp3dCgRLQ9dBYMA+tbui
        JvFBeHfcCSA8rV4QMGai3ZBrQJNvTzYAkOy6GqeAtMuJASNuoJWAen5Xt3fASijdtzjDMy8JNEA18
        yr+hPqHIYIHRh6L5jr5Uptg8f+a7GTD5VfKjP+3/UU6OoZ/ljleNyQK00IvFTPww0rL3t4uOkmiok
        U9kaIzoSbcGYTKuLtelQ0uEfcN4GTMkAnOE8hQsdGP1Xh+7IRvLtzXY6N3xx+6z6bB1+C78iDpQxH
        OwMM9q5sWyzv9wjPSlsvVCPxjH4M+uUQEEDXSLHMeNgfEcVn5l4DH3mofm3a8LPL9ez8n++TInLFS
        ytlP94oQ==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE8N-0007wQ-1L;
        Tue, 11 Apr 2023 13:34:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 07/16] blk-mq: remove blk_flush_queue_rq
Date:   Tue, 11 Apr 2023 15:33:20 +0200
Message-Id: <20230411133329.554624-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411133329.554624-1-hch@lst.de>
References: <20230411133329.554624-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just call blk_mq_add_to_requeue_list directly from the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53202eff545efb..cbb5b069809117 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -138,11 +138,6 @@ static void blk_flush_restore_request(struct request *rq)
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
@@ -195,7 +190,7 @@ static void blk_flush_complete_seq(struct request *rq,
 
 	case REQ_FSEQ_DATA:
 		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
-		blk_flush_queue_rq(rq, true);
+		blk_mq_add_to_requeue_list(rq, true, true);
 		break;
 
 	case REQ_FSEQ_DONE:
@@ -352,7 +347,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	smp_wmb();
 	req_ref_set(flush_rq, 1);
 
-	blk_flush_queue_rq(flush_rq, false);
+	blk_mq_add_to_requeue_list(flush_rq, false, true);
 }
 
 static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
-- 
2.39.2

