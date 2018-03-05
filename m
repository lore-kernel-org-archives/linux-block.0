Return-Path: <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-throttle: fix race between blkcg_bio_issue_check
 and cgroup_rmdir
To: Tejun Heo <tj@kernel.org>
Cc: xuejiufei <jiufei.xue@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
 Caspar Zhang <caspar@linux.alibaba.com>,
 linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
References: <20180208152307.GL695913@devbig577.frc2.facebook.com>
 <aac95b90-786d-95bf-b93d-87ecca79f846@linux.alibaba.com>
 <20180212171143.GY695913@devbig577.frc2.facebook.com>
 <19009bad-8429-c210-dd91-2b20771a66bd@linux.alibaba.com>
 <20180222151721.GA1641506@devbig577.frc2.facebook.com>
 <bc6304d1-5b76-c867-e76a-ab1c87b604ee@linux.alibaba.com>
 <20180223142344.GC1641506@devbig577.frc2.facebook.com>
 <ac3f48fc-e306-5df3-1c30-cd3b385d971f@linux.alibaba.com>
 <20180227183355.GG24003@devbig577.frc2.facebook.com>
 <a74b1f86-1e54-cf07-9b53-773abbb9df33@linux.alibaba.com>
 <20180304202317.GC231488@devbig577.frc2.facebook.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <4f282c16-d8ce-783e-b274-0dbf28cf340a@linux.alibaba.com>
Date: Mon, 5 Mar 2018 09:17:27 +0800
MIME-Version: 1.0
In-Reply-To: <20180304202317.GC231488@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 18/3/5 04:23, Tejun Heo wrote:
> Hello, Joseph.
> 
> Sorry about late reply.
> 
> On Wed, Feb 28, 2018 at 02:52:10PM +0800, Joseph Qi wrote:
>> In current code, I'm afraid pd_offline_fn() as well as the rest
>> destruction have to be called together under the same blkcg->lock and
>> q->queue_lock.
>> For example, if we split the pd_offline_fn() and radix_tree_delete()
>> into 2 phases, it may introduce a race between blkcg_deactivate_policy()
>> when exit queue and blkcg_css_free(), which will result in
>> pd_offline_fn() to be called twice.
> 
> So, yeah, the sync scheme aroung blkg is pretty brittle and we'd need
> some restructuring to separate out blkg offlining and release, but it
> looks like that'd be the right thing to do, no?
> 
Agree, except the restriction above, as of now I don't find any more.
I'll try to fix in the way you suggested and post v3.

Thanks,
Joseph
