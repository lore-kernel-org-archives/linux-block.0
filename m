Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753F3C48BE6
	for <linux-block@archiver.kernel.org>; Sat, 12 Jun 2021 02:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FD061184
	for <linux-block@archiver.kernel.org>; Sat, 12 Jun 2021 02:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFLCiA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jun 2021 22:38:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64864 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLCh7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jun 2021 22:37:59 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15C2ZxXi058017;
        Sat, 12 Jun 2021 11:35:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Sat, 12 Jun 2021 11:35:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15C2ZxRW058012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Jun 2021 11:35:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] possible deadlock in del_gendisk
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Petr Vorel <pvorel@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>
References: <000000000000ae236f05bfde0678@google.com>
 <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
 <20210609164639.GM4910@sequoia>
 <49e00adb-ccf5-8024-6403-014ca82781dd@i-love.sakura.ne.jp>
 <CA+CK2bDWb2=bsoacY-eqZExObBpXuZE0a3Mr18_FXmGZTC5GnQ@mail.gmail.com>
 <CA+CK2bBe5muuGbHgfK7JjbzRE5ogf1oeD1iYeY6eJB046p9_ZQ@mail.gmail.com>
 <f76628cc-8f05-56dd-fec5-b1103aedd504@i-love.sakura.ne.jp>
Message-ID: <b817de92-668a-de29-0a81-eecc4124130b@i-love.sakura.ne.jp>
Date:   Sat, 12 Jun 2021 11:35:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f76628cc-8f05-56dd-fec5-b1103aedd504@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/12 0:49, Tetsuo Handa wrote:
> On 2021/06/12 0:18, Pavel Tatashin wrote:
>>>> Well, I made commit 310ca162d779efee ("block/loop: Use global lock for ioctl() operation.")
>>>> because per device lock was not sufficient. Did commit 6cc8e7430801fa23 ("loop: scale loop
>>>> device by introducing per device lock") take this problem into account?
>>>
>>> This was my intention when I wrote 6cc8e7430801fa23 ("loop: scale loop
>>> device by introducing per device lock"). This is why this change does
>>> not simply revert 310ca162d779efee ("block/loop: Use global lock for
>>> ioctl() operation."), but keeps loop_ctl_mutex to protect the global
>>> accesses.  loop_control_ioctl() is still locked by global
>>> loop_ctl_mutex.
> 
> No, loop_control_ioctl() (i.e. /dev/loop-control) is irrelevant here.
> What 310ca162d779efee addressed but (I worry) 6cc8e7430801fa23 broke is
> lo_ioctl() (i.e. /dev/loop$num).
> 
> syzbot was reporting NULL pointer dereference which is caused by
> race condition between ioctl(loop_fd, LOOP_CLR_FD, 0) versus
> ioctl(other_loop_fd, LOOP_SET_FD, loop_fd) due to traversing other
> loop devices at loop_validate_file() without holding corresponding
> lo->lo_mutex lock.

Here is a reproducer and a race window widening patch.
Since loop_validate_file() traverses on other loop devices,
changing fd of loop device needs to be protected using a global lock.

----------------------------------------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/loop.h>
#include <sys/wait.h>

int main(int argc, char *argv[])
{
	const int file_fd = open("test.img", O_RDWR | O_CREAT, 0600);
	const int loop0_fd = open("/dev/loop0", O_RDWR);
	const int loop1_fd = open("/dev/loop1", O_RDWR);

	if (ftruncate(file_fd, 1024 * 1048576) ||
	    ioctl(loop0_fd, LOOP_SET_FD, file_fd))
		return 1;
	if (fork() == 0) {
		ioctl(loop1_fd, LOOP_SET_FD, loop0_fd); // Will trigger oops.
		_exit(0);
	} else {
		ioctl(loop0_fd, LOOP_CLR_FD, 0);
		wait(NULL);
	}
	ioctl(loop1_fd, LOOP_CLR_FD, 0);
	return 0;
}
----------------------------------------

----------------------------------------
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d58d68f3c7cd..e1c4586afcaf 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -683,6 +683,9 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 		if (l->lo_state != Lo_bound) {
 			return -EINVAL;
 		}
+		pr_info("Start delay injection at %s()\n", __func__);
+		schedule_timeout_killable(5 * HZ);
+		pr_info("End delay injection at %s()\n", __func__);
 		f = l->lo_backing_file;
 	}
 	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
@@ -1219,9 +1222,11 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
+	pr_info("Start resetting at %s()\n", __func__);
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_backing_file = NULL;
 	spin_unlock_irq(&lo->lo_lock);
+	pr_info("End resetting at %s()\n", __func__);
 
 	loop_release_xfer(lo);
 	lo->transfer = NULL;
@@ -1309,6 +1314,9 @@ static int loop_clr_fd(struct loop_device *lo)
 {
 	int err;
 
+	pr_info("Start delay injection at %s()\n", __func__);
+	schedule_timeout_killable(2 * HZ);
+	pr_info("End delay injection at %s()\n", __func__);
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
----------------------------------------

----------------------------------------
[  393.386477][ T2736] loop: module loaded
[  396.310463][ T2785] loop0: detected capacity change from 0 to 2097152
[  396.323798][ T2785] Start delay injection at loop_clr_fd()
[  396.335087][ T2787] Start delay injection at loop_validate_file()
[  398.410156][ T2785] End delay injection at loop_clr_fd()
[  398.449494][ T2785] Start resetting at __loop_clr_fd()
[  398.453236][ T2785] End resetting at __loop_clr_fd()
[  401.369512][ T2787] End delay injection at loop_validate_file()
[  401.378793][ T2787] BUG: kernel NULL pointer dereference, address: 00000000000001b8
[  401.391729][ T2787] #PF: supervisor read access in kernel mode
[  401.401927][ T2787] #PF: error_code(0x0000) - not-present page
[  401.411844][ T2787] PGD 0 P4D 0 
[  401.417355][ T2787] Oops: 0000 [#1] PREEMPT SMP
[  401.425137][ T2787] CPU: 2 PID: 2787 Comm: a.out Tainted: G            E     5.13.0-rc5+ #705
[  401.440991][ T2787] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  401.456288][ T2787] RIP: 0010:loop_validate_file.isra.0.cold+0x3d/0x55 [loop]
[  401.468657][ T2787] Code: e8 52 86 a8 e1 bf f4 01 00 00 e8 d1 c4 ac e1 48 c7 c6 a0 a7 24 a0 48 c7 c7 f0 a2 24 a0 e8 35 86 a8 e1 49 8b 84 24 f0 00 00 00 <48> 8b 80 b8 01 00 00 4c 8b 20 4d 85 e4 0f 84 5a c8 ff ff e9 33 c8
[  401.502261][ T2787] RSP: 0018:ffffc90000637c70 EFLAGS: 00010282
[  401.737017][ T2787] RAX: 0000000000000000 RBX: ffff888104e9f8e8 RCX: ffff88800e34c440
[  402.204394][ T2787] RDX: 0000000000000000 RSI: ffff88800e34c440 RDI: 0000000000000002
[  402.675231][ T2787] RBP: 0000000000000001 R08: ffffffff81153303 R09: 0000000000000000
[  403.143909][ T2787] R10: 0000000000000005 R11: 0000000000000000 R12: ffff88810640b800
[  403.626245][ T2787] R13: ffff88811640425c R14: 0000000000700000 R15: ffff888104b66b78
[  404.133199][ T2787] FS:  00007f942f0eb540(0000) GS:ffff88811bd00000(0000) knlGS:0000000000000000
[  404.654995][ T2787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  404.926956][ T2787] CR2: 00000000000001b8 CR3: 000000000e243003 CR4: 00000000000706e0
[  405.458619][ T2787] Call Trace:
[  405.717447][ T2787]  loop_configure+0x1b2/0x840 [loop]
[  405.978507][ T2787]  ? filemap_map_pages+0x2a8/0xe40
[  406.238951][ T2787]  ? write_comp_data+0x1c/0x70
[  406.496447][ T2787]  lo_ioctl+0x1cb/0xa00 [loop]
[  406.753819][ T2787]  ? loop_configure+0x840/0x840 [loop]
[  407.013433][ T2787]  blkdev_ioctl+0x18d/0x3a0
[  407.265515][ T2787]  block_ioctl+0x66/0x80
[  407.512857][ T2787]  ? blkdev_read_iter+0xa0/0xa0
[  407.756710][ T2787]  __x64_sys_ioctl+0xbb/0x110
[  408.000459][ T2787]  do_syscall_64+0x3a/0xb0
[  408.234492][ T2787]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  408.466905][ T2787] RIP: 0033:0x7f942f00f50b
[  408.691384][ T2787] Code: 0f 1e fa 48 8b 05 85 39 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 39 0d 00 f7 d8 64 89 01 48
[  409.380090][ T2787] RSP: 002b:00007ffdebd33a98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  409.832289][ T2787] RAX: ffffffffffffffda RBX: 000055fb7ce9f2d0 RCX: 00007f942f00f50b
[  410.285264][ T2787] RDX: 0000000000000004 RSI: 0000000000004c00 RDI: 0000000000000005
[  410.737236][ T2787] RBP: 0000000000000005 R08: 0000000000000000 R09: 00007f942f0eb540
[  411.207972][ T2787] R10: 00007f942f0eb810 R11: 0000000000000246 R12: 0000000000000000
[  411.659094][ T2787] R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
[  412.119426][ T2787] Modules linked in: loop(E) input_leds evdev sg led_class mousedev video rapl backlight ac button binfmt_misc sd_mod t10_pi crc_t10dif crct10dif_generic sr_mod cdrom ata_generic psmouse ahci crct10dif_pclmul libahci crct10dif_common atkbd crc32_pclmul crc32c_intel ata_piix ghash_clmulni_intel libps2 libata aesni_intel libaes i8042 crypto_simd i2c_piix4 serio scsi_mod cryptd rtc_cmos i2c_core
[  413.585708][ T2787] CR2: 00000000000001b8
[  413.851068][ T2787] ---[ end trace 2bb5fac824816119 ]---
----------------------------------------
