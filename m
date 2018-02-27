Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 27 Feb 2018 10:33:55 -0800
From: Tejun Heo <tj@kernel.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: xuejiufei <jiufei.xue@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
	Caspar Zhang <caspar@linux.alibaba.com>,
	linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] blk-throttle: fix race between blkcg_bio_issue_check
 and cgroup_rmdir
Message-ID: <20180227183355.GG24003@devbig577.frc2.facebook.com>
References: <20180207213811.GF695913@devbig577.frc2.facebook.com>
 <b590caed-1423-4776-966d-cd9e346a8ea1@linux.alibaba.com>
 <20180208152307.GL695913@devbig577.frc2.facebook.com>
 <aac95b90-786d-95bf-b93d-87ecca79f846@linux.alibaba.com>
 <20180212171143.GY695913@devbig577.frc2.facebook.com>
 <19009bad-8429-c210-dd91-2b20771a66bd@linux.alibaba.com>
 <20180222151721.GA1641506@devbig577.frc2.facebook.com>
 <bc6304d1-5b76-c867-e76a-ab1c87b604ee@linux.alibaba.com>
 <20180223142344.GC1641506@devbig577.frc2.facebook.com>
 <ac3f48fc-e306-5df3-1c30-cd3b385d971f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ac3f48fc-e306-5df3-1c30-cd3b385d971f@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Joseph.

On Sat, Feb 24, 2018 at 09:45:49AM +0800, Joseph Qi wrote:
> > IIRC, as long as the blkcg and the device are there, the blkgs aren't
> > gonna be destroyed.  So, if you have a ref to the blkcg through
> > tryget, the blkg shouldn't go away.
> > 
> 
> Maybe we have misunderstanding here.
> 
> In this case, blkg doesn't go away as we have rcu protect, but
> blkg_destroy() can be called, in which blkg_put() will put the last
> refcnt and then schedule __blkg_release_rcu().
> 
> css refcnt can't prevent blkcg css from offlining, instead it is css
> online_cnt.
> 
> css_tryget() will only get a refcnt of blkcg css, but can't be
> guaranteed to fail when css is confirmed to kill.

Ah, you're right.  I was thinking we only destroy blkgs from blkcg
release path.  Given that we primarily use blkcg refcnting to pin
them, I believe that's what we should do - ie. only call
pd_offline_fn() from blkcg_css_offline() path and do the rest of
destruction from blkcg_css_free().  What do you think?

Thanks.

-- 
tejun
