Return-Path: <SRS0=iom0=XP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD41C3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 20:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2B32086A
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 20:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="BCOMuJ//";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JAdWYsgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfITU46 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:56:58 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:56307 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387681AbfITU46 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Sep 2019 16:56:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E84B45D1;
        Fri, 20 Sep 2019 16:56:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 20 Sep 2019 16:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=B/6ielKbnZFOuxRq+xMeobCda5E
        2RohcYU67WFLaIW0=; b=BCOMuJ//Wc8IMks6jg3V7WFJLTcTdhYnbeSnZRQZcmU
        9x70HR+D3qtIe8vY21VCJeC3GqJDNJ1IFSA/5PlPqMcevZfkR1Zvk2GVgM5Iofz5
        PyWCbN2+n5awb8IDnapT7ayZ574zMCd2LZdeNsZC87LNwSlqXruE69OZ0DR8/zr7
        pf0f7upD372StidfjplhGupVLgLXvW49HOPEbHKGmIZDUhp+xrqPWQ0LRLMSRnpa
        qyj9/UACcY2R2zO0DsR5acPzkp3vKnD3g4HY3cpBYSQDboACgVMWrAucYc9rlaar
        TkVGvoA0ae7hk52vUMHlgQm0wxyDhfjNM59q+vHaviA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=B/6iel
        KbnZFOuxRq+xMeobCda5E2RohcYU67WFLaIW0=; b=JAdWYsgmzKEePNKXyOQmV2
        pdjiSJaUShwzqYgVYdSy+Kw8J6Skjv5a1Qi7Z/3YoB6GOBGccRvKmzXgeYm1h35M
        035ZNZTUZdlyroi2a1ltSl9/pqoovUnofBfVKp2O2BDWe7y0t8qCBreZmYIbnBHv
        RRgYOwH0lIE5Rpp7YJc2unEbPo18kUj4hkRqAdAvqW3RPtbLmRZYwAVq9lbcEbU5
        QOqc3A83Vwne1iSemqmH9OMi6UusVJTaJQj3MMOMG/k2a5kzdCStR2Wjc3HTDfA1
        EfqRpdX/adN64f0yi3+R1QN7K+DZiuDXxgWvhDLn831xLFEusVa1F1y+GWg5xFaw
        ==
X-ME-Sender: <xms:Fz2FXVfHW2UyGs_ezo_4Sj-d4LfPGOh-G4VJV5_X6Hc43jbknbwWiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddvgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucfkphepie
    ejrdduiedtrddvudekrddvfeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgv
    shesrghnrghrrgiivghlrdguvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Fz2FXVnUgZtpHw5C_WLnQ6cp6sg26PiO-037TLg1LG7UM0zSQZIm0g>
    <xmx:Fz2FXZG6f540NquYsxYZHGAYNyX0VAHcdWFqoPTPfe5zOu8B6POP5Q>
    <xmx:Fz2FXZcYF4FVWiiWE1Cx_07dG8ZFA4fNjbOKJwh0RmefeH1cABcMgA>
    <xmx:GD2FXdtTtTZhtH14KJ5Gn8Rly6MJSyltfpuRpXtdQlO4oa0vfl18lg>
Received: from intern.anarazel.de (c-67-160-218-237.hsd1.ca.comcast.net [67.160.218.237])
        by mail.messagingengine.com (Postfix) with ESMTPA id 82DC8D60063;
        Fri, 20 Sep 2019 16:56:55 -0400 (EDT)
Date:   Fri, 20 Sep 2019 13:56:54 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] io_uring: IORING_OP_TIMEOUT support
Message-ID: <20190920205654.2g7z6znt4r337qrt@alap3.anarazel.de>
References: <f0488dd6-c32b-be96-9bdc-67099f1f56f8@kernel.dk>
 <20190920165348.pjmdnm3mozna3ous@alap3.anarazel.de>
 <838a193a-cb83-c6d5-f251-b113e9faf9d5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <838a193a-cb83-c6d5-f251-b113e9faf9d5@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2019-09-20 14:18:07 -0600, Jens Axboe wrote:
> On 9/20/19 10:53 AM, Andres Freund wrote:
> > Hi,
> > 
> > On 2019-09-17 10:03:58 -0600, Jens Axboe wrote:
> >> There's been a few requests for functionality similar to io_getevents()
> >> and epoll_wait(), where the user can specify a timeout for waiting on
> >> events. I deliberately did not add support for this through the system
> >> call initially to avoid overloading the args, but I can see that the use
> >> cases for this are valid.
> > 
> >> This adds support for IORING_OP_TIMEOUT. If a user wants to get woken
> >> when waiting for events, simply submit one of these timeout commands
> >> with your wait call. This ensures that the application sleeping on the
> >> CQ ring waiting for events will get woken. The timeout command is passed
> >> in a pointer to a struct timespec. Timeouts are relative.
> > 
> > Hm. This interface wouldn't allow to to reliably use a timeout waiting for
> > io_uring_enter(..., min_complete > 1, ING_ENTER_GETEVENTS, ...)
> > right?
> 
> I've got a (unpublished as of yet) version that allows you to wait for N
> events, and canceling the timer it met. So that does allow you to reliably
> wait for N events.

Cool.

I'm not quite sure how to parse "canceling the timer it met".

I assume you mean that one could ask for min_complete, and
IORING_OP_TIMEOUT would interrupt that wait, even if fewer than
min_complete have been collected?  It'd probably be good to return 0
instead of EINTR if at least one event is ready, otherwise it does seem
to make sense.


> > I can easily imagine usecases where I'd want to submit a bunch of ios
> > and wait for all of their completion to minimize unnecessary context
> > switches, as all IOs are required to continue. But with a relatively
> > small timeout, to allow switching to do other work etc.
> 
> The question is if it's worth it to add support for "wait for these N
> exact events", or whether "wait for N events" is enough. The application
> needs to read those completions anyway, and could then decide to loop
> if it's still missing some events. Downside is that it may mean more
> calls to wait, but since the io_uring is rarely shared, it might be
> just fine.

I think "wait for N events" is sufficient. I'm not even sure how one
could safely use "wait for these N exact events", or what precisely it
would mean.  All the usecases for min_complete that I can think of
basically just want to avoid unnecessary userspace transitions if not
enough work has been done to have a chance to finish its task - but if
there's plenty results other than the just submitted ones in the queue
that's also ok.


> , but since the io_uring is rarely shared, it might be just fine.

FWIW, I think we might want to share it between (forked) processes in
postgres, but I'm not sure yet (as in, in my current rough prototype I'm
not yet doing so). Without that it's a lot harder to really benefit from
the queue ordering operations, and sharing also allows to order queue
flushes to later parts of the journal, making it more likely that
connections COMMITing earlier also finish earlier.

Another, fairly crucial, reason is that being able to finish io requests
started by other backends would make it far easier to avoid deadlock
risk between postgres connections / background processes. Otherwise it's
fairly easy to encounter situations where backend A issues a few
prefetch requests and then blocks on some lock held by process B, and B
needs the one of the prefetchted buffers from A to finish IO. There's
more complex workarounds for this, but ...

Greetings,

Andres Freund
