Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0073C4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94E7208BA
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgLQQuV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 11:50:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:43680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgLQQuV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 11:50:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D80F5ACA5;
        Thu, 17 Dec 2020 16:49:39 +0000 (UTC)
Date:   Thu, 17 Dec 2020 17:49:39 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201217164939.z4zjhycpxsyqvvcd@beryllium.lan>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
 <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
 <243c7259-0b1b-b239-4f0f-650520333392@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243c7259-0b1b-b239-4f0f-650520333392@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 17, 2020 at 09:45:47AM -0700, Jens Axboe wrote:
> On 12/8/20 1:44 AM, Daniel Wagner wrote:
> > It looks like the patched version show tiny bit better numbers for this
> > workload. slat seems to be one of the major difference between the two
> > runs. But that is the only thing I really spotted to be really off.
> 
> slat is the same, just one is in nsec and the other is in usec.

Ah, good eyes. Need to remember this :)

> > I keep going with some more testing. Let what kind of tests you would
> > also want to see. I'll do a few plain NVMe tests next.
> 
> This is a good test, thanks.

Got sidetracked. Haven't started yet with these tests.
