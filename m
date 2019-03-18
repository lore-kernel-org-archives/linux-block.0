Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCFBC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 10:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEFA20850
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 10:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCRKoL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:44:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:41744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbfCRKoL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 06:44:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 701C1ADE4;
        Mon, 18 Mar 2019 10:44:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A7E651E425D; Mon, 18 Mar 2019 11:44:08 +0100 (CET)
Date:   Mon, 18 Mar 2019 11:44:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block@vger.kernel.org, jack@suse.cz,
        syzbot <syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: general protection fault in loop_validate_file (2)
Message-ID: <20190318104408.GC9415@quack2.suse.cz>
References: <00000000000098bf7d05845616d7@google.com>
 <60b13932-0526-09bc-0a32-48371e941544@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60b13932-0526-09bc-0a32-48371e941544@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 18-03-19 14:51:59, Dongli Zhang wrote:
> 
> 
> On 3/18/19 11:36 AM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    9c7dc824 Merge tag '5.1-rc-smb3' of git://git.samba.org/sf..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=148a35fb200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7e1aaa1cfbfe1abf
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9bdc1adc1c55e7fe765b
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
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
> > FS:  00007f04b0c91700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000625208 CR3: 00000000a7af8000 CR4: 00000000001406e0
> > Call Trace:
> >  loop_set_fd drivers/block/loop.c:930 [inline]
> >  lo_ioctl+0x99d/0x2150 drivers/block/loop.c:1542
> >  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
> >  blkdev_ioctl+0xee8/0x1c40 block/ioctl.c:605
> >  block_ioctl+0xee/0x130 fs/block_dev.c:1931
> >  vfs_ioctl fs/ioctl.c:46 [inline]
> >  file_ioctl fs/ioctl.c:509 [inline]
> >  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
> >  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
> >  __do_sys_ioctl fs/ioctl.c:720 [inline]
> >  __se_sys_ioctl fs/ioctl.c:718 [inline]
> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
> >  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
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
> > FS:  00007f04b0c91700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
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
> 
> As discussed with Tetsuo in other email thread, the issue can hit when the
> backend of the loop is another loop device, e.g., loop0's backend is a file,
> while loop1's backend is loop0.
> 
> 
> loop0's backend is file            loop1's backend is loop0
> 
> __loop_clr_fd
>   mutex_lock(&loop_ctl_mutex);
>   lo->lo_backing_file = NULL;
>   mutex_unlock(&loop_ctl_mutex);
>                                    loop_set_fd()
>                                      mutex_lock_killable(&loop_ctl_mutex);
>                                      loop_validate_file
>                                        f = l->lo_backing_file; --> access if
>                                               loop0 is not Lo_unbound
>   mutex_lock(&loop_ctl_mutex);
>   lo->lo_flags = 0;
>   mutex_unlock(&loop_ctl_mutex);
> 
> 
> 
> Here I post below for more feedback. We should use a loop device as backend only
> when it is still bound.

Yes, this is the right fix. Thanks for writing it! In fact, the problem has
been introduced already in commit 7ccd0791d985 "loop: Push loop_ctl_mutex
down into loop_clr_fd()" after which loop_validate_file() could see devices
in Lo_rundown state with which it didn't count. It was harmless at that
point but still. So when submitting the fix, please include there:

Fixes: 7ccd0791d985 "loop: Push loop_ctl_mutex down into loop_clr_fd()"

And also appropriate Reported-by for syzbot. Something like:

Reported-by: syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com

You can also add my:

Reviewed-by: Jan Kara <jack@suse.cz>

							Thanks!

								Honza

> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1e6edd5..bf1c61c 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -656,7 +656,7 @@ static int loop_validate_file(struct file *file, struct
> block_device *bdev)
>                         return -EBADF;
> 
>                 l = f->f_mapping->host->i_bdev->bd_disk->private_data;
> -               if (l->lo_state == Lo_unbound) {
> +               if (l->lo_state != Lo_bound) {
>                         return -EINVAL;
>                 }
>                 f = l->lo_backing_file;
> 
> 
> Thanks Tetsuo for the discussion and feedback!
> 
> Dongli Zhang
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
