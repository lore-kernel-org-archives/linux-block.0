Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DDAC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C2223AA8
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgLHNOB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLHNOB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 08:14:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E8C061749
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 05:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mwUwAz4oo7DdtTjCJXSgglhbE80qb3YirGBlxjlaxWQ=; b=Fy7ri/MSQxKRAV5VsOcE+VAGGK
        zn6yBWK9ecErdjd6F0djhf+KZ6FvOFHjx1wvtJkwDkClQ7v51QsPb/GWAM0u5ZcD549EU9v/MCwa1
        Oiy3WRj0JgoO4F6Sh7Hqsz2roLJP5Pi8DzEZQ6NjSPMhQglJc8aUpPj+kYNqGkwQvTTVev/elS0/V
        4kzxbhqUmy27k2DJIj++G0INYKZG76bNRWKjq76gA5wDT8eo9Se0y8wd7KCWO+cOT16JXK8W3geVr
        ZCG2kU3X4mKh1IPLpXNSNvZu8OKv1FMZKw8owil/DJWmyvxu46c0L7NkLDO8Nmh7aInvubteA/Xhi
        K/44dgWQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmcnv-0005zJ-4N; Tue, 08 Dec 2020 13:13:19 +0000
Date:   Tue, 8 Dec 2020 13:13:19 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201208131319.GB22219@infradead.org>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 07, 2020 at 04:52:57PM -0700, Jens Axboe wrote:
> On 12/4/20 12:13 PM, Sebastian Andrzej Siewior wrote:
> > Controllers with multiple queues have their IRQ-handelers pinned to a
> > CPU. The core shouldn't need to complete the request on a remote CPU.
> > 
> > Remove this case and always raise the softirq to complete the request.
> 
> I don't like this one at all, it'll add a softirq jump for the fast path
> for eg nvme devices.

For the real fast path, that is either a polled queue or irq driven
queues that only map to a single CPU we are never reaching this code,
so I'm not too worried.  Not that I'd complain about numbers, preferably
in the commit log.
