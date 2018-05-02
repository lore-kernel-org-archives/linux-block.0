Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750918AbeEBJrg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 May 2018 05:47:36 -0400
Date: Wed, 2 May 2018 17:47:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Performance drop due to "blk-mq-sched: improve sequential I/O
 performance"
Message-ID: <20180502094713.GA31961@ming.t460p>
References: <3f49cb1f5a04fd61a73fe9f033868278@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3f49cb1f5a04fd61a73fe9f033868278@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 02, 2018 at 01:13:34PM +0530, Kashyap Desai wrote:
> Hi Ming,
> 
> I was running some performance test on latest 4.17-rc and figure out
> performance drop (approximate 15% drop) due to below patch set.
> https://marc.info/?l=linux-block&m=150802309522847&w=2
> 
> I observed drop on latest 4.16.6 stable and 4.17-rc kernel as well. Taking
> bisect approach, figure out that Issue is not observed using last stable
> kernel 4.14.38.
> I pick 4.14.38 stable kernel  as base line and applied above patch to
> confirm the behavior.
> 
> lscpu output -
> 
> Architecture:          x86_64
> CPU op-mode(s):        32-bit, 64-bit
> Byte Order:            Little Endian
> CPU(s):                72
> On-line CPU(s) list:   0-71
> Thread(s) per core:    2
> Core(s) per socket:    18
> Socket(s):             2
> NUMA node(s):          2
> Vendor ID:             GenuineIntel
> CPU family:            6
> Model:                 85
> Model name:            Intel(R) Xeon(R) Gold 6150 CPU @ 2.70GHz
> Stepping:              4
> CPU MHz:               1457.182
> CPU max MHz:           2701.0000
> CPU min MHz:           1200.0000
> BogoMIPS:              5400.00
> Virtualization:        VT-x
> L1d cache:             32K
> L1i cache:             32K
> L2 cache:              1024K
> L3 cache:              25344K
> NUMA node0 CPU(s):     0-17,36-53
> NUMA node1 CPU(s):     18-35,54-71
> 
> I am having 16 SSDs - "SDLL1DLR400GCCA1". Created two R0 VD (each VD
> consist of 8 SSDs) using MegaRaid Ventura series adapter.
> 
> fio script -
> numactl -N 1 fio 2vd.fio --bs=4k --iodepth=128 -rw=randread --group_report
> --ioscheduler=none --numjobs=4
> 
> 
>                    		| v4.14.38-stable   	| patched
> v4.14.38-stable
>                    		| mq-none	       	| mq-none
> ---------------------------------------------------------------------
> randread        "iops"	 | 1597k 		| 1377k
> 
> 
> Below is perf tool report without patch set. ( Looks like lock contention
> is causing this drop, so provided relevant snippet)
> 
> -    3.19%     2.89%  fio              [kernel.vmlinux]            [k]
> _raw_spin_lock
>    - 2.43% io_submit
>       - 2.30% entry_SYSCALL_64
>          - do_syscall_64
>             - 2.18% do_io_submit
>                - 1.59% blk_finish_plug
>                   - 1.59% blk_flush_plug_list
>                      - 1.59% blk_mq_flush_plug_list
>                         - 1.00% __blk_mq_delay_run_hw_queue
>                            - 0.99% blk_mq_sched_dispatch_requests
>                               - 0.63% blk_mq_dispatch_rq_list
>                                    0.60% scsi_queue_rq
>                         - 0.57% blk_mq_sched_insert_requests
>                            - 0.56% blk_mq_insert_requests
>                                 0.51% _raw_spin_lock
> 
> Below is perf tool report after applying patch set.
> 
> -    4.10%     3.51%  fio              [kernel.vmlinux]            [k]
> _raw_spin_lock
>    - 3.09% io_submit
>       - 2.97% entry_SYSCALL_64
>          - do_syscall_64
>             - 2.85% do_io_submit
>                - 2.35% blk_finish_plug
>                   - 2.35% blk_flush_plug_list
>                      - 2.35% blk_mq_flush_plug_list
>                         - 1.83% __blk_mq_delay_run_hw_queue
>                            - 1.83% __blk_mq_run_hw_queue
>                               - 1.83% blk_mq_sched_dispatch_requests
>                                  - 1.82% blk_mq_do_dispatch_ctx
>                                     - 1.14% blk_mq_dequeue_from_ctx
>                                        - 1.11% dispatch_rq_from_ctx
>                                             1.03% _raw_spin_lock
>                           0.50% blk_mq_sched_insert_requests
> 
> Let me know if you want more data or is this something a known implication
> of patch-set ?

The percpu lock of 'ctx->lock' shouldn't have taken so much CPU in
dispatch_rq_from_ctx, and the reason may be that the single sbitmap
is shared among all CPUs(nodes).

So this issue may be same with your previous report, I will provide
the per-host tagset patches against v4.17-rc3 for you to test this week.

Could you run your benchmark and test patches against v4.17-rc
kernel next time?

BTW, could you update with us if the previous cpu lockup issue is fixed
or not after commit adbe552349f2(scsi: megaraid_sas: fix selection of reply queue)?

Actually we did discuss a bit about this kind of issue on last week's lsfmm.

Thanks,
Ming
