Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20C8C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB0C23AA7
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgLHNLe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgLHNLd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 08:11:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BB1C061749
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 05:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nxtHzv3G9CEsPKPHZfP9UfNvs7B1c+41sN5DQUZcSLw=; b=sM+C6cWEp/UxfITu1s664UuzM/
        KtCXekYwrglfLhLy6D/RD6L44Acm7LKZvypGQS3AWpwsDNkzWHKiQdtq09R62M8ETESngQfpRvBTl
        M9f10LNE/OPkNJ8nZjN3D/oe7bKqi4ftmXvVz2gvLqrX8LWT2ZexyfcQZSLIsHzjajjH2HNKW+R/i
        cGeg7cFQDXW4/ZA53vh/lll4g3Y467lCNRbPUtVJBwL2oAUCHRsf/0E11go14GF1sjSwSBUF83LTJ
        RUb6EsqVHqnB1ado+dxtvcBCJz/EgmScMOyx9ng0DXJhTYsAAFWs8geJI4Smst8FsrEMySuz7hmvf
        n1WzFCyA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmclV-0005nK-Ds; Tue, 08 Dec 2020 13:10:49 +0000
Date:   Tue, 8 Dec 2020 13:10:49 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] blk-mq: Don't complete on a remote CPU in force
 threaded mode
Message-ID: <20201208131049.GA22219@infradead.org>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204191356.2516405-2-bigeasy@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 04, 2020 at 08:13:54PM +0100, Sebastian Andrzej Siewior wrote:
> With force threaded interrupts enabled, raising softirq from an SMP
> function call will always result in waking the ksoftirqd thread. This is
> not optimal given that the thread runs at SCHED_OTHER priority.
> 
> Completing the request in hard IRQ-context on PREEMPT_RT (which enforces
> the force threaded mode) is bad because the completion handler may
> acquire sleeping locks which violate the locking context.
> 
> Disable request completing on a remote CPU in force threaded mode.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
