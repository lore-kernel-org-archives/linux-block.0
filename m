Return-Path: <axboe@kernel.dk>
Subject: Re: [regression, 4.9-rc1] blk-mq: list corruption in request queue
To: Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org
References: <20161018230740.GE14023@dastard>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ecae68c8-a9fd-8087-9f0d-35aba5495f81@kernel.dk>
Date: Tue, 18 Oct 2016 17:11:57 -0600
MIME-Version: 1.0
In-Reply-To: <20161018230740.GE14023@dastard>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/18/2016 05:07 PM, Dave Chinner wrote:
> Hi Jens,
>
> One of my test VMs (4p, 4GB RAM) tripped over this last night
> running xfs/297 over a pair of 20GB iscsi luns:
>
> [ 8341.363558] ------------[ cut here ]------------
> [ 8341.364360] WARNING: CPU: 0 PID: 10929 at lib/list_debug.c:33 __list_add+0x89/0xb0
> [ 8341.365439] list_add corruption. prev->next should be next (ffffe8ffffc02808), but was ffffc90005f6bda8. (prev=ffff88013363bb80).
> [ 8341.366900] Modules linked in:
> [ 8341.367305] CPU: 0 PID: 10929 Comm: fsstress Tainted: G        W       4.9.0-rc1-dgc+ #1001
> [ 8341.368323] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
> [ 8341.369431]  ffffc90009d1b860 ffffffff81821c60 ffffc90009d1b8b0 0000000000000000
> [ 8341.370423]  ffffc90009d1b8a0 ffffffff810b69fb 0000002181808107 ffff880133713840
> [ 8341.371415]  ffff88013363bb80 ffffe8ffffc02808 ffffe8ffffc02800 0000000000000008
> [ 8341.372442] Call Trace:
> [ 8341.372759]  [<ffffffff81821c60>] dump_stack+0x63/0x83
> [ 8341.373411]  [<ffffffff810b69fb>] __warn+0xcb/0xf0
> [ 8341.374017]  [<ffffffff810b6a6f>] warn_slowpath_fmt+0x4f/0x60
> [ 8341.374741]  [<ffffffff817f7cbf>] ? part_round_stats+0x4f/0x60
> [ 8341.375466]  [<ffffffff8183e999>] __list_add+0x89/0xb0
> [ 8341.376125]  [<ffffffff81806c8c>] blk_sq_make_request+0x3ec/0x520
> [ 8341.376881]  [<ffffffff817facf0>] generic_make_request+0xd0/0x1c0
> [ 8341.377637]  [<ffffffff817fae38>] submit_bio+0x58/0x100
> [ 8341.378315]  [<ffffffff815176a2>] xfs_submit_ioend+0x82/0xd0
> [ 8341.379039]  [<ffffffff81517619>] ? xfs_start_page_writeback+0x99/0xa0
> [ 8341.379845]  [<ffffffff8151827a>] xfs_do_writepage+0x59a/0x730
> [ 8341.380601]  [<ffffffff811b1fc6>] write_cache_pages+0x1f6/0x550
> [ 8341.381357]  [<ffffffff81517ce0>] ? xfs_aops_discard_page+0x140/0x140
> [ 8341.382158]  [<ffffffff81517790>] xfs_vm_writepages+0xa0/0xd0
> [ 8341.382887]  [<ffffffff811b2bde>] do_writepages+0x1e/0x30
> [ 8341.383603]  [<ffffffff811a68d1>] __filemap_fdatawrite_range+0x71/0x90
> [ 8341.384423]  [<ffffffff811a6a31>] filemap_write_and_wait_range+0x41/0x90
> [ 8341.385255]  [<ffffffff8151ca94>] xfs_free_file_space+0xb4/0x460
> [ 8341.386021]  [<ffffffff817b13fd>] ? avc_has_perm+0xad/0x1b0
> [ 8341.386715]  [<ffffffff810dd57a>] ? __might_sleep+0x4a/0x80
> [ 8341.387422]  [<ffffffff8151ce79>] xfs_zero_file_space+0x39/0xd0
> [ 8341.388164]  [<ffffffff81524fec>] xfs_file_fallocate+0x2fc/0x340
> [ 8341.388917]  [<ffffffff817b7827>] ? selinux_file_permission+0xd7/0x110
> [ 8341.389738]  [<ffffffff810dd57a>] ? __might_sleep+0x4a/0x80
> [ 8341.390439]  [<ffffffff811ff4c7>] vfs_fallocate+0x157/0x220
> [ 8341.391156]  [<ffffffff81200338>] SyS_fallocate+0x48/0x80
> [ 8341.391834]  [<ffffffff81002b97>] do_syscall_64+0x67/0x180
> [ 8341.392517]  [<ffffffff81c8edab>] entry_SYSCALL64_slow_path+0x25/0x25
> [ 8341.393343] ---[ end trace 477b0f6e35ebd064 ]---
> [ 8341.502708] ------------[ cut here ]------------
> [ 8341.503479] WARNING: CPU: 1 PID: 27731 at lib/list_debug.c:29 __list_add+0x62/0xb0
> [ 8341.505131] list_add corruption. next->prev should be prev (ffffe8ffffc02808), but was ffff880133795dc0. (next=ffffe8ffffc02808).
> [ 8341.506657] Modules linked in:
> [ 8341.507092] CPU: 1 PID: 27731 Comm: kworker/1:0H Tainted: G        W       4.9.0-rc1-dgc+ #1001
> [ 8341.508137] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
> [ 8341.509228] Workqueue: kblockd blk_mq_requeue_work
> [ 8341.509819]  ffffc900038efcb8 ffffffff81821c60 ffffc900038efd08 0000000000000000
> [ 8341.510760]  ffffc900038efcf8 ffffffff810b69fb 0000001d3371cf98 ffff88013363e100
> [ 8341.511729]  ffffe8ffffc02808 ffffe8ffffc02808 ffffc900038efde0 ffff88013363e100
> [ 8341.512708] Call Trace:
> [ 8341.513026]  [<ffffffff81821c60>] dump_stack+0x63/0x83
> [ 8341.513669]  [<ffffffff810b69fb>] __warn+0xcb/0xf0
> [ 8341.514283]  [<ffffffff810b6a6f>] warn_slowpath_fmt+0x4f/0x60
> [ 8341.515003]  [<ffffffff810eeb76>] ? set_next_entity+0xb6/0x970
> [ 8341.515733]  [<ffffffff810e96e0>] ? account_entity_dequeue+0x70/0x90
> [ 8341.516521]  [<ffffffff8183e972>] __list_add+0x62/0xb0
> [ 8341.517162]  [<ffffffff8180700e>] blk_mq_insert_request+0x11e/0x130
> [ 8341.517951]  [<ffffffff8180763c>] blk_mq_requeue_work+0xbc/0x130
> [ 8341.518701]  [<ffffffff810d01d0>] process_one_work+0x180/0x440
> [ 8341.519430]  [<ffffffff810d04de>] worker_thread+0x4e/0x490
> [ 8341.520119]  [<ffffffff810d0490>] ? process_one_work+0x440/0x440
> [ 8341.520865]  [<ffffffff810d0490>] ? process_one_work+0x440/0x440
> [ 8341.521612]  [<ffffffff810d6255>] kthread+0xd5/0xf0
> [ 8341.522226]  [<ffffffff810d6180>] ? kthread_park+0x60/0x60
> [ 8341.522912]  [<ffffffff81c8ef45>] ret_from_fork+0x25/0x30
> [ 8341.523620] ---[ end trace 477b0f6e35ebd065 ]---
>
> I haven't seen it before, hence it's probably a regression. I
> haven't tried to reproduce it yet, so I don't know if it's easy
> to trip over.

Dave Jones just reported the same thing, and also as a regression from
4.8. I'll look into this, nothing sticks out at me immediately. It's
hitting both sq/mq cases.

-- 
Jens Axboe
