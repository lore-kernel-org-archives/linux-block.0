Return-Path: <bfoster@redhat.com>
Date: Fri, 27 Apr 2018 08:20:06 -0400
From: Brian Foster <bfoster@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Benlong Zhang <zhangbenlong@didichuxing.com>, axboe@kernel.dk,
	shli@kernel.org, david@fromorbit.com, linux-block@vger.kernel.org,
	Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] A tentative patch to bypass REQ_META in blk throttle
Message-ID: <20180427122006.GA9380@bfoster.bfoster>
References: <20180420100554.GA23471@localhost>
 <20180426190118.GP1911913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180426190118.GP1911913@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 26, 2018 at 12:01:18PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Fri, Apr 20, 2018 at 06:06:01PM +0800, Benlong Zhang wrote:
> > One problem with cgwb is how fs should treat metadata bios.
> > For example in xfs, the log might be partially stuck in one
> > group, leaving threads in other groups waiting for too long.
> > Please refer to the linux-xfs discussion:
> > "[PATCH V2] xfs: implement cgroup writeback support"
> > 
> > One approach is to correctly tag bio->bi_css from within the
> > filesystems (for xfs log should be blkcg_root), and the other
> > is to skip them, but relies on REQ_META being set.
> > 
> > It works with xfs on a cgwb porting implementation to 3.10.0.
> > But really not sure about other filesystems...
> 
> Yeah, Josef (cc'd) is working on a similar approach but in a more
> generic way.
> 

I thought Josef's work had more to do with tracking/managing dirty
metadata (i.e., driving writeback/reclaim and whatnot). Perhaps I just
haven't followed it close enough... how does that relate to cgroup bio
ownership?

The issue addressed by this patch (wrt to XFS) is that log I/O that
happens to be submitted via a throttled cgroup ends up blocking
unthrottled tasks because the log is essentially a global/shared
mechanism. We therefore want to somehow exempt metadata I/O from
throttling in that particular case.

Note that I'm not familiar enough with the block layer code to know
whether this patch is the right way to do that, but I think (as noted in
the commit log above) that not doing the default bio association if the
fs hasn't (or associating with some root group) for metadata I/O would
also be sufficient. Hm?

Brian

> Thanks.
> 
> -- 
> tejun
