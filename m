Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64849C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4249C610EA
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhJMRPr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhJMRPr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:15:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9815CC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HwShVUBGMuj12htLU6yzyPn5jS+b2JOUPgD3Xriiefs=; b=Wjhv4D+s8TbZYPu5UipljFUD3J
        Y2LnEFInPNUoL66+GDSRNtbfUfivj6SGhK4E5+Ovyclcf3jil7Rn770vM5XYMt3BcFW+J8MozDvOE
        FO5CeIPwJEzamDX5mE1dWcbFdrTQ90IahAJRFxftZTweDzjOyNlvKJMueHWMIkFac1GNvnFYpiCZl
        shch1V7Zs8+dqKK8kx1RylqjTdK1m9176wGNcgsN/rnp9+gBzFaafWQ++wNmJxmxz9OsXN3vqjimZ
        jSa3Yd5OOHpz9RhW4yX9LMBgax0+z5bAB0Z4Jr7i97cj+g+/1drU2lb3NRMPXr1jkGNWUNkSKJZNC
        V3vGhV4g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mahnE-007eKp-BS; Wed, 13 Oct 2021 17:12:10 +0000
Date:   Wed, 13 Oct 2021 18:11:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/4] block: provide helpers for rq_list manipulation
Message-ID: <YWcTWJzo2WV9L/k9@infradead.org>
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013164937.985367-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 10:49:34AM -0600, Jens Axboe wrote:
> Instead of open-coding the list additions, traversal, and removal,
> provide a basic set of helpers.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c         | 21 +++++----------------
>  include/linux/blk-mq.h | 25 +++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6dfd3aaa6073..46a91e5fabc5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -426,10 +426,10 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>  			tag = tag_offset + i;
>  			tags &= ~(1UL << i);
>  			rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
> -			rq->rq_next = *data->cached_rq;
> -			*data->cached_rq = rq;
> +			rq_list_add_tail(data->cached_rq, rq);
>  		}

This doesn't seem to match the code in the current for-5.6/block branch.

>  		data->nr_tags -= nr;
> +		return rq_list_pop(data->cached_rq);
>  	} else {

But either way no need for an else after a return.
