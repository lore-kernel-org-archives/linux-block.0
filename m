Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 23 Feb 2018 06:23:44 -0800
From: Tejun Heo <tj@kernel.org>
To: xuejiufei <jiufei.xue@linux.alibaba.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
	Caspar Zhang <caspar@linux.alibaba.com>,
	linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] blk-throttle: fix race between blkcg_bio_issue_check
 and cgroup_rmdir
Message-ID: <20180223142344.GC1641506@devbig577.frc2.facebook.com>
References: <6f136c90-faa9-4bc0-b02f-3a112b4d8360@linux.alibaba.com>
 <20180207213811.GF695913@devbig577.frc2.facebook.com>
 <b590caed-1423-4776-966d-cd9e346a8ea1@linux.alibaba.com>
 <20180208152307.GL695913@devbig577.frc2.facebook.com>
 <aac95b90-786d-95bf-b93d-87ecca79f846@linux.alibaba.com>
 <20180212171143.GY695913@devbig577.frc2.facebook.com>
 <19009bad-8429-c210-dd91-2b20771a66bd@linux.alibaba.com>
 <20180222151721.GA1641506@devbig577.frc2.facebook.com>
 <bc6304d1-5b76-c867-e76a-ab1c87b604ee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bc6304d1-5b76-c867-e76a-ab1c87b604ee@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Fri, Feb 23, 2018 at 09:56:54AM +0800, xuejiufei wrote:
> > On Thu, Feb 22, 2018 at 02:14:34PM +0800, Joseph Qi wrote:
> >> I still don't get how css_tryget can work here.
> >>
> >> The race happens when:
> >> 1) writeback kworker has found the blkg with rcu;
> >> 2) blkcg is during offlining and blkg_destroy() has already been called.
> >> Then, writeback kworker will take queue lock and access the blkg with
> >> refcount 0.
> > 
> > Yeah, then tryget would fail and it should go through the root.
> > 
> In this race, the refcount of blkg becomes zero and is destroyed.
> However css may still have refcount, and css_tryget can return success
> before other callers put the refcount.
> So I don't get how css_tryget can fix this race? Or I wonder if we can
> add another function blkg_tryget?

IIRC, as long as the blkcg and the device are there, the blkgs aren't
gonna be destroyed.  So, if you have a ref to the blkcg through
tryget, the blkg shouldn't go away.

Thanks.

-- 
tejun
