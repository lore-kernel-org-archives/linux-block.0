Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [RFC PATCH 0/3] blk-mq: rework queue freeze and preempt-only
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, tj@kernel.org,
        kent.overstreet@gmail.com, ming.lei@redhat.com, bart.vanassche@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
 <1537463217.224533.4.camel@acm.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <0e6caed5-33eb-e645-f452-3dfc6c20206d@oracle.com>
Date: Fri, 21 Sep 2018 09:51:52 +0800
MIME-Version: 1.0
In-Reply-To: <1537463217.224533.4.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 09/21/2018 01:06 AM, Bart Van Assche wrote:
> On Thu, 2018-09-20 at 18:18 +0800, Jianchao Wang wrote:
>> The current queue freeze depending on percpu_ref_kil/reinit has a limit that
>> we have drain the requests before unfreeze the queue.
>>
>> Let's rework the queue freeze feature as following:
>> 1. introduce __percpu_ref_get_many.
>>    It is same with original percpu_ref_get_many, but just need callers to provide
>>    sched rcu critical section. We will put the __percpu_ref_get_many and our own
>>    condition checking under rcu_read_lock_sched. With this new helper interface,
>>    we could save an extra rcu_read_lock_sched.
>> 2. rework the blk_queue_enter as:
>>    
>>    rcu_read_lock_sched()
>>    if condition check true
>>      __percpu_ref_get_many(&q->q_usage_counter, 1)
>>    else
>>      goto wait
>>    rcu_read_unlock_sched()
>> 3. use percpu_ref_switch_to_atomic/percpu to switch mode directly.
>>
>> Then we could unfreeze the queue w/o draining requests.
>> In addition, preempt-only mode code could be simplified.
> Hello Jianchao,
>                                                                            =
> Thanks for having taken a look. However, the approach of this patch series
> may be more complicated than necessary. Had you considered something like
> the patch below?

This patch is just a trying that let our life easier w/o changing anything in percpu-ref code. :)
In fact, the 1st patch which introduces a new non-functional-changing helper interface in
percpu-ref code is not necessary.

This patchset just implement our own condition checking in blk_queue_enter instead of depending on
__PERCPU_REF_DEAD checking in percpu_ref_tryget_live.

Then we could do more thing here, like:
 - unfreeze the queue without draining requests.
 - check whether q->q_usage_counter is zero
 - add other gate conditions into blk_queue_enter, such as preempt-only, even any others.

So why not try it ?

Thanks
Jianchao
