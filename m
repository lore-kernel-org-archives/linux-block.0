Return-Path: <ebiggers3@gmail.com>
Return-Path: <ebiggers3@gmail.com>
Date: Thu, 1 Feb 2018 19:58:45 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Hou Tao <houtao1@huawei.com>, Foy <long7573@126.com>,
	Jens Axboe <axboe@kernel.dk>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Paolo Valente <paolo.valente@linaro.org>, security@kernel.org,
	syzkaller@googlegroups.com, linux-block@vger.kernel.org
Subject: Re: blkdev loop UAF
Message-ID: <20180202035845.GA949@zzz.localdomain>
References: <654967ea.6cce.160e43379f6.Coremail.long7573@126.com>
 <20180111082441.myaxc2upbjhcucqh@mwanda>
 <69a2465f-dd67-6962-4f15-57fa9cbafe4d@huawei.com>
 <20180111170008.24crzej4utoh5s3p@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180111170008.24crzej4utoh5s3p@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 11, 2018 at 06:00:08PM +0100, Jan Kara wrote:
> On Thu 11-01-18 19:22:39, Hou Tao wrote:
> > Hi,
> > 
> > On 2018/1/11 16:24, Dan Carpenter wrote:
> > > Thanks for your report and the patch.  I am sending it to the
> > > linux-block devs since it's already public.
> > > 
> > > regards,
> > > dan carpenter
> > 
> > The User-after-free problem is not specific for loop device, it can also
> > be reproduced on scsi device, and there are more race problems caused by
> > the race between bdev open and gendisk shutdown [1].
> > 
> > The cause of the UAF problem is that there are two instances of gendisk which share
> > the same bdev. After the process owning the new gendisk increases bdev->bd_openers,
> > the other process which owns the older gendisk will find bdev->bd_openers is not zero
> > and will put the last reference of the older gendisk and cause User-after-free.
> > 
> > I had proposed a patch for the problem, but it's still an incomplete fix for the race
> > between gendisk shutdown and bdev opening.
> > 
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 4a181fc..5ecdb9f 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -1510,6 +1510,11 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
> >                 if (bdev->bd_bdi == &noop_backing_dev_info)
> >                         bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
> >         } else {
> > +               if (bdev->bd_disk != disk) {
> > +                       ret = -ENXIO;
> > +                       goto out_unlock_bdev;
> > +               }
> > +
> >                 if (bdev->bd_contains == bdev) {
> >                         ret = 0;
> >                         if (bdev->bd_disk->fops->open)
> > 
> > 
> > As far as I know, Jan Kara is working on these problems. So, Jan, any suggestions ?
> 
> Yeah, thanks for the ping. I was working today to get this fixed. I have
> about 6 patches (attached) which should fix all the outstanding issues I'm
> aware of.  So far they are only boot tested. I will give them more
> stress-testing next week and then post them officially but if you have time,
> feel free to try them out as well. Thanks!
> 

Jan, are you still planning to fix this?  This was also reported by syzbot here:
https://groups.google.com/d/msg/syzkaller-bugs/9wXx4YULITQ/0SK8vqxhAgAJ.  Note
that the C reproducer attached to that report doesn't work for me anymore
following ae6650163c6 ("loop: fix concurrent lo_open/lo_release").  However,
syzbot has still hit this on more recent kernels.  Here's a C reproducer that
still works for me on Linus' tree as of today, though it can take 5-10 seconds:

#include <fcntl.h>
#include <linux/loop.h>
#include <sys/ioctl.h>
#include <unistd.h>

int main()
{
	int fd = open("/dev/loop-control", 0);

	if (!fork()) {
		for (;;)
			ioctl(fd, LOOP_CTL_ADD, 0);
	}

	if (!fork()) {
		for (;;)
			ioctl(fd, LOOP_CTL_REMOVE, 0);
	}

	fork();
	for (;;) {
		fd = open("/dev/loop0", O_EXCL);
		close(fd);
	}
}

This is the KASAN splat I get from the above:

BUG: KASAN: use-after-free in disk_unblock_events+0x3e/0x40 block/genhd.c:1672
Read of size 8 at addr ffff880030743670 by task systemd-udevd/165

CPU: 1 PID: 165 Comm: systemd-udevd Not tainted 4.15.0-08279-gfe53d1443a146 #38
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0xb3/0x145 lib/dump_stack.c:53
perf: interrupt took too long (7334 > 4816), lowering kernel.perf_event_max_sample_rate to 27000
 print_address_description+0x73/0x290 mm/kasan/report.c:252
 kasan_report_error mm/kasan/report.c:351 [inline]
 kasan_report+0x235/0x350 mm/kasan/report.c:409
 disk_unblock_events+0x3e/0x40 block/genhd.c:1672
 __blkdev_get+0x41b/0xd30 fs/block_dev.c:1535
 blkdev_get+0x283/0x980 fs/block_dev.c:1591
 do_dentry_open.isra.1+0x6c0/0xaf0 fs/open.c:752
 do_last fs/namei.c:3378 [inline]
 path_openat+0x587/0x28b0 fs/namei.c:3518
 do_filp_open+0x231/0x3a0 fs/namei.c:3553
 do_sys_open+0x399/0x610 fs/open.c:1059
 do_syscall_64+0x213/0x740 arch/x86/entry/common.c:285
 entry_SYSCALL64_slow_path+0x25/0x25
RIP: 0033:0x7f51d23262ce
RSP: 002b:00007ffdf1844310 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000562878961d30 RCX: 00007f51d23262ce
RDX: 00000000000a0800 RSI: 0000562878974860 RDI: ffffffffffffff9c
RBP: 0000562878965150 R08: 00007f51d1c9d914 R09: ffffffffffffffb0
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000e
R13: 0000562878965150 R14: 0000000000000004 R15: 0000000000000003

Allocated by task 160:
 kmem_cache_alloc_node_trace include/linux/slab.h:413 [inline]
 kmalloc_node include/linux/slab.h:537 [inline]
 kzalloc_node include/linux/slab.h:699 [inline]
 __alloc_disk_node+0xb6/0x450 block/genhd.c:1415
 loop_add+0x3fd/0x9e0 drivers/block/loop.c:1814
 loop_probe+0x152/0x180 drivers/block/loop.c:1921
 kobj_lookup+0x176/0x310 drivers/base/map.c:124
 get_gendisk+0x28/0x290 block/genhd.c:804
 __blkdev_get+0x2ec/0xd30 fs/block_dev.c:1433
 blkdev_get+0x485/0x980 fs/block_dev.c:1591
 do_dentry_open.isra.1+0x6c0/0xaf0 fs/open.c:752
 do_last fs/namei.c:3378 [inline]
 path_openat+0x587/0x28b0 fs/namei.c:3518
 do_filp_open+0x231/0x3a0 fs/namei.c:3553
 do_sys_open+0x399/0x610 fs/open.c:1059
 entry_SYSCALL_64_fastpath+0x1e/0x8b

Freed by task 165:
 __cache_free mm/slab.c:3484 [inline]
 kfree+0x8a/0xd0 mm/slab.c:3799
 disk_release+0x2c3/0x380 block/genhd.c:1264
 device_release+0x6e/0x1d0 drivers/base/core.c:811
 kobject_cleanup lib/kobject.c:646 [inline]
 kobject_release lib/kobject.c:675 [inline]
 kref_put include/linux/kref.h:70 [inline]
 kobject_put+0x14c/0x400 lib/kobject.c:692
 __blkdev_get+0x39f/0xd30 fs/block_dev.c:1528
 blkdev_get+0x283/0x980 fs/block_dev.c:1591
 do_dentry_open.isra.1+0x6c0/0xaf0 fs/open.c:752
 do_last fs/namei.c:3378 [inline]
 path_openat+0x587/0x28b0 fs/namei.c:3518
 do_filp_open+0x231/0x3a0 fs/namei.c:3553
 do_sys_open+0x399/0x610 fs/open.c:1059
 do_syscall_64+0x213/0x740 arch/x86/entry/common.c:285
 return_from_SYSCALL_64+0x0/0x75

The buggy address belongs to the object at ffff880030743280
 which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 1008 bytes inside of
 2048-byte region [ffff880030743280, ffff880030743a80)
The buggy address belongs to the page:
page:ffffea0000a99670 count:1 mapcount:0 mapping:ffff880030742180 index:0x0 compound_mapcount: 0
flags: 0x100000000008100(slab|head)
raw: 0100000000008100 ffff880030742180 0000000000000000 0000000100000003
raw: ffffea0000b895a0 ffffea0000b91720 ffff880036000800
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff880030743500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff880030743580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff880030743600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff880030743680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff880030743700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
