Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FE8C55179
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D282067C
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bTYuNixG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgJ2O5r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJ2O5r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 10:57:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565CAC0613CF;
        Thu, 29 Oct 2020 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gaixN9Bvdo5h62VzxGq1fbBr5CvrRZrgy2xdLXcGzLE=; b=bTYuNixGSW2EZao7BIhpVMoBkg
        Fnfsb0miEeUi3RCG985nAhHBTRXcZ5zUyXS69dio+GuELyGkENctUrl4Si3aPWCXxI9R681ZfZjUb
        FfnzHqlfL6psaiXl1i+23BNkSEYxmg9iFWriVvp4QfG3iorYGmwxddxjuoFqNQg8LkBZ20KWgGzCR
        3VPByv+8ikppMJVye3Zvksowg+Q87VfPAephQ4TPxKsSRUGsqEvKk1gLB+rt2laTKdVPwKewgXJQQ
        YCe4CkT2Bs/wAVsrqwBh/Cz6SUFnogZTvBB+LW6NHCdfQhfTtoDN4CdsdkGj82up76AVXl5Jlzpld
        rE/iUJJg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY9N2-00056S-3U; Thu, 29 Oct 2020 14:57:44 +0000
Date:   Thu, 29 Oct 2020 14:57:43 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201029145743.GA19379@infradead.org>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
 <20201028141251.3608598-3-bigeasy@linutronix.de>
 <20201029131212.dsulzvsb6pahahbs@linutronix.de>
 <20201029140536.GA6376@infradead.org>
 <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 29, 2020 at 03:56:23PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-10-29 14:05:36 [+0000], Christoph Hellwig wrote:
> > Well, usb-storage obviously seems to do it, and the block layer
> > does not prohibit it.
> 
> Also loop, nvme-tcp and then I stopped looking.
> Any objections about adding local_bh_disable() around it?

To me it seems like the whole IPI plus potentially softirq dance is
a little pointless when completing from process context.

Sagi, any opinion on that from the nvme-tcp POV?
