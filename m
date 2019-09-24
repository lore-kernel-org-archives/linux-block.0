Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EB6C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 09:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E4A214D9
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 09:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OrfOVB6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393980AbfIXJt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:49:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392592AbfIXJt5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 05:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J0LZ/gusRdLyBWuYJRWJKvWsgZDGpCWr1sFbbmR0ywU=; b=OrfOVB6yh0tLqWmKmibVsYj7v
        Y7RqOoFoTFHmJzVEEnPzO3ycgqqjdiULaBY9g+B7fX5Tkv8bfG7OQc1yKMu/ppfwwywcBvNDxFeqM
        CpKae2SqC0H1jvs3m+ksS2xVys3D0Fhw12J3dN3Xf+iSRxKj+CeM6bBN5JNvFqXACz8WNwD0/skmY
        cz6O0kTvdGDsNORYDXbdaUIpGceNjwB9YHSL1utX6Le1a1NSncpcwXdAy5NNj5sAFeqPDZJRdqM4B
        oDelUPuFe3MkrthRQh5mef1PIn0q4B6QKufhPSu3KqqtDBE1sD3SCa0ta5ZeG2x5+IzGn4A6LtZgs
        i6q0ehSuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iChS7-0006sx-Aj; Tue, 24 Sep 2019 09:49:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76DDD305E35;
        Tue, 24 Sep 2019 11:48:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 054BF20D80D41; Tue, 24 Sep 2019 11:49:43 +0200 (CEST)
Date:   Tue, 24 Sep 2019 11:49:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
Message-ID: <20190924094942.GN2349@hirez.programming.kicks-ass.net>
References: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 24, 2019 at 10:36:28AM +0200, Jens Axboe wrote:

> +struct io_wait_queue {
> +	struct wait_queue_entry wq;
> +	struct io_ring_ctx *ctx;
> +	struct task_struct *task;

wq.private is where the normal waitqueue stores the task pointer.

(I'm going to rename that)

> +	unsigned to_wait;
> +	unsigned nr_timeouts;
> +};
> +
> +static inline bool io_should_wake(struct io_wait_queue *iowq)
> +{
> +	struct io_ring_ctx *ctx = iowq->ctx;
> +
> +	/*
> +	 * Wake up if we have enough events, or if a timeout occured since we
> +	 * started waiting. For timeouts, we always want to return to userspace,
> +	 * regardless of event count.
> +	 */
> +	return io_cqring_events(ctx->rings) >= iowq->to_wait ||
> +			atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
> +}
> +
> +static int io_wake_function(struct wait_queue_entry *curr, unsigned int mode,
> +			    int wake_flags, void *key)
> +{
> +	struct io_wait_queue *iowq = container_of(curr, struct io_wait_queue,
> +							wq);
> +
> +	if (io_should_wake(iowq)) {
> +		list_del_init(&curr->entry);
> +		wake_up_process(iowq->task);

Then you can use autoremove_wake_function() here.

> +		return 1;
> +	}
> +
> +	return -1;
> +}

Ideally we'd get wait_event()'s @cond in a custom wake function. Then we
can _always_ do this.

This is one I'd love to have lambda functions for. It would actually
work with GCC nested functions, because the wake function will always be
in scope, but we can't use those in the kernel for other reasons :/

