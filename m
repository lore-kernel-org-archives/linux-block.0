Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4579CF
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118807; cv=none; b=rXDYsv0g0wkSy5p+TQRmfuTSIYI1I/ovdbupu2Iz1rHp0EOxQPCyFOA8MWoGHtex0em8vg1GnkcV7h1QCru17zUtIxFeXupZhb+1O7hiX35YnCydwB137wtq4vUm14x9TvY6ZpZZUiKIIPVCFQ2cA5vP8gKBvoD9XKTwblUPnMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118807; c=relaxed/simple;
	bh=6PQruBQUs4L6XERNA5uo6tMnbMJaVAi3kCWYZOgC+HU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NYSuIYhlRJPbwvutZWxN6EDIARyEOj/CPm/3z0ko6uff+3GytAtZN0/nVEphhri8/o3x44ZIqP/EDJW204GozMrd1RV5XwXtYaEDLaq3oqprVUTfJJSnHMg2H23yMpN5krNDPBC+T5butKYiEInsFz+/D056E6u8SLWzEFr1NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d9fde69c43so394120139f.1
        for <linux-block@vger.kernel.org>; Tue, 07 May 2024 14:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715118805; x=1715723605;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKrO+Yygx10DAdCAw+kzbS8LqYHN7hhctGK7Te+fD08=;
        b=iHD4pCGlptp/pZkrXlhwYsU4JZk4oqsHUvw8o9UUR33JOSUjsRbimwTmb3/o+ZK6rF
         MpgP4Oxg1JnOKNOgtnqfsV/qQq7+rpWTZ4QDtpmWTJWiRrKn4YPPDGnh5JvuNwiOhcpw
         MVEsnCBe359afm49nPtXXc/Du5nOG1DOlTM76rsgDE9PO6XkgmAEziIXldusjyYZfrDg
         D+hm6NylwMPJieTXesXHqLn284vU2JmU+e82gpTOPmwhSANl2moAaChQZsaoFNW0GKUx
         9lGWimOT+ABv2Z20UPToE4C46LDmdI513spN9b+VmXH5XCy1027fJT59er51kleUTBuV
         vi7g==
X-Forwarded-Encrypted: i=1; AJvYcCWqPsQVzS1s7y51XRZLyDwELV8zNHm8ePd0YS58flsWalt/HRkKMGZcfRukXGrhVdzqonH9HsHkNyrwVCEhZgBL0ZJCoj0LVHOvGCk=
X-Gm-Message-State: AOJu0YzNmD7GYBEXlYzZfuAWjBJgWmjls6YqRVJekOAdvHSMZFbPtzJD
	OEcW35mylPT5omqtdpJwUYmBXPfMSkvkW3U+yX6IFcPhiwn8/X/+tBKwABc5tTiI1cZEYyU3iph
	4cW67aMmohblVWvYnAOwVdWQo2VGugoWt9C5y3w8BqGHTN0eCX+4Um4I=
X-Google-Smtp-Source: AGHT+IEULMXAyDEeN3qRsGmugC2JBVVwSztZqZzUncKCJwWIwLE89V/ds+NLip+RxrcopGTnSIIJLsPYt+dQ16lg0jToU6W7M1qs
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1648:b0:488:59cc:eb44 with SMTP id
 8926c6da1cb9f-488fdd5404dmr53513173.3.1715118805225; Tue, 07 May 2024
 14:53:25 -0700 (PDT)
Date: Tue, 07 May 2024 14:53:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002223bc0617e437cc@google.com>
Subject: [syzbot] [block?] WARNING: locking bug in mempool_init_node
From: syzbot <syzbot+d24a87174027a66198b8@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d25a941ea50 Merge tag 'block-6.9-20240503' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16314b1f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45d8db3acdc1ccc6
dashboard link: https://syzkaller.appspot.com/bug?extid=d24a87174027a66198b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3d25a941.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49d9f26b0beb/vmlinux-3d25a941.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2c424c14fff/bzImage-3d25a941.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d24a87174027a66198b8@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "c->lock" with key __key.0, but found a different class "&c->lock" with the same key
WARNING: CPU: 2 PID: 24525 at kernel/locking/lockdep.c:932 look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Modules linked in:
CPU: 2 PID: 24525 Comm: syz-executor.0 Not tainted 6.9.0-rc6-syzkaller-00227-g3d25a941ea50 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Code: c7 c7 40 b7 0c 8b e8 5c 55 7e f6 90 0f 0b 90 90 90 31 db eb be c6 05 5a 61 b4 04 01 90 48 c7 c7 60 ba 0c 8b e8 3e 55 7e f6 90 <0f> 0b 90 90 e9 62 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90002b36eb8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff93d6d800 RCX: ffffc90034a01000
RDX: 0000000000040000 RSI: ffffffff81513a06 RDI: 0000000000000001
RBP: ffffffff94661890 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000006b6f6f4c R12: ffffe8ffad4d9550
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff94649aa0
FS:  0000000000000000(0000) GS:ffff88802c400000(0063) knlGS:00000000f5ebab40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7452054 CR3: 000000004c5e6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0xb1/0x1230 kernel/locking/lockdep.c:1284
 __lock_acquire+0x111/0x3b30 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 ___slab_alloc+0x789/0x16d0 mm/slub.c:3569
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x2e9/0x320 mm/slub.c:3852
 mempool_init_node+0x31e/0x760 mm/mempool.c:217
 mempool_init+0x3a/0x50 mm/mempool.c:246
 mempool_init_slab_pool include/linux/mempool.h:68 [inline]
 bioset_init+0x324/0x7a0 block/bio.c:1752
 bch2_fs_fs_io_direct_init+0x58/0x90 fs/bcachefs/fs-io-direct.c:679
 bch2_fs_alloc+0x1bdf/0x25c0 fs/bcachefs/super.c:938
 bch2_fs_open+0x713/0x10f0 fs/bcachefs/super.c:2081
 bch2_mount+0xd41/0x1090 fs/bcachefs/fs.c:1903
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1779
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x6e1/0x1f10 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72c8579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5eba400 EFLAGS: 00000292 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f5eba460 RCX: 0000000020011a40
RDX: 0000000020011a00 RSI: 0000000001200014 RDI: 00000000f5eba4a0
RBP: 00000000f5eba460 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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
