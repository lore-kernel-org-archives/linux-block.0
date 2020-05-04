Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D98C3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 08:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9577F20746
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 08:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgEDIPH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 04:15:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726750AbgEDIPG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 04:15:06 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 444123308DAA760ABAEA;
        Mon,  4 May 2020 09:15:05 +0100 (IST)
Received: from [127.0.0.1] (10.210.171.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 09:15:04 +0100
Subject: Re: [PATCH V9 00/11] blk-mq: improvement CPU hotplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200502235454.1118520-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5db8635b-b606-3dd9-ce1d-5280097acbd3@huawei.com>
Date:   Mon, 4 May 2020 09:14:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200502235454.1118520-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.25]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/05/2020 00:54, Ming Lei wrote:
> Hi,
> 
> Thomas mentioned:
>      "
>       That was the constraint of managed interrupts from the very beginning:
>      
>        The driver/subsystem has to quiesce the interrupt line and the associated
>        queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>        until it's restarted by the core when the CPU is plugged in again.
>      "
> 
> But no drivers or blk-mq do that before one hctx becomes inactive(all
> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
> 
> This patchset tries to address the issue by two stages:
> 
> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
> 
> - mark the hctx as internal stopped, and drain all in-flight requests
> if the hctx is going to be dead.
> 
> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
> 
> - steal bios from the request, and resubmit them via generic_make_request(),
> then these IO will be mapped to other live hctx for dispatch
> 
> Thanks John Garry for running lots of tests on arm64 with this patchset
> and co-working on investigating all kinds of issues.
> 
> Thanks Christoph's review on V7.
> 
> Please comment & review, thanks!
> 

Hi Ming,

Bad news, I see this on the first hotplug loop:

[66.628964] CPU2: shutdown
[66.631663] psci: CPU2 killed (polled 0 ms)
[66.681062] CPU3: shutdown
[66.683761] psci: CPU3 killed (polled 0 ms)
[66.717097] CPU4: shutdown
[66.719796] psci: CPU4 killed (polled 0 ms)
[66.753136] CPU5: shutdown
[66.755834] psci: CPU5 killed (polled 0 ms)
[66.801234] CPU6: shutdown=2746MiB/s,w=0KiB/s][r=703k,w=0 IOPS][eta 00m:55s]
[66.803932] psci: CPU6 killed (polled 0 ms)
[66.837170] irq_shutdown irq150
[66.840410] CPU7: shutdown
[66.843112] psci: CPU7 killed (polled 0 ms)
[66.885394] CPU8: shutdown
[66.888092] psci: CPU8 killed (polled 0 ms)
[66.925431] CPU9: shutdown
[66.928128] psci: CPU9 killed (polled 0 ms)
[66.965526] CPU10: shutdown
[66.968311] psci: CPU10 killed (polled 0 ms)
[67.025569] irq_shutdown irq151
[67.028808] CPU11: shutdown
[67.031599] psci: CPU11 killed (polled 0 ms)
[67.306393] CPU12: shutdown
[67.309179] psci: CPU12 killed (polled 0 ms)
[67.347266] CPU13: shutdown
[67.350058] psci: CPU13 killed (polled 0 ms)
[67.410910] CPU14: shutdown
[67.413695] psci: CPU14 killed (polled 0 ms)
[67.454453] irq_shutdown irq152
[67.457699] CPU15: shutdown
[67.457799] ------------[ cut here ]------------
[67.460506] psci: CPU15 killed (polled 0 ms)
[67.465091] refcount_t: underflow; use-after-free.
[67.465112] WARNING: CPU: 0 PID: 557 at lib/refcount.c:28 
refcount_warn_saturate+0x6c/0x13c
[67.482468] Modules linked in:
[67.485511] CPU: 0 PID: 557 Comm: irq/149-hisi_sa Not tainted 
5.7.0-rc2-13190-gb615db31b5f4 #331
[67.494281] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 
IT21 Nemo 2.0 RC0 04/18/2018
[67.503398] pstate: 20000005 (nzCv daif -PAN -UAO)
[67.508176] pc : refcount_warn_saturate+0x6c/0x13c
[67.512954] lr : refcount_warn_saturate+0x6c/0x13c
[67.517730] sp : ffff80001fd3b920
[67.521031] x29: ffff80001fd3b920 x28: ffff001f9c549500
[67.526329] x27: ffff001f9c54956c x26: 000000000000d8d0
[67.531627] x25: ffff001fb08c7378 x24: 0000000000000000
[67.536925] x23: ffff001f9a6eef00 x22: 0000000000000000
[67.542223] x21: 0000000000001000 x20: ffff001f9ebd0918
[67.547521] x19: ffff001f9a6eef00 x18: 0000000000000000
[67.552820] x17: 000000007fffffff x16: 0000000000000311
[67.558118] x15: 000000000001ffff x14: 0000000000000001
[67.563416] x13: 000000000000001f x12: 0000000000000000
[67.568714] x11: ffff800011aca468 x10: 0000000000fddfa0
[67.574012] x9 : 0000000000000000 x8 : ffff041faa022098
[67.579310] x7 : 0000000000000000 x6 : ffff001ffbe871d0
[67.584608] x5 : 0000000000000001 x4 : 0000000000000000
[67.589906] x3 : 0000000000000000 x2 : 0000000000000007
[67.595204] x1 : 0000000100000001 x0 : 0000000000000026
[67.600503] Call trace:
[67.602937]  refcount_warn_saturate+0x6c/0x13c
[67.607369]  aio_complete_rw+0x350/0x384
[67.611279]  blkdev_bio_end_io+0xc4/0x12c
[67.615276]  bio_endio+0x104/0x130
[67.618665]  blk_update_request+0x98/0x37c
[67.622748]  blk_mq_end_request+0x24/0x138
[67.626831]  blk_mq_resubmit_end_rq+0x40/0x58
[67.631174]  __blk_mq_end_request+0xb0/0x10c
[67.635432]  scsi_end_request+0xdc/0x20c
[67.639341]  scsi_io_completion+0x5c/0x468
[67.643424]  scsi_finish_command+0xcc/0x11c
[67.647594]  scsi_softirq_done+0x11c/0x144
[67.651676]  blk_mq_complete_request+0x114/0x150
[67.656280]  scsi_mq_done+0x40/0x74
[67.659756]  sas_scsi_task_done+0x64/0xa4
[67.663753]  slot_complete_v2_hw+0x1c4/0x470
[67.668010]  cq_thread_v2_hw+0x194/0x250
[67.671920]  irq_thread_fn+0x28/0x6c
[67.675482]  irq_thread+0x158/0x1e8
[67.678957]  kthread+0x124/0x150
[67.682173]  ret_from_fork+0x10/0x18
[67.685735] ---[ end trace 90afd0085490db4a ]---
[67.690361] Unable to handle kernel paging request at virtual address 
0000000b0000000a
[67.698279] Mem abort info:
[67.701068]ESR = 0x96000004
[67.704121]EC = 0x25: DABT (current EL), IL = 32 bits
[67.709425]SET = 0, FnV = 0
[67.712470]EA = 0, S1PTW = 0
[67.715608] Data abort info:
[67.718476]ISV = 0, ISS = 0x00000004
[67.722307]CM = 0, WnR = 0
[67.725272] user pgtable: 4k pages, 48-bit VAs, pgdp=0000001fabf2c000
[67.731708] [0000000b0000000a] pgd=0000000000000000
[67.736580] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[67.742139] Modules linked in:
[67.745181] CPU: 0 PID: 557 Comm: irq/149-hisi_sa Tainted: G 
W5.7.0-rc2-13190-gb615db31b5f4 #331
[67.755340] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 
IT21 Nemo 2.0 RC0 04/18/2018
[67.764458] pstate: 60000005 (nZCv daif -PAN -UAO)
[67.769235] pc : bio_check_pages_dirty+0x60/0x130
[67.773926] lr : blkdev_bio_end_io+0xe0/0x12c
[67.778269] sp : ffff80001fd3b940
[67.781570] x29: ffff80001fd3b940 x28: ffff001f9c549500
[67.786869] x27: ffff001f9c54956c x26: 000000000000d8d0
[67.792167] x25: ffff001fb08c7378 x24: 0000000000000000
Jobs: 6 (f=6): [[ R ( 66)7].[7191466] x23: ffff001f9a6eef00 x22: 
0000000000000001
[67.809706] x21: 0000000000000001 x20: ffff001f9ebd0918
[67.815005] x19: ffff001f9ebd0918 x18: 0000000000000000
[67.820302] x17: 000000007fffffff x16: 0000000000000311
[67.825601] x15: 000000000001ffff x14: 0000000000000001
[67.830899] x13: 000000000000001f x12: 0000000000000000
[67.836198] x11: ffff800011aca468 x10: 0000000000fddfa0
[67.841496] x9 : 0000000000001000 x8 : ffff001f9ebd1c00
[67.846794] x7 : 0000000000000000 x6 : 0000000000000001
[67.852092] x5 : 0000000000000ffe x4 : 0000000000000000
[67.857390] x3 : 0000000b0000000a x2 : ffff001fb4db9800
[67.862688] x1 : 0000000000000000 x0 : 0000000000000001
[67.867986] Call trace:
[67.870420]  bio_check_pages_dirty+0x60/0x130
[67.874764]  blkdev_bio_end_io+0xe0/0x12c
[67.878759]  bio_endio+0x104/0x130
[67.882148]  blk_update_request+0x98/0x37c
[67.886231]  blk_mq_end_request+0x24/0x138
[67.890314]  blk_mq_resubmit_end_rq+0x40/0x58
[67.894656]  __blk_mq_end_request+0xb0/0x10c
[67.898913]  scsi_end_request+0xdc/0x20c
[67.902823]  scsi_io_completion+0x5c/0x468
[67.906906]  scsi_finish_command+0xcc/0x11c
[67.911076]  scsi_softirq_done+0x11c/0x144
[67.915159]  blk_mq_complete_request+0x114/0x150
[67.919762]  scsi_mq_done+0x40/0x74
[67.923238]  sas_scsi_task_done+0x64/0xa4
[67.927234]  slot_complete_v2_hw+0x1c4/0x470
[67.931491]  cq_thread_v2_hw+0x194/0x250
[67.935400]  irq_thread_fn+0x28/0x6c
[67.938962]  irq_thread+0x158/0x1e8
[67.942438]  kthread+0x124/0x150
[67.945652]  ret_from_fork+0x10/0x18
[67.949217] Code: 52800001 f9400443 37000683 aa0203e3 (f9400063)
[67.955297] ---[ end trace 90afd0085490db4b ]---
[67.959919] note: irq/149-hisi_sa[557] exited with preempt_count 1
[67.966094] genirq: exiting task "irq/149-hisi_sa" (557) is an active 
IRQ thread (irq 149)
[68.011756] CPU16: shutdown
[68.014542] psci: CPU16 killed (polled 0 ms)
[68.063856] CPU17: shutdown
[68.066642] psci: CPU17 killed (polled 0 ms)
[68.107841] CPU18: shutdown
[68.110626] psci: CPU18 killed (polled 0 ms)
[68.175801] irq_shutdown irq137
[68.179099] CPU19: shutdown
[68.179289] Unable to handle kernel NULL pointer dereference at virtual 
address 000000000000000c
[68.181894] psci: CPU19 killed (polled 0 ms)
[68.190667] Mem abort info:
[68.190669]ESR = 0x96000004
[68.190671]EC = 0x25: DABT (current EL), IL = 32 bits
[68.190673]SET = 0, FnV = 0
[68.190676]EA = 0, S1PTW = 0
[68.212237] Data abort info:
[68.215104]ISV = 0, ISS = 0x00000004
[68.218931]CM = 0, WnR = 0
[68.221892] user pgtable: 4k pages, 48-bit VAs, pgdp=0000001f9a7fa000
[68.228324] [000000000000000c] pgd=0000000000000000
[68.233200] Internal error: Oops: 96000004 [#2] PREEMPT SMP
[68.238758] Modules linked in:
[68.241802] CPU: 20 PID: 546 Comm: irq/138-hisi_sa Tainted: GD 
W5.7.0-rc2-13190-gb615db31b5f4 #331
[68.252047] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 
IT21 Nemo 2.0 RC0 04/18/2018
[68.261165] pstate: 20000005 (nzCv daif -PAN -UAO)
[68.265949] pc : bio_check_pages_dirty+0x80/0x130
[68.270641] lr : blkdev_bio_end_io+0xe0/0x12c
[68.274984] sp : ffff80001fce3940
[68.278285] x29: ffff80001fce3940 x28: ffff001f78d27600
[68.283583] x27: ffff001f78d2766c x26: 0000000000002020
[68.288882] x25: ffff001fb08c34b8 x24: 0000000000000000
[68.294180] x23: ffff001f9d476cc0 x22: 0000000000000001
[68.299478] x21: 0000000000000001 x20: ffff001f8db52318
[68.304776] x19: ffff001f8db52318 x18: 0000000000000000
[68.310074] x17: 00003fffffffffff x16: 00000000000000f7
[68.315372] x15: 000000000001ffff x14: 0000000000000001
[68.320670] x13: 000000000000002e x12: 000000000000002e
[68.325968] x11: 000000000000ffff x10: 0000000000013dee
[68.331266] x9 : 0000000000001000 x8 : 0000000000000000
[68.336564] x7 : 0000000000000000 x6 : 0000000000000000
[68.341862] x5 : fffffdffbfeded88 x4 : 0000000000000000
[68.347160] x3 : 0000000000000000 x2 : ffff80001043da70
[68.352458] x1 : 0000000000000000 x0 : 0000000000000001
[68.357757] Call trace:
[68.360191]  bio_check_pages_dirty+0x80/0x130
[68.364534]  blkdev_bio_end_io+0xe0/0x12c
[68.368530]  bio_endio+0x104/0x130
[68.371919]  blk_update_request+0x98/0x37c
[68.376004]  blk_mq_end_request+0x24/0x138
[68.380087]  blk_mq_resubmit_end_rq+0x40/0x58
[68.384430]  __blk_mq_end_request+0xb0/0x10c
[68.388688]  scsi_end_request+0xdc/0x20c
[68.392596]  scsi_io_completion+0x5c/0x468
[68.396681]  scsi_finish_command+0xcc/0x11c
[68.400850]  scsi_softirq_done+0x11c/0x144
[68.404933]  blk_mq_complete_request+0x114/0x150
[68.409536]  scsi_mq_done+0x40/0x74
[68.413012]  sas_scsi_task_done+0x64/0xa4
[68.417010]  slot_complete_v2_hw+0x1c4/0x470
[68.421267]  cq_thread_v2_hw+0x194/0x250
[68.425177]  irq_thread_fn+0x28/0x6c
[68.428740]  irq_thread+0x158/0x1e8
[68.432216]  kthread+0x124/0x150
[68.435431]  ret_from_fork+0x10/0x18
[68.438997] Code: f9403668 937c7cc7 8b070103 35fffd61 (b9400c65)
[68.445077] ---[ end trace 90afd0085490db4c ]---
[68.449690] note: irq/138-hisi_sa[546] exited with preempt_count 1
[68.455866] genirq: exiting task "irq/138-hisi_sa" (546) is an active 
IRQ thread (irq 138)
[68.504505] CPU20: shutdown
[68.507305] psci: CPU20 killed (polled 0 ms)
[68.556524] CPU21: shutdown
[68.559312] psci: CPU21 killed (polled 0 ms)
[68.592523] CPU22: shutdown


> https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-improve-cpu-hotplug

note: I'm using this branch, and we really should tag this or have an 
immutable branch so I know that I'm testing the same thing as in this 
series. I don't recognize the baseline here. I guess it's Jens' for-next.

Cheers,
John


> 
> V9:
> 	- add Reviewed-by tag
> 	- document more on memory barrier usage between getting driver tag
> 	and handling cpu offline(7/11)
> 	- small code cleanup as suggested by Chritoph(7/11)
> 	- rebase against for-5.8/block(1/11, 2/11)
> V8:
> 	- add patches to share code with blk_rq_prep_clone
> 	- code re-organization as suggested by Christoph, most of them are
> 	in 04/11, 10/11
> 	- add reviewed-by tag
> 
> V7:
> 	- fix updating .nr_active in get_driver_tag
> 	- add hctx->cpumask check in cpuhp handler
> 	- only drain requests which tag is >= 0
> 	- pass more aggressive cpuhotplug&io test
> 
> V6:
> 	- simplify getting driver tag, so that we can drain in-flight
> 	  requests correctly without using synchronize_rcu()
> 	- handle re-submission of flush & passthrough request correctly
> 
> V5:
> 	- rename BLK_MQ_S_INTERNAL_STOPPED as BLK_MQ_S_INACTIVE
> 	- re-factor code for re-submit requests in cpu dead hotplug handler
> 	- address requeue corner case
> 
> V4:
> 	- resubmit IOs in dispatch list in case that this hctx is dead
> 
> V3:
> 	- re-organize patch 2 & 3 a bit for addressing Hannes's comment
> 	- fix patch 4 for avoiding potential deadlock, as found by Hannes
> 
> V2:
> 	- patch4 & patch 5 in V1 have been merged to block tree, so remove
> 	  them
> 	- address comments from John Garry and Minwoo
> 
> Ming Lei (11):
>    block: clone nr_integrity_segments and write_hint in blk_rq_prep_clone
>    block: add helper for copying request
>    blk-mq: mark blk_mq_get_driver_tag as static
>    blk-mq: assign rq->tag in blk_mq_get_driver_tag
>    blk-mq: support rq filter callback when iterating rqs
>    blk-mq: prepare for draining IO when hctx's all CPUs are offline
>    blk-mq: stop to handle IO and drain IO before hctx becomes inactive
>    block: add blk_end_flush_machinery
>    blk-mq: add blk_mq_hctx_handle_dead_cpu for handling cpu dead
>    blk-mq: re-submit IO in case that hctx is inactive
>    block: deactivate hctx when the hctx is actually inactive
> 
>   block/blk-core.c           |  27 ++-
>   block/blk-flush.c          | 141 ++++++++++++---
>   block/blk-mq-debugfs.c     |   2 +
>   block/blk-mq-tag.c         |  39 ++--
>   block/blk-mq-tag.h         |   4 +
>   block/blk-mq.c             | 352 +++++++++++++++++++++++++++++--------
>   block/blk-mq.h             |  22 ++-
>   block/blk.h                |  11 +-
>   drivers/block/loop.c       |   2 +-
>   drivers/md/dm-rq.c         |   2 +-
>   include/linux/blk-mq.h     |   6 +
>   include/linux/cpuhotplug.h |   1 +
>   12 files changed, 477 insertions(+), 132 deletions(-)
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> 

