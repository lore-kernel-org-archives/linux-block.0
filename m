Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118B19EEC2
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170588; cv=none; b=Jaz2awci1Zy40db/sMmFZsxXOzihiRGvpco3lNixtl1AUz5AxuHSSgFSqS/2vr8nR/pvInW/MrCs1sDC2evOJMw+A29FuRItnWTjzD9MWpGnER7Wt8DVOBw6E5kxKjAlgumkwKjSbGPc8lyBoeA9shmEU/5dnAKWAoEkwXctc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170588; c=relaxed/simple;
	bh=7vMLxDoVdyud5TuRomZ/MpXE6tYPJ4LRQcLdhusWGv4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MqjmoiH+eV/V+fEoW+5qBjELuuboaAQDIxKVHgRP5STOauZlQv1F6EOmejtL0KlT9iVITP1SlMtvshhxkukeeDFgsXaEpv1rA3vl7k7aglifRZGIOwh9VcvgKVk4rINA8kzhOO7fdQ3NSKSDwby1gCA3adVtFpgdlPCCBkH6tkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-93e7f4f7bb1so216413639f.3
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 17:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763170586; x=1763775386;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXADMyKgol+4ZYHF6+0Ht+l795eH6xblTXW+I0Xrg64=;
        b=bCDBrHJ8udLJdsWqn9RFNgBFSoPBkenSbRZVaVv7F1sjfBic7OLMwBgPfKUxNZBK1K
         G6cjGkWVDZ6fZxYvO5OtbZ7pFzJcEXF1h6vTqa6SfynhDeJ5W9rKpU1A35W0/M8lWV37
         aFiy1anhQ/GL0rRZDJ5wYgcEV91BZUJ0QORXrBGEVLFfli+rD/R4edNBBbC/zhhYNk8u
         gDClSLUZJv73FMCPWvPkde6qDdi+Vwy4Czh7jDbKOelRM/4MLmjFvXJuXrAs+7Dif0/L
         ycxxHtSEGhRR/ZKY5RCB891Vv1fc9d916QHp5CNofBKlIAtpt2sXa41/bRbggAYEhLhm
         hn5w==
X-Forwarded-Encrypted: i=1; AJvYcCU2oN85s513l/WF7hIv2gu1YP41ikJpoBkPMDw6eOYi81EwDibEX0HHEj4rVBg9xPcLaUD6ctP/IUJeIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YymvdYBEq2xbsVOfJ9Jxm4UMlO5tQfAre0ing1ntK4RQaBK+1Iz
	Vp8v5yHhh+QgycZvAn3Ug8tBFaoUGB7n/jZ8QlxGR/tmrQC8bW6aEb7IOcQOXjdfkpdFrEzqaD8
	f7pu9Rj3v1A+maWsnU2K5CJOJU2nbTLMUN+TT7bWWOvFjp0oXzjzQhg4doTo=
X-Google-Smtp-Source: AGHT+IFq5PAPXYr80k2eK5i6QUqOMpm3sepjekWPe0XQ0YtHzYHeSWi0yvjjMGLr3T45/aNqO8YwJxOEFESHB4RbAhDN6K96fOPR
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:982a:b0:5b7:bc45:7128 with SMTP id
 8926c6da1cb9f-5b7c9e0350emr1027826173.17.1763170585831; Fri, 14 Nov 2025
 17:36:25 -0800 (PST)
Date: Fri, 14 Nov 2025 17:36:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6917d919.050a0220.3565dc.004b.GAE@google.com>
Subject: [syzbot] [block?] general protection fault in zcomp_stream_get
From: syzbot <syzbot+16a8410141ca18c0d963@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	minchan@kernel.org, senozhatsky@chromium.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7a0892d2836e Merge tag 'pci-v6.18-fixes-5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12152914580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=16a8410141ca18c0d963
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a45e159158b8/disk-7a0892d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/846d1b2a57ec/vmlinux-7a0892d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8b608296ff12/bzImage-7a0892d2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16a8410141ca18c0d963@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 14292 Comm: syz.1.2163 Tainted: G     U  W    L XTNJ syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER, [W]=WARN, [L]=SOFTLOCKUP, [X]=AUX, [T]=RANDSTRUCT, [N]=TEST, [J]=FWCTL
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:zcomp_stream_get+0x33/0xa0 drivers/block/zram/zcomp.c:113
Code: 00 00 00 00 fc ff df 41 54 55 48 89 fd 53 49 89 ec 49 c1 ec 03 4d 01 ec e8 5a b8 d5 fb e8 55 b8 d5 fb 65 48 8b 1d 15 90 ba 0d <41> 80 3c 24 00 75 4f 48 03 5d 00 31 f6 48 89 df e8 e8 92 78 05 48
RSP: 0018:ffffc90003baf488 EFLAGS: 00010283
RAX: 0000000000000516 RBX: ffff888124b0d000 RCX: ffffc9000ae99000
RDX: 0000000000080000 RSI: ffffffff85e6a00b RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000006 R09: 7277682f7665642f
R10: eb9cce1e473f4118 R11: 0000000000000001 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff888142f2fc00 R15: ffffea0002067280
FS:  00007f1de6ff66c0(0000) GS:ffff888124b0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b311f7ff8 CR3: 000000004f02c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 zram_write_page drivers/block/zram/zram_drv.c:1859 [inline]
 zram_bvec_write drivers/block/zram/zram_drv.c:1932 [inline]
 zram_bio_write drivers/block/zram/zram_drv.c:2373 [inline]
 zram_submit_bio+0xdd4/0x1df0 drivers/block/zram/zram_drv.c:2402
 __submit_bio+0x304/0x690 block/blk-core.c:646
 __submit_bio_noacct block/blk-core.c:692 [inline]
 submit_bio_noacct_nocheck+0x75c/0xc10 block/blk-core.c:757
 submit_bio_noacct+0x5bd/0x1f60 block/blk-core.c:879
 submit_bio_wait+0x110/0x250 block/bio.c:1388
 __blkdev_direct_IO_simple+0x488/0x860 block/fops.c:99
 blkdev_direct_IO+0xcc6/0x2100 block/fops.c:435
 blkdev_direct_write block/fops.c:726 [inline]
 blkdev_write_iter+0x703/0xe00 block/fops.c:794
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1de8d8f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1de6ff6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f1de8fe5fa0 RCX: 00007f1de8d8f6c9
RDX: 000000100000a3d9 RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007f1de8e11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1de8fe6038 R14: 00007f1de8fe5fa0 R15: 00007ffd527f5948
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:zcomp_stream_get+0x33/0xa0 drivers/block/zram/zcomp.c:113
Code: 00 00 00 00 fc ff df 41 54 55 48 89 fd 53 49 89 ec 49 c1 ec 03 4d 01 ec e8 5a b8 d5 fb e8 55 b8 d5 fb 65 48 8b 1d 15 90 ba 0d <41> 80 3c 24 00 75 4f 48 03 5d 00 31 f6 48 89 df e8 e8 92 78 05 48
RSP: 0018:ffffc90003baf488 EFLAGS: 00010283
RAX: 0000000000000516 RBX: ffff888124b0d000 RCX: ffffc9000ae99000
RDX: 0000000000080000 RSI: ffffffff85e6a00b RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000006 R09: 7277682f7665642f
R10: eb9cce1e473f4118 R11: 0000000000000001 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff888142f2fc00 R15: ffffea0002067280
FS:  00007f1de6ff66c0(0000) GS:ffff888124b0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a02d54d950 CR3: 000000004f02c000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 6 bytes skipped:
   0:	df 41 54             	filds  0x54(%rcx)
   3:	55                   	push   %rbp
   4:	48 89 fd             	mov    %rdi,%rbp
   7:	53                   	push   %rbx
   8:	49 89 ec             	mov    %rbp,%r12
   b:	49 c1 ec 03          	shr    $0x3,%r12
   f:	4d 01 ec             	add    %r13,%r12
  12:	e8 5a b8 d5 fb       	call   0xfbd5b871
  17:	e8 55 b8 d5 fb       	call   0xfbd5b871
  1c:	65 48 8b 1d 15 90 ba 	mov    %gs:0xdba9015(%rip),%rbx        # 0xdba9039
  23:	0d
* 24:	41 80 3c 24 00       	cmpb   $0x0,(%r12) <-- trapping instruction
  29:	75 4f                	jne    0x7a
  2b:	48 03 5d 00          	add    0x0(%rbp),%rbx
  2f:	31 f6                	xor    %esi,%esi
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 e8 92 78 05       	call   0x5789321
  39:	48                   	rex.W


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
