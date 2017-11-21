Return-Path: <borntraeger@de.ibm.com>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>,
        "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com"
 <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <9c5eec5d-f542-4d76-6933-6fe31203ce09@de.ibm.com>
 <1511205644.2396.32.camel@wdc.com>
 <04526c98-ffc5-1eca-3aa8-50f9212c4323@de.ibm.com>
 <5c9f2228-0a8b-8225-7038-e6cb3f31ca0b@kernel.dk>
 <2e44dbd3-2f90-c267-560c-91d1d4b0e892@de.ibm.com>
 <823b9dd5-7781-5a72-03ff-bc931433fc19@kernel.dk>
 <bd928410-4d38-603e-00c9-4c4db20d8e86@de.ibm.com>
 <15f232d2-2aaa-df7c-57e8-2f710e051e84@de.ibm.com>
Date: Tue, 21 Nov 2017 11:14:34 +0100
MIME-Version: 1.0
In-Reply-To: <15f232d2-2aaa-df7c-57e8-2f710e051e84@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <c8bd769e-9742-205d-11b0-469428a8579c@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 11/21/2017 10:50 AM, Christian Borntraeger wrote:
> 
> 
> On 11/21/2017 09:35 AM, Christian Borntraeger wrote:
>>
>>
>> On 11/20/2017 09:52 PM, Jens Axboe wrote:
>>> On 11/20/2017 01:49 PM, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 11/20/2017 08:42 PM, Jens Axboe wrote:
>>>>> On 11/20/2017 12:29 PM, Christian Borntraeger wrote:
>>>>>>
>>>>>>
>>>>>> On 11/20/2017 08:20 PM, Bart Van Assche wrote:
>>>>>>> On Fri, 2017-11-17 at 15:42 +0100, Christian Borntraeger wrote:
>>>>>>>> This is 
>>>>>>>>
>>>>>>>> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1141)     * are mapped to it.
>>>>>>>> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1142)     */
>>>>>>>> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1143)    WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
>>>>>>>> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1144)            cpu_online(hctx->next_cpu));
>>>>>>>> 6a83e74d2 (Bart Van Assche           2016-11-02 10:09:51 -0600 1145) 
>>>>>>>> b7a71e66d (Jens Axboe                2017-08-01 09:28:24 -0600 1146)    /*
>>>>>>>
>>>>>>> Did you really try to figure out when the code that reported the warning
>>>>>>> was introduced? I think that warning was introduced through the following
>>>>>>> commit:
>>>>>>
>>>>>> This was more a cut'n'paste to show which warning triggered since line numbers are somewhat volatile.
>>>>>>
>>>>>>>
>>>>>>> commit fd1270d5df6a005e1248e87042159a799cc4b2c9
>>>>>>> Date:   Wed Apr 16 09:23:48 2014 -0600
>>>>>>>
>>>>>>>     blk-mq: don't use preempt_count() to check for right CPU
>>>>>>>      
>>>>>>>     UP or CONFIG_PREEMPT_NONE will return 0, and what we really
>>>>>>>     want to check is whether or not we are on the right CPU.
>>>>>>>     So don't make PREEMPT part of this, just test the CPU in
>>>>>>>     the mask directly.
>>>>>>>
>>>>>>> Anyway, I think that warning is appropriate and useful. So the next step
>>>>>>> is to figure out what work item was involved and why that work item got
>>>>>>> executed on the wrong CPU.
>>>>>>
>>>>>> It seems to be related to virtio-blk (is triggered by fio on such disks). Your comment basically
>>>>>> says: "no this is not a known issue" then :-)
>>>>>> I will try to take a dump to find out the work item
>>>>>
>>>>> blk-mq does not attempt to freeze/sync existing work if a CPU goes away,
>>>>> and we reconfigure the mappings. So I don't think the above is unexpected,
>>>>> if you are doing CPU hot unplug while running a fio job.
>>>>
>>>> I did a cpu hot plug (adding a CPU) and I started fio AFTER that.
>>>
>>> OK, that's different, we should not be triggering a warning for that.
>>> What does your machine/virtblk topology look like in terms of CPUS,
>>> nr of queues for virtblk, etc?
>>
>> FWIW, 4.11 does work, 4.12 and later is broken.
> 
> In fact: 4.12 is fine, 4.12.14 is broken.


Bisect points to

1b5a7455d345b223d3a4658a9e5fce985b7998c1 is the first bad commit
commit 1b5a7455d345b223d3a4658a9e5fce985b7998c1
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jun 26 12:20:57 2017 +0200

    blk-mq: Create hctx for each present CPU
    
    commit 4b855ad37194f7bdbb200ce7a1c7051fecb56a08 upstream.
    
    Currently we only create hctx for online CPUs, which can lead to a lot
    of churn due to frequent soft offline / online operations.  Instead
    allocate one for each present CPU to avoid this and dramatically simplify
    the code.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Jens Axboe <axboe@kernel.dk>
    Cc: Keith Busch <keith.busch@intel.com>
    Cc: linux-block@vger.kernel.org
    Cc: linux-nvme@lists.infradead.org
    Link: http://lkml.kernel.org/r/20170626102058.10200-3-hch@lst.de
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
    Cc: Mike Galbraith <efault@gmx.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:040000 040000 a61cb023014a7b7a6b9f24ea04fe8ab22299e706 059ba6dc3290c74e0468937348e580cd53f963e7 M	block
:040000 040000 432e719d7e738ffcddfb8fc964544d3b3e0a68f7 f4572aa21b249a851a1b604c148eea109e93b30d M	include





adding Christoph FWIW, your patch triggers the following on 4.14 when doing a cpu hotplug (adding a
CPU) and then accessing a virtio-blk device.


  747.652408] ------------[ cut here ]------------
[  747.652410] WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 __blk_mq_run_hw_queue+0xd4/0x100
[  747.652410] Modules linked in: dm_multipath
[  747.652412] CPU: 4 PID: 2895 Comm: kworker/4:1H Tainted: G        W       4.14.0+ #191
[  747.652412] Hardware name: IBM 2964 NC9 704 (KVM/Linux)
[  747.652414] Workqueue: kblockd blk_mq_run_work_fn
[  747.652414] task: 0000000060680000 task.stack: 000000005ea30000
[  747.652415] Krnl PSW : 0704f00180000000 0000000000505864 (__blk_mq_run_hw_queue+0xd4/0x100)
[  747.652417]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
[  747.652417] Krnl GPRS: 0000000000000010 00000000000000ff 000000005cbec400 0000000000000000
[  747.652418]            0000000063709120 0000000000000000 0000000063709500 0000000059fa44b0
[  747.652418]            0000000059fa4480 0000000000000000 000000006370f700 0000000063709100
[  747.652419]            000000005cbec500 0000000000970948 000000005ea33d80 000000005ea33d48
[  747.652423] Krnl Code: 0000000000505854: ebaff0a00004        lmg     %r10,%r15,160(%r15)
           000000000050585a: c0f4ffe690d3       brcl    15,1d7a00
          #0000000000505860: a7f40001           brc     15,505862
          >0000000000505864: 581003b0           l       %r1,944
           0000000000505868: c01b001fff00       nilf    %r1,2096896
           000000000050586e: a784ffdb           brc     8,505824
           0000000000505872: a7f40001           brc     15,505874
           0000000000505876: 9120218f           tm      399(%r2),32
[  747.652435] Call Trace:
[  747.652435] ([<0000000063709600>] 0x63709600)
[  747.652436]  [<0000000000187bcc>] process_one_work+0x264/0x4b8 
[  747.652438]  [<0000000000187e78>] worker_thread+0x58/0x4f8 
[  747.652439]  [<000000000018ee94>] kthread+0x144/0x168 
[  747.652439]  [<00000000008f8a62>] kernel_thread_starter+0x6/0xc 
[  747.652440]  [<00000000008f8a5c>] kernel_thread_starter+0x0/0xc 
[  747.652440] Last Breaking-Event-Address:
[  747.652441]  [<0000000000505860>] __blk_mq_run_hw_queue+0xd0/0x100
[  747.652442] ---[ end trace 4a001a80379b18ba ]---
[  747.652450] ------------[ cut here ]------------
