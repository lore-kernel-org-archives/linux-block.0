Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC737C433EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 12:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2D460EE3
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 12:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhKAMxx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 08:53:53 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:55119 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhKAMxx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 08:53:53 -0400
Received: by mail-il1-f200.google.com with SMTP id i20-20020a056e021d1400b0025c005cadefso7646659ila.21
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 05:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dBJ5vpuI59e0eOOVakkB2wOHLyYhGbssOGUlgrE1X/4=;
        b=W5UjIdQXhNm/KDvkeoYRzrrklnxL8BsMUHjnSFsRg444618c9ddtX0/I5OY1gQLkEA
         PHgW2mgs9aip3f3f4nZmDF82bFEe9PvzKPLI18j7bGAxiuahCVgXOX4SoyiTbtpBmDx5
         ty03CQLZajqU7Ku4XWJmK33eLO/+hTwSvzAEz5sHW6yztlJ237PGHHILwe3WhY/a1hd2
         Mmqbk2++a2CSBH1sQDf4YpsP8dJWfqiifqciMkFKqW3AiZN34l6Gq8P3F0FGm6NUzV7r
         LoJAyqfIKLMDDueJJu306DGg7PYQm5+icIhuJvF+CcgCe6wZvVg80ZJblo5+rmxP/3IC
         vr5Q==
X-Gm-Message-State: AOAM533Oe3RzgoujBBgDnHVsr2y0acR791C6DyR0N/dZdY+G0DJZwfM1
        vhlgD65x+dbDL3zfxA+j6FET5WHIHwlD8oc/2CVFZltaJVBs
X-Google-Smtp-Source: ABdhPJz2YzbP9SqEU1b77ZAvs4wyT43tJHGgCUpdmjppg1zXhxbgtQZUbcr4sryblfjgDmF80+yiTtvuyrsg8eSIRZSH5jsXr0DV
MIME-Version: 1.0
X-Received: by 2002:a05:6602:280a:: with SMTP id d10mr20112678ioe.216.1635771080032;
 Mon, 01 Nov 2021 05:51:20 -0700 (PDT)
Date:   Mon, 01 Nov 2021 05:51:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028c58805cfb9a28f@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in __blk_mq_alloc_requests
From:   syzbot <syzbot+cd20829ac44b92bf6ed0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    503f375baa99 Add linux-next specific files for 20211028
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14688302b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa50dda6b6975803
dashboard link: https://syzkaller.appspot.com/bug?extid=cd20829ac44b92bf6ed0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1385446ab00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fc8c6ab00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cd20829ac44b92bf6ed0@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1
BUG: unable to handle page fault for address: ffffed101e501750
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffee067 P4D 23ffee067 PUD 13fff5067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6523 Comm: syz-executor279 Not tainted 5.15.0-rc7-next-20211028-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__blk_mq_alloc_requests_batch block/blk-mq.c:408 [inline]
RIP: 0010:__blk_mq_alloc_requests+0x4a7/0xb00 block/blk-mq.c:457
Code: e8 fd 48 8b 44 24 10 80 38 00 0f 85 a6 04 00 00 48 8b 44 24 08 45 89 ed 48 8b b0 88 00 00 00 4a 8d 1c ee 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 6c 04 00 00 44 8b ac 24 a0 00 00 00 48 8b 03
RSP: 0018:ffffc900027fea90 EFLAGS: 00010a06
RAX: 1ffff1101e501750 RBX: ffff8880f280ba80 RCX: 0000000000000000
RDX: ffff888017bd1d40 RSI: ffff888019f43000 RDI: 0000000000000003
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff838f31a1 R11: 0000000000000000 R12: 0000000000000000
R13: 000000001b119150 R14: dffffc0000000000 R15: ffffc900027fec28
FS:  00005555573e63c0(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed101e501750 CR3: 0000000021651000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blk_mq_submit_bio+0xdac/0x1b40 block/blk-mq.c:2526
 __submit_bio+0x794/0x8e0 block/blk-core.c:894
 __submit_bio_noacct_mq block/blk-core.c:972 [inline]
 submit_bio_noacct block/blk-core.c:998 [inline]
 submit_bio_noacct+0x6c9/0x8a0 block/blk-core.c:987
 submit_bio block/blk-core.c:1059 [inline]
 submit_bio+0x1ea/0x430 block/blk-core.c:1017
 mpage_bio_submit fs/mpage.c:66 [inline]
 mpage_readahead+0x589/0x750 fs/mpage.c:393
 read_pages+0x1e4/0xfa0 mm/readahead.c:129
 page_cache_ra_unbounded+0x64b/0x940 mm/readahead.c:238
 do_page_cache_ra mm/readahead.c:268 [inline]
 ondemand_readahead+0x594/0x1090 mm/readahead.c:551
 page_cache_sync_ra+0x1cb/0x200 mm/readahead.c:579
 page_cache_sync_readahead include/linux/pagemap.h:980 [inline]
 filemap_get_pages+0x2b2/0x1be0 mm/filemap.c:2556
 filemap_read+0x315/0xeb0 mm/filemap.c:2642
 generic_file_read_iter+0x3b6/0x5a0 mm/filemap.c:2792
 blkdev_read_iter+0x117/0x200 block/fops.c:583
 call_read_iter include/linux/fs.h:2156 [inline]
 io_iter_do_read fs/io_uring.c:3462 [inline]
 io_read+0x33c/0xff0 fs/io_uring.c:3519
 io_issue_sqe+0x800/0x7010 fs/io_uring.c:6628
 __io_queue_sqe fs/io_uring.c:6978 [inline]
 io_queue_sqe fs/io_uring.c:7020 [inline]
 io_submit_sqe fs/io_uring.c:7223 [inline]
 io_submit_sqes+0x1bca/0x8a20 fs/io_uring.c:7329
 __do_sys_io_uring_enter+0xf6e/0x1f50 fs/io_uring.c:10043
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8a945379c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea64277e8 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8a945379c9
RDX: 0000000000000000 RSI: 00000000000002ff RDI: 0000000000000003
RBP: 00007ffea6427800 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffffed101e501750
---[ end trace dde64fe0ea4dcb18 ]---
RIP: 0010:__blk_mq_alloc_requests_batch block/blk-mq.c:408 [inline]
RIP: 0010:__blk_mq_alloc_requests+0x4a7/0xb00 block/blk-mq.c:457
Code: e8 fd 48 8b 44 24 10 80 38 00 0f 85 a6 04 00 00 48 8b 44 24 08 45 89 ed 48 8b b0 88 00 00 00 4a 8d 1c ee 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 6c 04 00 00 44 8b ac 24 a0 00 00 00 48 8b 03
RSP: 0018:ffffc900027fea90 EFLAGS: 00010a06
RAX: 1ffff1101e501750 RBX: ffff8880f280ba80 RCX: 0000000000000000
RDX: ffff888017bd1d40 RSI: ffff888019f43000 RDI: 0000000000000003
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff838f31a1 R11: 0000000000000000 R12: 0000000000000000
R13: 000000001b119150 R14: dffffc0000000000 R15: ffffc900027fec28
FS:  00005555573e63c0(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed101e501750 CR3: 0000000021651000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 fd 48 8b 44       	callq  0x448b4902
   5:	24 10                	and    $0x10,%al
   7:	80 38 00             	cmpb   $0x0,(%rax)
   a:	0f 85 a6 04 00 00    	jne    0x4b6
  10:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  15:	45 89 ed             	mov    %r13d,%r13d
  18:	48 8b b0 88 00 00 00 	mov    0x88(%rax),%rsi
  1f:	4a 8d 1c ee          	lea    (%rsi,%r13,8),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	0f 85 6c 04 00 00    	jne    0x4a1
  35:	44 8b ac 24 a0 00 00 	mov    0xa0(%rsp),%r13d
  3c:	00
  3d:	48 8b 03             	mov    (%rbx),%rax


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
