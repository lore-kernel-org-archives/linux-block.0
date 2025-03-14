Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700F12AE77
	for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968149; cv=none; b=BoGm0jctT7UwWptaaP9xOlNLYhcpQB19qHx4pWhzXY1hwm/NaijjatTR8e1QmY8+84Dz6mqkW8sjQgKFp5Up6C+ZnZrB7vNF0/eCwI2sRe/DJXwqttVXu70AEULVeZ8J8W/XnKELmdwrBHeYiO98GHzJDD9W/N7aEZffwtPVLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968149; c=relaxed/simple;
	bh=FWBaRSt0hd7lbAWNjIRmROwnetmpEzTA89iIHte9/+M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D0l88/vAJUnIKJq6DxaTrj6JZgWg1We94ssBBfct5YxqHRMvrdavY0VcogyoxtY0NJmFOAyl1KaxNg/r/yL/VptW9Ce5xcquILlG5sQxjC6jicZ9UjGTrCz6WJpIRCZMO8R0zixqejB7dyAMxS7fgp/leWzZmTUj5DZibHine9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43d3338d7so44055535ab.0
        for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 09:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741968146; x=1742572946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a01yNwfg+tsRWKVEaYSOGrK7UdIqa0u1nRwFTRBxZm4=;
        b=es7eAwoe59qluORIsc62mNh03Z1Y41xh5w0iFIG9OEfZuN10314um7pKcjVR3m8Wn3
         iiTLh5xquNczkk3N/maCgoIMPzZL4SPMPGjcYaksRfheD3PJC0UeswhNpS+A3aXkM+Ur
         MC7GhiR5kdf6CDT5Ve9KZFZQbxnSDSj9cqr8wDCXgIJZRKGFExFvFclcqbPGXWiF6XBs
         NZLuhwY6jL2adxXtJDGao4xW7uBvfatGfnn6Gsn7CBMTW6CBRNTJTzgtIZfmG62r0Pdd
         JzDeZ/8dhSGkx/Mg2ueuSKXPBQFY/t0SSbS5h21BWjOxI8yOf4GYQGeFjkDz8ubtAcHR
         eW4w==
X-Forwarded-Encrypted: i=1; AJvYcCXTr3k+TqpAw19W5Ceb9fErc/qckKSSeGvdlkYc/oA3ht18TiQApxhAsejHp0aRu4oX5yJKyjGGFW1URQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9OhKF3M2jiXEo1qRx6m19omqvBR6hB80pAcRMBSdKojjqw3n
	52XnNx/qgGLoxPPqmfZ1p4tJhkimmXN5wNSMYbZqQJNbML1YCoX2mn4rAOHH9Lsuvk/xvEgYmHy
	0gQCQOGQqN5GI9zE9RuF3Na42UETGDJbo0abkBAkorevJrL87qhcwNok=
X-Google-Smtp-Source: AGHT+IHIFRG/TL3NB9OUxwcR4Bibk/UVp1EYQ8cFlNPbBojSzROSkPTqJUvIzuWEz0JspLXm5dFNhJ2v+idvdcdt2ik7Gt6jcXoa
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cc:b0:3d3:dfc2:912f with SMTP id
 e9e14a558f8ab-3d483a0f58fmr28219165ab.7.1741968146422; Fri, 14 Mar 2025
 09:02:26 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:02:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d45312.050a0220.14e108.0046.GAE@google.com>
Subject: [syzbot] [block?] WARNING in bioset_exit
From: syzbot <syzbot+4b6dfa650582fe3f8827@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    80e54e84911a Linux 6.14-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11221478580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31c94a07ddad0b00
dashboard link: https://syzkaller.appspot.com/bug?extid=4b6dfa650582fe3f8827
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-80e54e84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3bc20f88b58a/vmlinux-80e54e84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fad1b751c2d1/bzImage-80e54e84.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b6dfa650582fe3f8827@syzkaller.appspotmail.com

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
bucket 0:28 gen 0 has wrong data_type: got free, should be btree, fixing
bucket 0:28 gen 0 data type btree has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:29 gen 0 has wrong data_type: got free, should be btree, fixing
bucket 0:29 gen 0 data type btree has wrong dirty_sectors: got 0, should be 256, fixing
bucket 0:31 gen 0 has wrong data_type: got btree, should be need_discard, fixing
bucket 0:31 gen 0 data type need_discard has wrong dirty_sectors: got 256, should be 0, fixing
bucket 0:32 gen 0 has wrong data_type: got sb, should be btree, fixing
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
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5325 at block/bio.c:146 bio_put_slab block/bio.c:146 [inline]
WARNING: CPU: 0 PID: 5325 at block/bio.c:146 bioset_exit+0x5ba/0x650 block/bio.c:1662
Modules linked in:
CPU: 0 UID: 0 PID: 5325 Comm: syz.0.0 Not tainted 6.14.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bio_put_slab block/bio.c:146 [inline]
RIP: 0010:bioset_exit+0x5ba/0x650 block/bio.c:1662
Code: cc e8 ca 38 ef fc e9 75 fd ff ff e8 c0 38 ef fc 90 48 c7 c7 60 f9 7e 8c e8 63 f5 ae fc 90 0f 0b 90 90 eb a2 e8 a7 38 ef fc 90 <0f> 0b 90 e9 d8 fe ff ff e8 99 38 ef fc 90 0f 0b 90 e9 05 ff ff ff
RSP: 0018:ffffc9000d4df880 EFLAGS: 00010287
RAX: ffffffff84d2a669 RBX: ffff88801285a9c0 RCX: 0000000000100000
RDX: ffffc9000ef1a000 RSI: 00000000000e287c RDI: 00000000000e287d
RBP: ffff888053149418 R08: ffffffff903cf777 R09: 1ffffffff2079eee
R10: dffffc0000000000 R11: fffffbfff2079eef R12: 00000000000004b0
R13: 1ffff1100a629283 R14: 0000000000000000 R15: ffff88801285a9c0
FS:  00007f8a423e96c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559b14e3d028 CR3: 0000000033de6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_fs_fs_io_direct_exit+0x19/0x30 fs/bcachefs/fs-io-direct.c:676
 __bch2_fs_free fs/bcachefs/super.c:558 [inline]
 bch2_fs_release+0x1a9/0x7b0 fs/bcachefs/super.c:624
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 bch2_fs_get_tree+0xdee/0x17a0 fs/bcachefs/fs.c:2299
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8a4158e90a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8a423e8e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8a423e8ef0 RCX: 00007f8a4158e90a
RDX: 00004000000058c0 RSI: 0000400000005900 RDI: 00007f8a423e8eb0
RBP: 00004000000058c0 R08: 00007f8a423e8ef0 R09: 0000000000010000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000400000005900
R13: 00007f8a423e8eb0 R14: 0000000000005912 R15: 0000400000000080
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
