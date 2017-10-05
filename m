Return-Path: <shli@kernel.org>
Date: Thu, 5 Oct 2017 09:45:05 -0700
From: Shaohua Li <shli@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org, vgoyal@redhat.com, axboe@kernel.dk,
	Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [RFC 2/2] blockcg: export latency info for each cgroup
Message-ID: <20171005164505.sbreklcta6rs4acd@kernel.org>
References: <cover.1507138530.git.shli@fb.com>
 <7f592647e6c30b6eb7cb1cef4892bca060a73d78.1507138530.git.shli@fb.com>
 <20171004180438.GQ3301751@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171004180438.GQ3301751@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 04, 2017 at 11:04:39AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Oct 04, 2017 at 10:41:20AM -0700, Shaohua Li wrote:
> > Export the latency info to user. The latency is a good sign to indicate
> > if IO is congested or not. User can use the info to make decisions like
> > adjust cgroup settings.
> 
> Nice, yeah, this can be really useful.
> 
> > Existing io.stat shows accumulated IO bytes and requests, but
> > accumulated value for latency doesn't make much sense. This patch
> > exports the latency info in a 100ms interval.
> 
> We probably want running avg of a few intervals.
> 
> > A micro benchmark running fio test against null_blk in a third level
> > cgroup shows around 4% regression. If I only do the latency accouting
> 
> Heh, that's quite a bit.
> 
> > for leaf cgroup, the regression seems to disappear. So not quite sure if
> > we should do the accounting for intermediate nodes or if the whole thing
> > should be enabled optionally.
> 
> I suspect that if we make the calculations and propagations lazy, the
> overhead will likely become negligible.  Can you please take a look at
> how the basic resource accounting code in kernel/cgroup/stat.c?  It's
> an infra code for collecting stats without burdening hot path.  It's
> currently only used for CPU but we can easily expand it to cover other
> resources.  Having to do running avgs might interfere with the lazy
> propagation a bit but I think we can make it work if we make the right
> trade-offs.

Looks that is similar to how io.stat exposes bytes/ios. It does the
propagation at the time when user read the status file. However, doing the same
for latency is meaningless, we shouldn't accumulate latency for a long time. If
we want to do it lazily, alternatives are:
- export total requests and total latency. User can calculate the average in
  any interval. We can't export min/max latency then.
- export avg/min/max since last time when user reads io.stat. We clear all
  statistics once user reads io.stat and re-account from scratch.

Thanks,
Shaohua
