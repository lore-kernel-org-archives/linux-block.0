Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3118C4363A
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 00:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759DF207DE
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 00:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hmnOVDO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbgJ2Aba (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbgJ1Wbh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 18:31:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F6C0613D1;
        Wed, 28 Oct 2020 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pbW1tCuoCb5OoMHKLe/zo1YdTNTlOPVa8AEEc+GMK0Y=; b=hmnOVDO2mdOUeHyF8dFmOqABl7
        IXFwxMOZo6teAYlA1iNNnFgmC0MWOlUVzDGhdcFFMBqwluvZzjo+88drh7c/WUtjjzOtgaS615aOR
        /BHOoqPXDwWPBkaFkPHuTDUwzExGsptpZiDp2vRREC2z8P7c3zBDl0Fw7h1VpmdhdycUk0NMmEqe3
        0nff9M143urlCeeFNHU2ERF5NazR6z2vFFYcSpsxCCi4lhwJkZWNema1wQAEJsA+83rNH1a/1KSZI
        LXl3MSdcHO4dW0kMOAvYlgjSQ7kcW9ghP0tE7MmnY0EDcJ7fEyaYRzHaKYaTQhw5q0hJj51EKgd1P
        fVD2YZrg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXmh3-0004yC-Ds; Wed, 28 Oct 2020 14:44:53 +0000
Date:   Wed, 28 Oct 2020 14:44:53 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201028144453.GA18610@infradead.org>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
 <20201028141251.3608598-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028141251.3608598-3-bigeasy@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 28, 2020 at 03:12:51PM +0100, Sebastian Andrzej Siewior wrote:
>  static int blk_softirq_cpu_dead(unsigned int cpu)
>  {
> -	/*
> -	 * If a CPU goes away, splice its entries to the current CPU
> -	 * and trigger a run of the softirq
> -	 */
> -	local_irq_disable();
> -	list_splice_init(&per_cpu(blk_cpu_done, cpu),
> -			 this_cpu_ptr(&blk_cpu_done));
> -	raise_softirq_irqoff(BLOCK_SOFTIRQ);
> -	local_irq_enable();
> -
> +	blk_complete_reqs(&per_cpu(blk_cpu_done, cpu));
>  	return 0;

How can this be preempted?  Can't we keep using this_cpu_ptr here?
