Return-Path: <kt0755@gmail.com>
MIME-Version: 1.0
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
 <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk> <CAEAjamtJrbLZyN+f97Y+LOMbogveYNBdxM-pVvfqUMhaGsH2uw@mail.gmail.com>
 <CAEAjams3Y4PE-yDP0FyipCAohOepSF9WgXw3h_CEd1YW+mjS0g@mail.gmail.com> <ad9f11b6-1e3c-8412-ecce-d04a1c8c317a@kernel.dk>
In-Reply-To: <ad9f11b6-1e3c-8412-ecce-d04a1c8c317a@kernel.dk>
From: Kyungtae Kim <kt0755@gmail.com>
Date: Fri, 26 Oct 2018 09:22:51 -0400
Message-ID: <CAEAjamu-MmtPF0_kqyPKJBcZSWz=SGi_1VjLq7z9MMm5-t7Oog@mail.gmail.com>
Subject: Re: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To: axboe@kernel.dk
Cc: jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
	DaeRyong Jeong <threeearcat@gmail.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

I corrected the patch as follows:

[PATCH] floppy: Avoid memory access beyond the array bounds in setup_rw_floppy()

setup_rw_floppy() writes some bytes of array cmd to the floppy disk
controller, depending on cmd_count.
Although the size of array cmd is fixed like 16, cmd_count can be much
larger through raw_cmd_ioctl().
Noticed there is no bound check for this, thereby leading to invalid
memory access.

This patch adds a bound check for cmd_count when initialized for the
first time.

The crash log is as follows:
UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
index 16 is out of range for type 'unsigned char [16]'
CPU: 0 PID: 2420 Comm: kworker/u4:3 Not tainted 4.19.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: floppy fd_timer_workfn
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 __ubsan_handle_out_of_bounds+0x174/0x1b8 lib/ubsan.c:386
 setup_rw_floppy+0xbd9/0xe60 drivers/block/floppy.c:1495
 seek_floppy drivers/block/floppy.c:1605 [inline]
 floppy_ready+0x61a/0x2230 drivers/block/floppy.c:1917
 fd_timer_workfn+0x1a/0x20 drivers/block/floppy.c:994
 process_one_work+0xa0c/0x1820 kernel/workqueue.c:2153
 worker_thread+0x8f/0xd20 kernel/workqueue.c:2296
 kthread+0x3a3/0x470 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413

Signed-off-by: Kyungtae Kim <kt0755@gmail.com>
---
 drivers/block/floppy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index a8cfa01..41160a1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *param,
                         */
                return -EINVAL;

+       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
+         return -EINVAL;
+
        for (i = 0; i < 16; i++)
                ptr->reply[i] = 0;
        ptr->resultcode = 0;
--
2.7.4


On Wed, Oct 24, 2018 at 5:27 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/24/18 12:33 AM, Kyungtae Kim wrote:
> > Corrected.
>
> You'll want to read Documentation/process/submitting-patches.rst as
> your patch is lacking in several areas.
>
>
> --
> Jens Axboe
>
