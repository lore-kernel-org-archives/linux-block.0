Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35174 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbdHIHL0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2017 03:11:26 -0400
Received: by mail-pg0-f50.google.com with SMTP id v189so24614233pgd.2
        for <linux-block@vger.kernel.org>; Wed, 09 Aug 2017 00:11:25 -0700 (PDT)
Date: Wed, 9 Aug 2017 00:11:18 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V2 01/20] blk-mq-sched: fix scheduler bad performance
Message-ID: <20170809071118.GA16843@vader>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-2-ming.lei@redhat.com>
 <20170809001143.GH4072@vader.DHCP.thefacebook.com>
 <CACVXFVMx4vmzXeeVki40TgtX5Zpeqd-bFh5MaLP1iUEixoZA+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVMx4vmzXeeVki40TgtX5Zpeqd-bFh5MaLP1iUEixoZA+A@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 09, 2017 at 10:32:52AM +0800, Ming Lei wrote:
> On Wed, Aug 9, 2017 at 8:11 AM, Omar Sandoval <osandov@osandov.com> wrote:
> > On Sat, Aug 05, 2017 at 02:56:46PM +0800, Ming Lei wrote:
> >> When hw queue is busy, we shouldn't take requests from
> >> scheduler queue any more, otherwise IO merge will be
> >> difficult to do.
> >>
> >> This patch fixes the awful IO performance on some
> >> SCSI devices(lpfc, qla2xxx, ...) when mq-deadline/kyber
> >> is used by not taking requests if hw queue is busy.
> >
> > Jens added this behavior in 64765a75ef25 ("blk-mq-sched: ask scheduler
> > for work, if we failed dispatching leftovers"). That change was a big
> > performance improvement, but we didn't figure out why. We'll need to dig
> > up whatever test Jens was doing to make sure it doesn't regress.
> 
> Not found info about Jen's test case on this commit from google.
> 
> Maybe Jens could provide some input about your test case?

Okay I found my previous discussion with Jens (it was an off-list
discussion). The test case was xfs/297 from xfstests: after
64765a75ef25, the test went from taking ~300 seconds to ~200 seconds on
his SCSI device.

> In theory, if hw queue is busy and requests are left in ->dispatch,
> we should not have continued to dequeue requests from sw/scheduler queue
> any more. Otherwise, IO merge can be hurt much. At least on SCSI devices,
> this improved much on sequential I/O,  at least 3X of sequential
> read is increased on lpfc with this patch, in case of mq-deadline.

Right, your patch definitely makes more sense intuitively.

> Or are there other special cases in which we still need
> to push requests hard into a busy hardware?

xfs/297 does a lot of fsyncs and hence a lot of flushes, that could be
the special case.

> And this patch won't have an effect on devices in which queue busy
> is seldom triggered, such as NVMe.
