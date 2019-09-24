Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9D7C432C2
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 11:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBC7214AF
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 11:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bgwn3WTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504718AbfIXLnK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:43:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48382 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfIXLnJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 07:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/g8501+xXPx9KBW91ZExYmZcRElzY2bnL/DarT6l+8M=; b=Bgwn3WTm0Lnrg1//d4BerjSWo
        pVdHxf41TMDMWPLe0SRTGe45Qh+3KOt+d/rjiQ68qbhxGc+V0OinUYo9Ftq8x9LM1mcezWmyDWCdT
        0YlyN89b6LqQs/uTUzoAhrkDekSAfbOG+y9lUuwHkKJOTyUFgXD3xoyQYPcO3Jj3QjwaItur8s8RC
        tr2Dn/XVev/7ANYQoVCUVpwrM3+fE0O+xKUSGnC9yJWKxhg+tB9NRfFFBl8jDg8hfVavSrCIcDCwe
        Px4xdxsdBRC8OUaYdTOUv8kmfcjeFhoA03EyvdBgE1v1wbkg/NUzTTQJ30P5YgKpRUnsNGEqbxEEO
        g5ubY8j8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCjDh-00086A-Kl; Tue, 24 Sep 2019 11:43:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD830305E42;
        Tue, 24 Sep 2019 13:42:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 648D829E510E7; Tue, 24 Sep 2019 13:43:00 +0200 (CEST)
Date:   Tue, 24 Sep 2019 13:43:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
Message-ID: <20190924114300.GM2332@hirez.programming.kicks-ass.net>
References: <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
 <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
 <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 24, 2019 at 02:11:29PM +0300, Pavel Begunkov wrote:

> @@ -2717,15 +2757,18 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>  			return ret;
>  	}
>  
> +	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
> +	prepare_to_wait_exclusive(&ctx->wait, &iowq.wq, TASK_INTERRUPTIBLE);
> +	do {
> +		if (io_should_wake(&iowq))
> +			break;
> +		schedule();
> +		if (signal_pending(current))
> +			break;
> +		set_current_state(TASK_INTERRUPTIBLE);
> +	} while (1);
> +	finish_wait(&ctx->wait, &iowq.wq);

It it likely OK, but for paranoia, I'd prefer this form:

	for (;;) {
		prepare_to_wait_exclusive(&ctx->wait, &iowq.wq, TASK_INTERRUPTIBLE);
		if (io_should_wake(&iowq))
			break;
		schedule();
		if (signal_pending(current))
			break;
	}
	finish_wait(&ctx->wait, &iowq.wq);

The thing is, if we ever succeed with io_wake_function() (that CPU
observes io_should_wake()), but when waking here, we do not observe
is_wake_function() and go sleep again, we might never wake up if we
don't put ourselves back on the wait-list again.

