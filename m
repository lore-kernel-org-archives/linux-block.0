Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B73C433E6
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD58664E60
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhBIKFP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhBIKDC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 05:03:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CB6C06178C;
        Tue,  9 Feb 2021 02:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X2PQU1d5jzox0n/Xj9r6pmILEewABEB0sLzcB3dEs78=; b=wXj1WWStI2PDo6gGZKOUwwRAGM
        zjYH0nZlrd5tAt61XXt21vqKF2C7UNREVLl6r6dr3dXgFcYpbY82PWna0H+cBcDXek5+/3PCuLGOV
        MG3YPg93Y2rqo4o7yJw3cTjk3KIN7cgZiSAR1m0jHi6kZasS3XfRZ6PU8Q6bKT3GJe84AkemyCv+q
        faNz+AUi7sxy33XmmWYMUMHcqB5xnWahR1Q+r+eZUx4M7f2VDJ+lTMEowRvc4axvXWtmroqYFE27D
        htFI6Bu7j8Wtmvufjh7huqRbzb1TKKGnQMV2CFLFh5xE8HZ/HqEgvIpYv7k+nW2S8jJbgCjnDnPvm
        HdIbE7aQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9PqV-007H0M-GH; Tue, 09 Feb 2021 10:02:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19DC7301324;
        Tue,  9 Feb 2021 11:02:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5A392C0909CA; Tue,  9 Feb 2021 11:02:10 +0100 (CET)
Date:   Tue, 9 Feb 2021 11:02:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/3] smp: Process pending softirqs in
 flush_smp_call_function_from_idle()
Message-ID: <YCJdoovwxhlbJ4ln@hirez.programming.kicks-ass.net>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123201027.3262800-2-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 23, 2021 at 09:10:25PM +0100, Sebastian Andrzej Siewior wrote:
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

Fair enough. I'll stick this in tip/sched/smp for Jens and merge that
into tip/sched/core.

Thanks!
