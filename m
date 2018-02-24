Return-Path: <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-throttle: fix race between blkcg_bio_issue_check
 and cgroup_rmdir
To: Tejun Heo <tj@kernel.org>, xuejiufei <jiufei.xue@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Caspar Zhang <caspar@linux.alibaba.com>,
 linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
References: <6f136c90-faa9-4bc0-b02f-3a112b4d8360@linux.alibaba.com>
 <20180207213811.GF695913@devbig577.frc2.facebook.com>
 <b590caed-1423-4776-966d-cd9e346a8ea1@linux.alibaba.com>
 <20180208152307.GL695913@devbig577.frc2.facebook.com>
 <aac95b90-786d-95bf-b93d-87ecca79f846@linux.alibaba.com>
 <20180212171143.GY695913@devbig577.frc2.facebook.com>
 <19009bad-8429-c210-dd91-2b20771a66bd@linux.alibaba.com>
 <20180222151721.GA1641506@devbig577.frc2.facebook.com>
 <bc6304d1-5b76-c867-e76a-ab1c87b604ee@linux.alibaba.com>
 <20180223142344.GC1641506@devbig577.frc2.facebook.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <ac3f48fc-e306-5df3-1c30-cd3b385d971f@linux.alibaba.com>
Date: Sat, 24 Feb 2018 09:45:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180223142344.GC1641506@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Tejun,

On 18/2/23 22:23, Tejun Heo wrote:
> Hello,
> 
> On Fri, Feb 23, 2018 at 09:56:54AM +0800, xuejiufei wrote:
>>> On Thu, Feb 22, 2018 at 02:14:34PM +0800, Joseph Qi wrote:
>>>> I still don't get how css_tryget can work here.
>>>>
>>>> The race happens when:
>>>> 1) writeback kworker has found the blkg with rcu;
>>>> 2) blkcg is during offlining and blkg_destroy() has already been called.
>>>> Then, writeback kworker will take queue lock and access the blkg with
>>>> refcount 0.
>>>
>>> Yeah, then tryget would fail and it should go through the root.
>>>
>> In this race, the refcount of blkg becomes zero and is destroyed.
>> However css may still have refcount, and css_tryget can return success
>> before other callers put the refcount.
>> So I don't get how css_tryget can fix this race? Or I wonder if we can
>> add another function blkg_tryget?
> 
> IIRC, as long as the blkcg and the device are there, the blkgs aren't
> gonna be destroyed.  So, if you have a ref to the blkcg through
> tryget, the blkg shouldn't go away.
> 

Maybe we have misunderstanding here.

In this case, blkg doesn't go away as we have rcu protect, but
blkg_destroy() can be called, in which blkg_put() will put the last
refcnt and then schedule __blkg_release_rcu().

css refcnt can't prevent blkcg css from offlining, instead it is css
online_cnt.

css_tryget() will only get a refcnt of blkcg css, but can't be
guaranteed to fail when css is confirmed to kill.

The race sequence:
writeback kworker                   cgroup_rmdir
                                      cgroup_destroy_locked
                                        kill_css
                                          css_killed_ref_fn
                                            css_killed_work_fn
                                              offline_css
                                                blkcg_css_offline
  blkcg_bio_issue_check
    rcu_read_lock
    blkg_lookup
                                                  spin_trylock(q->queue_lock)
                                                  blkg_destroy
                                                  spin_unlock(q->queue_lock)
    blk_throtl_bio
      spin_lock_irq(q->queue_lock)
      spin_unlock_irq(q->queue_lock)
    rcu_read_unlock

Thanks,
Joseph
