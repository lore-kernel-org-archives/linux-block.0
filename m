Return-Path: <axboe@kernel.dk>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Bart Van Assche <Bart.VanAssche@wdc.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <9c5eec5d-f542-4d76-6933-6fe31203ce09@de.ibm.com>
 <1511205644.2396.32.camel@wdc.com>
 <04526c98-ffc5-1eca-3aa8-50f9212c4323@de.ibm.com>
 <5c9f2228-0a8b-8225-7038-e6cb3f31ca0b@kernel.dk>
 <2e44dbd3-2f90-c267-560c-91d1d4b0e892@de.ibm.com>
 <823b9dd5-7781-5a72-03ff-bc931433fc19@kernel.dk>
 <bd928410-4d38-603e-00c9-4c4db20d8e86@de.ibm.com>
 <15f232d2-2aaa-df7c-57e8-2f710e051e84@de.ibm.com>
 <c8bd769e-9742-205d-11b0-469428a8579c@de.ibm.com>
 <b7b3cf4b-837e-f9ba-61c0-4f9ddd8b9a95@kernel.dk>
 <055f040d-3f9a-a8fd-e8e2-326c6b9094a1@kernel.dk>
 <1aeecf2e-a68e-4c18-5912-2473f457e6ea@de.ibm.com>
 <8fedc2ad-d775-7789-742c-92ca928a3aee@kernel.dk>
 <ebf96f76-3f53-283d-042d-8ea3f5eddb3d@kernel.dk>
 <ba994ec6-8db6-f77e-ac73-92e3f6b0135a@de.ibm.com>
 <ae02b9c5-9a2e-cb8b-7828-475b3c0b1cb9@kernel.dk>
 <c438db5f-f4f1-69f8-37f3-e91eae29fa25@de.ibm.com>
 <d8dbde03-f528-1cac-03dd-bcc724fcd5c8@kernel.dk>
 <276625a9-44fb-719d-9281-caacefdbb99f@de.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eceae481-cf9a-0429-7a15-c363a8e7bc2a@kernel.dk>
Date: Tue, 21 Nov 2017 13:21:08 -0700
MIME-Version: 1.0
In-Reply-To: <276625a9-44fb-719d-9281-caacefdbb99f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/21/2017 01:19 PM, Christian Borntraeger wrote:
> 
> On 11/21/2017 09:14 PM, Jens Axboe wrote:
>> On 11/21/2017 01:12 PM, Christian Borntraeger wrote:
>>>
>>>
>>> On 11/21/2017 08:30 PM, Jens Axboe wrote:
>>>> On 11/21/2017 12:15 PM, Christian Borntraeger wrote:
>>>>>
>>>>>
>>>>> On 11/21/2017 07:39 PM, Jens Axboe wrote:
>>>>>> On 11/21/2017 11:27 AM, Jens Axboe wrote:
>>>>>>> On 11/21/2017 11:12 AM, Christian Borntraeger wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 11/21/2017 07:09 PM, Jens Axboe wrote:
>>>>>>>>> On 11/21/2017 10:27 AM, Jens Axboe wrote:
>>>>>>>>>> On 11/21/2017 03:14 AM, Christian Borntraeger wrote:
>>>>>>>>>>> Bisect points to
>>>>>>>>>>>
>>>>>>>>>>> 1b5a7455d345b223d3a4658a9e5fce985b7998c1 is the first bad commit
>>>>>>>>>>> commit 1b5a7455d345b223d3a4658a9e5fce985b7998c1
>>>>>>>>>>> Author: Christoph Hellwig <hch@lst.de>
>>>>>>>>>>> Date:   Mon Jun 26 12:20:57 2017 +0200
>>>>>>>>>>>
>>>>>>>>>>>     blk-mq: Create hctx for each present CPU
>>>>>>>>>>>     
>>>>>>>>>>>     commit 4b855ad37194f7bdbb200ce7a1c7051fecb56a08 upstream.
>>>>>>>>>>>     
>>>>>>>>>>>     Currently we only create hctx for online CPUs, which can lead to a lot
>>>>>>>>>>>     of churn due to frequent soft offline / online operations.  Instead
>>>>>>>>>>>     allocate one for each present CPU to avoid this and dramatically simplify
>>>>>>>>>>>     the code.
>>>>>>>>>>>     
>>>>>>>>>>>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>>>>>>>>>     Reviewed-by: Jens Axboe <axboe@kernel.dk>
>>>>>>>>>>>     Cc: Keith Busch <keith.busch@intel.com>
>>>>>>>>>>>     Cc: linux-block@vger.kernel.org
>>>>>>>>>>>     Cc: linux-nvme@lists.infradead.org
>>>>>>>>>>>     Link: http://lkml.kernel.org/r/20170626102058.10200-3-hch@lst.de
>>>>>>>>>>>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>>>>>>>>>>     Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
>>>>>>>>>>>     Cc: Mike Galbraith <efault@gmx.de>
>>>>>>>>>>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>>>>>
>>>>>>>>>> I wonder if we're simply not getting the masks updated correctly. I'll
>>>>>>>>>> take a look.
>>>>>>>>>
>>>>>>>>> Can't make it trigger here. We do init for each present CPU, which means
>>>>>>>>> that if I offline a few CPUs here and register a queue, those still show
>>>>>>>>> up as present (just offline) and get mapped accordingly.
>>>>>>>>>
>>>>>>>>> From the looks of it, your setup is different. If the CPU doesn't show
>>>>>>>>> up as present and it gets hotplugged, then I can see how this condition
>>>>>>>>> would trigger. What environment are you running this in? We might have
>>>>>>>>> to re-introduce the cpu hotplug notifier, right now we just monitor
>>>>>>>>> for a dead cpu and handle that.
>>>>>>>>
>>>>>>>> I am not doing a hot unplug and the replug, I use KVM and add a previously
>>>>>>>> not available CPU.
>>>>>>>>
>>>>>>>> in libvirt/virsh speak:
>>>>>>>>   <vcpu placement='static' current='1'>4</vcpu>
>>>>>>>
>>>>>>> So that's why we run into problems. It's not present when we load the device,
>>>>>>> but becomes present and online afterwards.
>>>>>>>
>>>>>>> Christoph, we used to handle this just fine, your patch broke it.
>>>>>>>
>>>>>>> I'll see if I can come up with an appropriate fix.
>>>>>>
>>>>>> Can you try the below?
>>>>>
>>>>>
>>>>> It does prevent the crash but it seems that the new CPU is not "used " after the hotplug for mq:
>>>>>
>>>>>
>>>>> output with 2 cpus:
>>>>> /sys/kernel/debug/block/vda
>>>>> /sys/kernel/debug/block/vda/hctx0
>>>>> /sys/kernel/debug/block/vda/hctx0/cpu0
>>>>> /sys/kernel/debug/block/vda/hctx0/cpu0/completed
>>>>> /sys/kernel/debug/block/vda/hctx0/cpu0/merged
>>>>> /sys/kernel/debug/block/vda/hctx0/cpu0/dispatched
>>>>> /sys/kernel/debug/block/vda/hctx0/cpu0/rq_list
>>>>> /sys/kernel/debug/block/vda/hctx0/active
>>>>> /sys/kernel/debug/block/vda/hctx0/run
>>>>> /sys/kernel/debug/block/vda/hctx0/queued
>>>>> /sys/kernel/debug/block/vda/hctx0/dispatched
>>>>> /sys/kernel/debug/block/vda/hctx0/io_poll
>>>>> /sys/kernel/debug/block/vda/hctx0/sched_tags_bitmap
>>>>> /sys/kernel/debug/block/vda/hctx0/sched_tags
>>>>> /sys/kernel/debug/block/vda/hctx0/tags_bitmap
>>>>> /sys/kernel/debug/block/vda/hctx0/tags
>>>>> /sys/kernel/debug/block/vda/hctx0/ctx_map
>>>>> /sys/kernel/debug/block/vda/hctx0/busy
>>>>> /sys/kernel/debug/block/vda/hctx0/dispatch
>>>>> /sys/kernel/debug/block/vda/hctx0/flags
>>>>> /sys/kernel/debug/block/vda/hctx0/state
>>>>> /sys/kernel/debug/block/vda/sched
>>>>> /sys/kernel/debug/block/vda/sched/dispatch
>>>>> /sys/kernel/debug/block/vda/sched/starved
>>>>> /sys/kernel/debug/block/vda/sched/batching
>>>>> /sys/kernel/debug/block/vda/sched/write_next_rq
>>>>> /sys/kernel/debug/block/vda/sched/write_fifo_list
>>>>> /sys/kernel/debug/block/vda/sched/read_next_rq
>>>>> /sys/kernel/debug/block/vda/sched/read_fifo_list
>>>>> /sys/kernel/debug/block/vda/write_hints
>>>>> /sys/kernel/debug/block/vda/state
>>>>> /sys/kernel/debug/block/vda/requeue_list
>>>>> /sys/kernel/debug/block/vda/poll_stat
>>>>
>>>> Try this, basically just a revert.
>>>
>>> Yes, seems to work.
>>>
>>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>
>> Great, thanks for testing.
>>
>>> Do you know why the original commit made it into 4.12 stable? After all
>>> it has no Fixes tag and no cc stable-
>>
>> I was wondering the same thing when you said it was in 4.12.stable and
>> not in 4.12 release. That patch should absolutely not have gone into
>> stable, it's not marked as such and it's not fixing a problem that is
>> stable worthy. In fact, it's causing a regression...
>>
>> Greg? Upstream commit is mentioned higher up, start of the email.
>>
> 
> 
> Forgot to cc Greg?

I did, thanks for doing that. Now I wonder how to mark this patch,
as we should revert it from kernels that have the bad commit. 4.12
is fine, 4.12.later-stable is not.

-- 
Jens Axboe
