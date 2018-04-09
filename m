Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751874AbeDIJFu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Apr 2018 05:05:50 -0400
Subject: Re: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
From: Yi Zhang <yi.zhang@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <682acdbe-7624-14d6-36e0-e2dd4c6b771f@grimberg.me>
 <256ebbe9-d932-a826-977b-5a5cb8483755@redhat.com>
 <ebdf8c7f-ae42-a08f-0d79-d2d4f17ec117@grimberg.me>
 <20180408104433.GB29020@ming.t460p> <20180408104801.GC29020@ming.t460p>
 <343d151b-c953-c5d6-0ce6-f08c390ae8aa@grimberg.me>
 <20180408110417.GA19252@ming.t460p>
 <2ed81c04-b5e4-7d87-5311-34975fd67f98@grimberg.me>
 <20180408125735.GA23106@ming.t460p>
 <f5b97687-b8e6-d1f7-1588-0cfa0883f92d@grimberg.me>
 <20180409024722.GC26619@ming.t460p>
 <3760790a-e3c9-73d4-5191-16320f6cdbde@grimberg.me>
 <9eb1d6ba-3994-596f-1b90-38a9b879f416@redhat.com>
Message-ID: <f34c2a61-fac9-71cb-0663-5876196f3ef4@redhat.com>
Date: Mon, 9 Apr 2018 17:05:40 +0800
MIME-Version: 1.0
In-Reply-To: <9eb1d6ba-3994-596f-1b90-38a9b879f416@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 04/09/2018 04:54 PM, Yi Zhang wrote:
>
>
> On 04/09/2018 04:31 PM, Sagi Grimberg wrote:
>>
>>>> My device exposes nr_hw_queues which is not higher than 
>>>> num_online_cpus
>>>> so I want to connect all hctxs with hope that they will be used.
>>>
>>> The issue is that CPU online & offline can happen any time, and after
>>> blk-mq removes CPU hotplug handler, there is no way to remap queue
>>> when CPU topo is changed.
>>>
>>> For example:
>>>
>>> 1) after nr_hw_queues is set as num_online_cpus() and hw queues
>>> are initialized, then some of CPUs become offline, and the issue
>>> reported by Zhang Yi is triggered, but in this case, we should fail
>>> the allocation since 1:1 mapping doesn't need to use this inactive
>>> hw queue.
>>
>> Normal cpu offlining is fine, as the hctxs are already connected. When
>> we reset the controller and re-establish the queues, the issue triggers
>> because we call blk_mq_alloc_request_hctx.
>>
>> The question is, for this particular issue, given that the request
>> execution is guaranteed to run from an online cpu, will the below work?
> Hi Sagi
> Sorry for the late response, bellow patch works, here is the full log:

And this issue cannot be reproduced on 4.15.
So I did bisect testing today, found it was introduced from bellow commit:
bf9ae8c blk-mq: fix bad clear of RQF_MQ_INFLIGHT in blk_mq_ct_ctx_init()

>
> [  117.370832] nvme nvme0: new ctrl: NQN 
> "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.0.90:4420
> [  117.427385] nvme nvme0: creating 40 I/O queues.
> [  117.736806] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.90:4420
> [  122.531891] smpboot: CPU 1 is now offline
> [  122.573007] IRQ 37: no longer affine to CPU2
> [  122.577775] IRQ 54: no longer affine to CPU2
> [  122.582532] IRQ 70: no longer affine to CPU2
> [  122.587300] IRQ 98: no longer affine to CPU2
> [  122.592069] IRQ 140: no longer affine to CPU2
> [  122.596930] IRQ 141: no longer affine to CPU2
> [  122.603166] smpboot: CPU 2 is now offline
> [  122.840577] smpboot: CPU 3 is now offline
> [  125.204901] print_req_error: operation not supported error, dev 
> nvme0n1, sector 143212504
> [  125.204907] print_req_error: operation not supported error, dev 
> nvme0n1, sector 481004984
> [  125.204922] print_req_error: operation not supported error, dev 
> nvme0n1, sector 436594584
> [  125.204924] print_req_error: operation not supported error, dev 
> nvme0n1, sector 461363784
> [  125.204945] print_req_error: operation not supported error, dev 
> nvme0n1, sector 308124792
> [  125.204957] print_req_error: operation not supported error, dev 
> nvme0n1, sector 513395784
> [  125.204959] print_req_error: operation not supported error, dev 
> nvme0n1, sector 432260176
> [  125.204961] print_req_error: operation not supported error, dev 
> nvme0n1, sector 251704096
> [  125.204963] print_req_error: operation not supported error, dev 
> nvme0n1, sector 234819336
> [  125.204966] print_req_error: operation not supported error, dev 
> nvme0n1, sector 181874128
> [  125.938858] nvme nvme0: Reconnecting in 10 seconds...
> [  125.938862] Buffer I/O error on dev nvme0n1, logical block 367355, 
> lost async page write
> [  125.942587] Buffer I/O error on dev nvme0n1, logical block 586, 
> lost async page write
> [  125.942589] Buffer I/O error on dev nvme0n1, logical block 375453, 
> lost async page write
> [  125.942591] Buffer I/O error on dev nvme0n1, logical block 587, 
> lost async page write
> [  125.942592] Buffer I/O error on dev nvme0n1, logical block 588, 
> lost async page write
> [  125.942593] Buffer I/O error on dev nvme0n1, logical block 375454, 
> lost async page write
> [  125.942594] Buffer I/O error on dev nvme0n1, logical block 589, 
> lost async page write
> [  125.942595] Buffer I/O error on dev nvme0n1, logical block 590, 
> lost async page write
> [  125.942596] Buffer I/O error on dev nvme0n1, logical block 591, 
> lost async page write
> [  125.942597] Buffer I/O error on dev nvme0n1, logical block 592, 
> lost async page write
> [  130.205584] print_req_error: 537000 callbacks suppressed
> [  130.205586] print_req_error: I/O error, dev nvme0n1, sector 471135288
> [  130.218763] print_req_error: I/O error, dev nvme0n1, sector 471137240
> [  130.225985] print_req_error: I/O error, dev nvme0n1, sector 471138328
> [  130.233206] print_req_error: I/O error, dev nvme0n1, sector 471140096
> [  130.240433] print_req_error: I/O error, dev nvme0n1, sector 471140184
> [  130.247659] print_req_error: I/O error, dev nvme0n1, sector 471140960
> [  130.254874] print_req_error: I/O error, dev nvme0n1, sector 471141864
> [  130.262095] print_req_error: I/O error, dev nvme0n1, sector 471143296
> [  130.269317] print_req_error: I/O error, dev nvme0n1, sector 471143776
> [  130.276537] print_req_error: I/O error, dev nvme0n1, sector 471144224
> [  132.954315] nvme nvme0: Identify namespace failed
> [  132.959698] buffer_io_error: 3801549 callbacks suppressed
> [  132.959699] Buffer I/O error on dev nvme0n1, logical block 0, async 
> page read
> [  132.974669] Buffer I/O error on dev nvme0n1, logical block 0, async 
> page read
> [  132.983078] Buffer I/O error on dev nvme0n1, logical block 0, async 
> page read
> [  132.991476] Buffer I/O error on dev nvme0n1, logical block 0, async 
> page read
> [  132.999859] Buffer I/O error on dev nvme0n1, logical block 0, async 
> page read
> [  133.008217] Buffer I/O error on dev nvme0n1, logical block 0, async 
> page read
> [  133.016575] Dev nvme0n1: unable to read RDB block 0
> [  133.022423] Buffer I/O error on dev nvme0n1, logical block 0, async 
> page read
> [  133.030800] Buffer I/O error on dev nvme0n1, logical block 0, async 
> page read
> [  133.039151]  nvme0n1: unable to read partition table
> [  133.050221] Buffer I/O error on dev nvme0n1, logical block 
> 65535984, async page read
> [  133.060154] Buffer I/O error on dev nvme0n1, logical block 
> 65535984, async page read
> [  136.334516] nvme nvme0: creating 37 I/O queues.
> [  136.636012] no online cpu for hctx 1
> [  136.640448] no online cpu for hctx 2
> [  136.644832] no online cpu for hctx 3
> [  136.650432] nvme nvme0: Successfully reconnected (1 attempts)
> [  184.894584] x86: Booting SMP configuration:
> [  184.899694] smpboot: Booting Node 1 Processor 1 APIC 0x20
> [  184.913923] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [  184.929556] smpboot: Booting Node 1 Processor 3 APIC 0x22
>
> And here is the debug ouput:
> [root@rdma-virt-01 linux (test)]$ gdb vmlinux
> GNU gdb (GDB) Red Hat Enterprise Linux 7.6.1-110.el7
> Copyright (C) 2013 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later 
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show 
> copying"
> and "show warranty" for details.
> This GDB was configured as "x86_64-redhat-linux-gnu".
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>...
> Reading symbols from /home/test/linux/vmlinux...done.
> (gdb) l *(blk_mq_get_request+0x23e)
> 0xffffffff8136bf9e is in blk_mq_get_request (block/blk-mq.c:327).
> 322        rq->rl = NULL;
> 323        set_start_time_ns(rq);
> 324        rq->io_start_time_ns = 0;
> 325    #endif
> 326
> 327        data->ctx->rq_dispatched[op_is_sync(op)]++;
> 328        return rq;
> 329    }
> 330
> 331    static struct request *blk_mq_get_request(struct request_queue *q,
>
>
>
>> -- 
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 75336848f7a7..81ced3096433 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -444,6 +444,10 @@ struct request *blk_mq_alloc_request_hctx(struct 
>> request_queue *q,
>>                 return ERR_PTR(-EXDEV);
>>         }
>>         cpu = cpumask_first_and(alloc_data.hctx->cpumask, 
>> cpu_online_mask);
>> +       if (cpu >= nr_cpu_ids) {
>> +               pr_warn("no online cpu for hctx %d\n", hctx_idx);
>> +               cpu = cpumask_first(alloc_data.hctx->cpumask);
>> +       }
>>         alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
>>
>>         rq = blk_mq_get_request(q, NULL, op, &alloc_data);
>> -- 
>>
>>> 2) when nr_hw_queues is set as num_online_cpus(), there may be
>>> much less online CPUs, so the hw queue number can be initialized as
>>> much smaller, then performance is degraded much even if some CPUs
>>> become online later.
>>
>> That is correct, when the controller will be reset though, more queues
>> will be added to the system. I agree it would be good if we can change
>> stuff dynamically.
>>
>>> So the current policy is to map all possible CPUs for handing CPU
>>> hotplug, and if you want to get 1:1 mapping between hw queue and
>>> online CPU, the nr_hw_queues can be set as num_possible_cpus.
>>
>> Having nr_hw_queues == num_possible_cpus cannot work as it requires
>> establishing an RDMA queue-pair with a set of HW resources both on
>> the host side _and_ on the controller side, which are idle.
>>
>>> Please see commit 16ccfff28976130 (nvme: pci: pass max vectors as
>>> num_possible_cpus() to pci_alloc_irq_vectors).
>>
>> Yes, I am aware of this patch, however I not sure it'll be a good idea
>> for nvmf as it takes resources from both the host and the target for
>> for cpus that may never come online...
>>
>>> It will waste some memory resource just like percpu variable, but it
>>> simplifies the queue mapping logic a lot, and can support both hard
>>> and soft CPU online/offline without CPU hotplug handler, which may
>>> cause very complicated queue dependency issue.
>>
>> Yes, but these some memory resources are becoming an issue when it
>> takes HW (RDMA) resources on the local device and on the target device.
>>
>>>> I agree we don't want to connect hctx which doesn't have an online
>>>> cpu, that's redundant, but this is not the case here.
>>>
>>> OK, I will explain below, and it can be fixed by the following patch 
>>> too:
>>>
>>> https://marc.info/?l=linux-block&m=152318093725257&w=2
>>>
>>
>> I agree this patch is good!
>>
>>>>>>> Or I may understand you wrong, :-)
>>>>>>
>>>>>> In the report we connected 40 hctxs (which was exactly the number of
>>>>>> online cpus), after Yi removed 3 cpus, we tried to connect 37 hctxs.
>>>>>> I'm not sure why some hctxs are left without any online cpus.
>>>>>
>>>>> That is possible after the following two commits:
>>>>>
>>>>> 4b855ad37194 ("blk-mq: Create hctx for each present CPU)
>>>>> 20e4d8139319 (blk-mq: simplify queue mapping & schedule with each 
>>>>> possisble CPU)
>>>>>
>>>>> And this can be triggered even without putting down any CPUs.
>>>>>
>>>>> The blk-mq CPU hotplug handler is removed in 4b855ad37194, and we 
>>>>> can't
>>>>> remap queue any more when CPU topo is changed, so the static & 
>>>>> fixed mapping
>>>>> has to be setup from the beginning.
>>>>>
>>>>> Then if there are less enough online CPUs compared with number of 
>>>>> hw queues,
>>>>> some of hctxes can be mapped with all offline CPUs. For example, 
>>>>> if one device
>>>>> has 4 hw queues, but there are only 2 online CPUs and 6 offline 
>>>>> CPUs, at most
>>>>> 2 hw queues are assigned to online CPUs, and the other two are all 
>>>>> with offline
>>>>> CPUs.
>>>>
>>>> That is fine, but the problem that I gave in the example below 
>>>> which has
>>>> nr_hw_queues == num_online_cpus but because of the mapping, we still
>>>> have unmapped hctxs.
>>>
>>> For FC's case, there may be some hctxs not 'mapped', which is caused by
>>> blk_mq_map_queues(), but that should one bug.
>>>
>>> So the patch(blk-mq: don't keep offline CPUs mapped to hctx 0)[1] is
>>> fixing the issue:
>>>
>>> [1] https://marc.info/?l=linux-block&m=152318093725257&w=2
>>>
>>> Once this patch is in, any hctx should be mapped by at least one CPU.
>>
>> I think this will solve the problem Yi is stepping on.
>>
>>> Then later, the patch(blk-mq: reimplement blk_mq_hw_queue_mapped)[2]
>>> extends the mapping concept, maybe it should have been renamed as
>>> blk_mq_hw_queue_active(), will do it in V2.
>>>
>>> [2] https://marc.info/?l=linux-block&m=152318099625268&w=2
>>
>> This is also a good patch.
>>
>> ...
>>
>>>> But when we reset the controller, we call blk_mq_update_nr_hw_queues()
>>>> with the current number of nr_hw_queues which never exceeds
>>>> num_online_cpus. This in turn, remaps the mq_map which results
>>>> in unmapped queues because of the mapping function, not because we
>>>> have more hctx than online cpus...
>>>
>>> As I mentioned, num_online_cpus() isn't one stable variable, and it
>>> can change any time.
>>
>> Correct, but I'm afraid num_possible_cpus might not work either.
>>
>>> After patch(blk-mq: don't keep offline CPUs mapped to hctx 0) is in,
>>> there won't be unmapped queue any more.
>>
>> Yes.
>>
>>>> An easy fix, is to allocate num_present_cpus queues, and only connect
>>>> the oneline ones, but as you said, we have unused resources this way.
>>>
>>> Yeah, it should be num_possible_cpus queues because physical CPU 
>>> hotplug
>>> is needed to be supported for KVM or S390, or even some X86_64 system.
>>
>> num_present_cpus is a waste of resources (as I said, both on the host
>> and on the target), but num_possible_cpus is even worse as this is
>> all cpus that _can_ be populated.
>>
>>>> We also have an issue with blk_mq_rdma_map_queues with the only
>>>> device that supports it because it doesn't use managed affinity (code
>>>> was reverted) and can have irq affinity redirected in case of cpu
>>>> offlining...
>>>
>>> That can be one corner case, looks I have to re-consider the patch
>>> (blk-mq: remove code for dealing with remapping queue), which may cause
>>> regression for this RDMA case, but I guess CPU hotplug may break this
>>> case easily.
>>>
>>> [3] https://marc.info/?l=linux-block&m=152318100625284&w=2
>>>
>>> Also this case will make blk-mq's queue mapping much complicated,
>>> could you provide one link about the reason for reverting managed 
>>> affinity
>>> on this device?
>>
>> The problem was that users reported a regression because now
>> /proc/irp/$IRQ/smp_affinity is immutable. Looks like netdev users do
>> this on a regular basis (and also rely on irq_banacer at times) while
>> nvme users (and other HBAs) do not care about it.
>>
>> Thread starts here:
>> https://www.spinics.net/lists/netdev/msg464301.html
>>
>>> Recently we fix quite a few issues on managed affinity, maybe the
>>> original issue for RDMA affinity has been addressed already.
>>
>> That is not specific to RDMA affinity, its because RDMA devices are
>> also network devices and people want to apply their irq affinity
>> scripts on it like their used to with other devices.
>>
>>>> The goal here I think, should be to allocate just enough queues (not
>>>> more than the number online cpus) and spread it 1x1 with online cpus,
>>>> and also make sure to allocate completion vectors that align to online
>>>> cpus. I just need to figure out how to do that...
>>>
>>> I think we have to support CPU hotplug, so your goal may be hard to
>>> reach if you don't want to waste memory resource.
>>
>> Well, not so much if I make blk_mq_rdma_map_queues do the right thing?
>>
>> As I said, for the first go, I'd like to fix the mapping for the simple
>> case where we map the queues with some cpus offlined. Having queues
>> being added dynamically is a different story and I agree would require
>> more work.
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
