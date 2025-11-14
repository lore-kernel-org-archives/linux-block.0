Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57F26ED3F
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763097872; cv=none; b=cvMGPJ/KiRwj5mvBrt2+kb5UZt7NHTs60XbmnU1BX9ftLJXW1IpW5gEdbhfTFiDGfhpCGwv2XToGlfzSKcmCFtODwU9JTQVv7vxzqalyDoxwlAzPc7w2/esvAYTfxn117h/O97bW8bN1YQFgZSi9ZGm1yMz4aN/0fjDjwBq8ObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763097872; c=relaxed/simple;
	bh=uGXcCA2+5K6gAfi73l7GjM58oDyfSWMy+1kmcs0sDEw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lx2AhkF3VmvC1ttIvcMEFt3+ybkbvIVP/rVNKgp9N5vJnZHbFSYy9jKDvDSxAfUYaePjfUKQ5oYlyfip10zlsGj8zqJJyWR8pt5lk4pGKdwOmQY1X/X/WCFeVwMfslXzIbjy9HdiJrETLWsWbkCQtypEMs9N9fRsIG0HHE5/Ydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-9489bfaef15so158774139f.1
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 21:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763097870; x=1763702670;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxy20Su5wQPdheGYbgJbTm5YpH+uh46rSfoKyaLaYz4=;
        b=m2W0kW76Q+tjLx3OWRZde6feDqOUYRPHfwGB5ehDOhbZnliQN+ulvG/sHTsPH77962
         1zW2ropMPLlSYg81fQUVFCdHbJqEC+dMvQi3QghFE2B6KdChWbsNmzM1blFw8thOrhtg
         yphSVTid0AawSNY3+YUXpxdCwMEmqQYU101zS6ETeYMIp2ynoAgq1xnsu0nQ7i1YH7V2
         J3iKGyePzNhcARZ7txiDdOoKR5BYJQxrlGkyLtr1Na+hShcxF3qBy3kldChUES09JOhY
         kybVtSMXU7TtSvNvjCh/aZ/N8mh4sl3fbE+n2PW2wjofXKoUD/R/YSQ6d2QTwn+N2Mm9
         mENA==
X-Forwarded-Encrypted: i=1; AJvYcCW0B0mHwUV9hkBoAi8sc/FbONvtFPgFrbeyHWIQnDSXR9jSe1aCyyA6bjpO5d22j6phqeN9golYFKBDPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFRyecgwtphWsq783bKKfzekzIQ9j/6HmleisHuGBpFHPomH8
	GSv84sdVmKfBWXiveO/etdKHVv4gvx491UVoQpGFajFQXuxcDGdPCB/ErDS9U0HtVPeNMUuKHjD
	6DWVW5SeoHUJRhHaTrUUv1zpZYnTlqGqdYqAfCCQkYJ6FR6ZaFyvVp9On56g=
X-Google-Smtp-Source: AGHT+IH5V2rpFeoWBuoKCg4AtOsjU2L+qVO9/rAczCVE1fduQ7VrXGv7gycv5dhBcSh1sf0UKoVWSjGOAhdajdNtKZbmFLpW6YOO
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4a0c:b0:948:b49f:c859 with SMTP id
 ca18e2360f4ac-948e0cd3c73mr289335839f.4.1763097870359; Thu, 13 Nov 2025
 21:24:30 -0800 (PST)
Date: Thu, 13 Nov 2025 21:24:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6916bd0e.a70a0220.3124cb.0046.GAE@google.com>
Subject: [syzbot] [block?] general protection fault in bio_seg_gap
From: syzbot <syzbot+8df17e797225d69050d4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab40c92c74c6 Add linux-next specific files for 20251110
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e2317c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4c0e7075df4bf51
dashboard link: https://syzkaller.appspot.com/bug?extid=8df17e797225d69050d4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11527084580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e1b412580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63d584f3f4ab/disk-ab40c92c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4bb564de81d2/vmlinux-ab40c92c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/704d37065029/bzImage-ab40c92c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c9f9c8e46d00/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14ec87cd980000)

The issue was bisected to:

commit 2f6b2565d43cdb5087cac23d530cca84aa3d897e
Author: Keith Busch <kbusch@kernel.org>
Date:   Tue Oct 14 15:04:55 2025 +0000

    block: accumulate memory segment gaps per bio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1197b0b4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1397b0b4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1597b0b4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8df17e797225d69050d4@syzkaller.appspotmail.com
Fixes: 2f6b2565d43c ("block: accumulate memory segment gaps per bio")

=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
EXT4-fs: Ignoring removed i_version option
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 6018 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:bio_get_first_bvec block/blk-merge.c:22 [inline]
RIP: 0010:bio_get_last_bvec block/blk-merge.c:30 [inline]
RIP: 0010:bio_seg_gap+0x1c6/0x7d0 block/blk-merge.c:743
Code: fd 48 ba 00 00 00 00 00 fc ff df 49 8b 06 48 89 5c 24 20 49 89 de 49 c1 e6 04 48 89 44 24 08 4a 8d 2c 30 48 89 e8 48 c1 e8 03 <80> 3c 10 00 74 12 48 89 ef e8 0c 33 b9 fd 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003036a60 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880788e5b80
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880786a1030
RBP: 0000000000000000 R08: ffff888141f6d877 R09: 1ffff110283edb0e
R10: dffffc0000000000 R11: ffffed10283edb0f R12: 0000000000000400
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880786a1000
FS:  0000555589f40500(0000) GS:ffff888125ecd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe080ddae9c CR3: 00000000745c6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 bio_attempt_back_merge+0x4ba/0x920 block/blk-merge.c:940
 blk_attempt_plug_merge+0x145/0x1d0 block/blk-merge.c:1073
 blk_mq_attempt_bio_merge block/blk-mq.c:3022 [inline]
 blk_mq_submit_bio+0x1abd/0x26d0 block/blk-mq.c:3186
 __submit_bio+0x207/0x5a0 block/blk-core.c:637
 __submit_bio_noacct_mq block/blk-core.c:724 [inline]
 submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
 submit_bio_wait+0x104/0x200 block/bio.c:1389
 blkdev_issue_discard+0x113/0x1b0 block/blk-lib.c:95
 ext4_mb_clear_bb fs/ext4/mballoc.c:6620 [inline]
 ext4_free_blocks+0xce2/0x1bf0 fs/ext4/mballoc.c:6770
 ext4_clear_blocks+0x372/0x3f0 fs/ext4/indirect.c:888
 ext4_free_data fs/ext4/indirect.c:962 [inline]
 ext4_ind_truncate+0x701/0xb30 fs/ext4/indirect.c:1154
 ext4_truncate+0xb24/0x12e0 fs/ext4/inode.c:4620
 ext4_evict_inode+0x86e/0xe80 fs/ext4/inode.c:260
 evict+0x5f4/0xae0 fs/inode.c:837
 ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:470
 __ext4_fill_super fs/ext4/super.c:5618 [inline]
 ext4_fill_super+0x5920/0x61e0 fs/ext4/super.c:5737
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1697
 vfs_get_tree+0x92/0x2b0 fs/super.c:1757
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3641 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3717
 do_mount fs/namespace.c:4040 [inline]
 __do_sys_mount fs/namespace.c:4228 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4205
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f74a6990e6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd3db28e18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd3db28ea0 RCX: 00007f74a6990e6a
RDX: 0000200000000ac0 RSI: 0000200000000240 RDI: 00007ffd3db28e60
RBP: 0000200000000ac0 R08: 00007ffd3db28ea0 R09: 0000000003810744
R10: 0000000003810744 R11: 0000000000000246 R12: 0000200000000240
R13: 00007ffd3db28e60 R14: 0000000000000453 R15: 000000000000002c
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bio_get_first_bvec block/blk-merge.c:22 [inline]
RIP: 0010:bio_get_last_bvec block/blk-merge.c:30 [inline]
RIP: 0010:bio_seg_gap+0x1c6/0x7d0 block/blk-merge.c:743
Code: fd 48 ba 00 00 00 00 00 fc ff df 49 8b 06 48 89 5c 24 20 49 89 de 49 c1 e6 04 48 89 44 24 08 4a 8d 2c 30 48 89 e8 48 c1 e8 03 <80> 3c 10 00 74 12 48 89 ef e8 0c 33 b9 fd 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003036a60 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880788e5b80
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880786a1030
RBP: 0000000000000000 R08: ffff888141f6d877 R09: 1ffff110283edb0e
R10: dffffc0000000000 R11: ffffed10283edb0f R12: 0000000000000400
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880786a1000
FS:  0000555589f40500(0000) GS:ffff888125ecd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe080ddae9c CR3: 00000000745c6000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	fd                   	std
   1:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
   8:	fc ff df
   b:	49 8b 06             	mov    (%r14),%rax
   e:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
  13:	49 89 de             	mov    %rbx,%r14
  16:	49 c1 e6 04          	shl    $0x4,%r14
  1a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  1f:	4a 8d 2c 30          	lea    (%rax,%r14,1),%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	48 89 ef             	mov    %rbp,%rdi
  33:	e8 0c 33 b9 fd       	call   0xfdb93344
  38:	48                   	rex.W
  39:	ba 00 00 00 00       	mov    $0x0,%edx
  3e:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
