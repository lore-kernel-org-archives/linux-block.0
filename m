Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676227A92A
	for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 04:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836197; cv=none; b=VEanVu2OveuJcUZ4mk9F+wnUvsCRJ6uc+zgV7GNfnIdPWJRRV8TVmlZnHF8cxBmeVL4UDrv+12V56rVKHK86Rdj2SrebP3WstcZjJCgInWWZrl+uw2TPKhp/iQiBRnuaAJWbm7FBrNEGzYW3cygptw8VSELuNkKWs4xHnqlf/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836197; c=relaxed/simple;
	bh=tD4yUyDNqfKZ+v7WjGAeHzcqa624KDFXQaOHkamS+zU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OiL/DQKjoLlBVzvsdVuJ1YK2y/EgHed9Bvcfx7w4pGpt3TJr7bD3E+AppyGs8wgDoHNICgJbHJCjYhZ6c51c8HdP39HaF4vk+habbdwpf7GvlXg2ju8XOFmjMhqPNAsF+HH+2kkVi3UohjGmk33fLwt2JldURG7C3SPaCCWpVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e66b7e4a94so46896995ab.1
        for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 21:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755836193; x=1756440993;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJq+m/9OQU7aTALsq12cLsaVurRSJhJooV7vRIntjzM=;
        b=fX6lozqHHHLkXZ7KqP4mNVLrO83/b8d43yrb3IubmRb70odOnIaUe+FdvdI7lzgeLi
         X8/2zJMGko9L7p0po5d128rNjkRGjS55IZjONdYWZtKXC/jKshRJ+W4Qub9I72Kh49bV
         Pds7vlCTRqdvgt9whwkMqbCf2u1kgfEkD16G51dOJfx+5tm7yFqK7LtwutVcXHJpZuJk
         lNA7a9WDY2hJy8+DQI3hMFk9VJZyaxRER/dIx+VAmSFf7ttfsl5hs6YqqEwV3KLCc9cg
         2hBFekZkzZtVAsX2WVrVfzttKEfRaWoVn5mkRFRD7qQsjZvrj/y46mMt1Mywr3SOZzXT
         wcYA==
X-Forwarded-Encrypted: i=1; AJvYcCV88fz7yR/JCCju4oAcuBJ4UU1yu0rOKRsnhDWhLs7FGPDmq6x81FOduv1nAmEdYpfvbN0IXUs+z3B1Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySBcUgK7q/o4WqRZthyiCr3gBuXtJkoqT9W7fYq9uFc9UH2kTa
	rDm0O8SSuuLT4wBWpv3SR9JMEdUwO1RtNGIeHt+wRdozlN5FPTfAz+lsLHbSacetX1hb39Husag
	P3UeOxPL6m5l8RI+UHQUXi3sqMdtrDJ/Sjk+17tUHr8WJztf1FOZjmxyCSmE=
X-Google-Smtp-Source: AGHT+IF/4MA78lHyKLFSoL6e7cd1q0IREUYQnZsnWJ5ac/BF+8MxFCiqpUrv0RTj/mghcef9c6QffwVc/Ujm6xulaBLj7P7KH6rj
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:3e2:c6e1:7713 with SMTP id
 e9e14a558f8ab-3e921c4db80mr31469945ab.18.1755836193082; Thu, 21 Aug 2025
 21:16:33 -0700 (PDT)
Date: Thu, 21 Aug 2025 21:16:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a7ef21.050a0220.37038e.004e.GAE@google.com>
Subject: [syzbot] [block?] [ntfs3?] general protection fault in blk_mq_issue_direct
From: syzbot <syzbot+127bd32548258909963d@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    be48bcf004f9 Merge tag 'for-6.17-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15995ba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9f694461848a008
dashboard link: https://syzkaller.appspot.com/bug?extid=127bd32548258909963d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1439c6f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c7f60d7b6589/disk-be48bcf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fe093258314/vmlinux-be48bcf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/493b5928449f/bzImage-be48bcf0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dd51753d0efa/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+127bd32548258909963d@syzkaller.appspotmail.com

overlayfs: upper fs does not support tmpfile.
overlayfs: upper fs does not support RENAME_WHITEOUT.
Oops: general protection fault, probably for non-canonical address 0xdffffc0020000008: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000100000040-0x0000000100000047]
CPU: 0 UID: 0 PID: 6460 Comm: syz.3.167 Tainted: G        W           6.17.0-rc2-syzkaller-00028-gbe48bcf004f9 #0 PREEMPT_{RT,(full)} 
CPU: 0 UID: 0 PID: 6460 Comm: syz.3.167 Tainted: G        W           6.17.0-rc2-syzkaller-00028-gbe48bcf004f9 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:rq_list_pop include/linux/blk-mq.h:267 [inline]
RIP: 0010:blk_mq_issue_direct+0x7b/0x660 block/blk-mq.c:2792
Code: c1 e8 03 48 89 44 24 30 c7 44 24 04 00 00 00 00 4c 89 64 24 20 4c 89 6c 24 18 49 8d 5e 48 48 89 d8 48 c1 e8 03 48 89 44 24 28 <42> 80 3c 38 00 74 08 48 89 df e8 a6 58 82 fd 48 89 5c 24 10 48 8b
RSP: 0018:ffffc9000559e1d8 EFLAGS: 00010203
RAX: 0000000020000008 RBX: 0000000100000047 RCX: ffff88802fa88000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888024920000 R08: ffff88802fa88000 R09: 0000000000000003
R10: 0000000000000100 R11: 000000000000000d R12: ffffc9000559e500
R13: 1ffff92000ab3ca0 R14: 00000000ffffffff R15: dffffc0000000000
FS:  00007fd977a9e6c0(0000) GS:ffff8881268c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9e1ca45000 CR3: 000000003189a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 blk_mq_dispatch_queue_requests+0x6fe/0x800 block/blk-mq.c:2878
 blk_mq_flush_plug_list+0x432/0x550 block/blk-mq.c:2961
 __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1220
 blk_finish_plug block/blk-core.c:1247 [inline]
 __submit_bio+0x2d3/0x5a0 block/blk-core.c:649
 __submit_bio_noacct_mq block/blk-core.c:722 [inline]
 submit_bio_noacct_nocheck+0x4f2/0xbb0 block/blk-core.c:751
 submit_bh fs/buffer.c:2829 [inline]
 __sync_dirty_buffer+0x22e/0x370 fs/buffer.c:2867
 ntfs_write_bh+0x58b/0x740 fs/ntfs3/fsntfs.c:1461
 mi_write+0x84/0x1b0 fs/ntfs3/record.c:402
 indx_update_dup+0x584/0x730 fs/ntfs3/index.c:2705
 ni_update_parent+0x9e7/0xdd0 fs/ntfs3/frecord.c:3182
 ni_write_inode+0x944/0xfb0 fs/ntfs3/frecord.c:3277
 write_inode fs/fs-writeback.c:1525 [inline]
 __writeback_single_inode+0x6f4/0x1000 fs/fs-writeback.c:1745
 writeback_single_inode+0x1d5/0x640 fs/fs-writeback.c:1801
 sync_inode_metadata+0xb9/0x110 fs/fs-writeback.c:2883
 __generic_file_fsync+0x142/0x1b0 fs/libfs.c:1550
 generic_file_fsync+0x6f/0xf0 fs/libfs.c:1580
 ovl_sync_file+0x3a/0x50 fs/overlayfs/copy_up.c:254
 ovl_copy_up_metadata+0x831/0xb60 fs/overlayfs/copy_up.c:725
 ovl_copy_up_workdir fs/overlayfs/copy_up.c:821 [inline]
 ovl_do_copy_up fs/overlayfs/copy_up.c:1001 [inline]
 ovl_copy_up_one fs/overlayfs/copy_up.c:1202 [inline]
 ovl_copy_up_flags+0x160c/0x2fe0 fs/overlayfs/copy_up.c:1257
 ovl_open+0x13e/0x2f0 fs/overlayfs/file.c:211
 do_dentry_open+0x9ae/0x1350 fs/open.c:965
 vfs_open+0x3b/0x350 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ef1/0x3840 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd97842ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd977a9e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fd978655fa0 RCX: 00007fd97842ebe9
RDX: 00000000000c4042 RSI: 0000200000000300 RDI: ffffffffffffff9c
RBP: 00007fd9784b1e19 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001ff R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd978656038 R14: 00007fd978655fa0 R15: 00007ffe14b13fa8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rq_list_pop include/linux/blk-mq.h:267 [inline]
RIP: 0010:blk_mq_issue_direct+0x7b/0x660 block/blk-mq.c:2792
Code: c1 e8 03 48 89 44 24 30 c7 44 24 04 00 00 00 00 4c 89 64 24 20 4c 89 6c 24 18 49 8d 5e 48 48 89 d8 48 c1 e8 03 48 89 44 24 28 <42> 80 3c 38 00 74 08 48 89 df e8 a6 58 82 fd 48 89 5c 24 10 48 8b
RSP: 0018:ffffc9000559e1d8 EFLAGS: 00010203
RAX: 0000000020000008 RBX: 0000000100000047 RCX: ffff88802fa88000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888024920000 R08: ffff88802fa88000 R09: 0000000000000003
R10: 0000000000000100 R11: 000000000000000d R12: ffffc9000559e500
R13: 1ffff92000ab3ca0 R14: 00000000ffffffff R15: dffffc0000000000
FS:  00007fd977a9e6c0(0000) GS:ffff8881269c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9e1ca47000 CR3: 000000003189a000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	c1 e8 03             	shr    $0x3,%eax
   3:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
   8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
   f:	00
  10:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
  15:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
  1a:	49 8d 5e 48          	lea    0x48(%r14),%rbx
  1e:	48 89 d8             	mov    %rbx,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 a6 58 82 fd       	call   0xfd8258df
  39:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
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
