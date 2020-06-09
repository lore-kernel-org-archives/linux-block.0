Return-Path: <SRS0=iQ6z=7W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCE1C433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 13:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8268220760
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 13:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="brayCqXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgFINjA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgFINjA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jun 2020 09:39:00 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AB6C05BD1E;
        Tue,  9 Jun 2020 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HWh6P44BdWZmQIF8VcmUSbalmmaslEENnThQdSj8D00=; b=brayCqXKtixRb5UN8h2w5jf3wG
        uy+WsOhWc3fl25hRI27mz1KhFK1K2u17Lol59T9g9m/Ph5Em7TZXq76biFFI2WfKE+JpV4mH/nYYr
        rZFs9WaVesO0W8jpMY9X+urO0hWU6qd6L0vMv3+3b7r+mWgnhyQbYT/zH7iLf3mVu4coL/MSbRlm3
        N7zWHM8+8x8gZXQrGnarcnwdlnNO7VycK1B/1hPkQU44jguvTwUUxpaLgYVJmrjNDyWVMPBIOeJl/
        VwtJ9ejnv81zq64x2SJ5jKGRSU5O/IcfvuygoWFKYNaxbR9BOsEGs7FvRnWs4FLJEMg5zBmNHOjP5
        Bfc/275w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jieSf-0006sf-7R; Tue, 09 Jun 2020 13:38:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D01273019CE;
        Tue,  9 Jun 2020 15:38:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5A87213D3A8E; Tue,  9 Jun 2020 15:38:37 +0200 (CEST)
Date:   Tue, 9 Jun 2020 15:38:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: blk-softirq vs smp_call_function_single_async()
Message-ID: <20200609133837.GA2514@hirez.programming.kicks-ass.net>
References: <20200608115800.GA2531@hirez.programming.kicks-ass.net>
 <20200608154557.GA26611@infradead.org>
 <20200608155833.GC2531@hirez.programming.kicks-ass.net>
 <20200608163342.GA5155@infradead.org>
 <20200608164009.GD2531@hirez.programming.kicks-ass.net>
 <20200608164254.GA2431@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608164254.GA2431@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 08, 2020 at 09:42:54AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 08, 2020 at 06:40:09PM +0200, Peter Zijlstra wrote:
> > There isn't one, it was meant to be used with static allocations.
> > 
> > Frederic proposed changing all these to irq_work, and I think I'll go do
> > that. First dinner though.

OK, after having looked at this more, I think my initial analysis is
actually wrong and this code should work as-is.

The thing that I missed yesterday is that we only add the request to the
blk_cpu_done list in the IPI, this means that the race I described
earlier is not in fact possible.

The IPI must happen for progress to be made.

And the same is true for blk_mq_force_complete_rq(), which also uses
this csd.

> The irq_work API looks reasonable.  What are the tradeoffs for
> smp_call_single_async vs irq_work?

To still answer your question; irq_work_queue*() has an atomic op extra
that allows for more convenient semantics -- but is in your case
strictly superfluous.

Still, Jens' point about irq_work being smaller stands, and I think more
users could benefit from something intermediate. Let me continue with
the cleanups / audit and see what comes out at the end.

Thanks!
