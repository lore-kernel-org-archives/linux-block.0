Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BC0C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 09:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829E820989
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 09:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfCSJll (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:41:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:48026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfCSJlk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 05:41:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C62AADCC;
        Tue, 19 Mar 2019 09:41:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C6E911E428E; Tue, 19 Mar 2019 10:41:36 +0100 (CET)
Date:   Tue, 19 Mar 2019 10:41:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        penguin-kernel@i-love.sakura.ne.jp
Subject: Re: general protection fault in loop_validate_file (2)
Message-ID: <20190319094136.GE17334@quack2.suse.cz>
References: <00000000000098bf7d05845616d7@google.com>
 <cb7aa6d1-6d1e-a9ac-239a-1b5d8160f8cd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb7aa6d1-6d1e-a9ac-239a-1b5d8160f8cd@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 18-03-19 20:27:02, Dongli Zhang wrote:
> Hi Jan,
> 
> Indeed there is another issue implicitly reported by below console output from
> syzkaller:
> 
> [  245.524424][ T9455] loop_reread_partitions: partition scan of loop0 () failed
> (rc=-13)
> [  245.563340][ T9499] kasan: CONFIG_KASAN_INLINE enabled
> [  245.576412][ T9489] __loop_clr_fd: partition scan of loop0 failed (rc=-13)
> [  245.581275][ T9499] kasan: GPF could be caused by NULL-ptr deref or user
> memory access
> [  245.602596][ T9499] general protection fault: 0000 [#1] PREEMPT SMP KASAN
> 
> I think rc=-13 is because of below code at line 168:
> 
> 162 int __blkdev_reread_part(struct block_device *bdev)
> 163 {
> 164         struct gendisk *disk = bdev->bd_disk;
> 165
> 166         if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
> 167                 return -EINVAL;
> 168         if (!capable(CAP_SYS_ADMIN))
> 169                 return -EACCES;
> 170
> 171         lockdep_assert_held(&bdev->bd_mutex);
> 172
> 173         return rescan_partitions(disk, bdev);
> 174 }
> 175 EXPORT_SYMBOL(__blkdev_reread_part);
> 
> I can reproduce this by 'chown username /dev/loop0' on my test machine.
> 
> Taking 'losetup -d /dev/loop0' as sample, as /dev/loop0 belongs to my username,
> I am able to detach the loop without 'su'.
> 
> However, because of above line 168, the partition scan would fail.
> 
> Should we always assume the user should have admin privilege to detach
> the loop and this is not a bug?

Firstly, __blkdev_reread_part() is used for all devices so we have to be
*very* careful when we relax the permission checks there.

Secondly, I'm not convinced it is always safe to allow non-priviledged user
to force repartitioning of a device. That exposes the whole partition table
parsing code to non-priviledged user and thus increases possible attack
surface.

But in this specific case we call __blkdev_reread_part() only to tear down
partitions. So in this specific case calling it by unpriviledged user is
fine plus leaving stale partitions behind is certainly not nice. What we
could do is:

Export drop_partitions() functionality as a function like
__blkdev_drop_part() that would call drop_partitions(bdev->bd_disk, bdev).
It would expect (and assert) that &bdev->bd_mutex is already locked. It
should probably also replicate the check:

        if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
                return -EINVAL;

from __blkdev_reread_part(). And we can call this from __loop_clr_fd().

Then we can just unexport __blkdev_reread_part() (since only loop.c is
using it) and fold it inside blkdev_reread_part().

What do you think?

								Honza

> On 03/18/2019 11:36 AM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    9c7dc824 Merge tag '5.1-rc-smb3' of git://git.samba.org/sf..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=148a35fb200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7e1aaa1cfbfe1abf
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9bdc1adc1c55e7fe765b
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com
> > 
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 9499 Comm: syz-executor.4 Not tainted 5.0.0+ #25
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> > 01/01/2011
> > RIP: 0010:loop_validate_file+0x23e/0x310 drivers/block/loop.c:652
> > Code: 00 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85 d4 00 00 00 4d 8b a4 24 f0 00
> > 00 00 49 8d bc 24 b8 01 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 0f 85 a8 00
> > 00 00 4d 8b a4 24 b8 01 00 00 4c 89 e0
> > RSP: 0018:ffff88804d2bfb18 EFLAGS: 00010202
> > RAX: 0000000000000037 RBX: ffff888095ffa3d8 RCX: ffffc9000e657000
> > RDX: 0000000000000077 RSI: ffffffff83e754ed RDI: 00000000000001b8
> > RBP: ffff88804d2bfb40 R08: ffff88808eab41c0 R09: fffffbfff11d981d
> > R10: ffff88804d2bfb40 R11: ffffffff88ecc0e7 R12: 0000000000000000
> > R13: 0000000000000002 R14: ffff888095ffa800 R15: dffffc0000000000
> > FS:  00007f04b0c91700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000625208 CR3: 00000000a7af8000 CR4: 00000000001406e0
> > Call Trace:
> >  loop_set_fd drivers/block/loop.c:930 [inline]
> >  lo_ioctl+0x99d/0x2150 drivers/block/loop.c:1542
> >  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
> >  blkdev_ioctl+0xee8/0x1c40 block/ioctl.c:605
> >  block_ioctl+0xee/0x130 fs/block_dev.c:1931
> >  vfs_ioctl fs/ioctl.c:46 [inline]
> >  file_ioctl fs/ioctl.c:509 [inline]
> >  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
> >  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
> >  __do_sys_ioctl fs/ioctl.c:720 [inline]
> >  __se_sys_ioctl fs/ioctl.c:718 [inline]
> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
> >  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x458079
> > Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89
> > d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b
> > b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007f04b0c90c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458079
> > RDX: 0000000000000004 RSI: 0000000000004c00 RDI: 0000000000000003
> > RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f04b0c916d4
> > R13: 00000000004c1252 R14: 00000000004d3160 R15: 00000000ffffffff
> > Modules linked in:
> > ---[ end trace 81b29486bae7280a ]---
> > RIP: 0010:loop_validate_file+0x23e/0x310 drivers/block/loop.c:652
> > Code: 00 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85 d4 00 00 00 4d 8b a4 24 f0 00
> > 00 00 49 8d bc 24 b8 01 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 0f 85 a8 00
> > 00 00 4d 8b a4 24 b8 01 00 00 4c 89 e0
> > RSP: 0018:ffff88804d2bfb18 EFLAGS: 00010202
> > RAX: 0000000000000037 RBX: ffff888095ffa3d8 RCX: ffffc9000e657000
> > RDX: 0000000000000077 RSI: ffffffff83e754ed RDI: 00000000000001b8
> > RBP: ffff88804d2bfb40 R08: ffff88808eab41c0 R09: fffffbfff11d981d
> > R10: ffff88804d2bfb40 R11: ffffffff88ecc0e7 R12: 0000000000000000
> > R13: 0000000000000002 R14: ffff888095ffa800 R15: dffffc0000000000
> > FS:  00007f04b0c91700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000625208 CR3: 00000000a7af8000 CR4: 00000000001406e0
> > 
> > 
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
