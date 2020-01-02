Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87677C2D0DC
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 10:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B602085B
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 10:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgABK2K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:28:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:52276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbgABK2K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Jan 2020 05:28:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1BB2BB2DB;
        Thu,  2 Jan 2020 10:28:08 +0000 (UTC)
Date:   Thu, 2 Jan 2020 11:28:07 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Long Li <longli@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH 2/3] softirq: implement interrupt flood detection
Message-ID: <20200102102807.dc7yf6choxre2lbg@beryllium.lan>
References: <20191218071942.22336-1-ming.lei@redhat.com>
 <20191218071942.22336-3-ming.lei@redhat.com>
 <20191218104941.GR2844@hirez.programming.kicks-ass.net>
 <20191219015948.GB6080@ming.t460p>
 <20191219092319.GX2844@hirez.programming.kicks-ass.net>
 <20191219104347.ql6shgh2x7hk6iid@boron>
 <20191231034806.GB20062@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231034806.GB20062@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Tue, Dec 31, 2019 at 11:48:06AM +0800, Ming Lei wrote:
> On Thu, Dec 19, 2019 at 11:43:47AM +0100, Daniel Wagner wrote:
> get_util_irq() only works in case of HAVE_SCHED_AVG_IRQ which depends
> on IRQ_TIME_ACCOUNTING or PARAVIRT_TIME_ACCOUNTING.
> 
> Also rq->avg_irq.util_avg is only updated when there is scheduler
> activities. However, when interrupt flood happens, scheduler can't
> have chance to be called. Looks get_util_irq() can't be relied on
> for this task.

I am not totally sold on the idea to do so as much work as possible in
the IRQ context. I started to play with the patches from Keith [1] which
move the work to proper kernel thread.

> > ps: A customer observes the same problem as Ming is reporting.
> 
> Actually this issue should be more serious on ARM64 system, in which
> there are more CPU cores, and each CPU core is often slower than
> x86's, and each interrupt is only delivered to single CPU target.
> 
> Meantime the storage device performance is same for the two kinds of
> systems.

As it turnes out, we missed one fix 2887e41b910b ("blk-wbt: Avoid lock
contention and thundering herd issue in wbt_wait") in our enterprise
kernel which helps but doesn't solve the real cause. But as I said
moving the work out of the IRQ context will address all those
problems. Obvious there is no free lunch, let's see if we find a way
to address all the performance issues.

Thanks,
Daniel

[1] https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/
