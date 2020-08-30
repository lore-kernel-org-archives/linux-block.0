Return-Path: <SRS0=wgWW=CI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF1C28B49
	for <linux-block@archiver.kernel.org>; Sun, 30 Aug 2020 06:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A1A20693
	for <linux-block@archiver.kernel.org>; Sun, 30 Aug 2020 06:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W/8iO6ZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgH3G01 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Aug 2020 02:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgH3G00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Aug 2020 02:26:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BB3C061236
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 23:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8dZNYXrkOT+DSvM3VSaNks9Q4n+eRWSrmycO3ns3uPE=; b=W/8iO6ZNipzzNBCsGThJZVHKIO
        MuIommAG04vTA98IMxTcJTu1GSoSecbYxgRzbdrMtHVjrDm+6MCkamX3WZpMIp1Eo4+PXpJIqgV5g
        XEbTFhCcCM0Fbnfmhr7ygrskPL7kKqw2Zbt9wQwi06yVpdPnyQ6LNk/5meqtsrBe4u2yEAqVsO8rJ
        rdoe2XsHfnVsBTar5s7iw5c670zDxecufOGHs4XF7mYtWsDWNRpkxS88yYkMfbvAX65lFSQyQZBWy
        skkQJgLJzhnwAw8Rz0AbjfuiX3hH3qNJ5ISTQ6d3G7LSkyxSnrJoCP3Zo5u8+33zDU7Od2KmRyf+y
        34DAjWSQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCGnI-0002ej-Ei; Sun, 30 Aug 2020 06:26:24 +0000
Date:   Sun, 30 Aug 2020 07:26:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix -EAGAIN IOPOLL task/vm accounting
Message-ID: <20200830062624.GA8972@infradead.org>
References: <d27ff6f0-9347-e880-fa9d-514e993014dc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27ff6f0-9347-e880-fa9d-514e993014dc@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 29, 2020 at 10:51:11AM -0600, Jens Axboe wrote:
> We currently increment the task/vm counts when we first attempt to queue a
> bio. But this isn't necessarily correct - if the request allocation fails
> with -EAGAIN, for example, and the caller retries, then we'll over-account
> by as many retries as are done.
> 
> This can happen for polled IO, where we cannot wait for requests. Hence
> retries can get aggressive, if we're running out of requests. If this
> happens, then watching the IO rates in vmstat are incorrect as they count
> every issue attempt as successful and hence the stats are inflated by
> quite a lot potentially.
> 
> Add a bio flag to know if we've done accounting or not. This prevents
> the same bio from being accounted potentially many times, when retried.

Can't the resubmitter just use submit_bio_noacct?  What is the call
stack here?
