Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730D1494A9
	for <linux-block@vger.kernel.org>; Sat, 28 Jun 2025 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751077531; cv=none; b=aPYQX0U5kO6ZFR5Pc5l6ho0AgJre866CUG45H2FYQjOdh0+wJLIJfVeR97y6DzoCzkoXlDnrdBtkIgtVXcG+wwtTfvrqZuGLoV6mDTfD0FbXAXu9fm7gLKve4fIxauk1s+pIyeq8INeeXfYz56uEle9RBo9bJ1h9fsWeyfxTw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751077531; c=relaxed/simple;
	bh=JtQzyn27RMDuTjVIvJMU80N35L2x4wCeYg07utm4mdU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ppMHWsiW3b7e0gloub/dbqMNRthrqQXLU5vE15qP2f/+SxP1kNhhTHu37CnIlRcWm2KgfQ2IbH/6FUDRT4Ttnl8+TqkaMyHr5TPwwQmx3Se2Srnk8iv2qtmI4GtrWGmYRRESEoqQyDpX2HuGGhYM9SLQj6zLIrb6CRfvkRxkwFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3df2d0b7c50so5257715ab.1
        for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 19:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751077528; x=1751682328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17UoAorZRx0TYoS0tsz1k5/Pm+icqHe5YL+HLnq6l6s=;
        b=n2j7NjbEoO0A+ghFe5XXg+HaVSYutjSsAW3jdAHrbbF+kKAVySb1YGI/czuw9m4FzX
         FhlZSTi9/LPoBpac7b242hIwwJnjE+gtaCcyX6ZK2HXVew0ainsI3QSejwTuvR3eGLY4
         xTyc7qjV1FcuvpNbkjiP/zBtSNbO1+Xj1EEnichTq+gM6LNAl1dqpmHE0broK+GT1E1n
         F1u+DNd2h2d8zGcsGfgl7yvRqtHrklqpA9cH4/WuqdlL3ko589O8o7fOUzR8fOB9kpbq
         QPJ/HsaWTLbFl0c/j2PipPk2UTN+Wxk1Yo1Smu/Ba40dlpKMTr3zu/pTj6LBrXzKt9Tu
         etJg==
X-Forwarded-Encrypted: i=1; AJvYcCV9bNwc/+2vPeV2nbwdBJycqH1X+V8IltCMTaEY7NCkXVeOgFpbE1ddlUFMDlvwdpxgk97A6v13FRddzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3YCRl5ZOpqIvXiduGOKBkxu/RygehTVduUkmTqjB2WQ6IbYZ
	hnaviV9BAgf3yqL4kr4qOzyB6TWdPBTE3tvOj6Vh3xx2qIZK3oJcsa9cVc2fkuvKpXoRvGqDg1I
	fGQiC9OiJTQW9zA4UxWxTSrLRN/c3MuLogaG5zkWxptJVFnASC2ZkHrMT3KM=
X-Google-Smtp-Source: AGHT+IGfMgFi4/i/Yd/+XJAX6Hy5RTpGwYM6JDvMcY6HWtds7v/J0Mg8gpaz7I+ZS5ZVP4FHc+xKNsqrkJ/EFbYeSRFD2fu/kbbL
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2409:b0:3dd:f4d5:1c1a with SMTP id
 e9e14a558f8ab-3df4abad659mr69311055ab.17.1751077528597; Fri, 27 Jun 2025
 19:25:28 -0700 (PDT)
Date: Fri, 27 Jun 2025 19:25:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685f5298.a70a0220.2f4de1.0006.GAE@google.com>
Subject: [syzbot] [block?] WARNING in bdev_count_inflight_rw
From: syzbot <syzbot+f37a847571460b5ac3e4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    78f4e737a53e Merge tag 'for-6.16/dm-fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fee182580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ad206eb0100c6a2
dashboard link: https://syzkaller.appspot.com/bug?extid=f37a847571460b5ac3e4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-78f4e737.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/25280700ec66/vmlinux-78f4e737.xz
kernel image: https://storage.googleapis.com/syzbot-assets/612c7f59b159/bzImage-78f4e737.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f37a847571460b5ac3e4@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 13932 at block/genhd.c:144 bdev_count_inflight_rw+0x3ba/0x510 block/genhd.c:144
Modules linked in:
CPU: 3 UID: 0 PID: 13932 Comm: syz.0.1834 Not tainted 6.16.0-rc3-syzkaller-00042-g78f4e737a53e #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bdev_count_inflight_rw+0x3ba/0x510 block/genhd.c:144
Code: b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 4b 01 00 00 c7 43 04 00 00 00 00 e9 5f ff ff ff e8 a7 86 ff fc 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 0f b6
RSP: 0000:ffffc9000c3571a8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000c357230 RCX: ffffffff84bc0298
RDX: ffff8880233e0000 RSI: ffffffff84bc0359 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000001 R12: 00000000ffffffff
R13: dffffc0000000000 R14: ffffc9000c357234 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff888097860000(0063) knlGS:00000000569b2440
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f71bd12a CR3: 0000000069b94000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bdev_count_inflight+0x74/0xb0 block/genhd.c:163
 update_io_ticks+0x22a/0x2a0 block/blk-core.c:1021
 blk_account_io_start block/blk-mq.c:1116 [inline]
 blk_account_io_start+0x3e9/0x730 block/blk-mq.c:1092
 blk_mq_bio_to_request block/blk-mq.c:2675 [inline]
 blk_mq_submit_bio+0xd9d/0x26a0 block/blk-mq.c:3191
 __submit_bio+0x3cf/0x690 block/blk-core.c:635
 __submit_bio_noacct_mq block/blk-core.c:722 [inline]
 submit_bio_noacct_nocheck+0x660/0xd30 block/blk-core.c:751
 submit_bio_noacct+0x50d/0x1eb0 block/blk-core.c:874
 ext4_mpage_readpages+0x66d/0x19d0 fs/ext4/readpage.c:395
 ext4_readahead+0x102/0x140 fs/ext4/inode.c:3337
 read_pages+0x1c4/0xc70 mm/readahead.c:160
 page_cache_ra_unbounded+0x5d2/0x7d0 mm/readahead.c:264
 do_page_cache_ra mm/readahead.c:327 [inline]
 page_cache_ra_order+0x9c8/0xd00 mm/readahead.c:532
 do_sync_mmap_readahead mm/filemap.c:3271 [inline]
 filemap_fault+0x1465/0x26c0 mm/filemap.c:3412
 __do_fault+0x10a/0x490 mm/memory.c:5169
 do_read_fault mm/memory.c:5590 [inline]
 do_fault mm/memory.c:5724 [inline]
 do_pte_missing mm/memory.c:4251 [inline]
 handle_pte_fault mm/memory.c:6069 [inline]
 __handle_mm_fault+0x3c2a/0x5490 mm/memory.c:6212
 handle_mm_fault+0x589/0xd10 mm/memory.c:6381
 do_user_addr_fault+0x60c/0x1370 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x5c/0xb0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0023:0xf71bd12a
Code: Unable to access opcode bytes at 0xf71bd100.
RSP: 002b:00000000ff8ced80 EFLAGS: 00010202
RAX: 00000000000000a0 RBX: 0000000000000000 RCX: 000000000000000b
RDX: 000000000001c5f8 RSI: 00000000569b7a08 RDI: 0000000000000090
RBP: 00000000f73f96a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
