Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612EFC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3235320880
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfA1PJ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:09:28 -0500
Received: from verein.lst.de ([213.95.11.211]:40136 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfA1PJ2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 10:09:28 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4A60668DCF; Mon, 28 Jan 2019 16:09:26 +0100 (CET)
Date:   Mon, 28 Jan 2019 16:09:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com
Subject: Re: [PATCH 09/13] io_uring: add submission polling
Message-ID: <20190128150926.GB10110@lst.de>
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-12-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123153536.7081-12-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 23, 2019 at 08:35:22AM -0700, Jens Axboe wrote:
> Proof of concept.

Is that still true?

> 1) Maybe have smarter backoff. Busy loop for X time, then go to
>    monitor/mwait, finally the schedule we have now after an idle
>    second. Might not be worth the complexity.
> 
> 2) Probably want the application to pass in the appropriate grace
>    period, not hard code it at 1 second.

2) actually sounds really useful.  Should we look into it ASAP?

>  
>  	struct {
>  		/* CQ ring */
> @@ -264,6 +267,9 @@ static void __io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
>  
>  	if (waitqueue_active(&ctx->wait))
>  		wake_up(&ctx->wait);
> +	if ((ctx->flags & IORING_SETUP_SQPOLL) &&
> +	    waitqueue_active(&ctx->sqo_wait))

waitqueue_active is really cheap and sqo_wait should not otherwise
by active.  Do we really need the flags check here?

> +			/*
> +			 * Normal IO, just pretend everything completed.
> +			 * We don't have to poll completions for that.
> +			 */
> +			if (ctx->flags & IORING_SETUP_IOPOLL) {
> +				/*
> +				 * App should not use IORING_ENTER_GETEVENTS
> +				 * with thread polling, but if it does, then
> +				 * ensure we are mutually exclusive.

Should we just return an error early on in this case instead?

>  	if (to_submit) {
> +		if (ctx->flags & IORING_SETUP_SQPOLL) {
> +			wake_up(&ctx->sqo_wait);
> +			ret = to_submit;

Do these semantics really make sense?  Maybe we should have an
IORING_ENTER_WAKE_SQ instead of overloading the to_submit argument?
Especially as we don't really care about returning the number passed in.

> +	if (ctx->sqo_thread) {
> +		kthread_park(ctx->sqo_thread);

Can you explain why we need the whole kthread_park game?  It is only
intended to deal with pausing a thread, and if need it to shut down
a thread we have a bug somewhere.

>  static void io_sq_offload_stop(struct io_ring_ctx *ctx)
>  {
> +	if (ctx->sqo_thread) {
> +		kthread_park(ctx->sqo_thread);
> +		kthread_stop(ctx->sqo_thread);
> +		ctx->sqo_thread = NULL;

Also there isn't really much of a point in setting pointers to NULL
just before freeing the containing structure.  In the best case this
now papers over bugs that poisoning or kasan would otherwise find.
