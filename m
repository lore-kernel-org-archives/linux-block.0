Subject: Re: Large latency on blk_queue_enter
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1656B440-3ECA-4F2B-B95C-418CF0F347E9@lightnvm.io>
 <20170508122738.GC5696@ming.t460p>
 <76E35BA3-FEC9-46D6-B36F-554F464FA9ED@lightnvm.io>
 <bbe256c2-f9ff-e594-45c9-7f9ac233ee7a@fb.com>
 <E169E488-53EC-468A-9221-DF11F0944298@lightnvm.io>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, linux-block@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <661d4b67-cf0c-a703-331b-ce24d75e782d@fb.com>
Date: Mon, 8 May 2017 08:23:36 -0600
MIME-Version: 1.0
In-Reply-To: <E169E488-53EC-468A-9221-DF11F0944298@lightnvm.io>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/08/2017 08:20 AM, Javier Gonz�lez wrote:
>> On 8 May 2017, at 16.13, Jens Axboe <axboe@fb.com> wrote:
>>
>> On 05/08/2017 07:44 AM, Javier Gonz�lez wrote:
>>>> On 8 May 2017, at 14.27, Ming Lei <ming.lei@redhat.com> wrote:
>>>>
>>>> On Mon, May 08, 2017 at 01:54:58PM +0200, Javier Gonz�lez wrote:
>>>>> Hi,
>>>>>
>>>>> I find an unusual added latency(~20-30ms) on blk_queue_enter when
>>>>> allocating a request directly from the NVMe driver through
>>>>> nvme_alloc_request. I could use some help confirming that this is a bug
>>>>> and not an expected side effect due to something else.
>>>>>
>>>>> I can reproduce this latency consistently on LightNVM when mixing I/O
>>>>> from pblk and I/O sent through an ioctl using liblightnvm, but I don't
>>>>> see anything on the LightNVM side that could impact the request
>>>>> allocation.
>>>>>
>>>>> When I have a 100% read workload sent from pblk, the max. latency is
>>>>> constant throughout several runs at ~80us (which is normal for the media
>>>>> we are using at bs=4k, qd=1). All pblk I/Os reach the nvme_nvm_submit_io
>>>>> function on lightnvm.c., which uses nvme_alloc_request. When we send a
>>>>> command from user space through an ioctl, then the max latency goes up
>>>>> to ~20-30ms. This happens independently from the actual command
>>>>> (IN/OUT). I tracked down the added latency down to the call
>>>>> percpu_ref_tryget_live in blk_queue_enter. Seems that the queue
>>>>> reference counter is not released as it should through blk_queue_exit in
>>>>> blk_mq_alloc_request. For reference, all ioctl I/Os reach the
>>>>> nvme_nvm_submit_user_cmd on lightnvm.c
>>>>>
>>>>> Do you have any idea about why this might happen? I can dig more into
>>>>> it, but first I wanted to make sure that I am not missing any obvious
>>>>> assumption, which would explain the reference counter to be held for a
>>>>> longer time.
>>>>
>>>> You need to check if the .q_usage_counter is working at atomic mode.
>>>> This counter is initialized as atomic mode, and finally switchs to
>>>> percpu mode via percpu_ref_switch_to_percpu() in blk_register_queue().
>>>
>>> Thanks for commenting Ming.
>>>
>>> The .q_usage_counter is not working on atomic mode. The queue is
>>> initialized normally through blk_register_queue() and the counter is
>>> switched to percpu mode, as you mentioned. As I understand it, this is
>>> how it should be, right?
>>
>> That is how it should be, yes. You're not running with any heavy
>> debugging options, like lockdep or anything like that?
> 
> No lockdep, KASAN, kmemleak or any of the other usual suspects.
> 
> What's interesting is that it only happens when one of the I/Os comes
> from user space through the ioctl. If I have several pblk instances on
> the same device (which would end up allocating a new request in
> parallel, potentially on the same core), the latency spike does not
> trigger.
> 
> I also tried to bind the read thread and the liblightnvm thread issuing
> the ioctl to different cores, but it does not help...

How do I reproduce this? Off the top of my head, and looking at the code,
I have no idea what is going on here.

-- 
Jens Axboe
