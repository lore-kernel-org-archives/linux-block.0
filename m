Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434DC32AAC5
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756931; cv=none; b=QtFcm+A5NOfve3a9MhbHoisxFRE7DSb1THw399EXlYHyLkmD/K2iMyYWNq7BMW14XOFrTYGKlgtzLca965MxEqVFECSlE+A8cxe8l/+jEZoh0UBBAm+d9jNI5ftX8F49x6iiba8IUoUS9FpOaDWDJrGKHriMlMCm1Cpea6FeOE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756931; c=relaxed/simple;
	bh=pK0W3OI2xGS6LuGacNPoSWgmepdWxkozPMxPvgjqAIc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AS6sL9IowF3g7eq3WgS/JPXSPI5cvB/fglNc1/GrriEIt5C9CJUiJac4k8T9zjsKVO5ZVeiH/qYoeUYUivphcmHBXq+6hiAYSQszJTqywk2IuUem/nHqWFMyNctQpXUGwLgI0cbVWFNJewcs3tPy3szdsqc0lJTgumdhqhqJL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-486cc29e03bso4303378b6e.3
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 11:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756929; x=1783361729;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kt2DrcjE5btuCM8Uki/zMdK5/0531fPcDp1wPqpAtYk=;
        b=iFs8h6URQiZGQWLvf9PiBGqE/Pd2FxvUQMkOSF//nf3yV3StwqAUShxkW1jQWNRXlA
         d1wHQg/qlhAfMlO4UCKWF9z+q4JxQjTbGwbI5tyuDuPiFpwtciKeq2Vr5w006vKU6+GA
         HnKZyOLt1rzEle98FDmGuZI/bJj8vq98E9MSx7o3rwxkO/Wvuiuw/djt6icu8xzyPM/Y
         rqVHT2lVKlE+xqfqyquC3MoCjRj8RkBuD7Zwh3OIwDz1NgMYNbm7Uf1RXP8eVvQKOTlt
         2QX4rOAZ+diW26gNzDr19NDD8fEEMa7zppDrFIrI/vlHZ9j5W8KkFhV/ZVSKFa9zBhnt
         pNOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+i/iTamRjZBFcVMSR1kp0/yD22oBZK5k6+hknXzBiUB6w7JBTOU1TcQ5yAiG+eTZmC2sDqwBy80F9Vmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22zM1DRJBVyhmKP/jVp8JiuzmbVJkmY1lzo9LdVxgBeqsu3sE
	SO1mqES/oWuWk3o9A0IqTT8FwdvxDlKtcBwXA9ey9ycc/Dvi96QRZN8pVi8GSC09lAdyAVHfd3P
	S72mf0VF4r5cFzSTXAMhxW7Qk8R0cRwID7vpAXeTt12ySxbje/JHxWMMuk44=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:130f:b0:492:3ad9:326d with SMTP id
 5614622812f47-495eaf6a762mr432827b6e.22.1782756929296; Mon, 29 Jun 2026
 11:15:29 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:15:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a42b641.854d4ab9.360e1d.000b.GAE@google.com>
Subject: [syzbot] [block?] WARNING in ublk_ch_batch_io_uring_cmd
From: syzbot <syzbot+1a67ee1aa79484801ec6@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab9de95c9cf9 Merge tag 'rust-7.2-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120f22ae580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86ba763b42fa66a
dashboard link: https://syzkaller.appspot.com/bug?extid=1a67ee1aa79484801ec6
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c16df342a923/disk-ab9de95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ddf00a828178/vmlinux-ab9de95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f468c716a7be/bzImage-ab9de95c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a67ee1aa79484801ec6@syzkaller.appspotmail.com

------------[ cut here ]------------
ret
WARNING: drivers/block/ublk_drv.c:3683 at ublk_batch_revert_prep_cmd drivers/block/ublk_drv.c:3683 [inline], CPU#1: syz.3.517/8158
WARNING: drivers/block/ublk_drv.c:3683 at ublk_handle_batch_prep_cmd drivers/block/ublk_drv.c:3732 [inline], CPU#1: syz.3.517/8158
WARNING: drivers/block/ublk_drv.c:3683 at ublk_ch_batch_io_uring_cmd+0x1626/0x1830 drivers/block/ublk_drv.c:3999, CPU#1: syz.3.517/8158
Modules linked in:
CPU: 1 UID: 0 PID: 8158 Comm: syz.3.517 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:ublk_batch_revert_prep_cmd drivers/block/ublk_drv.c:3683 [inline]
RIP: 0010:ublk_handle_batch_prep_cmd drivers/block/ublk_drv.c:3732 [inline]
RIP: 0010:ublk_ch_batch_io_uring_cmd+0x1626/0x1830 drivers/block/ublk_drv.c:3999
Code: ff e8 2e c4 96 05 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c f8 ec ff ff 4c 89 ff e8 05 5f 17 fc e9 eb ec ff ff e8 bb d0 a9 fb 90 <0f> 0b 90 e9 a9 fe ff ff 44 89 f1 80 e1 07 fe c1 38 c1 0f 8c bb ed
RSP: 0018:ffffc90004387480 EFLAGS: 00010283
RAX: ffffffff861c5fe5 RBX: ffff888054070090 RCX: 0000000000080000
RDX: ffffc9000db0b000 RSI: 0000000000003aa6 RDI: 0000000000003aa7
RBP: ffffc90004387aa0 R08: ffffc900043877e0 R09: 1ffff92000870efc
R10: dffffc0000000000 R11: fffff52000870efd R12: 00000000ffffffea
R13: ffff8880260c2770 R14: 00000000ffffffea R15: 0000000000000020
FS:  00007fdc0093f6c0(0000) GS:ffff888125327000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2b3d7e8158 CR3: 0000000053938000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 io_uring_cmd+0x2e6/0x8b0 io_uring/uring_cmd.c:271
 __io_issue_sqe+0x188/0x4d0 io_uring/io_uring.c:1395
 io_issue_sqe+0x16d/0x1020 io_uring/io_uring.c:1418
 io_queue_sqe io_uring/io_uring.c:1649 [inline]
 io_submit_sqe io_uring/io_uring.c:1934 [inline]
 io_submit_sqes+0xd26/0x2310 io_uring/io_uring.c:2057
 __do_sys_io_uring_enter io_uring/io_uring.c:2646 [inline]
 __se_sys_io_uring_enter+0x35b/0x1bb0 io_uring/io_uring.c:2595
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdbff99ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdc0093ef38 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 0000200000001f40 RCX: 00007fdbff99ce59
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000007
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000008
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000000b40
R13: 0000200000000b48 R14: 0000000000000104 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
