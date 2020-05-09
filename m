Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8290C28CBC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C86520746
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588995796;
	bh=nWXeJpc0x1vqSAQgcfyf4MiW0bgjg46tgn+2BpKXhV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dss3Xuss6zC6AjozYcHAQiTKw1Up4YKxRw+xh5kNkfQ72UXyA8pWHU7BoRb6fs6zA
	 PkmnUAJAvfjZia0DhYGRU43aWeADVzZmlEifJNYugVL7Y4zEY1KmIadtrhY2c1Ohej
	 Z5Y756skPOaCJ4P0EFEX2OeIu6WGWYG+mNL5DbJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgEIDnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 23:43:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38246 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgEIDnP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 23:43:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id m7so1604052plt.5;
        Fri, 08 May 2020 20:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TjuBVWE/+eZ0TK+8Wvbs1LYOJWs+7y04K5bauGvqpt8=;
        b=d802CIPVAlLy/bqhbqwxJfO//Cnpr+07SS6LNwLmJsz1xcp/zflEGe/+4zRJXPYpOF
         0l/ImCivqg2bEDFN8yKz0jVJ1LU70P66sT7z3nqbMlsJMUlEOMqrqfmSg4S96p8qKX9U
         hFjE1zRWwFBGd9xp2jeG3C4jNDtIPXvAWw5wFnykQTw02TJn5kLwtY+gHHrwd58nir27
         7/EUYyAg/QrdZxvBtV4MqhfjNTbfsJJ1sp2C6QfTHRz3UjGEwhGn2glZjJYy3e9NBc80
         A5mW0zXrcpWcahtV5p5sODdjKbvyWX7O/pRyYOcuFX3JFgM0N02cXxRFkxEs3Spy6kC+
         Au2Q==
X-Gm-Message-State: AGi0PuaT8MFEP0PxB0qcKb/2qodh4nuk7wiDxqqacqd30TBDna2G6Za7
        tuU2khwqI5pTnItDc4UDAQg=
X-Google-Smtp-Source: APiQypLIdVp5JwarFVdiMg5ajBb9Ax3XybAUdje6DcZLjicgg28JrA5/PNlJYvyyw0xjvasWFQRF9w==
X-Received: by 2002:a17:90a:3327:: with SMTP id m36mr8336012pjb.116.1588995794881;
        Fri, 08 May 2020 20:43:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 127sm3265500pfw.72.2020.05.08.20.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 20:43:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E67004035F; Sat,  9 May 2020 03:43:12 +0000 (UTC)
Date:   Sat, 9 May 2020 03:43:12 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 0/6] block: add error handling for *add_disk*()
Message-ID: <20200509034312.GH11244@42.do-not-panic.com>
References: <20200429074844.6241-1-mcgrof@kernel.org>
 <896ca55e-0daa-fb62-f9cb-0714389936a5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <896ca55e-0daa-fb62-f9cb-0714389936a5@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 05, 2020 at 06:18:22PM -0700, Bart Van Assche wrote:
> On 2020-04-29 00:48, Luis Chamberlain wrote:
> > While working on some blktrace races I noticed that we don't do
> > error handling on *add_disk*() and friends. This is my initial
> > work on that.
> > 
> > This is based on linux-next tag next-20200428, you can also get this
> > on my branch 20200428-block-fixes [0].
> > 
> > Let me know what you think.
> Hi Luis,
> 
> Thank you for having done this work.

My pleasure, I just made one minor change to this series, but that's
all so far. Note that break-blktrace run_0004.sh still yields:

debugfs: Directory 'loop0' with parent 'block' already present!

And so I suspect something else is up, this is even after. That's using
my latest:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200508-block-fixes

Some more eyebealls on that would be useful.

> Since triggering error paths can be
> challenging, how about adding fault injection capabilities that make it
> possible to trigger all modified error paths and how about adding
> blktests that trigger these paths? That is the strategy that I followed
> myself recently to fix an error path in blk_mq_realloc_hw_ctxs().

Sure thing, but I get the impression that adding this may make it odd
to or harder to review. Shouldn't this be done after we have *some*
error handling? Right now we shouldn't regress as we never fail, and
that seemss worse.

Let me know, either way, I'll start work on it.

  Luis
