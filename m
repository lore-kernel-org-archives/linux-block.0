Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Message-Id: <201805080423.w484NEno006506@www262.sakura.ne.jp>
Subject: Re: [PATCH] loop: add recursion validation to
 =?ISO-2022-JP?B?TE9PUF9DSEFOR0VfRkQ=?=
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: axboe@kernel.dk, syzkaller-bugs@googlegroups.com,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Date: Tue, 08 May 2018 13:23:14 +0900
References: <201805080028.w480SH3m013943@www262.sakura.ne.jp> <20180508035626.GF999@thunk.org>
In-Reply-To: <20180508035626.GF999@thunk.org>
Content-Type: text/plain; charset="ISO-2022-JP"
List-ID: <linux-block@vger.kernel.org>

Theodore Y. Ts'o wrote:
> On Tue, May 08, 2018 at 09:28:17AM +0900, Tetsuo Handa wrote:
> > The thread I mean is:
> > 
> >   general protection fault in lo_ioctl (2)
> >   https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
> > 
> > Are you sure that your patch solves this problem as well?
> 
> Well, I can't be sure, since there's not enough information in that
> particular syzkaller report to definitively pin down the root cause.
> 
> And while I can't reproduce the crash using the syzkaller repro with
> the patch; I can't reproduce the crash *without* the patch, either.
> 
> This is what Syzkaller has to say, but of course, in its own
> documentation's words, "It's only a dumb bot".  :-)e
> 
> That being said, triggering the problem which it is so concerned about
> requires root privilieges, so I would not consider it high priority to
> track down --- especially given that we don't have a reliable
> reproducer for it.
> 

OK. Using sleep injection patch and reproducer shown below, I can reproduce
the crashes. Unless we hold corresponding lo->lo_ctl_mutex (or keep
lo->lo_refcnt elevated) when traversing other loop devices,
"/* Avoid recursion */" loop will suffer from races by loop_clr_fd().

------------------------------------------------------------
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -909,6 +909,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 			error = -EINVAL;
 			goto out_putf;
 		}
+		pr_err("Start sleeping\n");
+		schedule_timeout_killable(3 * HZ);
+		pr_err("End sleeping\n");
 		f = l->lo_backing_file;
 	}
 
------------------------------------------------------------

------------------------------------------------------------
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/loop.h>
#include <sys/ioctl.h>

int main(int argc, char *argv[])
{
	int fd0 = open("/dev/loop0", O_RDONLY);
	int fd1 = open("/dev/loop1", O_RDONLY);
	int fd2 = open("/tmp/file", O_RDWR | O_CREAT | O_TRUNC, 0600);
	ioctl(fd1, LOOP_SET_FD, fd2);
	if (fork() == 0) {
		sleep(1);
		ioctl(fd1, LOOP_CLR_FD, 0);
		_exit(0);
	}
	ioctl(fd0, LOOP_SET_FD, fd1);
	return 0;
}
------------------------------------------------------------

------------------------------------------------------------
[   14.119073] loop: module loaded
[   17.363610] Start sleeping
[   20.383442] End sleeping
[   20.386511] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[   20.394779] PGD 13377d067 P4D 13377d067 PUD 131509067 PMD 0 
[   20.400847] Oops: 0000 [#1] SMP
[   20.403875] Modules linked in: loop
[   20.406188] CPU: 6 PID: 6470 Comm: a.out Tainted: G                T 4.17.0-rc4+ #540
[   20.411266] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[   20.418169] RIP: 0010:lo_ioctl+0x7ef/0x840 [loop]
[   20.421272] RSP: 0018:ffffc90000bbbd88 EFLAGS: 00010282
[   20.424661] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83679478
[   20.429271] RDX: ffff8801332e9c00 RSI: 0000000000000086 RDI: 0000000000000286
[   20.434517] RBP: ffffc90000bbbdd8 R08: 0000000000000638 R09: 0000000000000000
[   20.436879] R10: 0000000000000190 R11: 0720072007200720 R12: ffff8801314ab118
[   20.439076] R13: ffff880138deae40 R14: ffff8801311f7780 R15: ffff8801314ab000
[   20.441144] FS:  00007f0b57743740(0000) GS:ffff88013a780000(0000) knlGS:0000000000000000
[   20.443588] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.445284] CR2: 0000000000000008 CR3: 0000000138efb002 CR4: 00000000000606e0
[   20.447381] Call Trace:
[   20.448149]  blkdev_ioctl+0x88d/0x950
[   20.449237]  block_ioctl+0x38/0x40
[   20.450269]  do_vfs_ioctl+0xaa/0x650
[   20.451479]  ? handle_mm_fault+0x108/0x250
[   20.452704]  ksys_ioctl+0x70/0x80
[   20.453737]  __x64_sys_ioctl+0x15/0x20
[   20.454887]  do_syscall_64+0x5d/0x100
[   20.456014]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   20.457519] RIP: 0033:0x7f0b57267107
[   20.458644] RSP: 002b:00007fff8a0fd698 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   20.460853] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f0b57267107
[   20.462952] RDX: 0000000000000004 RSI: 0000000000004c00 RDI: 0000000000000003
[   20.465023] RBP: 0000000000000003 R08: 00007f0b57743740 R09: 0000000000000000
[   20.467091] R10: 00007f0b57743a10 R11: 0000000000000246 R12: 00000000004005ef
[   20.469361] R13: 00007fff8a0fd790 R14: 0000000000000000 R15: 0000000000000000
[   20.471657] Code: a0 48 89 55 d0 e8 e0 5f 1d e1 bf b8 0b 00 00 e8 78 9e 7c e2 48 c7 c7 a9 40 00 a0 e8 ca 5f 1d e1 48 8b 55 d0 48 8b 82 f0 00 00 00 <48> 8b 40 08 48 8b 40 68 48 85 c0 0f 84 15 fd ff ff 0f b7 90 b8 
[   20.477207] RIP: lo_ioctl+0x7ef/0x840 [loop] RSP: ffffc90000bbbd88
[   20.479027] CR2: 0000000000000008
[   20.480063] ---[ end trace 925bc1b992d96cb3 ]---
[   20.481441] Kernel panic - not syncing: Fatal exception
[   20.483119] Kernel Offset: disabled
[   20.489564] Rebooting in 86400 seconds..
------------------------------------------------------------
