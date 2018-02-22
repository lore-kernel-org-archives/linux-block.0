Return-Path: <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-throttle: fix race between blkcg_bio_issue_check
 and cgroup_rmdir
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, xuejiufei <jiufei.xue@linux.alibaba.com>,
 Caspar Zhang <caspar@linux.alibaba.com>,
 linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
References: <6f136c90-faa9-4bc0-b02f-3a112b4d8360@linux.alibaba.com>
 <20180207213811.GF695913@devbig577.frc2.facebook.com>
 <b590caed-1423-4776-966d-cd9e346a8ea1@linux.alibaba.com>
 <20180208152307.GL695913@devbig577.frc2.facebook.com>
 <aac95b90-786d-95bf-b93d-87ecca79f846@linux.alibaba.com>
 <20180212171143.GY695913@devbig577.frc2.facebook.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <19009bad-8429-c210-dd91-2b20771a66bd@linux.alibaba.com>
Date: Thu, 22 Feb 2018 14:14:34 +0800
MIME-Version: 1.0
In-Reply-To: <20180212171143.GY695913@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Tejun,

Sorry for the delayed reply.

On 18/2/13 01:11, Tejun Heo wrote:
> Hello, Joseph.
> 
> On Fri, Feb 09, 2018 at 10:15:19AM +0800, Joseph Qi wrote:
>> IIUC, we have to identify it is in blkcg_css_offline now which will
>> blkg_put. Since percpu_ref_kill_and_confirm in kill_css will set flag
>> __PERCPU_REF_DEAD, so we can use this to avoid the race. IOW, if
>> __PERCPU_REF_DEAD is set now, we know blkcg css is in offline and
>> continue access blkg may risk double free. Thus we choose to skip these
>> ios.
>> I don't get how css_tryget works since it doesn't care the flag
>> __PERCPU_REF_DEAD. Also css_tryget can't prevent blkcg_css from
>> offlining since the race happens blkcg_css_offline is in progress.
>> Am I missing something here?
> 
> Once marked dead, the ref is in atomic mode and css_tryget() would hit
> the atomic counter.  Here, we don't care about the offlining and
> draining.  A draining memcg can still have a lot of memory to be
> written back attached to it and we don't want punt all of them to the
> root cgroup.

I still don't get how css_tryget can work here.

The race happens when:
1) writeback kworker has found the blkg with rcu;
2) blkcg is during offlining and blkg_destroy() has already been called.
Then, writeback kworker will take queue lock and access the blkg with
refcount 0.

So, I think we should take queue lock when lookup blkg if we want to
throttle the ios during offline (the way this patch tries), or use
css_tryget_online() to skip the further use of the risky blkg, which
means these ios won't be throttled either.

Thanks,
Joseph
