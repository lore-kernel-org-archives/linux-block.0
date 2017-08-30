Return-Path: <shli@kernel.org>
Date: Tue, 29 Aug 2017 22:07:04 -0700
From: Shaohua Li <shli@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, lizefan@huawei.com,
	Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [RFC] block/loop: make loop cgroup aware
Message-ID: <20170830050704.pabmup7k5dzredtl@kernel.org>
References: <dd357e1638021132cd39a11769a745a8318636d3.1503506490.git.shli@fb.com>
 <20170828225459.GE491396@devbig577.frc2.facebook.com>
 <20170829152236.vvtxahdrwqgmzmm7@kernel.org>
 <20170829152809.GM491396@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829152809.GM491396@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 29, 2017 at 08:28:09AM -0700, Tejun Heo wrote:
> Hello, Shaohua.
> 
> On Tue, Aug 29, 2017 at 08:22:36AM -0700, Shaohua Li wrote:
> > > Yeah, writeback tracks the most active cgroup and associates writeback
> > > ios with that cgroup.  For buffered loop devices, I think it'd be fine
> > > to make the loop driver forward the cgroup association and let the
> > > writeback layer determine the matching association as usual.
> > 
> > Doing this means we must forward cgroup info to page, not bio. I need to check
> > if we can make the mechanism work for memcg.
> 
> The association is already coming from the page.  We just need to make
> sure that going through loop driver doesn't get in the way of the
> membership getting propagated to the underlying device.

I think there is confusion. App writes files in upper layer fs on loop. memcg
estabilish membership for the pages of these files. Then writeback does write,
loop then write these pages to under layer fs. The write is done in loop
thread. The write will allocate new page cache for under layer fs files. The
issue is we must forward memcg info from upper layer files page cache to under
layer files page cache.

> > > Hmm... why do we need double forwarding (original issuer -> aio cmd ->
> > > ios) in loop?  If we need this, doesn't this mean that we're missing
> > > ownership forwarding in aio paths and should make the forwarding
> > > happen there?
> > 
> > what do you mean double forwarding?
> 
> So, this looks like the loop driver is explicitly forwarding the
> association from the original issuer to the aio command and then from
> the aio command to the ios to the underlying device.  I'm wondering
> whether the right way to do this is making aio forward the association
> by default, instead of the loop driver doing it explicitly.  That way,
> all aio users can benefit from the forwarding instead of just loop.

That's possible. The downside doing this in aio is we must audit all fs to make
sure all bio have association. I'd like to avoid doing this if there is no
other loop-like cgroup usage.

Thanks,
Shaohua
