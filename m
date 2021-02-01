Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392D2C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 19:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB23864E8D
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 19:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBATfs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBATfr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 14:35:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C7C061573;
        Mon,  1 Feb 2021 11:35:07 -0800 (PST)
Date:   Mon, 1 Feb 2021 20:35:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612208105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7q0ADVBv7wrASZe7+lbcKyA+aN2qy7UBOJmQRce20k=;
        b=bz0R4vyw46ywTkxpGU+9mHE5Y4ySzftT1jE9G1XqK1qHSiKhLeEEJQuOMF6uSOwTjUmuqm
        mVs+pSrV1miS4AjjaEsPuYE9E6h7jIlyqKJF26bbmybKWCjptNi0/uMOTDOskfAwFDbBvs
        0zM9Ojy/BlnVkE3N13cHQPad9hn8wmWtTwbrPhnQzgVW/6Ax29q4u1m//yVPcodz6OODdx
        yymDFKG7P6/QIrqrc++pHhy1dhq/Q08iiZrXdgucSM4GM6rzogPgwuo9BG19oqXtLWkbyW
        ZV6Qh/bJl6ExBScHNzb8e14aSOsY/jfTq6srI+NVqzxj67T/qSS9LXgST/k0XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612208105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7q0ADVBv7wrASZe7+lbcKyA+aN2qy7UBOJmQRce20k=;
        b=t5vQ6hM45TikxRW//7L332EwTlPU7ZXxNihCYkLR9uH9EiwnMLOY+Cfoj0DmKEia5Dsnqj
        em8J1vo12VBxohAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/3] smp: Process pending softirqs in
 flush_smp_call_function_from_idle()
Message-ID: <20210201193504.oxceui2y52zsxqmv@linutronix.de>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210123201027.3262800-2-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-01-23 21:10:25 [+0100], To linux-block@vger.kernel.org wrote:
> send_call_function_single_ipi() may wake an idle CPU without sending an
> IPI. The woken up CPU will process the SMP-functions in
> flush_smp_call_function_from_idle(). Any raised softirq from within the
> SMP-function call will not be processed.
> Should the CPU have no tasks assigned, then it will go back to idle with
> pending softirqs and the NOHZ will rightfully complain.
> 
> Process pending softirqs on return from flush_smp_call_function_queue().
> 
> Fixes: b2a02fc43a1f4 ("smp: Optimize send_call_function_single_ipi()")
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

A gentle ping.
This isn't just a requirement for the series: rps_trigger_softirq() is
invoked from smp_call_function_single_async() and raises a softirq.

Sebastian
