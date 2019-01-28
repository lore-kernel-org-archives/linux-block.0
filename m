Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DF4C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04A020844
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbfA1Qej (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:34:39 -0500
Received: from verein.lst.de ([213.95.11.211]:40689 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390147AbfA1Qei (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:34:38 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D987768DCF; Mon, 28 Jan 2019 17:34:36 +0100 (CET)
Date:   Mon, 28 Jan 2019 17:34:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH 05/18] Add io_uring IO interface
Message-ID: <20190128163436.GA12427@lst.de>
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-6-axboe@kernel.dk> <20190128145700.GA9795@lst.de> <42a5b12b-8d3a-2495-ad53-6a6fdd4504c6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a5b12b-8d3a-2495-ad53-6a6fdd4504c6@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 09:26:42AM -0700, Jens Axboe wrote:
> >> +static void io_free_scq_urings(struct io_ring_ctx *ctx)
> >> +{
> >> +	if (ctx->sq_ring) {
> >> +		page_frag_free(ctx->sq_ring);
> >> +		ctx->sq_ring = NULL;
> >> +	}
> >> +	if (ctx->sq_sqes) {
> >> +		page_frag_free(ctx->sq_sqes);
> >> +		ctx->sq_sqes = NULL;
> >> +	}
> >> +	if (ctx->cq_ring) {
> >> +		page_frag_free(ctx->cq_ring);
> >> +		ctx->cq_ring = NULL;
> >> +	}
> > 
> > Why is this using the page_frag helpers?  Also the callers just free
> > these ctx structure, so there isn't much of a point zeroing them out.
> 
> Why not use the page frag helpers? No point in open-coding it. I can
> kill the zeroing, double call would be a bug anyway.

Because they are at a different level of abstraction, and someone
might change the implementation, and is unlikely to catch the io_uring
mix of interfaces.  If you think this is really useful we should also
export the helpers under a different name and with documentation.
(and add a __get_free_pages version that returns a pointer..)
