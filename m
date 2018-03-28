Return-Path: <ming.lei@redhat.com>
Date: Wed, 28 Mar 2018 23:26:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
Message-ID: <20180328152617.GA6071@ming.t460p>
References: <20180328012035.17565-1-ming.lei@redhat.com>
 <ab28ea2a-9061-a4bb-723f-7db46d9a61c2@kernel.dk>
 <ebd41c63-5b64-23a7-1914-4abdedf3c9b2@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ebd41c63-5b64-23a7-1914-4abdedf3c9b2@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Hi Christian,

On Wed, Mar 28, 2018 at 09:45:10AM +0200, Christian Borntraeger wrote:
> FWIW, this patch does not fix the issue for me:
> 
> ostname=? addr=? terminal=? res=success'
> [   21.454961] WARNING: CPU: 3 PID: 1882 at block/blk-mq.c:1410 __blk_mq_delay_run_hw_queue+0xbe/0xd8
> [   21.454968] Modules linked in: scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_multipath dm_mod autofs4
> [   21.454984] CPU: 3 PID: 1882 Comm: dasdconf.sh Not tainted 4.16.0-rc7+ #26
> [   21.454987] Hardware name: IBM 2964 NC9 704 (LPAR)
> [   21.454990] Krnl PSW : 00000000c0131ea3 000000003ea2f7bf (__blk_mq_delay_run_hw_queue+0xbe/0xd8)
> [   21.454996]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [   21.455005] Krnl GPRS: 0000013abb69a000 0000013a00000000 0000013ac6c0dc00 0000000000000001
> [   21.455008]            0000000000000000 0000013abb69a710 0000013a00000000 00000001b691fd98
> [   21.455011]            00000001b691fd98 0000013ace4775c8 0000000000000001 0000000000000000
> [   21.455014]            0000013ac6c0dc00 0000000000b47238 00000001b691fc08 00000001b691fbd0
> [   21.455032] Krnl Code: 000000000069c596: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>                           000000000069c59c: c0f4ffff7a5e	brcl	15,68ba58
>                          #000000000069c5a2: a7f40001		brc	15,69c5a4
>                          >000000000069c5a6: e340f0c00004	lg	%r4,192(%r15)
>                           000000000069c5ac: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>                           000000000069c5b2: 07f4		bcr	15,%r4
>                           000000000069c5b4: c0e5fffffeea	brasl	%r14,69c388
>                           000000000069c5ba: a7f4fff6		brc	15,69c5a6
> [   21.455067] Call Trace:
> [   21.455072] ([<00000001b691fd98>] 0x1b691fd98)
> [   21.455079]  [<000000000069c692>] blk_mq_run_hw_queue+0xba/0x100 
> [   21.455083]  [<000000000069c740>] blk_mq_run_hw_queues+0x68/0x88 
> [   21.455089]  [<000000000069b956>] __blk_mq_complete_request+0x11e/0x1d8 
> [   21.455091]  [<000000000069ba9c>] blk_mq_complete_request+0x8c/0xc8 
> [   21.455103]  [<00000000008aa250>] dasd_block_tasklet+0x158/0x490 
> [   21.455110]  [<000000000014c742>] tasklet_hi_action+0x92/0x120 
> [   21.455118]  [<0000000000a7cfc0>] __do_softirq+0x120/0x348 
> [   21.455122]  [<000000000014c212>] irq_exit+0xba/0xd0 
> [   21.455130]  [<000000000010bf92>] do_IRQ+0x8a/0xb8 
> [   21.455133]  [<0000000000a7c298>] io_int_handler+0x130/0x298 
> [   21.455136] Last Breaking-Event-Address:
> [   21.455138]  [<000000000069c5a2>] __blk_mq_delay_run_hw_queue+0xba/0xd8
> [   21.455140] ---[ end trace be43f99a5d1e553e ]---
> [   21.510046] dasdconf.sh Warning: 0.0.241e is already online, not configuring

Thinking about this issue further, I can't understand the root cause for
this issue.

After commit 20e4d813931961fe ("blk-mq: simplify queue mapping & schedule with
each possisble CPU"), each hw queue should be mapped to at least one CPU, that
means this issue shouldn't happen. Maybe blk_mq_map_queues() works wrong?

Could you dump 'lscpu' and provide blk-mq debugfs for your DASD via the
following command?

(cd /sys/kernel/debug/block/$DASD && find . -type f -exec grep -aH . {} \;)

Thanks,
Ming
