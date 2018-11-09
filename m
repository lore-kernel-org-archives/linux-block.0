Return-Path: <axboe@kernel.dk>
Subject: Re: [LKP] a9f38e1dec [ 245.678853] INFO: task mount:580 blocked for
 more than 120 seconds.
To: kernel test robot <rong.a.chen@intel.com>, Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 LKP <lkp@01.org>
References: <20181107031643.GD24195@shao2-debian>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6914078b-a348-f92d-abbb-b2ccb162fc80@kernel.dk>
Date: Fri, 9 Nov 2018 15:59:41 -0700
MIME-Version: 1.0
In-Reply-To: <20181107031643.GD24195@shao2-debian>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 11/6/18 8:16 PM, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit a9f38e1dec107af70d81338332494bf0a1e76597
> Author:     Omar Sandoval <osandov@fb.com>
> AuthorDate: Mon Oct 15 09:21:34 2018 -0600
> Commit:     Jens Axboe <axboe@kernel.dk>
> CommitDate: Tue Oct 16 09:50:14 2018 -0600
> 
>     floppy: convert to blk-mq
>     
>     This driver likes to fetch requests from all over the place, so make
>     queue_rq put requests on a list so that the logic stays the same. Tested
>     with QEMU.
>     
>     Signed-off-by: Omar Sandoval <osandov@fb.com>
>     
>     Converted to blk_mq_init_sq_queue() and fixed a few spots where the
>     tag_set leaked on cleanup.
>     
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

I don't think this is the reason for the hang, I think it just exposed
it. I posted a patch to fix this, hopefully, it's included below as
well. Can you give it a try?


>From fd85da23e51d8c055592c2fde5bc36d43eb29074 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 9 Nov 2018 15:53:04 -0700
Subject: [PATCH] floppy: fix race condition in __floppy_read_block_0()

LKP recently reported a hang at bootup in the floppy code:

[  245.678853] INFO: task mount:580 blocked for more than 120 seconds.
[  245.679906]       Tainted: G                T 4.19.0-rc6-00172-ga9f38e1 #1
[  245.680959] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  245.682181] mount           D 6372   580      1 0x00000004
[  245.683023] Call Trace:
[  245.683425]  __schedule+0x2df/0x570
[  245.683975]  schedule+0x2d/0x80
[  245.684476]  schedule_timeout+0x19d/0x330
[  245.685090]  ? wait_for_common+0xa5/0x170
[  245.685735]  wait_for_common+0xac/0x170
[  245.686339]  ? do_sched_yield+0x90/0x90
[  245.686935]  wait_for_completion+0x12/0x20
[  245.687571]  __floppy_read_block_0+0xfb/0x150
[  245.688244]  ? floppy_resume+0x40/0x40
[  245.688844]  floppy_revalidate+0x20f/0x240
[  245.689486]  check_disk_change+0x43/0x60
[  245.690087]  floppy_open+0x1ea/0x360
[  245.690653]  __blkdev_get+0xb4/0x4d0
[  245.691212]  ? blkdev_get+0x1db/0x370
[  245.691777]  blkdev_get+0x1f3/0x370
[  245.692351]  ? path_put+0x15/0x20
[  245.692871]  ? lookup_bdev+0x4b/0x90
[  245.693539]  blkdev_get_by_path+0x3d/0x80
[  245.694165]  mount_bdev+0x2a/0x190
[  245.694695]  squashfs_mount+0x10/0x20
[  245.695271]  ? squashfs_alloc_inode+0x30/0x30
[  245.695960]  mount_fs+0xf/0x90
[  245.696451]  vfs_kern_mount+0x43/0x130
[  245.697036]  do_mount+0x187/0xc40
[  245.697563]  ? memdup_user+0x28/0x50
[  245.698124]  ksys_mount+0x60/0xc0
[  245.698639]  sys_mount+0x19/0x20
[  245.699167]  do_int80_syscall_32+0x61/0x130
[  245.699813]  entry_INT80_32+0xc7/0xc7

showing that we never complete that read request. The reason is that
the completion setup is racy - it initializes the completion event
AFTER submitting the IO, which means that the IO could complete
before/during the init. If it does, we are passing garbage to
complete() and we may sleep forever waiting for the event to
occur.

Fixes: 7b7b68bba5ef ("floppy: bail out in open() if drive is not responding to block0 read")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/floppy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index a8cfa011c284..fb23578e9a41 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4148,10 +4148,11 @@ static int __floppy_read_block_0(struct block_device *bdev, int drive)
 	bio.bi_end_io = floppy_rb0_cb;
 	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
 
+	init_completion(&cbdata.complete);
+
 	submit_bio(&bio);
 	process_fd_request();
 
-	init_completion(&cbdata.complete);
 	wait_for_completion(&cbdata.complete);
 
 	__free_page(page);
-- 
2.17.1


-- 
Jens Axboe
