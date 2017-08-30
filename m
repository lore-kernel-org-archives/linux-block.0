Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbdH3Gnx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 02:43:53 -0400
Date: Wed, 30 Aug 2017 14:43:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V2 2/2] block/loop: allow request merge for directio mode
Message-ID: <20170830064339.GB1024@ming.t460p>
References: <cover.1503602376.git.shli@fb.com>
 <cafa738c4f61d9b549b7d4675903e8c61962480b.1503602376.git.shli@fb.com>
 <20170829095604.GB32439@ming.t460p>
 <20170829151339.7zc2qv32qsfknpjh@kernel.org>
 <20170830025120.GC4897@ming.t460p>
 <20170830044320.v4gwvez6yzd4wm52@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170830044320.v4gwvez6yzd4wm52@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 29, 2017 at 09:43:20PM -0700, Shaohua Li wrote:
> On Wed, Aug 30, 2017 at 10:51:21AM +0800, Ming Lei wrote:
> > On Tue, Aug 29, 2017 at 08:13:39AM -0700, Shaohua Li wrote:
> > > On Tue, Aug 29, 2017 at 05:56:05PM +0800, Ming Lei wrote:
> > > > On Thu, Aug 24, 2017 at 12:24:53PM -0700, Shaohua Li wrote:
> > > > > From: Shaohua Li <shli@fb.com>
> > > > > 
> > > > > Currently loop disables merge. While it makes sense for buffer IO mode,
> > > > > directio mode can benefit from request merge. Without merge, loop could
> > > > > send small size IO to underlayer disk and harm performance.
> > > > 
> > > > Hi Shaohua,
> > > > 
> > > > IMO no matter if merge is used, loop always sends page by page
> > > > to VFS in both dio or buffer I/O.
> > > 
> > > Why do you think so?
> > 
> > do_blockdev_direct_IO() still handles page by page from iov_iter, and
> > with bigger request, I guess it might be the plug merge working.
> 
> This is not true. directio sends big size bio directly, not because of plug
> merge. Please at least check the code before you complain.

I complain nothing, just try to understand the idea behind,
never mind, :-)

> 
> > >  
> > > > Also if merge is enabled on loop, that means merge is run
> > > > on both loop and low level block driver, and not sure if we
> > > > can benefit from that.
> > > 
> > > why does merge still happen in low level block driver?
> > 
> > Because scheduler is still working on low level disk. My question
> > is that why the scheduler in low level disk doesn't work now
> > if scheduler on loop can merge?
> 
> The low level disk can still do merge, but since this is directio, the upper
> layer already dispatches request as big as possible. There is very little
> chance the requests can be merged again.

That is true, but these requests need to enter scheduler queue and
be tried to merge again, even though it is less possible to succeed.
Double merge may take extra CPU utilization.

Looks it doesn't answer my question.

Without this patch, the requests dispatched to loop won't be merged,
so they may be small and their sectors may be continuous, my question
is why dio bios converted from these small loop requests can't be
merged in block layer when queuing these dio bios to low level device?


> 
> > > 
> > > > 
> > > > So Could you provide some performance data about this patch?
> > > 
> > > In my virtual machine, a workload improves from ~20M/s to ~50M/s. And I clearly
> > > see the request size becomes bigger.
> > 
> > Could you share us what the low level disk is?
> 
> It's a SATA ssd.

For sata, it is pretty easy to trigger I/O merge.

-- 
Ming
