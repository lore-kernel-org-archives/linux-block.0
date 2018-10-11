Return-Path: <richard.weinberger@gmail.com>
MIME-Version: 1.0
References: <20181011165909.32615-1-axboe@kernel.dk> <20181011165909.32615-17-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-17-axboe@kernel.dk>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 11 Oct 2018 23:03:55 +0200
Message-ID: <CAFLxGvy04s++HExKixU02=e86kx4yqcz+boeepxi9=uDU94sQg@mail.gmail.com>
Subject: Re: [PATCH 16/17] mtd_blkdevs: convert to blk-mq
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	"linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Jens,

On Thu, Oct 11, 2018 at 7:00 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Straight forward conversion, using an internal list to enable the
> driver to pull requests at will.
>
> Dynamically allocate the tag set to avoid having to pull in the
> block headers for blktrans.h, since various mtd drivers use
> block conflicting names for defines and functions.

This explodes on my test system. :-/

[    2.236594] BUG: unable to handle kernel NULL pointer dereference
at 000000000000001a
[    2.237621] PGD 0 P4D 0
[    2.237968] Oops: 0000 [#1] SMP PTI
[    2.238425] CPU: 3 PID: 1110 Comm: kworker/3:1H Not tainted 4.19.0-rc7+ #143
[    2.239331] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[    2.240893] Workqueue: kblockd blk_mq_run_work_fn
[    2.241533] RIP: 0010:__blk_mq_end_request+0xe/0xb0
[    2.242212] Code: 44 21 c2 48 0f a3 10 73 02 f3 c3 f0 48 0f ab 10
c3 90 66 2e 0f 1f 84 00 00 00 00 00 41 54 55 89 f5 53 48 89 fb e8 f2
80 d6 ff <f6> 43 1a 02 49 89 c4 75 4f 4c 89 e6 48 89 df e8 4e 69 ff ff
48 83
[    2.244798] RSP: 0018:ffffac65c2c43d20 EFLAGS: 00010216
[    2.245469] RAX: 000000007caad848 RBX: 0000000000000000 RCX: 0000000000000017
[    2.246382] RDX: 0000031c57000000 RSI: 001778d956000000 RDI: ffffffffa4cc70c0
[    2.247296] RBP: 0000000000000000 R08: 00000000d2a4b8d8 R09: ffffffffa355ead3
[    2.248208] R10: fffff1a2c5e46740 R11: ffffffffff76acba R12: 0000000000000000
[    2.249123] R13: ffffa117793ff720 R14: ffffffffa46c7120 R15: 000000000007ff88
[    2.259551] FS:  0000000000000000(0000) GS:ffffa1177ab80000(0000)
knlGS:0000000000000000
[    2.259552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.259553] CR2: 000000000000001a CR3: 0000000177d44000 CR4: 00000000000006e0
[    2.259560] Call Trace:
[    2.259630]  mtd_queue_rq+0x1fa/0x400
[    2.259661]  blk_mq_dispatch_rq_list+0x8b/0x510
[    2.259672]  ? elv_rqhash_add+0x1/0x60
[    2.259680]  ? deadline_remove_request+0x44/0xa0
[    2.259684]  blk_mq_do_dispatch_sched+0x5a/0xf0
[    2.259690]  blk_mq_sched_dispatch_requests+0xf0/0x160
[    2.259697]  __blk_mq_run_hw_queue+0x49/0xc0
[    2.259705]  process_one_work+0x1e9/0x3d0
[    2.259726]  worker_thread+0x28/0x3d0
[    2.259728]  ? process_one_work+0x3d0/0x3d0
[    2.259732]  kthread+0x10e/0x130
[    2.259740]  ? kthread_create_worker_on_cpu+0x70/0x70
[    2.259750]  ret_from_fork+0x35/0x40
[    2.259763] Modules linked in:
[    2.259767] CR2: 000000000000001a
[    2.259772] ---[ end trace b08076f7e1ed1f91 ]---
[    2.259774] RIP: 0010:__blk_mq_end_request+0xe/0xb0
[    2.259776] Code: 44 21 c2 48 0f a3 10 73 02 f3 c3 f0 48 0f ab 10
c3 90 66 2e 0f 1f 84 00 00 00 00 00 41 54 55 89 f5 53 48 89 fb e8 f2
80 d6 ff <f6> 43 1a 02 49 89 c4 75 4f 4c 89 e6 48 89 df e8 4e 69 ff ff
48 83
[    2.259777] RSP: 0018:ffffac65c2c43d20 EFLAGS: 00010216
[    2.259778] RAX: 000000007caad848 RBX: 0000000000000000 RCX: 0000000000000017
[    2.259779] RDX: 0000031c57000000 RSI: 001778d956000000 RDI: ffffffffa4cc70c0
[    2.259780] RBP: 0000000000000000 R08: 00000000d2a4b8d8 R09: ffffffffa355ead3
[    2.259780] R10: fffff1a2c5e46740 R11: ffffffffff76acba R12: 0000000000000000
[    2.259781] R13: ffffa117793ff720 R14: ffffffffa46c7120 R15: 000000000007ff88
[    2.259782] FS:  0000000000000000(0000) GS:ffffa1177ab80000(0000)
knlGS:0000000000000000
[    2.259783] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.259784] CR2: 000000000000001a CR3: 0000000177d44000 CR4: 00000000000006e0
[    2.259786] Kernel panic - not syncing: Fatal exception
[    2.261997] Kernel Offset: 0x22200000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

-- 
Thanks,
//richard
