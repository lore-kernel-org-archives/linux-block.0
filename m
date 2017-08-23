Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753386AbdHWHtK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 03:49:10 -0400
Date: Wed, 23 Aug 2017 15:48:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V2 01/20] blk-mq-sched: fix scheduler bad performance
Message-ID: <20170823074847.GC11479@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-2-ming.lei@redhat.com>
 <20170809001143.GH4072@vader.DHCP.thefacebook.com>
 <CACVXFVMx4vmzXeeVki40TgtX5Zpeqd-bFh5MaLP1iUEixoZA+A@mail.gmail.com>
 <20170809071118.GA16843@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170809071118.GA16843@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 09, 2017 at 12:11:18AM -0700, Omar Sandoval wrote:
> On Wed, Aug 09, 2017 at 10:32:52AM +0800, Ming Lei wrote:
> > On Wed, Aug 9, 2017 at 8:11 AM, Omar Sandoval <osandov@osandov.com> wrote:
> > > On Sat, Aug 05, 2017 at 02:56:46PM +0800, Ming Lei wrote:
> > >> When hw queue is busy, we shouldn't take requests from
> > >> scheduler queue any more, otherwise IO merge will be
> > >> difficult to do.
> > >>
> > >> This patch fixes the awful IO performance on some
> > >> SCSI devices(lpfc, qla2xxx, ...) when mq-deadline/kyber
> > >> is used by not taking requests if hw queue is busy.
> > >
> > > Jens added this behavior in 64765a75ef25 ("blk-mq-sched: ask scheduler
> > > for work, if we failed dispatching leftovers"). That change was a big
> > > performance improvement, but we didn't figure out why. We'll need to dig
> > > up whatever test Jens was doing to make sure it doesn't regress.
> > 
> > Not found info about Jen's test case on this commit from google.
> > 
> > Maybe Jens could provide some input about your test case?
> 
> Okay I found my previous discussion with Jens (it was an off-list
> discussion). The test case was xfs/297 from xfstests: after
> 64765a75ef25, the test went from taking ~300 seconds to ~200 seconds on
> his SCSI device.

Just run xfs/297 on virtio-scsi device with this patch, and use
mq-deadline scheduler:

	v4.13-rc6 + block for-next: 				83s
	v4.13-rc6 + block for-next + this patch:	79s

So looks no big difference.

> 
> > In theory, if hw queue is busy and requests are left in ->dispatch,
> > we should not have continued to dequeue requests from sw/scheduler queue
> > any more. Otherwise, IO merge can be hurt much. At least on SCSI devices,
> > this improved much on sequential I/O,  at least 3X of sequential
> > read is increased on lpfc with this patch, in case of mq-deadline.
> 
> Right, your patch definitely makes more sense intuitively.
> 
> > Or are there other special cases in which we still need
> > to push requests hard into a busy hardware?
> 
> xfs/297 does a lot of fsyncs and hence a lot of flushes, that could be
> the special case.

IMO, this patch shouldn't degrade flush in theory, and actually in
Paolo's dbench test[1], flush latency is decreased a lot with this
patchset, and Paolo's test is on SATA device.

[1] https://marc.info/?l=linux-block&m=150217980602843&w=2

--
Ming
