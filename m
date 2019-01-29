Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB52C282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 17:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B509214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 17:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfA2R01 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:26:27 -0500
Received: from verein.lst.de ([213.95.11.211]:47475 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfA2R01 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 12:26:27 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 197B368CEC; Tue, 29 Jan 2019 18:26:25 +0100 (CET)
Date:   Tue, 29 Jan 2019 18:26:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 10/18] io_uring: batch io_kiocb allocation
Message-ID: <20190129172624.GB15347@lst.de>
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-11-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128213538.13486-11-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
> +static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
> +				   struct io_submit_state *state)
>  {
> +	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN;

No actually in this patch, but why do we do GFP_ATOMIC allocations
here?  We aren't in irq context or under a spinlock.

> +	if (!state)
> +		req = kmem_cache_alloc(req_cachep, gfp);

Add a
		if (!req)
			goto out;

plus the missing braces here..

> +	else if (!state->free_reqs) {
> +		size_t sz;
> +		int ret;
> +
> +		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
> +		ret = kmem_cache_alloc_bulk(req_cachep, gfp, sz,
> +						state->reqs);
> +		if (ret <= 0)
> +			goto out;
> +		state->free_reqs = ret - 1;
> +		state->cur_req = 1;
> +		req = state->reqs[0];
> +	} else {
> +		req = state->reqs[state->cur_req];
> +		state->free_reqs--;
> +		state->cur_req++;
> +	}
> +
>  	if (req) {
>  		req->ctx = ctx;
>  		req->flags = 0;
>  		return req;
>  	}

... and we don't need this conditional, which would otherwise also
be in the fast path.
