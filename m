Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B68C433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 16:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E2F2078C
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 16:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RG+Z387O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgFHQkc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbgFHQkb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 12:40:31 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5518FC08C5C3;
        Mon,  8 Jun 2020 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UYRjFEuiAFWDIq0QYKRYnGAKY3ToCP8PMJR7D9hMUs8=; b=RG+Z387OY2XbLPQjIZMDfFwj78
        8fTzy56dbLHTODMSCbt7VMDh4tQfZO1slCPJUzXghc/fhWE4QloX+aRkGuRSNkJxPjpZy/Hh4tAFs
        Nfi3SHKacf3pMJrhuyWa5mdq5cIJMDQJS1fi6piLVUFh5fanbpMdW2L1gFG9YJbqePDX5yDjwVjsD
        XumKPOEh5n55n2viS2o7PVCPYaki1ozfA7GoAmLTJ19DT2vwGrdiJiaaxsW+YwlqsGrnUtaTm9dTW
        jOtFZqsT6y9IYFY+xhavCvaZUQo/wc6L4e2eR/yLFiQeJ6fT9CIXZHzK6bayp6UJdYZH88rJMfQxq
        6ZX6PBeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiKom-0000wG-FC; Mon, 08 Jun 2020 16:40:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C60A03019CE;
        Mon,  8 Jun 2020 18:40:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF5A82B3CE923; Mon,  8 Jun 2020 18:40:09 +0200 (CEST)
Date:   Mon, 8 Jun 2020 18:40:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: blk-softirq vs smp_call_function_single_async()
Message-ID: <20200608164009.GD2531@hirez.programming.kicks-ass.net>
References: <20200608115800.GA2531@hirez.programming.kicks-ass.net>
 <20200608154557.GA26611@infradead.org>
 <20200608155833.GC2531@hirez.programming.kicks-ass.net>
 <20200608163342.GA5155@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608163342.GA5155@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 08, 2020 at 09:33:42AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 08, 2020 at 05:58:33PM +0200, Peter Zijlstra wrote:
> > > A request can only be completed once.
> > 
> > Sure, but that doesn't help.
> > 
> > CPU0				CPU1
> > 
> >  raise_blk_irq()		BLOCK_SOFTIRQ
> >    IPI -> CPU1
> > 
> > 				// picks up thing from CPU0
> > 				req->complete(req);
> > 
> > 
> > 	<big hole where CSD is active and request completed>
> > 
> > 				<IPI>
> > 				  trigger_softirq()
> > 
> > 
> > What happens to a struct request after completion, is it free()d
> > or reused? If reused, how do we guarantee CSD completion before
> > free()ing?
> 
> The request is freed in the block layer sense by __blk_mq_free_request
> (which doesn't actually free the memory, so it eventually gets reused).
> 
> __blk_mq_free_request is called from blk_mq_end_request which
> is called from the drivers ->complete_rq method, which is called
> from the block softirq.
> 
> What is the method to guaranteed CSD completion?

There isn't one, it was meant to be used with static allocations.

Frederic proposed changing all these to irq_work, and I think I'll go do
that. First dinner though.
