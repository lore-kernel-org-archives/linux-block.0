Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1050.oracle.com ([141.146.126.70]:32644 "EHLO
        aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754793AbcH0HLp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Aug 2016 03:11:45 -0400
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jens Axboe <axboe@fb.com>
Cc: Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH] bdev: fix NULL pointer dereference in sync()/close() race
Date: Sat, 27 Aug 2016 09:07:28 +0200
Message-Id: <20160827070728.12432-1-vegard.nossum@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I got this with syzkaller:

    general protection fault: 0000 [#1] PREEMPT SMP KASAN
    Dumping ftrace buffer:
       (ftrace buffer empty)
    CPU: 0 PID: 11941 Comm: syz-executor Not tainted 4.8.0-rc2+ #169
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
    task: ffff880110762cc0 task.stack: ffff880102290000
    RIP: 0010:[<ffffffff81f04b7a>]  [<ffffffff81f04b7a>] blk_get_backing_dev_info+0x4a/0x70
    RSP: 0018:ffff880102297cd0  EFLAGS: 00010202
    RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90000bb4000
    RDX: 0000000000000097 RSI: 0000000000000000 RDI: 00000000000004b8
    RBP: ffff880102297cd8 R08: 0000000000000000 R09: 0000000000000001
    R10: 0000000000000000 R11: 0000000000000001 R12: ffff88011a010a90
    R13: ffff88011a594568 R14: ffff88011a010890 R15: 7fffffffffffffff
    FS:  00007f2445174700(0000) GS:ffff88011aa00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00000000200047c8 CR3: 0000000107eb5000 CR4: 00000000000006f0
    DR0: 000000000000001e DR1: 000000000000001e DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
    Stack:
     1ffff10020452f9e ffff880102297db8 ffffffff81508daa 0000000000000000
     0000000041b58ab3 ffffffff844e89e1 ffffffff81508b30 ffffed0020452001
     7fffffffffffffff 0000000000000000 0000000000000000 7fffffffffffffff
    Call Trace:
     [<ffffffff81508daa>] __filemap_fdatawrite_range+0x27a/0x2e0
     [<ffffffff81508b30>] ? filemap_check_errors+0xe0/0xe0
     [<ffffffff83c24b47>] ? preempt_schedule+0x27/0x30
     [<ffffffff810020ae>] ? ___preempt_schedule+0x16/0x18
     [<ffffffff81508e36>] filemap_fdatawrite+0x26/0x30
     [<ffffffff817191b0>] fdatawrite_one_bdev+0x50/0x70
     [<ffffffff817341b4>] iterate_bdevs+0x194/0x210
     [<ffffffff81719160>] ? fdatawait_one_bdev+0x70/0x70
     [<ffffffff817195f0>] ? sync_filesystem+0x240/0x240
     [<ffffffff817196be>] sys_sync+0xce/0x160
     [<ffffffff817195f0>] ? sync_filesystem+0x240/0x240
     [<ffffffff81002b60>] ? exit_to_usermode_loop+0x190/0x190
     [<ffffffff8150455a>] ? __context_tracking_exit.part.4+0x3a/0x1e0
     [<ffffffff81005524>] do_syscall_64+0x1c4/0x4e0
     [<ffffffff83c3276a>] entry_SYSCALL64_slow_path+0x25/0x25
    Code: 89 fa 48 c1 ea 03 80 3c 02 00 75 35 48 8b 9b e0 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d bb b8 04 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 17 48 8b 83 b8 04 00 00 5b 5d 48 05 10 02 00 00
    RIP  [<ffffffff81f04b7a>] blk_get_backing_dev_info+0x4a/0x70
     RSP <ffff880102297cd0>

The problem is that sync() calls down to blk_get_backing_dev_info()
without necessarily having the block device opened (if it races with
another process doing close()):

    /**
     * blk_get_backing_dev_info - get the address of a queue's backing_dev_info
     * @bdev:       device
     *
     * Locates the passed device's request queue and returns the address of its
     * backing_dev_info.  This function can only be called if @bdev is opened      <----
     * and the return value is never NULL.
     */
    struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev)
    {
            struct request_queue *q = bdev_get_queue(bdev);

            return &q->backing_dev_info;
    }

bdev_get_queue() crashes on dereferencing bdev->bd_disk->queue because
->bd_disk was set to NULL when close() reached __blkdev_put().

Taking bdev->bd_mutex and checking bdev->bd_disk actually seems to be a
reliable test of whether it's safe to call filemap_fdatawrite() for the
block device inode and completely fixes the crash for me.

What I don't like about this patch is that it simply skips block devices
which we don't have any open file descriptors for. That seems wrong to
me because sync() should do writeback on (and wait for) _all_ devices,
not just the ones that we happen to have an open file descriptor for.
Imagine if we opened a device, wrote a lot of data to it, closed it,
called sync(), and sync() returns. Now we should be guaranteed the data
was written, but I'm not sure we are in this case. But maybe I've
misunderstood how the writeback mechanism works.

Another ugly thing is that we're now holding a new mutex over a
potentially big chunk of code (everything that happens inside
filemap_fdatawrite()). The only thing I can say is that it seems to
work here.

I have a reproducer that reliably triggers the problem in ~2 seconds so
I can easily test other proposed fixes if there are any. I would also be
happy to submit a new patch with some guidance on the Right Way to fix
this.

Cc: stable@vger.kernel.org
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 fs/sync.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/sync.c b/fs/sync.c
index 2a54c1f..9189eeb 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -81,7 +81,10 @@ static void sync_fs_one_sb(struct super_block *sb, void *arg)
 
 static void fdatawrite_one_bdev(struct block_device *bdev, void *arg)
 {
-	filemap_fdatawrite(bdev->bd_inode->i_mapping);
+	mutex_lock(&bdev->bd_mutex);
+	if (bdev->bd_disk)
+		filemap_fdatawrite(bdev->bd_inode->i_mapping);
+	mutex_unlock(&bdev->bd_mutex);
 }
 
 static void fdatawait_one_bdev(struct block_device *bdev, void *arg)
-- 
2.10.0.rc0.1.g07c9292

