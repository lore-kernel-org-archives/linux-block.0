Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E54C7EE2A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 04:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjESElP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 00:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjESElN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 00:41:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F8610DC
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 21:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=k4ufoMvzmdHzNs7ww5tI5ingjTVUUixghlJSJD/Y+Y0=; b=nF1Eoo435gbGmmEaR0sEu8mSQZ
        vPHOmlWhTWTRPUJMgwAszirSUlNa8+db0ADifEWdBc9JrMlQGPVZQGD2blc0t4SOOBxTZR62aaVqm
        QGq0KfB11ovDcBuxlhjHUJ07hLu2UTRdcbVopq7NbjPtMgvvUPP8Vbxibn26iuMEVRe+CBJEJXCBF
        dGvQSDb3I6oR1TINEAclRPi7Hv/fjUWKUFlKGpXPMzE264CTbuSna+/dMaEjbyh5UdOJocRozeOK/
        HODipa7jXRho/pX5PkXsm1pLc6733hR2JKoplNy7AQ1P0ajdX02G+pczHHnREBzWsJRwobAi9FMig
        okTZITzg==;
Received: from [2001:4bb8:188:3dd5:8711:951c:9ab6:1400] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzrvT-00F4ZE-0d;
        Fri, 19 May 2023 04:41:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 6/7] blk-mq: do not do head insertions post-pre-flush commands
Date:   Fri, 19 May 2023 06:40:49 +0200
Message-Id: <20230519044050.107790-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519044050.107790-1-hch@lst.de>
References: <20230519044050.107790-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_flush_complete_seq currently queues requests that write data after
a pre-flush from the flush state machine at the head of the queue.
This doesn't really make sense, as the original request bypassed all
queue lists by directly diverting to blk_insert_flush from
blk_mq_submit_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 7121f9ad0762f8..f407a59503173d 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -188,7 +188,7 @@ static void blk_flush_complete_seq(struct request *rq,
 
 	case REQ_FSEQ_DATA:
 		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
-		blk_mq_add_to_requeue_list(rq, BLK_MQ_INSERT_AT_HEAD);
+		blk_mq_add_to_requeue_list(rq, 0);
 		blk_mq_kick_requeue_list(q);
 		break;
 
-- 
2.39.2

