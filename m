Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 1/3] percpu_ref: add a new helper interface
 __percpu_ref_get_many
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, kent.overstreet@gmail.com, ming.lei@redhat.com,
        bart.vanassche@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
 <1537438703-25217-2-git-send-email-jianchao.w.wang@oracle.com>
 <20180920205333.GF902964@devbig004.ftw2.facebook.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <2659fd02-fc20-cada-c43e-fac12827d1ad@oracle.com>
Date: Fri, 21 Sep 2018 09:45:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180920205333.GF902964@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Tejun

Thanks for your kindly response.

On 09/21/2018 04:53 AM, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 20, 2018 at 06:18:21PM +0800, Jianchao Wang wrote:
>> -static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>> +static inline void __percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>>  {
>>  	unsigned long __percpu *percpu_count;
>>  
>> -	rcu_read_lock_sched();
> 
> So, if we're gonna do this (please read below tho), please add the
> matching assertion

Yes, I will.

> 
>>  	if (__ref_is_percpu(ref, &percpu_count))
>>  		this_cpu_add(*percpu_count, nr);
>>  	else
>>  		atomic_long_add(nr, &ref->count);
>> +}
>>  
>> +/**
>> + * percpu_ref_get_many - increment a percpu refcount
>> + * @ref: percpu_ref to get
>> + * @nr: number of references to get
>> + *
>> + * Analogous to atomic_long_add().
>> + *
>> + * This function is safe to call as long as @ref is between init and exit.
>> + */
>> +static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>> +{
>> +	rcu_read_lock_sched();
>> +	__percpu_ref_get_many(ref, nr);
>>  	rcu_read_unlock_sched();
>>  }
> 
> And add the matching variant for get/put with and without _many.

Yes.

> 
> Ming, so, if we make locking explicit like above, I think it should be
> fine to share the locking.  However, please note that percpu_ref and
> blk_mq are using different types of RCU, at least for now, and I'm not
> really sure that unifying that and taking out one rcu read lock/unlock
> is a meaningful optimization.
> 

Essentially, I want to rework the current queue freeze which depends on
percpu_ref_kil/reinit. We implement our own condition checking instead of
using the __PERCPU_REF_DEAD checking in percpu_ref_tryget_live. And use
percpu with percpu_ref_switch_to_atomic/percpu to switch the percpu ref
mode between percpu and atimic directly. Then it will be more convenient
to implement:
 - unfreeze the queue without draining requests.
 - check whether q->q_usage_counter is zero
 - add other gate conditions into blk_queue_enter, such as preempt-only

So I want to put the condition checking and percpu_ref_get_many into a
same sched rcu critical section.
 rcu_read_lock_sched()
   if condition check true
     percpu_ref_get_many(&q->q_usage_counter, 1)
   else
     goto wait
   rcu_read_unlock_sched()

Then we could freeze the queue like:
  set FROZEN flag on q
  percpu_ref_put(1)
  percpu_ref_switch_to_atomic
Otherwise, we may need a synchronize_rcu.
It is not for performance.

Is there any reason that why blk_queue_enter only could use rcu lock instead of
the sched rcu lock ?


> Let's please first do something straight-forward.  If somebody can
> show that this actually impacts performance, we can optimize it but
> right now all these seem premature to me.

Adding this interface is just for saving an extra rcu_read_lock/unlock_sched pair.
If it doesn't make any sense, It is OK for me to discard it. :)

Thanks
Jianchao
