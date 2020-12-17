Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC313C2BB9A
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91732388E
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgLQQnw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 11:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgLQQnv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 11:43:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E64BC061794
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 08:43:11 -0800 (PST)
Date:   Thu, 17 Dec 2020 17:43:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608223389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXCm6k0W027Mb8RYqeAY5zi85G+eofzAV5gJeZWu9zA=;
        b=sJbENBZllxsUK0vpYjNbq/67g6yX6rhzRo4o6PadlpLpBfWMXCYIm83BZtk4gLxGy4CGhE
        Zf9geaY8G1h33SLw6W8GCEO+LAZToJE9vUPpkbPFZ/fy1OYSGqCK/0rOL88nvBA4OmCUuq
        eWHJmx7XIwg3Kw6MG5bEaMyYeVq+ORO3n/oFuDY5gqcF/e7XTwOdQNGUa3yehB5xCN4mk5
        rRpRGF9Kl12W5dejMKWWpGL8cFFeK5EFsHoOYGcSnQFHShIUYIH5PxZByOp7WnAxvX7LmK
        NGRlJwWEBbHgZAhiYCDLg1u1tVNV+HS5aJHSKGdQlZjf17kNNZV0FMSAW8xPeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608223389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXCm6k0W027Mb8RYqeAY5zi85G+eofzAV5gJeZWu9zA=;
        b=w5srlj8Ef3+Lij9SQjdnxNT9c/5rRXBHEeIqgt72gOd6sWIF9pP0WeGHNIYYd1fHG6gxMb
        mUH/wtLigIH2XJBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201217164308.ueki3scv3oxt4uta@linutronix.de>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208131319.GB22219@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208131319.GB22219@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-08 13:13:19 [+0000], Christoph Hellwig wrote:
> On Mon, Dec 07, 2020 at 04:52:57PM -0700, Jens Axboe wrote:
> > On 12/4/20 12:13 PM, Sebastian Andrzej Siewior wrote:
> > > Controllers with multiple queues have their IRQ-handelers pinned to a
> > > CPU. The core shouldn't need to complete the request on a remote CPU.
> > > 
> > > Remove this case and always raise the softirq to complete the request.
> > 
> > I don't like this one at all, it'll add a softirq jump for the fast path
> > for eg nvme devices.
> 
> For the real fast path, that is either a polled queue or irq driven
> queues that only map to a single CPU we are never reaching this code,
> so I'm not too worried.  Not that I'd complain about numbers, preferably
> in the commit log.

Did Daniel provide all the numbers you/Jens were looking for or do we
still wait for some?

Sebastian
