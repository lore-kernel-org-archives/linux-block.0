Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EBDC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EA32146F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMd2/qBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EA32146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeLAEhF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:37:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeLAEhE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4SBpnzcUTD19KfnAOEQ4dVOpE+u1wXKyOE5kHDhAa4U=; b=rMd2/qBQN+zEAymYNo225guHI
        n9Y0NUyG+YkXyZng1CDFv0cq9nauyW2G9auj9pJnYLJ8mvfCEUL4rVKzobnn5GivrvtV6e2fsmLPC
        freHBP/XFQ02Pii7Z21HMcxvp0wccNhxgt+ZRxHOkx/lfEh6+wK/B813GB1kJZ+pTiyh0oRiBZesN
        r0jmFEOG0miBjAZyVIYlw+UW348jg/DPUDo4wGgKmmfKFRYuvaqt9uR//Uh5IXhvjs8rTIY+/+hNl
        +cpqjDeUUPJmFSUeX8mV5BXqYKcHtDMXwb7o+ylRJAnb8RI6+JTsNUxkfLB0GumQ5XNjz6JBAtxHX
        bTmXCN1Lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSmZF-0006aJ-4H; Fri, 30 Nov 2018 17:27:05 +0000
Date:   Fri, 30 Nov 2018 09:27:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: don't call ktime_get_ns() if we don't need it
Message-ID: <20181130172704.GA16952@infradead.org>
References: <51a1cb7b-6136-a220-6cac-9bccd2262ca3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a1cb7b-6136-a220-6cac-9bccd2262ca3@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 08:56:25AM -0700, Jens Axboe wrote:
> We only need the request fields and the end_io time if we have stats
> enabled, or if we have a scheduler attached as those may use it for
> completion time stats.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7dcef565dc0f..2b458e9da946 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -316,7 +316,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	RB_CLEAR_NODE(&rq->rb_node);
>  	rq->rq_disk = NULL;
>  	rq->part = NULL;
> -	rq->start_time_ns = ktime_get_ns();
> +	if (data->q->elevator)
> +		rq->start_time_ns = ktime_get_ns();

We also seem to use start_time_ns it in blk_account_io_done.

Also update it in attempt_merge, which might have some odd results
for completly uninitialized fields.
