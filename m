Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B62FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 06:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D693161BFE
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 06:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhKQG2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 01:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhKQG2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 01:28:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F17CC061570
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 22:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+RcnLDANqiBoENi2ko1ORluCsObvx+Pqp13a+pskDpY=; b=mvd54xIKEVnE6jmXIgt/P29JYU
        lgrVOh+qfkhMtlB11qA+cW0cv+8gNLQuFDIw9usu7zokzUxJvPZajqut7idW68fnE/GNnd7OTRr1U
        9R5NrJ8svVoSef4cw1rHz5o/Op2Fuo3CCfjcbZwQo4obBttfWlHo3KRrw/tZFChO/JlEHGsSr/uTT
        iMPLh/cULuHXIENt9Aj4f4dSv9fSqPSvv27UAwgY5Cf17FwRKsA2GA9aYOWy9nwLobvXlbHTWHPp9
        OOyc0ORB2hHh3e6X73LMSwOjc1XaeXL272HAzbV2QRSvxREIrZL4YUy5LSESh/DdrXHjIa3Sj54Xi
        uG6kNtFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnENx-003T5s-3r; Wed, 17 Nov 2021 06:25:33 +0000
Date:   Tue, 16 Nov 2021 22:25:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Message-ID: <YZSgXbsbTZXaKtNC@infradead.org>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117033807.185715-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> @@ -2208,6 +2208,19 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
>  	int queued = 0;
>  	int errors = 0;
>  
> +	/*
> +	 * Peek first request and see if we have a ->queue_rqs() hook. If we
> +	 * do, we can dispatch the whole plug list in one go. We already know
> +	 * at this point that all requests belong to the same queue, caller
> +	 * must ensure that's the case.
> +	 */
> +	rq = rq_list_peek(&plug->mq_list);
> +	if (rq->q->mq_ops->queue_rqs) {
> +		rq->q->mq_ops->queue_rqs(&plug->mq_list);
> +		if (rq_list_empty(plug->mq_list))
> +			return;
> +	}

I'd move this straight into the caller to simplify the follow, something
like the patch below.  Also I wonder if the slow path might want to
be moved from blk_mq_flush_plug_list into a separate helper to keep
the fast path as straight as possible?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ab34c4f20daf..370f4b2ab4511 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2255,6 +2255,14 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	plug->rq_count = 0;
 
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
+		struct request_queue *q = rq_list_peek(&plug->mq_list)->q;
+
+		if (q->mq_ops->queue_rqs) {
+			q->mq_ops->queue_rqs(&plug->mq_list);
+			if (rq_list_empty(plug->mq_list))
+				return;
+		}
+
 		blk_mq_plug_issue_direct(plug, false);
 		if (rq_list_empty(plug->mq_list))
 			return;
