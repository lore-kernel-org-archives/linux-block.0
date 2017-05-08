Return-Path: <axboe@kernel.dk>
Subject: Re: Large latency on blk_queue_enter
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1656B440-3ECA-4F2B-B95C-418CF0F347E9@lightnvm.io>
 <20170508122738.GC5696@ming.t460p>
 <76E35BA3-FEC9-46D6-B36F-554F464FA9ED@lightnvm.io>
 <bbe256c2-f9ff-e594-45c9-7f9ac233ee7a@fb.com>
 <E169E488-53EC-468A-9221-DF11F0944298@lightnvm.io>
 <661d4b67-cf0c-a703-331b-ce24d75e782d@fb.com>
 <C6ED0F6F-EEC2-4F2A-A498-34B0882BA924@lightnvm.io>
 <a088cc3d-7d85-98bf-e7a4-93368cadd238@fb.com>
 <375D00C3-8B76-40FA-BB81-69829270BF5A@lightnvm.io>
 <576f9601-b0de-c636-8195-07e12fe99734@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, linux-block@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <991bbc1d-1849-94d9-5787-69a630e7e10d@kernel.dk>
Date: Mon, 8 May 2017 09:14:22 -0600
MIME-Version: 1.0
In-Reply-To: <576f9601-b0de-c636-8195-07e12fe99734@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/08/2017 09:08 AM, Jens Axboe wrote:
> On 05/08/2017 09:02 AM, Javier González wrote:
>>> On 8 May 2017, at 16.52, Jens Axboe <axboe@fb.com> wrote:
>>>
>>> On 05/08/2017 08:46 AM, Javier González wrote:
>>>>> On 8 May 2017, at 16.23, Jens Axboe <axboe@fb.com> wrote:
>>>>>
>>>>> On 05/08/2017 08:20 AM, Javier González wrote:
>>>>>>> On 8 May 2017, at 16.13, Jens Axboe <axboe@fb.com> wrote:
>>>>>>>
>>>>>>> On 05/08/2017 07:44 AM, Javier González wrote:
>>>>>>>>> On 8 May 2017, at 14.27, Ming Lei <ming.lei@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On Mon, May 08, 2017 at 01:54:58PM +0200, Javier González wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> I find an unusual added latency(~20-30ms) on blk_queue_enter when
>>>>>>>>>> allocating a request directly from the NVMe driver through
>>>>>>>>>> nvme_alloc_request. I could use some help confirming that this is a bug
>>>>>>>>>> and not an expected side effect due to something else.
>>>>>>>>>>
>>>>>>>>>> I can reproduce this latency consistently on LightNVM when mixing I/O
>>>>>>>>>> from pblk and I/O sent through an ioctl using liblightnvm, but I don't
>>>>>>>>>> see anything on the LightNVM side that could impact the request
>>>>>>>>>> allocation.
>>>>>>>>>>
>>>>>>>>>> When I have a 100% read workload sent from pblk, the max. latency is
>>>>>>>>>> constant throughout several runs at ~80us (which is normal for the media
>>>>>>>>>> we are using at bs=4k, qd=1). All pblk I/Os reach the nvme_nvm_submit_io
>>>>>>>>>> function on lightnvm.c., which uses nvme_alloc_request. When we send a
>>>>>>>>>> command from user space through an ioctl, then the max latency goes up
>>>>>>>>>> to ~20-30ms. This happens independently from the actual command
>>>>>>>>>> (IN/OUT). I tracked down the added latency down to the call
>>>>>>>>>> percpu_ref_tryget_live in blk_queue_enter. Seems that the queue
>>>>>>>>>> reference counter is not released as it should through blk_queue_exit in
>>>>>>>>>> blk_mq_alloc_request. For reference, all ioctl I/Os reach the
>>>>>>>>>> nvme_nvm_submit_user_cmd on lightnvm.c
>>>>>>>>>>
>>>>>>>>>> Do you have any idea about why this might happen? I can dig more into
>>>>>>>>>> it, but first I wanted to make sure that I am not missing any obvious
>>>>>>>>>> assumption, which would explain the reference counter to be held for a
>>>>>>>>>> longer time.
>>>>>>>>>
>>>>>>>>> You need to check if the .q_usage_counter is working at atomic mode.
>>>>>>>>> This counter is initialized as atomic mode, and finally switchs to
>>>>>>>>> percpu mode via percpu_ref_switch_to_percpu() in blk_register_queue().
>>>>>>>>
>>>>>>>> Thanks for commenting Ming.
>>>>>>>>
>>>>>>>> The .q_usage_counter is not working on atomic mode. The queue is
>>>>>>>> initialized normally through blk_register_queue() and the counter is
>>>>>>>> switched to percpu mode, as you mentioned. As I understand it, this is
>>>>>>>> how it should be, right?
>>>>>>>
>>>>>>> That is how it should be, yes. You're not running with any heavy
>>>>>>> debugging options, like lockdep or anything like that?
>>>>>>
>>>>>> No lockdep, KASAN, kmemleak or any of the other usual suspects.
>>>>>>
>>>>>> What's interesting is that it only happens when one of the I/Os comes
>>>>>> from user space through the ioctl. If I have several pblk instances on
>>>>>> the same device (which would end up allocating a new request in
>>>>>> parallel, potentially on the same core), the latency spike does not
>>>>>> trigger.
>>>>>>
>>>>>> I also tried to bind the read thread and the liblightnvm thread issuing
>>>>>> the ioctl to different cores, but it does not help...
>>>>>
>>>>> How do I reproduce this? Off the top of my head, and looking at the code,
>>>>> I have no idea what is going on here.
>>>>
>>>> Using LightNVM and liblightnvm [1] you can reproduce it by:
>>>>
>>>> 1. Instantiate a pblk instance on the first channel (luns 0 - 7):
>>>>        sudo nvme lnvm create -d nvme0n1 -n test0 -t pblk -b 0 -e 7 -f
>>>> 2. Write 5GB to the test0 block device with a normal fio script
>>>> 3. Read 5GB to verify that latencies are good (max. ~80-90us at bs=4k, qd=1)
>>>> 4. Re-run 3. and in parallel send a command through liblightnvm to a
>>>> different channel. A simple command is an erase (erase block 900 on
>>>> channel 2, lun 0):
>>>> 	sudo nvm_vblk line_erase /dev/nvme0n1 2 2 0 0 900
>>>>
>>>> After 4. you should see a ~25-30ms latency on the read workload.
>>>>
>>>> I tried to reproduce the ioctl in a more generic way to reach
>>>> __nvme_submit_user_cmd(), but SPDK steals the whole device. Also, qemu
>>>> is not reliable for this kind of performance testing.
>>>>
>>>> If you have a suggestion on how I can mix an ioctl with normal block I/O
>>>> read on a standard NVMe device, I'm happy to try it and see if I can
>>>> reproduce the issue.
>>>
>>> Just to rule out this being any hardware related delays in processing
>>> IO:
>>>
>>> 1) Does it reproduce with a simpler command, anything close to a no-op
>>>   that you can test?
>>
>> Yes. I tried with a 4KB read and with a fake command I drop right after
>> allocation.
>>
>>> 2) What did you use to time the stall being blk_queue_enter()?
>>>
>>
>> I have some debug code measuring time with ktime_get() in different
>> places in the stack, and among other places, around blk_queue_enter(). I
>> use them then to measure max latency and expose it through sysfs. I can
>> see that the latency peak is recorded in the probe before
>> blk_queue_enter() and not in the one after.
>>
>> I also did an experiment, where the normal I/O path allocates the
>> request with BLK_MQ_REQ_NOWAIT. When running the experiment above, the
>> read test fails since we reach:
>> 	if (nowait)
>> 	  return -EBUSY;
>>
>> in blk_queue_enter.
> 
> OK, that's starting to make more sense, that indicates that there is indeed
> something wrong with the refs. Does the below help?

No, that can't be right, it does look balanced to begin with.
blk_mq_alloc_request() always grabs a queue ref, and always drops it. If
we return with a request succesfully allocated, then we have an extra
ref on it, which is dropped when it is later freed. Something smells
fishy, I'll dig a bit.

-- 
Jens Axboe
