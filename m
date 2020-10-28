Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D81C388F7
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 00:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3652080C
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 00:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MEr4Wj2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgJ2Abu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbgJ1Wbb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 18:31:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90954C0613D1;
        Wed, 28 Oct 2020 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=11r151o8JcIiklZdrY5InpTby+OlWFUHOfysaQ6dEeo=; b=MEr4Wj2p6V6PCicC2/5IqSL14D
        CvUuk7+ZmDja8bW9YCBqbzS8GUFijYKiYAa8vT88s7Kjl3vvBnadljzN5Rz40L7uUZrkrzbdF8Ygi
        EyGe1dGZjF7bB+ADMWngAr7MMW24qcbizYzZ9MkxaAH205OLRzXiWGJtYkgRIEnSrzNtE+s4CxZeg
        9NKDrKFx2xKV1pli4hqdxkQq5IaEfSBQgSlHHh6hNrRwaqAkPfDjBDimONIEyPSlK8DP5shpCF+Et
        2suFpQ2fDAA413qvSqCUppesziln55ZKBg3rRqod8rJ3M/wZ3aP/tzXLXfVfNOFWZL8sImIqowjYv
        eE4oaCjg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXfNY-0006jP-FQ; Wed, 28 Oct 2020 06:56:16 +0000
Date:   Wed, 28 Oct 2020 06:56:16 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
Message-ID: <20201028065616.GA24449@infradead.org>
References: <20201021175059.GA4989@hmbx>
 <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
 <20201023112130.GA23790@infradead.org>
 <20201023135219.mzzl76eqqy6tqwhe@linutronix.de>
 <20201027092606.GA20805@infradead.org>
 <20201027101102.cvczdb3mkvtoguo5@linutronix.de>
 <20201027160742.GA19073@infradead.org>
 <87eelj1tx0.fsf@nanos.tec.linutronix.de>
 <20201027172309.GA15004@infradead.org>
 <20201027205806.s7qau5xf4lzuslcu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027205806.s7qau5xf4lzuslcu@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The remaining part is a switch to llist which avoids locking (IRQ
> off/on) and it allows invoke the IPI/raise softirq only if something was
> added. The entries are now processed in the reverse order but this
> shouldn't matter right?

For correctness it should not matter, but I think it could have
performance implications.  I think you'll have to throw in a
llist_reverse_order.

> I would split this into two patches (the blk_mq_complete_need_ipi() hunk
> and the llist part) unless there are objections.

Yes, please do.
