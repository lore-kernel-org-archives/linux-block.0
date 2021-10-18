Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC971C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6E061278
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhJRIhK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhJRIhK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 04:37:10 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C27C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TLLgiVB/OZiEpTIPrjLGS0E+oZkxrHGDwj1kjWD3zF4=; b=yGwYlOX+b3qr6k1XAd6ubjuqSO
        gJ6ibmul3wRtwiSfiSby9A2+JVq8ogg02zffWnqyDjo5IeTJvU5KXsTQGDKOhmkIEAzul3mvi1ICa
        D2ywsX6WfvD6YPEuREfTzcrSPzKnXl9wViBLo/hnVRULCAjVwGUfonslM4zJQUJS85bYVWp9wAtEb
        hd7eZFs0rvMCidYFIaD8ywRcS/QRqXJchJyBbXdIHdV4fowfmRTbW8kdgLVuF0J3dnjqpDa3bIggu
        WiLVuV61DAlyvVeFzqwsEFWKSSK9ttK6fAlacbgoK5sTLa+1qzMO66OxzjOUA9rUhCVwDV/EyiSl4
        NQl18Hbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcO6k-00Ef06-Az; Mon, 18 Oct 2021 08:34:58 +0000
Date:   Mon, 18 Oct 2021 01:34:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: don't dereference request after flush insertion
Message-ID: <YW0xsrhF3X5Eh8s5@infradead.org>
References: <f2f17f46-ff3a-01c4-bfd4-8dec836ec343@kernel.dk>
 <YWzSqzsuDF8Fl9jB@T590>
 <17362528-4be4-1407-5a05-cfb0a7524910@kernel.dk>
 <YWzVuDdyTVvED1QA@T590>
 <1f603aff-62d5-637a-147d-3d4530acb232@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f603aff-62d5-637a-147d-3d4530acb232@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think this can be done much simpler. The only place in
blk_insert_flush that actually needs to run the queue is the case
where no flushes are needed, as all the others are handled via the flush
state machine and the requeue list.  So something like this should work:

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 4201728bf3a5a..1fce6d16e6d3a 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -421,7 +421,7 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		blk_mq_request_bypass_insert(rq, false, false);
+		blk_mq_request_bypass_insert(rq, false, true);
 		return;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f296edff47246..89a142b61f456 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2314,7 +2314,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (unlikely(is_flush_fua)) {
 		/* Bypass scheduler for flush requests */
 		blk_insert_flush(rq);
-		blk_mq_run_hw_queue(rq->mq_hctx, true);
 	} else if (plug && (q->nr_hw_queues == 1 ||
 		   blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
 		   q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {
