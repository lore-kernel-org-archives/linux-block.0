Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A22E6CCC
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765088670; cv=none; b=sMvSsokqzokDJWNeGTZN+G8aB3L+gfkr6UPPA6t/bfIxsojwAnQpYhznRscNSQtyO8/80gZ5sj+FlCnP+GKdPr2xcUWoNwStcmamrbpJY2N1KzACF+Usm24HUUfitX98vQ6FKzxmvZT6rGNk8UEYvBCuSITw9gEiDE5T5q2QtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765088670; c=relaxed/simple;
	bh=Ib1YNOddUfsH7v1DbL1aqXte24LAixYrL5dmG5ps/RY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DPh640KhIr1kaNnfYr+m14yV/uIjjbB75OD/REdjYx7dXfuLtiZgeBv6r2gJ9G3x97EZeFL58FRk3XZYXQgGc1ljoRnrw/VXNJpj2DvMGiyE/UeeqK4F9qUFvvtQxKUwvituP9h3BTC0Gsk0hrJe66jKY2QIbqeQMuoCeP+iNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-65747d01bb0so5268591eaf.0
        for <linux-block@vger.kernel.org>; Sat, 06 Dec 2025 22:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765088668; x=1765693468;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cx6Z98rIzz7IMIIKluwae3+8MVUlw8/rfA20wqoNPxU=;
        b=wQgxd2e8nxK+/rGBONL45CrmB8xYhML4T5gX5N0FjnrBB36YzBtx+vhikghZRV/kaA
         Pm+iQPx77om9LIFJofAJPNWajGGyM+xtgsqIMMsLbr6GJWB9/I0EEECmiweWEJha0VvH
         1lU3IhABS7o+9W3kS3g59zC6xrl74ylKGew8n3jH5GJJNg/yqui3FDptbXrV+O/f0TPL
         AmjBiVlXLbjkfaZD+jKv3QwKVpzTHqSlIRgFcSlu43bjB7YtK+IdpBTVPQZgI0vqCI4W
         46oxbmwPncUq+TL87XSxXsXTxRxNFTDzlKPIkgMKYhjRExe8DrvzMH+SsYxXdr/V4T8Y
         PjbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq5nJNfdD0sRidl24nVYoSEW0ckXMeQ+x+Gr1JcVB0yYnAEvQcjBOzE0oZ63/oVUGjca4SdURccIJINQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0SPLsCYYLxojsBB1Cw0mPGHXXnXgH5QyGvhj4NfzNJ6LRiDQ
	9B987QyxZgvQbYdWKluYummG7D06m6/cL+aTOU3h6XcklmS79RxrrwJHTNkslFQp1YApB0HM+gB
	jE8dXRdjHNEVUUirZSvHDT6Q2oOk8x27OWuIqlb7B/Bf5XY/SyzIXdZ+WL+k=
X-Google-Smtp-Source: AGHT+IGAWahGHVunb5QkPYheEcE6IlFBVnZdVRRBHLrj9iGoxZ/nVcSNYQpG38We6M7o5/U23sLZZWM5XslAFWdTXBadEizLfVmo
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b03:b0:659:9a49:8ead with SMTP id
 006d021491bc7-6599a93ec27mr1572741eaf.49.1765088668406; Sat, 06 Dec 2025
 22:24:28 -0800 (PST)
Date: Sat, 06 Dec 2025 22:24:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69351d9c.a70a0220.38f243.0049.GAE@google.com>
Subject: [syzbot] [block?] kernel BUG in bio_chain
From: syzbot <syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b2c27842ba85 Add linux-next specific files for 20251203
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1688d2b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caadf525b0ab8d17
dashboard link: https://syzkaller.appspot.com/bug?extid=f6539d4ce3f775aee0cc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dd5512580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158d7512580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1168b2ea1fd1/disk-b2c27842.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2c3066faf780/vmlinux-b2c27842.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6693abe374d/bzImage-b2c27842.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/caedad91e176/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=118d7512580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: jid=0, already locked for use
gfs2: fsid=syz:syz.0: jid=0: Looking at journal...
------------[ cut here ]------------
kernel BUG at block/bio.c:342!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 912 Comm: kworker/1:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: gfs2_recovery gfs2_recover_func
RIP: 0010:bio_chain+0xee/0x100 block/bio.c:342
Code: 43 1c 5b 41 5c 41 5d 41 5e 41 5f 5d e9 1b e1 f2 06 cc 89 f9 80 e1 07 fe c1 38 c1 7c cf e8 aa fc bd fd eb c8 e8 d3 a8 57 fd 90 <0f> 0b e8 cb a8 57 fd 90 0f 0b 0f 1f 84 00 00 00 00 00 90 90 90 90
RSP: 0018:ffffc90003d07540 EFLAGS: 00010293
RAX: ffffffff846a0a5d RBX: ffff8880207223c0 RCX: ffff888025b49e80
RDX: 0000000000000000 RSI: ffff8880207223c0 RDI: ffff888020722500
RBP: 0000000000002004 R08: ffffffff8476a450 R09: ffffffff8df419e0
R10: dffffc0000000000 R11: ffffed10040e4487 R12: dffffc0000000000
R13: 1ffff110040e44a8 R14: ffff888020722500 R15: ffff888020722540
FS:  0000000000000000(0000) GS:ffff888125f49000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff5e0f43000 CR3: 0000000073e76000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 gfs2_chain_bio fs/gfs2/lops.c:487 [inline]
 gfs2_find_jhead+0x627/0xe40 fs/gfs2/lops.c:549
 gfs2_recover_func+0x5f5/0x1c90 fs/gfs2/recovery.c:459
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3261
 process_scheduled_works kernel/workqueue.c:3344 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3425
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bio_chain+0xee/0x100 block/bio.c:342
Code: 43 1c 5b 41 5c 41 5d 41 5e 41 5f 5d e9 1b e1 f2 06 cc 89 f9 80 e1 07 fe c1 38 c1 7c cf e8 aa fc bd fd eb c8 e8 d3 a8 57 fd 90 <0f> 0b e8 cb a8 57 fd 90 0f 0b 0f 1f 84 00 00 00 00 00 90 90 90 90
RSP: 0018:ffffc90003d07540 EFLAGS: 00010293
RAX: ffffffff846a0a5d RBX: ffff8880207223c0 RCX: ffff888025b49e80
RDX: 0000000000000000 RSI: ffff8880207223c0 RDI: ffff888020722500
RBP: 0000000000002004 R08: ffffffff8476a450 R09: ffffffff8df419e0
R10: dffffc0000000000 R11: ffffed10040e4487 R12: dffffc0000000000
R13: 1ffff110040e44a8 R14: ffff888020722500 R15: ffff888020722540
FS:  0000000000000000(0000) GS:ffff888125f49000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563e2b893950 CR3: 0000000026910000 CR4: 00000000003526f0


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
