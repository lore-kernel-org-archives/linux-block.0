Return-Path: <ebiggers3@gmail.com>
Return-Path: <ebiggers3@gmail.com>
Date: Tue, 30 Jan 2018 14:07:05 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <bot+a6509faab336a599793a6b78dbd65978d453baf6@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 blk_throtl_update_limit_valid
Message-ID: <20180130220705.j75vdli6kaubb7eo@gmail.com>
References: <001a1148cc3a38c5bf0560b27810@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001a1148cc3a38c5bf0560b27810@google.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Dec 19, 2017 at 06:42:00AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 6084b576dca2e898f5c101baef151f7bfdbb606d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> Unfortunately, I don't have any reproducer for this bug yet.
> 
> 
> netlink: 14 bytes leftover after parsing attributes in process
> `syz-executor6'.
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000098
> IP: blk_throtl_update_limit_valid.isra.19+0x6a/0x2e0
> block/blk-throttle.c:580
> PGD 213563067 P4D 213563067 PUD 214f2a067 PMD 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 3445 Comm: kworker/1:3 Not tainted 4.15.0-rc3-next-20171214+ #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events __blk_release_queue
> RIP: 0010:blk_throtl_update_limit_valid.isra.19+0x6a/0x2e0
> block/blk-throttle.c:580
> RSP: 0018:ffffc90002e13d30 EFLAGS: 00010093
> RAX: ffff8801e125c600 RBX: ffff8801df611c00 RCX: ffffffff81714e8a
> RDX: 0000000000000000 RSI: 00000000d36b0597 RDI: 0000000000000086
> RBP: ffffc90002e13d68 R08: 0000000000000001 R09: 000000000000000a
> R10: ffffc90002e13cb8 R11: 000000000000000a R12: 0000000000000000
> R13: ffff8801dfdcd808 R14: ffffffff817178f0 R15: 0000000000000098
> FS:  0000000000000000(0000) GS:ffff88021fd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000098 CR3: 0000000213784000 CR4: 00000000001426e0
> DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  throtl_pd_offline+0x4e/0x80 block/blk-throttle.c:602
>  blkg_destroy+0x93/0x270 block/blk-cgroup.c:327
>  blkg_destroy_all+0x69/0xe0 block/blk-cgroup.c:372
>  blkcg_exit_queue+0x21/0x40 block/blk-cgroup.c:1202
>  __blk_release_queue+0x54/0x180 block/blk-sysfs.c:802
>  process_one_work+0x288/0x7a0 kernel/workqueue.c:2112
>  worker_thread+0x43/0x4d0 kernel/workqueue.c:2246
>  kthread+0x149/0x170 kernel/kthread.c:238
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:524
> Code: c7 40 07 08 83 e8 c7 15 b1 ff e8 52 85 b3 ff 85 c0 59 74 12 e8 c8 54
> ba ff 80 3d aa f0 a9 01 00 0f 84 fd 01 00 00 e8 b6 54 ba ff <49> 8b 07 31 ff
> 48 8b 80 c8 06 00 00 48 8b 70 28 e8 e1 d9 b7 ff
> RIP: blk_throtl_update_limit_valid.isra.19+0x6a/0x2e0
> block/blk-throttle.c:580 RSP: ffffc90002e13d30
> CR2: 0000000000000098
> ---[ end trace b30dc449e3987ceb ]---
> Kernel panic - not syncing: Fatal exception
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
