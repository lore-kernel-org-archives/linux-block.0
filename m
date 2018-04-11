Return-Path: <00moses.alexander00@gmail.com>
Return-Path: <00moses.alexander00@gmail.com>
Date: Wed, 11 Apr 2018 16:28:59 +0200
From: Alexandru Moise <00moses.alexander00@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, shli@fb.com, nborisov@suse.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411142859.GB2322@gmail.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180411142019.GG793541@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 11, 2018 at 07:20:19AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 11, 2018 at 12:12:56PM +0200, Alexandru Moise wrote:
> > > But we already do this through calling blkcg_exit_queue() from
> > > __blk_release_queue().  What's missing?
> > 
> > Hi,
> > 
> > It might be the jetlag but I can't see how you end up calling
> > blkcg_exit_queue() from __blk_release_queue().
> > 
> > As I see it the only way to reach blkcg_exit_queue() is from
> > blk_cleanup_queue(), which I don't see anywhere in __blk_release_queue().
> > 
> > I suspect that I'm just fixing a corner case though and
> > the general case is what you describe or similar.
> 
> Ah, that changed recently.  Can you please check out the current
> upstream git master?
> 
> Thanks.
> 
Just did, without my patch I see this crash:

[    0.759999] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 4.16.0-ARCH+ #81                                 [7/1949]
[    0.759999] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/204
[    0.759999] RIP: 0010:pi_init+0x23f/0x2f0
[    0.759999] RSP: 0000:ffffc90000197d90 EFLAGS: 00010246
[    0.759999] RAX: 0000000000000000 RBX: 0000000000000020 RCX: 0000000000000038
[    0.759999] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000000
[    0.759999] RBP: ffffc90000197e18 R08: 00000000ffffffff R09: 00000000ffffffff
[    0.759999] R10: ffffea0000eda600 R11: ffff88003b69f164 R12: ffffffff82e2d740
[    0.759999] R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000000
[    0.759999] FS:  0000000000000000(0000) GS:ffff88003e500000(0000) knlGS:0000000000000000
[    0.759999] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.759999] CR2: 0000000000000008 CR3: 0000000002209001 CR4: 00000000000606e0
[    0.759999] Call Trace:
[    0.759999]  pf_init+0x1db/0x3be
[    0.759999]  ? pcd_init+0x4e8/0x4e8
[    0.759999]  do_one_initcall+0x9e/0x1b0
[    0.759999]  ? do_early_param+0x97/0x97
[    0.759999]  kernel_init_freeable+0x259/0x2fd
[    0.759999]  ? rest_init+0xd0/0xd0
[    0.759999]  ? syscall_slow_exit_work+0x1c/0x160
[    0.759999]  kernel_init+0xe/0x100
[    0.759999]  ret_from_fork+0x3a/0x50
[    0.759999] Code: 75 6a 49 8b 06 48 8b 40 78 48 85 c0 74 08 4c 89 f7 e8 46 76 51 00 83 c3 01 3b 5d a8 7d 0d 49
[    0.759999] RIP: pi_init+0x23f/0x2f0 RSP: ffffc90000197d90
[    0.759999] CR2: 0000000000000008
[    0.759999] ---[ end trace 12004f267bb8bf7d ]---
[    0.766666] BUG: unable to handle kernel NULL pointer dereference at 00000000000001b4
[    0.763350] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    0.763350]
[    0.766666] PGD 0 P4D 0
[    0.766666] Oops: 0000 [#2] PREEMPT SMP
[    0.766666] CPU: 0 PID: 6 Comm: kworker/u12:0 Tainted: G      D          4.16.0-ARCH+ #81
[    0.766666] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/20$
[    0.766666] Workqueue: nvme-reset-wq nvme_reset_work
[    0.766666] RIP: 0010:blk_queue_flag_set+0xf/0x40
[    0.766666] RSP: 0000:ffffc900001bfcb0 EFLAGS: 00010246
[    0.766666] RAX: ffff88003b698000 RBX: 0000000000000000 RCX: 0000000000000000
[    0.766666] RDX: ffff88003b698000 RSI: fffffffffffffff4 RDI: 000000000000001c
[    0.766666] RBP: ffffc900001bfcc0 R08: 0000000000000000 R09: 0000000000000000
[    0.766666] R10: ffffea0000eaa980 R11: ffffffff814e0970 R12: 000000000000001c
[    0.766666] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88003aad8010
[    0.766666] FS:  0000000000000000(0000) GS:ffff88003e400000(0000) knlGS:0000000000000000
[    0.766666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.766666] CR2: 00000000000001b4 CR3: 0000000002209001 CR4: 00000000000606f0
[    0.766666] Call Trace:
[    0.766666]  blk_mq_quiesce_queue+0x23/0x80
[    0.766666]  nvme_dev_disable+0x34f/0x480
[    0.766666]  ? nvme_irq+0x50/0x50
[    0.766666]  ? dev_warn+0x64/0x80
[    0.766666]  nvme_reset_work+0x13de/0x1570
[    0.766666]  ? __switch_to_asm+0x34/0x70
[    0.766666]  ? __switch_to_asm+0x40/0x70
[    0.766666]  ? _raw_spin_unlock_irq+0x15/0x30
[    0.766666]  ? finish_task_switch+0x156/0x210
[    0.766666]  process_one_work+0x20c/0x3d0
[    0.766666]  worker_thread+0x216/0x400
[    0.766666]  kthread+0x125/0x130
[    0.766666]  ? process_one_work+0x3d0/0x3d0
[    0.766666]  ? __kthread_bind_mask+0x60/0x60
[    0.766666]  ret_from_fork+0x3a/0x50


With the patch the crash goes away,

Thanks,
../Alex

> -- 
> tejun
