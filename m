Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA810C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 05:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C69A20870
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 05:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbfAaFfN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:35:13 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:31577 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfAaFfN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 00:35:13 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0V5Yx5L053802;
        Thu, 31 Jan 2019 14:35:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Thu, 31 Jan 2019 14:34:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0V5YwYd053745
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 31 Jan 2019 14:34:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: general protection fault in debugfs_create_files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <000000000000784c000580b16bdd@google.com>
Cc:     syzbot <syzbot+a9d09761be47db706560@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <1956aaad-701d-2c5f-180c-0eaeb01daf21@I-love.SAKURA.ne.jp>
Date:   Thu, 31 Jan 2019 14:34:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <000000000000784c000580b16bdd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, again.

syzbot is hitting a similar crash due to debugfs_create_dir() returning -EEXIST.
Should debugfs_create_dir() return NULL as well? Or should the caller use IS_ERR_OR_NULL() ?

--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -861,6 +861,8 @@ int blk_mq_debugfs_register(struct request_queue *q)
                                            blk_debugfs_root);
        if (!q->debugfs_dir)
                return -ENOMEM;
+       if (IS_ERR(q->debugfs_dir))
+               printk("debugfs_create_dir=%ld\n", PTR_ERR(q->debugfs_dir));

        if (!debugfs_create_files(q->debugfs_dir, q,
                                  blk_mq_debugfs_queue_attrs))

----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
        while (1) {
                if (fork() == 0) {
                        int fd = open("/dev/loop-control", O_RDWR);
                        ioctl(fd, 0x4c81, 0);
                        ioctl(fd, 0x4c80, 0);
                        close(fd);
                        _exit(0);
                }
        }
        return 0;
}
----------

[   55.613954] debugfs_create_dir=-17
[   55.617779] BUG: unable to handle kernel NULL pointer dereference at 0000000000000047
[   55.622521] #PF error: [normal kernel read fault]
[   55.625271] PGD 8000000109d7a067 P4D 8000000109d7a067 PUD 109d7b067 PMD 0
[   55.630875] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
[   55.634621] CPU: 0 PID: 9122 Comm: a.out Not tainted 5.0.0-rc4-next-20190130+ #744
[   55.638349] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[   55.644608] RIP: 0010:debugfs_create_files+0x5/0x60
[   55.647245] Code: 00 48 8d bb 28 05 00 00 e8 f8 34 43 00 48 8d bb 18 05 00 00 48 8b 75 00 5b 5d e9 06 e5 eb ff 66 0f 1f 44 00 00 55 48 89 fd 53 <48> 8b 47 58 48 89 d3 48 89 b0 90 03 00 00 48 8b 3a 48 85 ff 75 0e
[   55.655741] RSP: 0018:ffffa078839ebd50 EFLAGS: 00010246
[   55.658403] RAX: ffffffffffffffef RBX: ffff8b130d1d8008 RCX: 0000000000000000
[   55.662047] RDX: ffffffffb2e4d0a0 RSI: ffff8b130d1d8008 RDI: ffffffffffffffef
[   55.665353] RBP: ffffffffffffffef R08: 0000000000000000 R09: 0000000000000000
[   55.668639] R10: 0000000000000001 R11: 0000000000000004 R12: 0000000000000000
[   55.671909] R13: ffff8b130d1d80d0 R14: ffff8b130d1d8600 R15: ffff8b132d12c1c8
[   55.675171] FS:  00007fda47cb6740(0000) GS:ffff8b1339400000(0000) knlGS:0000000000000000
[   55.678789] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.681596] CR2: 0000000000000047 CR3: 000000010c014006 CR4: 00000000001606f0
[   55.684872] Call Trace:
[   55.686606]  blk_mq_debugfs_register+0x54/0x160
[   55.689093]  blk_register_queue+0xb2/0x190
[   55.691396]  __device_add_disk+0x31f/0x4f0
[   55.693623]  loop_add+0x1ef/0x280 [loop]
[   55.695773]  loop_control_ioctl+0x104/0x140 [loop]
[   55.698190]  do_vfs_ioctl+0x9f/0x6e0
[   55.700202]  ? lockdep_hardirqs_on+0x122/0x1b0
[   55.702488]  ? syscall_trace_enter+0x1c4/0x340
[   55.707327]  ? syscall_trace_enter+0x1c4/0x340
[   55.709946]  ksys_ioctl+0x5b/0x90
[   55.712269]  __x64_sys_ioctl+0x11/0x20
[   55.714434]  do_syscall_64+0x55/0x210
[   55.719649]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

On 2019/01/31 3:53, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=172ed528c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
> dashboard link: https://syzkaller.appspot.com/bug?extid=a9d09761be47db706560
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149209ef400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e00c2f400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a9d09761be47db706560@syzkaller.appspotmail.com
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8264 Comm: syz-executor060 Not tainted 5.0.0-rc4-next-20190130 #22
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:debugfs_create_files+0x2e/0x140 block/blk-mq-debugfs.c:842
> Code: 41 56 49 89 fe 41 55 41 54 49 89 f4 53 48 89 d3 e8 87 d0 f3 fd 49 8d 7e 58 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e3 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffff88809331f868 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: ffffffff8881d400 RCX: ffffffff82d9f665
> RDX: 0000000000000008 RSI: ffffffff838e48c9 RDI: 0000000000000047
> RBP: ffff88809331f888 R08: ffff8880a0c76400 R09: fffffbfff13024e6
> R10: fffffbfff13024e5 R11: ffffffff8981272b R12: ffff888099398ed0
> R13: ffff888099398ed0 R14: ffffffffffffffef R15: ffff888099398f98
> FS:  0000000001edd880(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f835b5dc6f0 CR3: 00000000a0365000 CR4: 00000000001406e0
> Call Trace:
>  blk_mq_debugfs_register+0xec/0x4e0 block/blk-mq-debugfs.c:865
>  blk_register_queue+0x1bc/0x370 block/blk-sysfs.c:944
>  __device_add_disk+0xe9f/0x13c0 block/genhd.c:723
>  device_add_disk+0x2b/0x40 block/genhd.c:739
>  add_disk include/linux/genhd.h:422 [inline]
>  loop_add+0x71d/0xa30 drivers/block/loop.c:1999
>  loop_control_ioctl+0x18e/0x470 drivers/block/loop.c:2100
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:509 [inline]
>  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
>  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
>  __do_sys_ioctl fs/ioctl.c:720 [inline]
>  __se_sys_ioctl fs/ioctl.c:718 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
>  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4420d9
> Code: e8 6c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 cb 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffddb7abd48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004420d9
> RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
> RBP: 0000000000010555 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402f30
> R13: 0000000000402fc0 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 5909b82e24594aac ]---
> RIP: 0010:debugfs_create_files+0x2e/0x140 block/blk-mq-debugfs.c:842
> Code: 41 56 49 89 fe 41 55 41 54 49 89 f4 53 48 89 d3 e8 87 d0 f3 fd 49 8d 7e 58 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e3 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffff88809331f868 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: ffffffff8881d400 RCX: ffffffff82d9f665
> RDX: 0000000000000008 RSI: ffffffff838e48c9 RDI: 0000000000000047
> RBP: ffff88809331f888 R08: ffff8880a0c76400 R09: fffffbfff13024e6
> R10: fffffbfff13024e5 R11: ffffffff8981272b R12: ffff888099398ed0
> R13: ffff888099398ed0 R14: ffffffffffffffef R15: ffff888099398f98
> FS:  0000000001edd880(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f835b5dc6f0 CR3: 00000000a0365000 CR4: 00000000001406e0
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 

