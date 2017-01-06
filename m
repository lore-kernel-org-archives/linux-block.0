Return-Path: <dan.j.williams@gmail.com>
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1480580308-15342-1-git-send-email-jack@suse.cz>
References: <1480580308-15342-1-git-send-email-jack@suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 5 Jan 2017 16:03:58 -0800
Message-ID: <CAA9_cmdr46h6wn8Eb3-BuJKN2cTQtdTodmuFG9xVXUU+m+gspg@mail.gmail.com>
Subject: Re: [PATCH] block: protect iterate_bdevs() against concurrent close
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	Wei Fang <fangwei1@huawei.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Rabin Vincent <rabinv@axis.com>, stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 1, 2016 at 12:18 AM, Jan Kara <jack@suse.cz> wrote:
> From: Rabin Vincent <rabinv@axis.com>
>
> If a block device is closed while iterate_bdevs() is handling it, the
> following NULL pointer dereference occurs because bdev->b_disk is NULL
> in bdev_get_queue(), which is called from blk_get_backing_dev_info() (in
> turn called by the mapping_cap_writeback_dirty() call in
> __filemap_fdatawrite_range()):
>
>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000508
>  IP: [<ffffffff81314790>] blk_get_backing_dev_info+0x10/0x20
>  PGD 9e62067 PUD 9ee8067 PMD 0
>  Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
>  Modules linked in:
>  CPU: 1 PID: 2422 Comm: sync Not tainted 4.5.0-rc7+ #400
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>  task: ffff880009f4d700 ti: ffff880009f5c000 task.ti: ffff880009f5c000
>  RIP: 0010:[<ffffffff81314790>]  [<ffffffff81314790>] blk_get_backing_dev_info+0x10/0x20
>  RSP: 0018:ffff880009f5fe68  EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: ffff88000ec17a38 RCX: ffffffff81a4e940
>  RDX: 7fffffffffffffff RSI: 0000000000000000 RDI: ffff88000ec176c0
>  RBP: ffff880009f5fe68 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000001 R11: 0000000000000000 R12: ffff88000ec17860
>  R13: ffffffff811b25c0 R14: ffff88000ec178e0 R15: ffff88000ec17a38
>  FS:  00007faee505d700(0000) GS:ffff88000fb00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>  CR2: 0000000000000508 CR3: 0000000009e8a000 CR4: 00000000000006e0
>  Stack:
>   ffff880009f5feb8 ffffffff8112e7f5 0000000000000000 7fffffffffffffff
>   0000000000000000 0000000000000000 7fffffffffffffff 0000000000000001
>   ffff88000ec178e0 ffff88000ec17860 ffff880009f5fec8 ffffffff8112e81f
>  Call Trace:
>   [<ffffffff8112e7f5>] __filemap_fdatawrite_range+0x85/0x90
>   [<ffffffff8112e81f>] filemap_fdatawrite+0x1f/0x30
>   [<ffffffff811b25d6>] fdatawrite_one_bdev+0x16/0x20
>   [<ffffffff811bc402>] iterate_bdevs+0xf2/0x130
>   [<ffffffff811b2763>] sys_sync+0x63/0x90
>   [<ffffffff815d4272>] entry_SYSCALL_64_fastpath+0x12/0x76
>  Code: 0f 1f 44 00 00 48 8b 87 f0 00 00 00 55 48 89 e5 <48> 8b 80 08 05 00 00 5d
>  RIP  [<ffffffff81314790>] blk_get_backing_dev_info+0x10/0x20
>   RSP <ffff880009f5fe68>
>  CR2: 0000000000000508
>  ---[ end trace 2487336ceb3de62d ]---
>
> The crash is easily reproducible by running the following command, if an
> msleep(100) is inserted before the call to func() in iterate_devs():
>
>  while :; do head -c1 /dev/nullb0; done > /dev/null & while :; do sync; done
>
> Fix it by holding the bd_mutex across the func() call and only calling
> func() if the bdev is opened.
>
> Cc: stable@vger.kernel.org
> Fixes: 5c0d6b60a0ba46d45020547eacf7199171920935
> Reported-and-tested-by: Wei Fang <fangwei1@huawei.com>
> Signed-off-by: Rabin Vincent <rabinv@axis.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/block_dev.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 05b553368bb4..899fa8ccc347 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1950,6 +1950,7 @@ void iterate_bdevs(void (*func)(struct block_device *, void *), void *arg)
>         spin_lock(&blockdev_superblock->s_inode_list_lock);
>         list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
>                 struct address_space *mapping = inode->i_mapping;
> +               struct block_device *bdev;
>
>                 spin_lock(&inode->i_lock);
>                 if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
> @@ -1970,8 +1971,12 @@ void iterate_bdevs(void (*func)(struct block_device *, void *), void *arg)
>                  */
>                 iput(old_inode);
>                 old_inode = inode;
> +               bdev = I_BDEV(inode);
>
> -               func(I_BDEV(inode), arg);
> +               mutex_lock(&bdev->bd_mutex);
> +               if (bdev->bd_openers)
> +                       func(bdev, arg);
> +               mutex_unlock(&bdev->bd_mutex);
>
>                 spin_lock(&blockdev_superblock->s_inode_list_lock);
>         }
> --


Hi,

I hit a bug with a similar signature back in October:

    http://marc.info/?l=linux-block&m=147769594003740&w=2

...and still see it in 4.10-rc2.

My reproducer is not very reliable. I'm thinking this fix doesn't work
because it assumes the only race is close vs sync, but my case is
device-shutdown vs sync. In fact iterate_bdevs() is not in my
backtrace:

[ 5750.941063] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000568
[..]
[ 5750.959449] CPU: 1 PID: 8910 Comm: lt-libndctl Tainted: G
O    4.10.0-rc2+ #672
[ 5750.961283] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
[ 5750.963538] task: ffff88033173c600 task.stack: ffffc90006a80000
[ 5750.964694] RIP: 0010:blk_get_backing_dev_info+0x10/0x20
[ 5750.965774] RSP: 0018:ffffc90006a83b00 EFLAGS: 00010246
[ 5750.966842] RAX: 0000000000000000 RBX: ffffc90006a83b60 RCX: 0000000000000000
[ 5750.968136] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88031b3a8040
[ 5750.969429] RBP: ffffc90006a83b00 R08: ffffffff82b013d0 R09: ffffffff81ea8107
[ 5750.970732] R10: 0000000000000001 R11: ffffffff82acd5c0 R12: ffff88031b3a83d0
[ 5750.972046] R13: ffff88031b3a81d0 R14: ffff8801efa934a0 R15: ffff88031b3a81d0
[ 5750.973344] FS:  00007f2cc4ed5d80(0000) GS:ffff88033ed00000(0000)
knlGS:0000000000000000
[ 5750.975171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5750.976295] CR2: 0000000000000568 CR3: 0000000333fcf000 CR4: 00000000000406e0
[ 5750.977608] Call Trace:
[ 5750.978345]  __inode_attach_wb+0x3a7/0x5d0
[ 5750.979281]  __filemap_fdatawrite_range+0xf8/0x100
[ 5750.980303]  filemap_write_and_wait+0x40/0x90
[ 5750.981270]  fsync_bdev+0x54/0x60
[ 5750.982110]  ? bdget_disk+0x30/0x40
[ 5750.982967]  invalidate_partition+0x24/0x50
[ 5750.983910]  del_gendisk+0xfa/0x230
[ 5750.984768]  pmem_release_disk+0x12/0x20 [nd_pmem]
[ 5750.985787]  devm_action_release+0xf/0x20
[ 5750.986697]  release_nodes+0x16d/0x2b0
[ 5750.987595]  devres_release_all+0x3c/0x60
[ 5750.988510]  device_release_driver_internal+0x16d/0x210
[ 5750.989586]  device_release_driver+0x12/0x20
[ 5750.990537]  unbind_store+0x10f/0x160
[ 5750.991425]  drv_attr_store+0x25/0x30
[ 5750.992301]  sysfs_kf_write+0x45/0x60
[ 5750.993176]  kernfs_fop_write+0x13c/0x1c0
[ 5750.994099]  __vfs_write+0x37/0x160
[ 5750.994967]  ? rcu_read_lock_sched_held+0x5d/0x70
[ 5750.995975]  ? rcu_sync_lockdep_assert+0x2f/0x60
[ 5750.996975]  ? __sb_start_write+0xce/0x1d0
[ 5750.997913]  ? vfs_write+0x17d/0x1a0
[ 5750.998790]  vfs_write+0xb5/0x1a0
[ 5750.999626]  SyS_write+0x58/0xc0
[ 5751.000458]  entry_SYSCALL_64_fastpath+0x1f/0xc2

...so I'm going to take a look at having blk_get_backing_dev_info()
take its own blkdev_get() reference.
