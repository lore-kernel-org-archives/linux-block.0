Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA8BC77B75
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 04:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjESElN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 00:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjESElM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 00:41:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6AE10E0
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 21:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EsOEomkX55SFfNb3cCrwA/PnbVTP+rm0OlgzDlFUVX4=; b=zpS9dDWHcpUm2yy4SWfIYhMBWl
        S6YCXoiFqw8HUe49nxePrfeR6J4HPOhby8TICFFuJwsCKB2VVpsBbvrFi5YSOFRLWsK9cJW97bbXO
        +k+HCShqDmn6LHrWPtjYmq6PMAnR82nc+4S1hbwq7ynl3BGpi1ic1JjEj8TGsAIglQrTe0nQUf3EM
        Tho/Cc3w3Bu3CyiIQ24Gt3VV5p6yn7EBS2ecfNP5i3H1m57jWpZmCN4U8EtITHByhqsLw9Oc86mIP
        X9qypuuHoI9CtQcEKBwQWhVCi2LJJCUTQILiGuhaX67UOs3eh2uB4le7MWasKpiEOm73Iy6gn4Epd
        bTyX8YxQ==;
Received: from [2001:4bb8:188:3dd5:8711:951c:9ab6:1400] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzrvQ-00F4Yw-0x;
        Fri, 19 May 2023 04:41:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 5/7] blk-mq: defer to the normal submission path for post-flush requests
Date:   Fri, 19 May 2023 06:40:48 +0200
Message-Id: <20230519044050.107790-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519044050.107790-1-hch@lst.de>
References: <20230519044050.107790-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Requests with the FUA bit on hardware without FUA support need a post
flush before returning to the caller, but they can still be sent using
the normal I/O path after initializing the flush-related fields and
end I/O handler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 6fb9cf2d38184b..7121f9ad0762f8 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -432,6 +432,17 @@ bool blk_insert_flush(struct request *rq)
 		 * Queue for normal execution.
 		 */
 		return false;
+	case REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH:
+		/*
+		 * Initialize the flush fields and completion handler to trigger
+		 * the post flush, and then just pass the command on.
+		 */
+		blk_rq_init_flush(rq);
+		rq->flush.seq |= REQ_FSEQ_POSTFLUSH;
+		spin_lock_irq(&fq->mq_flush_lock);
+		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
+		spin_unlock_irq(&fq->mq_flush_lock);
+		return false;
 	default:
 		/*
 		 * Mark the request as part of a flush sequence and submit it
-- 
2.39.2

