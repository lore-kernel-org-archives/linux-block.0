Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C91586C8
	for <linux-block@vger.kernel.org>; Fri, 31 May 2024 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163370; cv=none; b=NHKBDBYXFqDpoFAbokxtnh6kThIzpWnHEZ53vhNBmj6LUg2Z34JfE35mlgCb1ok9k70KQICKhYydysBG5cztN2nH1zmE+MEdFFqtduHNsQ1eTPTF6wOJENZsQWfETZFKKSPiLCc5gNM3NGOc/ovxcHd9LUof76pgnnozkasEjMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163370; c=relaxed/simple;
	bh=UZSV4Q93sZCFr3iDOHYk6nerLnAPVzKN6Pp+05lA/WY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IY7/IKyFQFo1orjKyAJiobHXU130SvmeNTOCE9oVoJ5gkThAY7/1ggndENYj4rayrI58OzvMuzqIYTG7mR+mr9yKkMqOX900m0+WCmjvkF2z26JbPqVFE0kQXg/XkriaDBUrwL0lZGZsflRcH9u7oCdqo4XAUObBn/NLqqR9bow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-374820a077cso12206745ab.1
        for <linux-block@vger.kernel.org>; Fri, 31 May 2024 06:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717163368; x=1717768168;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RI5YL3tOD/Rmu/yEiqghDR3Te1rvZPl499ZxyvXchlo=;
        b=Ks/BPjfljdZcB+lF9EnJfphRMXPwwxltlPDXicEKSQUDEiirQ+4Zo7c0ZV8903Ptaw
         TzcSHppR8c6ZSPcxTNsr5OTVj+vTtNzrAVGAkQtBlMHl85DpQxamRAqv8pNEliCUVb6F
         pLqPydpeWhRob5cptxpQszkbueTS1Zp+/WosF3l53HQHEkeNIfndV27xet1EQNY0HmO2
         mQBf8jvpGQ/PC5xWBJGXx7gradmVNxNlwVChDzUGKpLAxRtOWrmp1BplZXz22vP0kB+3
         NFy0KWzGDO31K3avOcGJGA3HXqZbHP+yffkcYDnKtfE+JIXktFVUc6ClMnZnxEZ5k4Y9
         mQSg==
X-Forwarded-Encrypted: i=1; AJvYcCWOnk/k7LG2uJB90I3SLgJxtinS3YYlia41j5bU201YNrs1wCfuNmtk7as6/wLLEQHzXsKyOrvNGduna6rWJz05I7Kshn1WcM27w9I=
X-Gm-Message-State: AOJu0YwKJI//xCSHiK8JrxKJdkqYldTzQNjg6P8bgC0hgx+tbbajmZP8
	3Wgz5e/UP3orNSIQpVN6HPc8We7O7SmdiwVgijNwLjp+fi1RuDVySqq9dzt/pKkZPuQ9tgZ9N4l
	zgCXoPunXE03vcsGqycD0bRqxwo8cXpmBE6p4siDNdBwfe2ifKOmAPs8=
X-Google-Smtp-Source: AGHT+IHj1HqxN8+cYdq+EB2qHeahM6+WdhWMXtSf+i3w0rGvDTcODcBMclSscj69NfT7dGMACi4dMA8IQ7uUeLRDzrOBwNJ+CFcu
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cf:b0:36c:4b17:e05d with SMTP id
 e9e14a558f8ab-3748b9ea14emr935895ab.4.1717163368686; Fri, 31 May 2024
 06:49:28 -0700 (PDT)
Date: Fri, 31 May 2024 06:49:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009cb7480619c04045@google.com>
Subject: [syzbot] [block?] WARNING: locking bug in mempool_alloc_noprof
From: syzbot <syzbot+c8ae2cacba71e6145314@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12765f72980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
dashboard link: https://syzkaller.appspot.com/bug?extid=c8ae2cacba71e6145314
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9bbdc63efe9/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed08b308e5d6/bzImage-4a4be1ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c8ae2cacba71e6145314@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "c->lock" with key __key.0, but found a different class "&c->lock" with the same key
WARNING: CPU: 1 PID: 6462 at kernel/locking/lockdep.c:932 look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Modules linked in:
CPU: 1 PID: 6462 Comm: syz-executor.2 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Code: c7 c7 a0 b7 2c 8b e8 ec a3 74 f6 90 0f 0b 90 90 90 31 db eb be c6 05 74 d6 ef 04 01 90 48 c7 c7 c0 ba 2c 8b e8 ce a3 74 f6 90 <0f> 0b 90 90 e9 62 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90002f6edc8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff941f9940 RCX: ffffc9000cb53000
RDX: 0000000000040000 RSI: ffffffff81510236 RDI: 0000000000000001
RBP: ffffffff94aedd50 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000006b6f6f4c R12: ffffe8ffad169870
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff94ad5be0
FS:  0000000000000000(0000) GS:ffff88802c100000(0063) knlGS:00000000f5effb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020002000 CR3: 000000005f492000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0xb1/0x1230 kernel/locking/lockdep.c:1284
 __lock_acquire+0x111/0x3b30 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 ___slab_alloc+0x7bb/0x1870 mm/slub.c:3715
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmem_cache_alloc_noprof+0x2ae/0x2f0 mm/slub.c:4007
 mempool_alloc_noprof+0x176/0x390 mm/mempool.c:402
 bio_alloc_bioset+0x480/0x8b0 block/bio.c:554
 bch2_writepage_io_alloc fs/bcachefs/fs-io-buffered.c:476 [inline]
 __bch2_writepage+0x107e/0x2500 fs/bcachefs/fs-io-buffered.c:610
 write_cache_pages+0xb0/0x130 mm/page-writeback.c:2591
 bch2_writepages+0x11f/0x200 fs/bcachefs/fs-io-buffered.c:650
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2634
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 file_write_and_wait_range+0xd0/0x140 mm/filemap.c:788
 bch2_fsync+0xa1/0x2c0 fs/bcachefs/fs-io.c:197
 vfs_fsync_range+0x141/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2794 [inline]
 bch2_buffered_write fs/bcachefs/fs-io-buffered.c:1128 [inline]
 bch2_write_iter+0x756/0x3180 fs/bcachefs/fs-io-buffered.c:1136
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1140 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf730d579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5eff5ac EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000020000180
RDX: 0000000000002000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
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
