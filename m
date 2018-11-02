Return-Path: <axboe@kernel.dk>
Subject: Re: [LKP] a518560778 [ 16.132179] BUG: KASAN: null-ptr-deref in
 brd_alloc
To: Ming Lei <ming.lei@redhat.com>, kernel test robot <rong.a.chen@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 LKP <lkp@01.org>
References: <20181102001957.GE24195@shao2-debian>
 <20181102005344.GD24769@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <de15243e-1ee4-f17b-34f5-5901ce11b5da@kernel.dk>
Date: Thu, 1 Nov 2018 20:00:17 -0600
MIME-Version: 1.0
In-Reply-To: <20181102005344.GD24769@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/1/18 6:53 PM, Ming Lei wrote:
> On Fri, Nov 02, 2018 at 08:19:57AM +0800, kernel test robot wrote:
>> Greetings,
>>
>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-linus
>>
>> commit a5185607787e030fcb0009194d3b12f8bcca59d6
>> Author:     Ming Lei <ming.lei@redhat.com>
>> AuthorDate: Wed Oct 31 16:40:50 2018 +0800
>> Commit:     Jens Axboe <axboe@kernel.dk>
>> CommitDate: Wed Oct 31 08:43:09 2018 -0600
>>
>>     block: brd: associate with queue until adding disk
>>     
>>     brd_free() may be called in failure path on one brd instance without
>>     the disk being added yet, so release handler of gendisk may free the
>>     associated request_queue early and cause the following use-after-free[1].
>>     
>>     This patch fixes this issue by associating gendisk with request_queue
>>     just before adding disk.
>>     
>>     [1] KASAN: use-after-free Read in del_timer_syncNon-volatile memory driver v1.3
>>     Linux agpgart interface v0.103
>>     [drm] Initialized vgem 1.0.0 20120112 for virtual device on minor 0
>>     usbcore: registered new interface driver udl
>>     ==================================================================
>>     BUG: KASAN: use-after-free in __lock_acquire+0x36d9/0x4c20
>>     kernel/locking/lockdep.c:3218
>>     Read of size 8 at addr ffff8801d1b6b540 by task swapper/0/1
>>     
>>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0+ #88
>>     Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>     Google 01/01/2011
>>     Call Trace:
>>       __dump_stack lib/dump_stack.c:77 [inline]
>>       dump_stack+0x244/0x39d lib/dump_stack.c:113
>>       print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
>>       kasan_report_error mm/kasan/report.c:354 [inline]
>>       kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
>>       __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>>       __lock_acquire+0x36d9/0x4c20 kernel/locking/lockdep.c:3218
>>       lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
>>       del_timer_sync+0xb7/0x270 kernel/time/timer.c:1283
>>       blk_cleanup_queue+0x413/0x710 block/blk-core.c:809
>>       brd_free+0x5d/0x71 drivers/block/brd.c:422
>>       brd_init+0x2eb/0x393 drivers/block/brd.c:518
>>       do_one_initcall+0x145/0x957 init/main.c:890
>>       do_initcall_level init/main.c:958 [inline]
>>       do_initcalls init/main.c:966 [inline]
>>       do_basic_setup init/main.c:984 [inline]
>>       kernel_init_freeable+0x5c6/0x6b9 init/main.c:1148
>>       kernel_init+0x11/0x1ae init/main.c:1068
>>       ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:350
>>     
>>     Reported-by: syzbot+3701447012fe951dabb2@syzkaller.appspotmail.com
>>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Sorry, my fault.
> 
> Jens, I just sent you V2 which fixes this issue, could you drop V1 from
> your for-linus and apply V2 against it?

Just did, dropped v1 and added v2 instead.

-- 
Jens Axboe
