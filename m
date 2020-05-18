Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EF4C433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 16:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42FAB20758
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 16:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgERQ4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 12:56:22 -0400
Received: from verein.lst.de ([213.95.11.211]:39387 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgERQ4W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 12:56:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7299268B02; Mon, 18 May 2020 18:56:19 +0200 (CEST)
Date:   Mon, 18 May 2020 18:56:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in
 blk_mq_alloc_request_hctx
Message-ID: <20200518165619.GA17465@lst.de>
References: <20200518093155.GB35380@T590> <87imgty15d.fsf@nanos.tec.linutronix.de> <20200518115454.GA46364@T590> <20200518131634.GA645@lst.de> <20200518141107.GA50374@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518141107.GA50374@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 18, 2020 at 10:11:07PM +0800, Ming Lei wrote:
> On Mon, May 18, 2020 at 03:16:34PM +0200, Christoph Hellwig wrote:
> > On Mon, May 18, 2020 at 07:54:54PM +0800, Ming Lei wrote:
> > > 
> > > I guess I misunderstood your point, sorry for that.
> > > 
> > > The requirement is just that the request needs to be allocated on one online
> > > CPU after INACTIVE is set, and we can use a workqueue to do that.
> > 
> > I've looked over the code again, and I'm really not sure why we need that.
> > Presumable the CPU hotplug code ensures tasks don't get schedule on the
> > CPU running the shutdown state machine, so if we just do a retry of the
> 
> percpu kthread still can be scheduled on the cpu to be online, see
> is_cpu_allowed(). And bound wq has been used widely in fs code.

s/to be online/to be offlined/ I guess.

Shouldn't all the per-cpu kthreads also stop as part of the offlining?
If they don't quiesce before the new blk-mq stop state I think we need
to make sure they do.  It is rather pointless to quiesce the requests
if a thread that can submit I/O is still live.

> > 
> >     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug.2
> > 
> 
> After preempt_disable() is removed, the INACTIVE bit is set in the CPU
> to be offline, and the bit can be read on all other CPUs, so other CPUs
> may not get synced with the INACTIVE bit.

INACTIVE is set to the hctx, and it is set by the last CPU to be
offlined that is mapped to the hctx.  once the bit is set the barrier
ensured it is seen everywhere before we start waiting for the requests
to finish.  What is missing?:

> 
> 
> Thanks,
> Ming
---end quoted text---
