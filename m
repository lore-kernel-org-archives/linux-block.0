Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69BC8FB
	for <linux-block@vger.kernel.org>; Sun,  2 Jun 2024 04:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717302204; cv=none; b=JF3Js4hz3V1uUzWES2pM71gXDL+cC5hnM/auw8FS7zI3NiD6uTqRSMJUoO5MLSljP8ZjDkWq1TU7apGC7Rv8wJ+wzaXHJujFaRAtb+Y3HBjRu5PkumvpNOPFJ8fihbewijZc95ni88nm0eU1y8jEVPj8RVWY6Pi+6cWcnSkoFDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717302204; c=relaxed/simple;
	bh=kvRtTa8G53aWf6UIJRUU0CiTqcgw0GVRDp2YilQ3WLU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hFQ4XgxwPA9FmtJj/7Gi6PGrSoBWgEcpTcri7I/F5ZUNSfEWn9JlP9H9QfNr2AcPjBNvbOFPYt2mkTfJRALkFFvlJSw+df9KrWF/+AwBlv7oycEBq02azW5JlwT+eml7zjTNDWRbvr3ZByMz5N5aoddhO3+S5vgShZnFtFo61XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e91ad684e4so445452039f.2
        for <linux-block@vger.kernel.org>; Sat, 01 Jun 2024 21:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717302202; x=1717907002;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oD+YLbtgQEleh1P+vIl7eQt0IQLu6eC6x4hua9MlLCg=;
        b=XBD3wsHwIfV1nc8eeN6EtsdaSqWvQKXi2fY3A+cd8b3Q9Q3CTa/ECu+92oxNEeO0vl
         0lRfKjawuKktDMeWM4xIR+ysU74ImSD8zVqvMjqoSmp6PkP3JLq3/L+DXQTGSA6P5GPv
         bCw0kY9ryTa29D8IpgzcjveNYbqh7oEP7jtdbc1mwvHLQdn4kI5odJ5l6vcs1ozDM3zj
         NQp8OAN7nE/EPTthW+cuhJtxgJf2LrIXpP4RpgWjklr60Wv7RG7o0dylZTkfQdICOMGJ
         TwWMS6GeMpcV0+Xn/4ryKfk7aaxv/+8hPcwNU6LdSqjMRaDTfWewPoNbDpaxhHvwFNoV
         zhSA==
X-Forwarded-Encrypted: i=1; AJvYcCV6hdPm6POqdLEciu5MfiJgQKHNXSsCPs2zIR6kcDW9sYJdnhPb9+JB/6ZoEnMY2U2ValpWsaJYw2vG3ad7iflmyFg95HkRZ3AUQN0=
X-Gm-Message-State: AOJu0YyB4fEnAYAYLX4J8ZL9NMSO3WSClF2LuMvaX9KnzcO+1PMwY+hG
	MWsBdc7nrgDA5ap/v63cPlX78b586FDKG1kt/VbxzZ+3g3JEwr3BHN1wxZSqNZR8lZSrcWHziT9
	WfUJzrvHop/WvhlabIP+bOxWKVVqvNrvVpYQSrfj9YlQBWJ/fctnsqcY=
X-Google-Smtp-Source: AGHT+IGDLJfJdJYbMKOuFRSK+4kmDDxlpHwswnzyb1YbzHY14Bj1QDcmXHeyIMVVxxpk+99QulCdxxfBtOg/bYe5+/IpBxm6dLRl
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13af:b0:374:9bc4:cdf0 with SMTP id
 e9e14a558f8ab-3749bc4d147mr218455ab.3.1717302202229; Sat, 01 Jun 2024
 21:23:22 -0700 (PDT)
Date: Sat, 01 Jun 2024 21:23:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc759e0619e093dc@google.com>
Subject: [syzbot] [block?] WARNING in mempool_init_node
From: syzbot <syzbot+9c496b2b58571de670a3@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e0cce98fe279 Merge tag 'tpmdd-next-6.10-rc2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176e80ec980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
dashboard link: https://syzkaller.appspot.com/bug?extid=9c496b2b58571de670a3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e0cce98f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb24795b031d/vmlinux-e0cce98f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bcfa9241b1bb/bzImage-e0cce98f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c496b2b58571de670a3@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(l->owner)
WARNING: CPU: 3 PID: 6747 at include/linux/local_lock_internal.h:30 local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
WARNING: CPU: 3 PID: 6747 at include/linux/local_lock_internal.h:30 ___slab_alloc+0x16c2/0x1870 mm/slub.c:3715
Modules linked in:
CPU: 3 PID: 6747 Comm: syz-executor.1 Not tainted 6.10.0-rc1-syzkaller-00021-ge0cce98fe279 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
RIP: 0010:___slab_alloc+0x16c2/0x1870 mm/slub.c:3715
Code: 9a 02 85 c0 74 09 83 3d 2f 45 01 0e 00 74 21 90 e9 30 ff ff ff 90 48 c7 c6 7f 8c 37 8d 48 c7 c7 c8 57 37 8d e8 cf 58 6f ff 90 <0f> 0b 90 90 eb c6 90 48 c7 c6 88 8c 37 8d 48 c7 c7 c8 57 37 8d e8
RSP: 0018:ffffc9000715f200 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000246 RCX: ffffc90002f82000
RDX: 0000000000040000 RSI: ffffffff81510236 RDI: 0000000000000001
RBP: ffffc9000715f2e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: ffff88801dd74880
R13: ffff888026ef1400 R14: ffffe8ffad369220 R15: ffffe8ffad369200
FS:  0000000000000000(0000) GS:ffff88802c300000(0063) knlGS:00000000f5ea4b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000ee082000 CR3: 000000004abc2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmem_cache_alloc_noprof+0x2ae/0x2f0 mm/slub.c:4007
 mempool_init_node+0x31e/0x760 mm/mempool.c:217
 mempool_init_noprof+0x3a/0x50 mm/mempool.c:246
 bioset_init+0x324/0x7a0 block/bio.c:1785
 bch2_fs_io_read_init+0x29/0xc0 fs/bcachefs/io_read.c:1216
 bch2_fs_alloc+0x19b0/0x2550 fs/bcachefs/super.c:918
 bch2_fs_open+0x713/0x10f0 fs/bcachefs/super.c:2102
 bch2_mount+0xd41/0x1090 fs/bcachefs/fs.c:1917
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x6e1/0x1f10 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72b2579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5ea4400 EFLAGS: 00000292 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f5ea4460 RCX: 0000000020011a40
RDX: 0000000020011a00 RSI: 0000000001200014 RDI: 00000000f5ea44a0
RBP: 00000000f5ea4460 R08: 0000000000000000 R09: 0000000000000000
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
