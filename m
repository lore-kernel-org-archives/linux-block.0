Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855752AE93
	for <linux-block@vger.kernel.org>; Sun,  2 Feb 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738519464; cv=none; b=n9Bnr6INQoEfoDPmmYFIZy6Uxi774Sk/Bo1mE6cB0G3jsKDiUWKrn3SsJHuVe0oakHBFbRlDMgUtPwnVFGbj5I6xlsWNM1mUMh41nPrZsLxouJlR4p1vfKXPD4sbgR4zhbu85HDN+gTuOl0ZBYk5EM1OxcohwqtUVFATX74KNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738519464; c=relaxed/simple;
	bh=n716OSu+4B+kztJqxkIeXlLvWc9ooog4IDk5aY85SMQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f3Onz0SEF11ko/CQKrpBEfS/LRYgHxwUTvB4Ahu4j80IDIe8xj8mAe9iZz9inT0Zi5P1OSAAJ+t4iDj2Ltc3NBxFPuUjUehY28qcXPd2WfsA0y4H7XR95qg+DYDqeJgWX5JoLTTsm+bseu/wDNY3X53CuXDlRTBflNnIlpiCl7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d00eac3de2so20641665ab.0
        for <linux-block@vger.kernel.org>; Sun, 02 Feb 2025 10:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738519461; x=1739124261;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PsUkC+kexBJl+7cjtLJepJ6OvyOh/oNcLHjYZhOIL5k=;
        b=tjUoRP2h85zy7IX8oIM5l6M9PRaG74eIYzaVB4i18F5osIyUhjlVGyDiipvqEfF1gk
         VurDg3iJyyeLyGLDARPO9ACMjI3dBZUCRhglITfUIQ1xFuAEXVtv7RI7kK6veOARhDbB
         wN5nb4GTMZbh9xOXK5iWZslAi0wQyG1+5UP41/PMn4mIwPe3hlgyOdHd4hePSOLMrl81
         J3dovgAh898ZOLTJT8JYNICaPNHOn3aIz8fN8JajEcI5mrcmOQPRgdDlTdIYSC3GmA72
         nd1H21YEIbbX7e8UOPhh24zguBivDlOYD5V5hcRecj0jtpwurP1IoxaMlpjaW8M2eCAt
         7EKw==
X-Forwarded-Encrypted: i=1; AJvYcCV6lmpWaa9bn9w6p+EGGnATuRwO8iLonzyBn2+yeGwY5rKXOVO5H5ZN4vi1znSBnsFUaKGVs0VK2JW5Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YywBdV7Sr6DB9i8TbbvDqITul/qUFgOpK5h5zYVwDd862q1YRjS
	f1sNiP013FJvdW7VSAQNlNw5kDt7trDFASkyjpWKNGg91u88CoXxdckF/K6YWjApR6ZNkRjF+K8
	z7ur8zikLElm/nnmr7E4fsGlMPrdAgjuXBWe0QAf5/xpYLO6DxqpS/xQ=
X-Google-Smtp-Source: AGHT+IGlxB0p1TkNBrEKVUg+90U045SVUMToxMi3mQ2dU9PbhVqtVSYIEbG6TvU2MV4+42mD+vCEkGFxRI6P5VEftYl9qgitcVS5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a29:b0:3d0:258e:4841 with SMTP id
 e9e14a558f8ab-3d0258e49f8mr51854105ab.21.1738519461598; Sun, 02 Feb 2025
 10:04:21 -0800 (PST)
Date: Sun, 02 Feb 2025 10:04:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679fb3a5.050a0220.163cdc.0030.GAE@google.com>
Subject: [syzbot] [block?] general protection fault in bioset_exit (2)
From: syzbot <syzbot+76f13f2acac84df26aae@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11014b24580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
dashboard link: https://syzkaller.appspot.com/bug?extid=76f13f2acac84df26aae
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a53b888c1f3f/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b5e17edafc0/bzImage-69e858e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76f13f2acac84df26aae@syzkaller.appspotmail.com

bucket 0:19 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:20 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:20 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:21 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:21 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:22 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:22 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:23 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:23 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:24 gen 0 has wrong data_type: got free, should be journal, fixing
bucket 0:24 gen 0 data type journal has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:26 gen 0 has wrong data_type: got free, should be btree, fixing
bucket 0:26 gen 0 data type btree has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:27 gen 0 has wrong data_type: got btree, should be need_discard, fixing
bucket 0:27 gen 0 data type need_discard has wrong dirty_sectors: got 256, should be 0, fixing
bucket 0:29 gen 0 has wrong data_type: got free, should be btree, fixing
bucket 0:29 gen 0 data type btree has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:32 gen 0 has wrong data_type: got sb, should be btree, fixing
bucket 0:34 gen 0 has wrong data_type: got user, should be need_discard, fixing
bucket 0:34 gen 0 data type need_discard has wrong dirty_sectors: got 16, should be 0, fixing
bucket 0:35 gen 0 has wrong data_type: got free, should be btree, fixing
bucket 0:35 gen 0 data type btree has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:38 gen 0 has wrong data_type: got free, should be btree, fixing
bucket 0:38 gen 0 data type btree has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:41 gen 0 has wrong data_type: got free, should be btree, fixing
bucket 0:41 gen 0 data type btree has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:120 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:120 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:121 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:121 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:122 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:122 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:123 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:123 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:124 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:124 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:125 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:125 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:126 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:126 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:127 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:127 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
 done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay...
bcachefs (loop0): bch2_journal_replay(): error erofs_journal_err
bcachefs (loop0): bch2_fs_recovery(): error erofs_journal_err
bcachefs (loop0): bch2_fs_start(): error starting filesystem erofs_journal_err
bcachefs (loop0): shutting down
bcachefs (loop0): shutdown complete
Oops: general protection fault, probably for non-canonical address 0x1000000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:qlist_move_cache+0x6a/0x140 mm/kasan/quarantine.c:302
Code: 00 00 00 00 48 8d 47 08 48 89 44 24 18 48 8d 47 10 48 89 44 24 10 48 8d 46 08 48 89 44 24 08 48 8d 46 10 48 89 04 24 4c 89 eb <4d> 8b 6d 00 48 89 df e8 aa 51 47 ff 48 c1 e8 06 48 83 e0 c0 48 8b
RSP: 0018:ffffc9000d3777b0 EFLAGS: 00010006
RAX: 0000000000000140 RBX: 0001000000000000 RCX: ffffffff9a463b08
RDX: ffffffff9a463b10 RSI: ffff888042616c80 RDI: 00000000000cf2c9
RBP: ffffea0000000000 R08: ffffffff816d68ec R09: fffff52001a6eedc
R10: dffffc0000000000 R11: fffff52001a6eedc R12: ffffffff9a463b00
R13: 0001000000000000 R14: ffffc9000d377808 R15: ffff888055273500
FS:  00007f1cd9cce6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c19933f0c8 CR3: 0000000040e1a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kasan_quarantine_remove_cache+0x10b/0x180 mm/kasan/quarantine.c:370
 kmem_cache_destroy+0x6e/0x160 mm/slab_common.c:528
 bio_put_slab block/bio.c:155 [inline]
 bioset_exit+0x54e/0x650 block/bio.c:1662
 bch2_fs_fs_io_direct_exit+0x19/0x30 fs/bcachefs/fs-io-direct.c:676
 __bch2_fs_free fs/bcachefs/super.c:547 [inline]
 bch2_fs_release+0x1a9/0x7b0 fs/bcachefs/super.c:613
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 bch2_fs_get_tree+0xdc4/0x1740 fs/bcachefs/fs.c:2299
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1cd8d8e54a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1cd9ccde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f1cd9ccdef0 RCX: 00007f1cd8d8e54a
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 00007f1cd9ccdeb0
RBP: 0000000020000000 R08: 00007f1cd9ccdef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000040
R13: 00007f1cd9ccdeb0 R14: 000000000000593f R15: 0000000020000380
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:qlist_move_cache+0x6a/0x140 mm/kasan/quarantine.c:302
Code: 00 00 00 00 48 8d 47 08 48 89 44 24 18 48 8d 47 10 48 89 44 24 10 48 8d 46 08 48 89 44 24 08 48 8d 46 10 48 89 04 24 4c 89 eb <4d> 8b 6d 00 48 89 df e8 aa 51 47 ff 48 c1 e8 06 48 83 e0 c0 48 8b
RSP: 0018:ffffc9000d3777b0 EFLAGS: 00010006
RAX: 0000000000000140 RBX: 0001000000000000 RCX: ffffffff9a463b08
RDX: ffffffff9a463b10 RSI: ffff888042616c80 RDI: 00000000000cf2c9
RBP: ffffea0000000000 R08: ffffffff816d68ec R09: fffff52001a6eedc
R10: dffffc0000000000 R11: fffff52001a6eedc R12: ffffffff9a463b00
R13: 0001000000000000 R14: ffffc9000d377808 R15: ffff888055273500
FS:  00007f1cd9cce6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c19933f0c8 CR3: 0000000040e1a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	48 8d 47 08          	lea    0x8(%rdi),%rax
   8:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   d:	48 8d 47 10          	lea    0x10(%rdi),%rax
  11:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  16:	48 8d 46 08          	lea    0x8(%rsi),%rax
  1a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  1f:	48 8d 46 10          	lea    0x10(%rsi),%rax
  23:	48 89 04 24          	mov    %rax,(%rsp)
  27:	4c 89 eb             	mov    %r13,%rbx
* 2a:	4d 8b 6d 00          	mov    0x0(%r13),%r13 <-- trapping instruction
  2e:	48 89 df             	mov    %rbx,%rdi
  31:	e8 aa 51 47 ff       	call   0xff4751e0
  36:	48 c1 e8 06          	shr    $0x6,%rax
  3a:	48 83 e0 c0          	and    $0xffffffffffffffc0,%rax
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


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
