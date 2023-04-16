Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31757C77B73
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 20:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDPUJ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 16:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDPUJ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 16:09:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF630C1
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 13:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SHXbm8Z8nKfavdIQ0OMv8qj4rAlHK97pzoOQsLu6yto=; b=UiRLhWaLx843X6pXv9Z4KX8Rnp
        WHqtYnrQZEx7rMLnyj/vYZD0MOKCVh59JN01wEMsIOdPL8FTU39vZ2TPGJpr0HwDmOT9HCQGcUV2P
        dOugUoc89N9Y39IdaMHJFI6jymyit+99DprHxzoQAl4frXdA2RC5GOSwZJfqoIgsAyd0rSqgc5a+A
        RVW7olbbZ22Pq2tG4ggilw9oCYtuZE4+djJRwm8zCvBGWqeTz1uvaDYpHdxtQ90GKe5EHy0bS6ZtH
        V2lJCbwZmRAqSQdlTRqLwaJiwS45UeJAZgCAod1lCy4vLIy9nsRHjF0mfdTb9l8OPd/YLRuiqq5Jw
        XOQShHgg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1po8h9-00EOJM-2z;
        Sun, 16 Apr 2023 20:09:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 6/7] blk-mq: do not do head insertations post-pre-flush commands
Date:   Sun, 16 Apr 2023 22:09:29 +0200
Message-Id: <20230416200930.29542-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416200930.29542-1-hch@lst.de>
References: <20230416200930.29542-1-hch@lst.de>
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
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 9eda6d46438dba..69e9806f575455 100644
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

