Return-Path: <axboe@kernel.dk>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Bart Van Assche <Bart.VanAssche@wdc.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <9c5eec5d-f542-4d76-6933-6fe31203ce09@de.ibm.com>
 <1511205644.2396.32.camel@wdc.com>
 <04526c98-ffc5-1eca-3aa8-50f9212c4323@de.ibm.com>
 <5c9f2228-0a8b-8225-7038-e6cb3f31ca0b@kernel.dk>
 <2e44dbd3-2f90-c267-560c-91d1d4b0e892@de.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <823b9dd5-7781-5a72-03ff-bc931433fc19@kernel.dk>
Date: Mon, 20 Nov 2017 13:52:14 -0700
MIME-Version: 1.0
In-Reply-To: <2e44dbd3-2f90-c267-560c-91d1d4b0e892@de.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/20/2017 01:49 PM, Christian Borntraeger wrote:
> 
> 
> On 11/20/2017 08:42 PM, Jens Axboe wrote:
>> On 11/20/2017 12:29 PM, Christian Borntraeger wrote:
>>>
>>>
>>> On 11/20/2017 08:20 PM, Bart Van Assche wrote:
>>>> On Fri, 2017-11-17 at 15:42 +0100, Christian Borntraeger wrote:
>>>>> This is 
>>>>>
>>>>> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1141)     * are mapped to it.
>>>>> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1142)     */
>>>>> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1143)    WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
>>>>> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1144)            cpu_online(hctx->next_cpu));
>>>>> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1145) 
>>>>> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1146)    /*
>>>>
>>>> Did you really try to figure out when the code that reported the warning
>>>> was introduced? I think that warning was introduced through the following
>>>> commit:
>>>
>>> This was more a cut'n'paste to show which warning triggered since line numbers are somewhat volatile.
>>>
>>>>
>>>> commit fd1270d5df6a005e1248e87042159a799cc4b2c9
>>>> Date:   Wed Apr 16 09:23:48 2014 -0600
>>>>
>>>>     blk-mq: don't use preempt_count() to check for right CPU
>>>>      
>>>>     UP or CONFIG_PREEMPT_NONE will return 0, and what we really
>>>>     want to check is whether or not we are on the right CPU.
>>>>     So don't make PREEMPT part of this, just test the CPU in
>>>>     the mask directly.
>>>>
>>>> Anyway, I think that warning is appropriate and useful. So the next step
>>>> is to figure out what work item was involved and why that work item got
>>>> executed on the wrong CPU.
>>>
>>> It seems to be related to virtio-blk (is triggered by fio on such disks). Your comment basically
>>> says: "no this is not a known issue" then :-)
>>> I will try to take a dump to find out the work item
>>
>> blk-mq does not attempt to freeze/sync existing work if a CPU goes away,
>> and we reconfigure the mappings. So I don't think the above is unexpected,
>> if you are doing CPU hot unplug while running a fio job.
> 
> I did a cpu hot plug (adding a CPU) and I started fio AFTER that.

OK, that's different, we should not be triggering a warning for that.
What does your machine/virtblk topology look like in terms of CPUS,
nr of queues for virtblk, etc?

You can probably get this info the easiest by just doing a:

# find /sys/kernel/debug/block/virtX

replace virtX with your virtblk device name. Generate this info both
before and after the hotplug event.

>> While it's a bit annoying that we trigger the WARN_ON() for a condition
>> that can happen, we're basically interested in it if it triggers for
>> normal operations.
> 
> I think we should never trigger a WARN_ON on conditions that can
> happen. I know some folks enabling panic_on_warn to detect/avoid data
> integrity issues. FWIW, this also seems to happen wit 4.13 and 4.12

It's not supposed to happen for your case, so I'd say it's been useful.
It's not a critical thing, but it is something that should not trigger
and we need to look into why it did, and fixing it up.

-- 
Jens Axboe
