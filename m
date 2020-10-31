Return-Path: <SRS0=St9l=EG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D00C388F9
	for <linux-block@archiver.kernel.org>; Sat, 31 Oct 2020 18:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9BD2068D
	for <linux-block@archiver.kernel.org>; Sat, 31 Oct 2020 18:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="efefLrOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgJaSJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 31 Oct 2020 14:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJaSJ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Oct 2020 14:09:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D67CC0617A6;
        Sat, 31 Oct 2020 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=px5gzTDuAA6r6aEMSVnOAXp+7prn4u4PCSua36AjyrI=; b=efefLrOQX2QQSjz75MCop0tUDq
        aRdVsfpVZlojVj7ptBWRjok41Bg71aM7sjg/y1MML1YxyXuo//NNUL5yfjw+/c+uMEo3x6AkMwZ8c
        9cbFKRpSBKZ6VkIK4oaM8OyTdORTWLAQochwdu5JMjdIBRbjtClVCh1yjLD5bknYWn1p75vo/nb8V
        hQpqO3Zga6PlZfFmEcV0EPNOmHSWucUPdk2bbaxv6OzyfMkVWSddc8FGJMlaG46V/2gbEw/6MG+Qf
        dJ3tL+rC0Px/EldTofN9HJvczSlvUBOSiQI189HTuSWlVqsi0j7a8fxaDHeM6uD97WXwl0+84o249
        Jw+e8/4Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYvJP-0003MF-3m; Sat, 31 Oct 2020 18:09:11 +0000
Date:   Sat, 31 Oct 2020 18:09:11 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201031180911.GA12737@infradead.org>
References: <20201029131212.dsulzvsb6pahahbs@linutronix.de>
 <20201029140536.GA6376@infradead.org>
 <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
 <20201029145743.GA19379@infradead.org>
 <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
 <20201029210103.ocufuvj6i4idf5hj@linutronix.de>
 <deb40e55-d228-06c8-8719-fc8657a0a19b@grimberg.me>
 <20201031104108.wjjdiklqrgyqmj54@linutronix.de>
 <3bbfb5e1-c5d7-8f3b-4b96-6dc02be0550d@kernel.dk>
 <76005875-1cfd-fb35-07f4-d35877d58b90@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76005875-1cfd-fb35-07f4-d35877d58b90@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 31, 2020 at 09:01:45AM -0600, Jens Axboe wrote:
> On 10/31/20 9:00 AM, Jens Axboe wrote:
> > On 10/31/20 4:41 AM, Sebastian Andrzej Siewior wrote:
> >> On 2020-10-29 14:07:59 [-0700], Sagi Grimberg wrote:
> >>>> in which context?
> >>>
> >>> Not sure what is the question.
> >>
> >> The question is in which context do you complete your requests. My guess
> >> by now is "usually softirq/NAPI and context in rare error case".
> > 
> > There really aren't any rules for this, and it's perfectly legit to
> > complete from process context. Maybe you're a kthread driven driver and
> > that's how you handle completions. The block completion path has always
> > been hard IRQ safe, but possible to call from anywhere.
> 
> A more recent example is polled IO, which will always complete from
> process/task context and very much is fast path.

But we never IPI for that anyway, so it is the easy case.
