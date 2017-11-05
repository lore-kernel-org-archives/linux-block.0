Return-Path: <ebiggers3@gmail.com>
Return-Path: <ebiggers3@gmail.com>
Date: Sun, 5 Nov 2017 12:18:34 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <bot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in blkdev_reread_part
Message-ID: <20171105201834.GA8126@zzz.localdomain>
References: <001a11446e86e97ceb055cf07f4e@google.com>
 <CACT4Y+bGjnajib6P4a0SxYkNUJpg_x8abEkec8AR+oBmC=-QUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACT4Y+bGjnajib6P4a0SxYkNUJpg_x8abEkec8AR+oBmC=-QUQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 01, 2017 at 10:02:44PM +0300, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> 
> Still happens on linux-next 36ef71cae353f88fd6e095e2aaa3e5953af1685d (Oct 20).
> Note repro needs to be compiled with -m32
> 
> [  243.819514] ======================================================
> [  243.820949] WARNING: possible circular locking dependency detected
> [  243.822417] 4.14.0-rc5-next-20171018 #15 Not tainted
> [  243.823592] ------------------------------------------------------
> [  243.825012] a.out/11871 is trying to acquire lock:
> [  243.826182]  (&bdev->bd_mutex){+.+.}, at: [<ffffffff8245f13e>]
> blkdev_reread_part+0x1e/0x40
> [  243.828317]
> [  243.828317] but task is already holding lock:
> [  243.829669]  (&lo->lo_ctl_mutex#2){+.+.}, at: [<ffffffff83867189>]
> lo_compat_ioctl+0x119/0x150
> [  243.831728]
> [  243.831728] which lock already depends on the new lock.
> [  243.831728]
> [  243.833373]

Here's a simplified reproducer:

	#include <fcntl.h>
	#include <linux/loop.h>
	#include <sys/ioctl.h>
	#include <unistd.h>

	int main()
	{
		int loopfd, fd;
		struct loop_info info = { .lo_flags = LO_FLAGS_PARTSCAN };

		loopfd = open("/dev/loop0", O_RDWR);

		fd = open("/bin/ls", O_RDONLY);

		ioctl(loopfd, LOOP_SET_FD, fd);

		ioctl(loopfd, LOOP_SET_STATUS, &info);
	}

It still needs to be compiled with -m32.  The reason is that lo_ioctl() has:

	mutex_lock_nested(&lo->lo_ctl_mutex, 1);

but lo_compat_ioctl() has:

	mutex_lock(&lo->lo_ctl_mutex);

But ->lo_ctl_mutex isn't actually being nested under itself, so I don't think
the "nested" annotation is actually appropriate.

It seems that ->bd_mutex is held while opening and closing block devices, which
should rank it above both ->lo_ctl_mutex and loop_index_mutex (see lo_open() and
lo_release()).

But blkdev_reread_part(), which takes ->bd_mutex, is called from some of the
ioctls while ->lo_ctl_mutex is held.

Perhaps we should call blkdev_reread_part() at the end of the ioctls, after
->lo_ctl_mutex has been dropped?  But it looks like that can do I/O to the
device, which probably could race with loop_clr_fd()...

Or perhaps we should just take both locks for the ioctls, in the order
->bd_mutex, then ->lo_ctl_mutex -- and then use __blkdev_reread_part()?

Eric
