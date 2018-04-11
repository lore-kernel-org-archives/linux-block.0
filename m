Return-Path: <00moses.alexander00@gmail.com>
Return-Path: <00moses.alexander00@gmail.com>
Date: Wed, 11 Apr 2018 21:00:27 +0200
From: Alexandru Moise <00moses.alexander00@gmail.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "tj@kernel.org" <tj@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411190027.GA21274@gmail.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 11, 2018 at 03:54:53PM +0000, Bart Van Assche wrote:
> On Wed, 2018-04-11 at 16:28 +0200, Alexandru Moise wrote:
> > [    0.766666] BUG: unable to handle kernel NULL pointer dereference at 00000000000001b4
> > [    0.763350] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> > [    0.763350]
> > [    0.766666] PGD 0 P4D 0
> > [    0.766666] Oops: 0000 [#2] PREEMPT SMP
> > [    0.766666] CPU: 0 PID: 6 Comm: kworker/u12:0 Tainted: G      D          4.16.0-ARCH+ #81
> > [    0.766666] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/20$
> > [    0.766666] Workqueue: nvme-reset-wq nvme_reset_work
> > [    0.766666] RIP: 0010:blk_queue_flag_set+0xf/0x40
> > [    0.766666] RSP: 0000:ffffc900001bfcb0 EFLAGS: 00010246
> > [    0.766666] RAX: ffff88003b698000 RBX: 0000000000000000 RCX: 0000000000000000
> > [    0.766666] RDX: ffff88003b698000 RSI: fffffffffffffff4 RDI: 000000000000001c
> > [    0.766666] RBP: ffffc900001bfcc0 R08: 0000000000000000 R09: 0000000000000000
> > [    0.766666] R10: ffffea0000eaa980 R11: ffffffff814e0970 R12: 000000000000001c
> > [    0.766666] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88003aad8010
> > [    0.766666] FS:  0000000000000000(0000) GS:ffff88003e400000(0000) knlGS:0000000000000000
> > [    0.766666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.766666] CR2: 00000000000001b4 CR3: 0000000002209001 CR4: 00000000000606f0
> > [    0.766666] Call Trace:
> > [    0.766666]  blk_mq_quiesce_queue+0x23/0x80
> > [    0.766666]  nvme_dev_disable+0x34f/0x480
> > [    0.766666]  ? nvme_irq+0x50/0x50
> > [    0.766666]  ? dev_warn+0x64/0x80
> > [    0.766666]  nvme_reset_work+0x13de/0x1570
> > [    0.766666]  ? __switch_to_asm+0x34/0x70
> > [    0.766666]  ? __switch_to_asm+0x40/0x70
> > [    0.766666]  ? _raw_spin_unlock_irq+0x15/0x30
> > [    0.766666]  ? finish_task_switch+0x156/0x210
> > [    0.766666]  process_one_work+0x20c/0x3d0
> > [    0.766666]  worker_thread+0x216/0x400
> > [    0.766666]  kthread+0x125/0x130
> > [    0.766666]  ? process_one_work+0x3d0/0x3d0
> > [    0.766666]  ? __kthread_bind_mask+0x60/0x60
> > [    0.766666]  ret_from_fork+0x3a/0x50
> 
> Hello Alexandru,
> 
> What made you look at cgroups? In the above register dump I see that %rbx == NULL.
> I think that means that the queue pointer argument of blk_queue_flag_set() is NULL.
> The NVMe initiator driver should never pass a NULL pointer to blk_mq_quiesce_queue().
> Please ask the NVMe driver maintainers for their opinion on the linux-nvme mailing
> list.
> 
> Thanks,
> 
> Bart.

The %rbx == NULL is only a symptom of the cgroup mishandling, perhaps we could
improve error handling in the NVMe driver, but I can say that about a lot of block
drivers actually, perhaps I will write some patches in the future to improve the
error handling.

But the root cause of it is in blkcg_init_queue() when blkg_create() returns
an ERR ptr, because it tries to insert into a populated index into blkcg->blkg_tree,
the entry that we fail to remove at __blk_release_queue().

Thanks,
../Alex


> 
> 
> 
