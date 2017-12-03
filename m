Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36195 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdLCUQL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Dec 2017 15:16:11 -0500
Date: Sun, 3 Dec 2017 12:16:08 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+2797c18fc195e3e240c3c3e7837a14130e157fb0@syzkaller.appspotmail.com>
Cc: adobriyan@gmail.com, akpm@linux-foundation.org, arnd@arndb.de,
        dan.carpenter@oracle.com, dave.jiang@intel.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, linux-block@vger.kernel.org
Subject: Re: WARNING in kmalloc_slab (3)
Message-ID: <20171203201608.GC844@zzz.localdomain>
References: <f403043d11ccfea019055f705d18@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f403043d11ccfea019055f705d18@google.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

+Cc linux-block

On Sun, Dec 03, 2017 at 06:25:01AM -0800, syzbot wrote:
> WARNING: CPU: 0 PID: 3081 at mm/slab_common.c:971 kmalloc_slab+0x5d/0x70
> mm/slab_common.c:971
> Kernel panic - not syncing: panic_on_warn set ...
> 
[...]
>  __do_kmalloc mm/slab.c:3706 [inline]
>  __kmalloc+0x25/0x760 mm/slab.c:3720
>  kmalloc include/linux/slab.h:504 [inline]
>  relay_create_buf kernel/relay.c:172 [inline]
>  relay_open_buf.part.10+0xc8/0x9b0 kernel/relay.c:449
>  relay_open_buf kernel/relay.c:446 [inline]
>  relay_open+0x57a/0xa40 kernel/relay.c:596
>  do_blk_trace_setup+0x4a4/0xcd0 kernel/trace/blktrace.c:544
>  __blk_trace_setup+0xb6/0x140 kernel/trace/blktrace.c:589
>  blk_trace_ioctl+0x1d5/0x2a0 kernel/trace/blktrace.c:728
>  blkdev_ioctl+0x1845/0x1e00 block/ioctl.c:587
>  block_ioctl+0xea/0x130 fs/block_dev.c:1860
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1530 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x1f/0x96

Looks like BLKTRACESETUP doesn't limit the '.buf_nr' parameter, allowing anyone
who can open a block device to cause an extremely large kmalloc.  Here's a
simplified reproducer:

#include <fcntl.h>
#include <linux/blktrace_api.h>
#include <linux/fs.h>
#include <sys/ioctl.h>

int main()
{
        int fd;
        struct blk_user_trace_setup setup = {
                .buf_size = 100,
                .buf_nr = 1000000,
        };

        fd = open("/dev/loop0", O_RDWR);
        ioctl(fd, BLKTRACESETUP, &setup);
}
