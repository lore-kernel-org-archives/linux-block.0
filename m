Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 0/3] Introduce a light-weight queue close feature
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, keith.busch@intel.com, jsmart2021@gmail.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        jthumshirn@suse.de, bart.vanassche@wdc.com
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180905212659.GB21352@ming.t460p>
 <b7074098-ab79-53b2-5cc6-25f859c4c666@oracle.com>
 <20180906125659.GA31250@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <51b4019b-8773-b76d-ee00-4399a86dbf16@oracle.com>
Date: Thu, 6 Sep 2018 21:55:21 +0800
MIME-Version: 1.0
In-Reply-To: <20180906125659.GA31250@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 09/06/2018 08:57 PM, Ming Lei wrote:
> On Thu, Sep 06, 2018 at 09:51:43AM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 09/06/2018 05:27 AM, Ming Lei wrote:
>>> On Wed, Sep 05, 2018 at 12:09:43PM +0800, Jianchao Wang wrote:
>>>> Dear all
>>>>
>>>> As we know, queue freeze is used to stop new IO comming in and drain
>>>> the request queue. And the draining queue here is necessary, because
>>>> queue freeze kills the percpu-ref q_usage_counter and need to drain
>>>> the q_usage_counter before switch it back to percpu mode. This could
>>>> be a trouble when we just want to prevent new IO.
>>>>
>>>> In nvme-pci, nvme_dev_disable freezes queues to prevent new IO.
>>>> nvme_reset_work will unfreeze and wait to drain the queues. However,
>>>> if IO timeout at the moment, no body could do recovery as nvme_reset_work
>>>> is waiting. We will encounter IO hang.
>>>
>>> As we discussed this nvme time issue before, I have pointed out that
>>> this is because of blk_mq_unfreeze_queue()'s limit which requires that
>>> unfreeze can only be done when this queue ref counter drops to zero.
>>>
>>> For this nvme timeout case, we may relax the limit, for example,
>>> introducing another API of blk_freeze_queue_stop() as counter-pair of
>>> blk_freeze_queue_start(), and simply switch the percpu-ref to percpu mode
>>> from atomic mode inside the new API.
>>
>> Looks like we cannot switch a percpu-ref to percpu mode directly w/o drain it.
>> Some references maybe lost.
>>
>> static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
>> {
>> 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
>> 	int cpu;
>>
>> 	BUG_ON(!percpu_count);
>>
>> 	if (!(ref->percpu_count_ptr & __PERCPU_REF_ATOMIC))
>> 		return;
>>
>> 	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
>>
>> 	/*
>> 	 * Restore per-cpu operation.  smp_store_release() is paired
>> 	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
>> 	 * zeroing is visible to all percpu accesses which can see the
>> 	 * following __PERCPU_REF_ATOMIC clearing.i
>> 	 */
>> 	for_each_possible_cpu(cpu)
>> 		*per_cpu_ptr(percpu_count, cpu) = 0;
>>
>> 	smp_store_release(&ref->percpu_count_ptr,
>> 			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);
> 
> Before REF_ATOMIC is cleared, all counting is done on the atomic type
> of &ref->count, and it is easy to keep the reference counter at
> ATOMIC mode. Also the reference counter can only be READ at atomic mode.
> 
> So could you explain a bit how the lost may happen? And it is lost at
> atomic mode or percpu mode?

I just mean __percpu_ref_switch_percpu just zeros the percpu_count.
It doesn't give the original values back to the percpu_count from atomic count

> 
>> }
>>
>>>
>>>>
>>>> So introduce a light-weight queue close feature in this patch set
>>>> which could prevent new IO and needn't drain the queue.
>>>
>>> Frankly speaking, IMO, it may not be an good idea to mess up the fast path
>>> just for handling the extremely unusual timeout event. The same is true
>>> for doing the preemp only stuff, as you saw I have posted patchset for
>>> killing it.
>>>
>>
>> In normal case, it is just a judgment like 
>>
>> 	if (unlikely(READ_ONCE(q->queue_gate))
>>
>> It should not be a big deal.> 
> Adding this stuff in fast path is quite difficult to verify its correctness
> because it is really lockless, or even barrier-less.
> 
> Not to mention, READ_ONCE() implies one barrier of smp_read_barrier_depends().

The checking is under rcu lock, the write side could use synchonize_rcu to ensure
the updating is globally visible.t
As for the READ_ONCE, it could be discarded.

Thanks
Jianchao
> 
> Thanks,
> Ming
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=BQVCMSSS6lYwogr6CE82oIlpLu5ReP8c4lHGgnvswV4&s=rZLfbqzKKXjlCpY1Sy6ocaQjAKZoJq_A49gvSucohNk&e=
> 
