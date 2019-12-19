Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444BDC2D0C1
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16284222C2
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 10:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfLSKnP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:43:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:48032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfLSKnM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 05:43:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1E71CAC0C;
        Thu, 19 Dec 2019 10:43:10 +0000 (UTC)
Date:   Thu, 19 Dec 2019 11:43:47 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Long Li <longli@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH 2/3] softirq: implement interrupt flood detection
Message-ID: <20191219104347.ql6shgh2x7hk6iid@boron>
References: <20191218071942.22336-1-ming.lei@redhat.com>
 <20191218071942.22336-3-ming.lei@redhat.com>
 <20191218104941.GR2844@hirez.programming.kicks-ass.net>
 <20191219015948.GB6080@ming.t460p>
 <20191219092319.GX2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219092319.GX2844@hirez.programming.kicks-ass.net>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Thu, Dec 19, 2019 at 10:23:19AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 19, 2019 at 09:59:48AM +0800, Ming Lei wrote:
> > > So pray tell, why did you not integrate this with IRQ_TIME_ACCOUNTING ?
> > > That already takes a timestamp and does most of what you need.
> > 
> > Yeah, that was the 1st approach I thought of, but IRQ_TIME_ACCOUNTING
> > may be disabled, and enabling it may cause observable effect on IO
> > performance.
> 
> Is that an actual concern, are people disabling it?

In SLE and openSUSE kernels it is disabled for x86_64 at this
point. And if I am not completely misstaken only x86_64 supports it at
this point. I was looking at enable_sched_clock_irqtime() which is
only called from x86_64.

Another thing I noticed get_util_irq() is defined in
kernel/sched/sched.h. I don't think the block/blq-mq.c driver should
include it direclty.

Thanks,
Daniel

ps: A customer observes the same problem as Ming is reporting.
