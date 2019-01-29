Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8491AC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 17:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0942184D
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 17:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfA2RYR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:24:17 -0500
Received: from verein.lst.de ([213.95.11.211]:47464 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfA2RYQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 12:24:16 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8A9C268CEC; Tue, 29 Jan 2019 18:24:14 +0100 (CET)
Date:   Tue, 29 Jan 2019 18:24:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
Message-ID: <20190129172414.GA15347@lst.de>
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-8-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128213538.13486-8-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  
> @@ -118,12 +120,16 @@ struct io_kiocb {
>  	struct list_head	list;
>  	unsigned int		flags;
>  #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
> +#define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
> +#define REQ_F_IOPOLL_EAGAIN	4	/* submission got EAGAIN */
>  	u64			user_data;
> +	u64			res;

Should this be ret or error instead?  res is kinda off.  A little
comment describing it won't hurt either.  Last but not least with
the actual errno value stored here we probably don't need the
REQ_F_IOPOLL_EAGAIN flag, do we?

> +	/*
> +	 * Only spin for completions if we don't have multiple devices hanging
> +	 * off our complete list, and we're under the requested amount.
> +	 */
> +	spin = !ctx->poll_multi_file && (*nr_events < min);

no need for the braces here.

> +static int io_iopoll_getevents(struct io_ring_ctx *ctx, unsigned int *nr_events,
> +				long min)
> +{
> +	int ret;
> +
> +	do {
> +		if (list_empty(&ctx->poll_list))
> +			return 0;
> +
> +		ret = io_do_iopoll(ctx, nr_events, min);
> +		if (ret < 0)
> +			break;
> +	} while (min && *nr_events < min);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return *nr_events < min;

The code looks a little clumsy to me.  Why not:

	while (!list_empty(&ctx->poll_list)) {
		int ret = io_do_iopoll(ctx, nr_events, min);
		if (ret)
			return ret;

		if (!min || *nr_events >= min)
			return 0;
	}

	return 1;
