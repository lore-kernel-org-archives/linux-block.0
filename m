Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3A13AA2D
	for <linux-block@vger.kernel.org>; Sun, 29 Dec 2024 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735510165; cv=none; b=StDXMP2LQntn6c5qVRN95cZkEwPlLjpoO+dnjcZujKro4D8K7fQiPKWtRteNgigK3JWHnd9qSi54Fnt1cGCXH5poF0iyXAR+bWnSkqIxYsEHeO44wq07Y1kWd/lnUGOjxBI9JW6+8/CT3qCFxj8VMJJYUdR9cUCEiKNaWuxgsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735510165; c=relaxed/simple;
	bh=Na2FrSyUGu0ONDs2pzAxpCQJidRIAqSkQctUH60AKXs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LiOw1nH+ymthM850W9fPMRS+i6Il4oBj4J9q+Bwm/iwNsoH1oupZuT7b3QiFm48AISmZl0PasdGTmYBbBDU2lTKXajP5mkHOVex6D4/FZavh1BRJsd1gu4nLqDqdHJQRfcmtvZDCp8eR2rXoQMH6WJdoaK7KTckuyu+TUhbiH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso196635115ab.0
        for <linux-block@vger.kernel.org>; Sun, 29 Dec 2024 14:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735510163; x=1736114963;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTNaEwW6RhuAGjwhkaCsh2JaW1BSuSXMdDWRSv0XX/c=;
        b=u8DKtXlh7KFgWeR/nkvq2YmNCTdDbQjCAFf+3pcEJyc4x0zv+ABsC+R4EXuaSxReE8
         5TYBDKQoQ9TGqYDwdW5GA1sLhuLB9MgvJ282x7PODR53w1++Kj3Wf9ofoWPGNuuPAHln
         +MkiI2Fazr7Uqltehgk3EKy1AB6/aKvxdg2WhW3Zg2PAVbWbTRIqNCt86oM6Q6jDCga4
         XQys7DvS+ZjQbrlhUbJe9qEASzSuKBxnq/4JL+6jKetBJaR6vQWPC66vryPi4Bg3J6C8
         qYk2ctVPsiJewV3Zo3k7NJ8Fb3WXjnQc2PGULn74LXSZdDrxp+CEl7LllENIbqXQmoas
         STEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo5gX5gseeevphar4PCIYdoiZkCthiDC/jgO+RoL/XNdlv31BbWVV7KmeuRztnZvs797ij1Wj8r9E0iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPOGitjHg0Slqbq9NK5/upYyC0yHoU4OdP7M7ekkY1DBfOs3md
	6mnPNcAOUx8Th8hEnH8t/JbGxSaHu/ZbeHG1yXmwvUrXFIVABCQmBkRKEt/vzqSztSQfCEKVBKe
	r4BE12QNQrqOEjA/FMftm67MuA0si7OiW/koG8tJuFd1mkWhqi7lH2L8=
X-Google-Smtp-Source: AGHT+IGEjp48IpD3KLC2wfjsOkY3Pd901RaQFztbAaNqoTGASi7cwTQmJFPfIEnmR/6m/43QREvu276iEGdRORdvRCUqb5q9fx9G
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3201:b0:3a7:15aa:3fcc with SMTP id
 e9e14a558f8ab-3c2d1aa3820mr325797365ab.1.1735510163530; Sun, 29 Dec 2024
 14:09:23 -0800 (PST)
Date: Sun, 29 Dec 2024 14:09:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6771c893.050a0220.2f3838.04ae.GAE@google.com>
Subject: [syzbot] [block?] kernel BUG in invalidate_inode_pages2_range
From: syzbot <syzbot+b2a8ea9a0e2074a9138a@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8155b4ef3466 Add linux-next specific files for 20241220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17da40b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
dashboard link: https://syzkaller.appspot.com/bug?extid=b2a8ea9a0e2074a9138a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98a974fc662d/disk-8155b4ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2dea9b72f624/vmlinux-8155b4ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/593a42b9eb34/bzImage-8155b4ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2a8ea9a0e2074a9138a@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/truncate.c:637!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 7059 Comm: syz.0.223 Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:invalidate_inode_pages2_range+0xdc7/0xe10 mm/truncate.c:637
Code: c6 20 ed 13 8c e8 e9 01 0c 00 90 0f 0b e8 21 29 c2 ff 4c 89 ef 48 c7 c6 60 ec 13 8c e8 d2 01 0c 00 90 0f 0b e8 0a 29 c2 ff 90 <0f> 0b e8 02 29 c2 ff 4c 89 ef 48 c7 c6 20 ed 13 8c e8 b3 01 0c 00
RSP: 0018:ffffc90004def3e0 EFLAGS: 00010283
RAX: ffffffff81fcfb16 RBX: ffffea0001501148 RCX: 0000000000080000
RDX: ffffc9000d89f000 RSI: 0000000000022890 RDI: 0000000000022891
RBP: ffffc90004def7a0 R08: ffffffff81fcfc52 R09: 1ffffd40002a022e
R10: dffffc0000000000 R11: fffff940002a022f R12: 0000000000000014
R13: ffffea0001501140 R14: ffffea0001501158 R15: 1ffffd40002a022b
FS:  00007fe35fda36c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe35fda2f98 CR3: 0000000022348000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blkdev_fallocate+0x262/0x490 block/fops.c:856
 vfs_fallocate+0x623/0x7a0 fs/open.c:338
 madvise_remove mm/madvise.c:1025 [inline]
 madvise_vma_behavior mm/madvise.c:1260 [inline]
 madvise_walk_vmas mm/madvise.c:1502 [inline]
 do_madvise+0x23c9/0x4d90 mm/madvise.c:1689
 __do_sys_madvise mm/madvise.c:1705 [inline]
 __se_sys_madvise mm/madvise.c:1703 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1703
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe35ef85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe35fda3038 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fe35f176160 RCX: 00007fe35ef85d29
RDX: 0000000000000009 RSI: 0000000000600002 RDI: 0000000020000000
RBP: 00007fe35f001aa8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fe35f176160 R15: 00007ffe789c5788
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:invalidate_inode_pages2_range+0xdc7/0xe10 mm/truncate.c:637
Code: c6 20 ed 13 8c e8 e9 01 0c 00 90 0f 0b e8 21 29 c2 ff 4c 89 ef 48 c7 c6 60 ec 13 8c e8 d2 01 0c 00 90 0f 0b e8 0a 29 c2 ff 90 <0f> 0b e8 02 29 c2 ff 4c 89 ef 48 c7 c6 20 ed 13 8c e8 b3 01 0c 00
RSP: 0018:ffffc90004def3e0 EFLAGS: 00010283
RAX: ffffffff81fcfb16 RBX: ffffea0001501148 RCX: 0000000000080000
RDX: ffffc9000d89f000 RSI: 0000000000022890 RDI: 0000000000022891
RBP: ffffc90004def7a0 R08: ffffffff81fcfc52 R09: 1ffffd40002a022e
R10: dffffc0000000000 R11: fffff940002a022f R12: 0000000000000014
R13: ffffea0001501140 R14: ffffea0001501158 R15: 1ffffd40002a022b
FS:  00007fe35fda36c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020004280 CR3: 0000000022348000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
