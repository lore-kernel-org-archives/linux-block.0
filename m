Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 16:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45790610A0
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 16:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhJNQKo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhJNQKo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 12:10:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13065C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YML0mzYVTmbrDFMJS6xPjUbqthBTaaEkXfzewkC36KQ=; b=u/GW7XmG0Pase5ZxhIQOqyG+by
        TTMGH06j1UOVvMLgn6aKMNUNkK2PzbuUphJR8BpA1f26gjFXH6V54/cUoy+PmRNtVPcnctMXOUDc9
        LX0FBSm8fDGiWgaGl1Mx+sdJxkeQ68YTAaw9X4qAZd5gNZKN0ogOpCrGAmkPLXRmsHKcd/DOaJPwN
        U81jWEMWDsES3nFtW25X7dUAElOgWWvOV1wZGaKi9wZIOwoF4AHE2jzJEKf5nmbMVAdgsLL3u5uXx
        fqpih5wGHk3Z9m4FyxzqTx6ancCfSwp+Et09ABMkDkp5dFgA0PeiF9Kk08eZATEoe+5MfO4N2vx6u
        b//+HvLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb3Ha-003nDa-NU; Thu, 14 Oct 2021 16:08:38 +0000
Date:   Thu, 14 Oct 2021 09:08:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] io_uring: utilize the io_batch infrastructure for
 more efficient polled IO
Message-ID: <YWhWBt7kljI+BGbX@infradead.org>
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-9-axboe@kernel.dk>
 <YWfkVtB+pMpaG2T3@infradead.org>
 <7ed66f47-6f5a-39b2-7cd8-df7cf0952743@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed66f47-6f5a-39b2-7cd8-df7cf0952743@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 14, 2021 at 09:45:38AM -0600, Jens Axboe wrote:
> On 10/14/21 2:03 AM, Christoph Hellwig wrote:
> > On Wed, Oct 13, 2021 at 10:54:15AM -0600, Jens Axboe wrote:
> >> @@ -2404,6 +2406,11 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
> >>  		struct kiocb *kiocb = &req->rw.kiocb;
> >>  		int ret;
> >>  
> >> +		if (!file)
> >> +			file = kiocb->ki_filp;
> >> +		else if (file != kiocb->ki_filp)
> >> +			break;
> >> +
> > 
> > Can you explain why we now can only poll for a single file (independent
> > of the fact that batching is used)?
> 
> Different file may be on a different backend, it's just playing it
> safe and splitting it up. In practice it should not matter.

Well, with file systems even the same file can land on different
devices.  Maybe we need a cookie?

Either way this should be commented as right now it looks pretty
arbitrary.
