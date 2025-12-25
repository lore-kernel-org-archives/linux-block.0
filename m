Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43332FC007
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766648066; cv=none; b=jaigXRjUi/vHXR65kbs5rxQ+qNtH4OMbdLhTwJ+hX4GwjqUCmgJdLacRkdwFt5LYtiLVclWUIxZFbTnBd8L5+0ayuhETwJWQugn5grgm0XIxS1la7KaU8apiW/m6XTkKWFUwIa+JFgE4yfewAJb9FP0Wlq867kL0q282feH22F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766648066; c=relaxed/simple;
	bh=PLkk7IZhtTh+/SYxJEL4KBpw+sYAUEfUPu0bnRBadCg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jEPnAWc52TKvImND9MrCz2ICl2yUspC6Qr48yUiGvEXzE0SjhtRE469fgDIFYOQqLWSC1NtfX762ZglV0RDxpsdIiIoo0+jEgKQx6Ny41sgUwh36FduYWNAMQXG3el4TxfDtEnT+zWjMeF8uVmFD2WS7mI+tbnSYBnsLljnfr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-65746235dd4so4682870eaf.3
        for <linux-block@vger.kernel.org>; Wed, 24 Dec 2025 23:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766648061; x=1767252861;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Eqn3pg9vBJ59sLZfc/0fIKhrL19tI/nJI9ruTTVmmM=;
        b=balAqlp8ZzLtSxELjg0zpM+niWmEKmSk3NdsYDpwBTdkYZo/cHW+vKanoI+a3mJhJS
         M46SDQCkop4OSZE049Eo973ZUeOenT0eNstC6dQ+ZUSsSKuBe12TubEagMnGV2p9L+HB
         TBm8x2gE88CR0nC50zVapJTS6NPQfplw8EMcmgD7F+nmwsKRUtqMqD3vNdj7a07A95QC
         h1EN6puXToR5fTLtYcTSDumxss4coto+bi5+f5GFt8sFc3QPy0hWWVYiFNtYsRTGss7S
         9XPHM1zP+ZTY7W0BOrHbhZfrE7LIBh7wmHZWtB4YHUylfARU6PKKb7Wm2FXR6i1R0c1u
         1i5w==
X-Forwarded-Encrypted: i=1; AJvYcCW4ylKdurbLh7EkRuTeEtOS/CwwGHgtQTI55OtCTYYrrGXCGoXAQfL9PBLjk4jQB/993jGYhi96DX9ORg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWzJ4KhzQfkMi53E19gCroo/P3Q9R20nzq7c88l8RkY3/XAHyo
	gaDEb5QsZgnMxl5u4K3vD4e1FJ8WQkq236617XtAB+tMEK/bt3lCZMiQyYqXJPHiprgPV4xiIdd
	4TR3vBIpsTpEmTCpWjHZsQevfmdpWv6ydb37a4I7wLQYWQJt/olHYiZF8/Sc=
X-Google-Smtp-Source: AGHT+IEMvEyil+P6EqioyWnjq5UJHLjQVrKWDCrQxS9gkADCb40a4LmvAb37r+jBcIR2FcI+f42zKL1TJ7G7jFG/g2BQ0Yx2xMM0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:b28b:0:b0:65d:6ed:e05c with SMTP id
 006d021491bc7-65d0eaf0753mr6219855eaf.64.1766648061384; Wed, 24 Dec 2025
 23:34:21 -0800 (PST)
Date: Wed, 24 Dec 2025 23:34:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694ce8fd.050a0220.35954c.0035.GAE@google.com>
Subject: [syzbot] [block?] WARNING in wbt_init_enable_default
From: syzbot <syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b927546677c8 Merge tag 'dma-mapping-6.19-2025-12-22' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11dc8b92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=71fcf20f7c1e5043d78c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10515f1a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b27369f4b013/disk-b9275466.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b2d81c4be86/vmlinux-b9275466.xz
kernel image: https://storage.googleapis.com/syzbot-assets/89c2ad4f36b6/bzImage-b9275466.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: block/blk-wbt.c:741 at wbt_init_enable_default+0x4e/0x60 block/blk-wbt.c:741, CPU#0: syz.1.439/7602
Modules linked in:
CPU: 0 UID: 0 PID: 7602 Comm: syz.1.439 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:wbt_init_enable_default+0x4e/0x60 block/blk-wbt.c:741
Code: ff 89 c6 e8 e4 e4 40 fd 85 db 75 18 e8 9b e0 40 fd 5b e9 20 2c 90 fc cc e8 8f e0 40 fd 5b e9 14 2c 90 fc cc e8 83 e0 40 fd 90 <0f> 0b 90 5b e9 04 2c 90 fc cc 0f 1f 84 00 00 00 00 00 90 90 90 90
RSP: 0018:ffffc90004ab7ab8 EFLAGS: 00010293
RAX: ffffffff848014fd RBX: 00000000fffffff4 RCX: ffff88802a78bd00
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: 1ffff11004165212 R08: ffffffff8f822277 R09: 1ffffffff1f0444e
R10: dffffc0000000000 R11: fffffbfff1f0444f R12: 0000000000000000
R13: 1ffff110051e05f7 R14: ffff888020b29000 R15: ffff888028f02fa8
FS:  00007f3ce68426c0(0000) GS:ffff888125e1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f999a972100 CR3: 000000007b2b2000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 blk_register_queue+0x36a/0x3f0 block/blk-sysfs.c:935
 __add_disk+0x677/0xd50 block/genhd.c:528
 add_disk_fwnode+0xfc/0x480 block/genhd.c:597
 add_disk include/linux/blkdev.h:785 [inline]
 loop_add+0x7f0/0xad0 drivers/block/loop.c:2093
 loop_control_get_free drivers/block/loop.c:2209 [inline]
 loop_control_ioctl+0x2f2/0x5a0 drivers/block/loop.c:2224
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3ce598f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3ce6842038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3ce5be6090 RCX: 00007f3ce598f749
RDX: 0000000000000000 RSI: 0000000000004c82 RDI: 0000000000000006
RBP: 00007f3ce5a13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3ce5be6128 R14: 00007f3ce5be6090 R15: 00007ffd72edd058
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
