Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A4FC433E6
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2254206F7
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbhAZFbv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbhAYKAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 05:00:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B409C0617AA;
        Mon, 25 Jan 2021 00:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mjV/4Z3CDRxQhs+wKq1+GM3JPWdjP4pMPtKxh3gu3Qg=; b=qnNhg72wYDhaBpZbjBxRedU+0p
        y18yUOE0T3saR/wjRv9Aysq05dijQ7rGD5IeOiFPH4IulcBXMa3mSOHz0nsjGONuGjnX8bUxe91Lq
        o0iftOB1HJRWIZKgbAeUX4mB9TIgk7jLu/uAP9L1t8upK9ueQWwbbOlUgvqt/ZQjEXoM0KwZG+rou
        3qUKywQdTwqdQxaEgTi6nJlEmmzNg13jdVCmIRVlCP50Kroa0OZiFB+esbyPn8aL4CaRTfVBIbVQi
        0tdq9by/K4+pPYMA2KFWLNuUh2lqwMMtMUm2P7OYZsltG6zVCZ+V+b+veepwSUlfVj8Fek4VCXNzW
        ccCPJNOA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3xIm-003y01-HS; Mon, 25 Jan 2021 08:32:49 +0000
Date:   Mon, 25 Jan 2021 08:32:48 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20210125083248.GA945284@infradead.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-3-bigeasy@linutronix.de>
 <30ce5ce2-8b9a-8873-4b37-c8720300942b@suse.de>
 <20210125082542.GC942655@infradead.org>
 <20210125083029.utnjqs2s3diqb5vx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125083029.utnjqs2s3diqb5vx@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 25, 2021 at 09:30:29AM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-01-25 08:25:42 [+0000], Christoph Hellwig wrote:
> > On Mon, Jan 25, 2021 at 08:10:16AM +0100, Hannes Reinecke wrote:
> > > I don't get this.
> > > This code is about _avoiding_ having to raise a softirq if the driver
> > > exports more than one hardware queue.
> > > So where exactly does the remote CPU case come in here?
> > 
> > __blk_mq_complete_request_remote is only called for the case where we
> > do not completelky locally.  The case that "degrades" here is where
> > the device supports multiple queues, but less than the number of CPUs,
> > and we bounce the completion to another CPU.
> 
> Does it really "degrade" or just use the softirq more often? The usual
> case is run the softirqs in irq_exit() which is just after IPI.

Well, I put it in quotes because I'm not sure what the exact effect
is.  But we do delay these completions to the softirq now instead of
hardirq context, which at least in theory increases latency.  OTOH it
might even have positive effects on the rest of the system.
