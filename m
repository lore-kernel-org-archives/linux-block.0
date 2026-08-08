Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB5388396
	for <linux-block@vger.kernel.org>; Sat,  8 Aug 2026 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219774; cv=none; b=bRVLl73F8wPAqMvoL5dhR0uyNSAuk56YuZsPk6aanlrgshA/0gZinpdqyekCVVLSGw8MOv3C8b4txXrylWE/Kw6aL3b3VY3/Rdys4TDFRV/JQPBHi8Wk3mJWPj3TEFMmV9K2DMajPqzmwpLYJ6lBaINjvjxOx6fC1kPwpJhNJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219774; c=relaxed/simple;
	bh=7k4Sd9kgwfoHkkThsjls/1q0u92Ydg1BFZFLcGIUl6w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CxfGDOlPFesO03UwHp/Uqme5VAV/i8Aeoq+WKtlCVt4wd1onKrrFPhyCGHRGiNh0NWTsfgI7YyzR7jJBfTi/25/VY0ZXAEQqH1zBZ7kIIbJe4HQqeHx4rMvhMiX3DRslQKzlK37156zabhw0F52cuJasy5P3rlt6ta2znSYCQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7ead32f5c6aso373305a34.1
        for <linux-block@vger.kernel.org>; Sat, 08 Aug 2026 13:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786219771; x=1786824571;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ublXvQE9zAqFoIb3oWfS9G9UDORxnCqvFU2vCfteeao=;
        b=Q4tGZvL1TRDuOU2VG5J+ITuhm1Lz4ybvgXBwO8XGbKqFctXUIJBWW3yEoIknct4yqA
         Q7SxkM/bur9nU+7gEbAKEVi9vbkY/f4D7Js5PPwDGUjy+yu4/PSr/NivQ08TElgNQyJo
         XgDsgxicDm3OWnpOdjQEb8cgwnxumeIl6X2WHwMaTjxNnqLVlcCyX9NCnGFnjm/WJ0J5
         dcyzyUc0uDZWiVgI1U4tJealIcfPH7AqcintI87l9FdLP1zlw34mtPF8Om1U+qXfc1jG
         Xv+3qVulsqozGcjVjs/pbauUc2N3aACjvaTkXrxx/FBG2RCzbLhd4XxFVayJON1dc6Vs
         K+PA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5fpR85X0wVhSbErHTAUL4n1Z/YYbqcNJBtFYkgDzjRvhu2tB1vj6F+ZHmBL059fs/gvvVcMhsV/qGww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yygm+h41eGwq+SUJVI5fM9WB7EMnix1OIEzy72uYx8M+Qr+VNnp
	gRJYi+dlpdy0BPoowa/y0Ga5yKZKvM77vBCe8hdKFeqHdG903El9tpqjeVausFnwdYGLuFtrYpR
	WVx+Dj4OsBAjf8oT9zBN/2lrq9Z56tVvz9KBaieHEZDTs4XF8jAd6PolDb54=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:238d:b0:492:5684:7ab3 with SMTP id
 5614622812f47-4afadf17a51mr17716708b6e.21.1786219771710; Sat, 08 Aug 2026
 13:09:31 -0700 (PDT)
Date: Sat, 08 Aug 2026 13:09:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a778cfb.9c11d2ce.289b96.00b7.GAE@google.com>
Subject: [syzbot] [block?] WARNING in blk_mq_free_tag_set
From: syzbot <syzbot+02b37e31e64ea5cb6d29@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b8c8af514d7 Add linux-next specific files for 20260807
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d2bfb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d343b54cc50df0f
dashboard link: https://syzkaller.appspot.com/bug?extid=02b37e31e64ea5cb6d29
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f56132580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/71ff4edcb608/disk-6b8c8af5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f5fa331d8f2/vmlinux-6b8c8af5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f993558ec63b/bzImage-6b8c8af5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+02b37e31e64ea5cb6d29@syzkaller.appspotmail.com

------------[ cut here ]------------
timer_delete_sync(&sdp->delay_work)
WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x3aa/0x890 kernel/rcu/srcutree.c:706, CPU#1: kworker/u8:11/3800
Modules linked in:
CPU: 1 UID: 0 PID: 3800 Comm: kworker/u8:11 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: nbd-del nbd_dev_remove_work
RIP: 0010:cleanup_srcu_struct+0x3aa/0x890 kernel/rcu/srcutree.c:706
Code: b9 8a 00 48 83 7d 00 00 4c 8b 74 24 10 0f 85 dd 03 00 00 41 ff c5 41 83 e5 0f 41 83 fd 07 0f 86 0e ff ff ff e9 ab 00 00 00 90 <0f> 0b 90 4c 8d b5 00 02 00 00 4c 89 f3 48 c1 eb 03 48 b8 00 00 00
RSP: 0018:ffffc9000e69f9d0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000607edad2e8c0 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff8e253559 RDI: 00000000ffffffff
RBP: ffffe8ffffc3a8c0 R08: ffffffff9058fb7f R09: 1ffffffff20b1f6f
R10: dffffc0000000000 R11: fffffbfff20b1f70 R12: ffff88802b760000
R13: 0000000000000000 R14: ffffffff8e5237d0 R15: 1ffffffff1ca47de
FS:  0000000000000000(0000) GS:ffff88812500c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbb3d026e9c CR3: 000000000e948000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 blk_mq_free_tag_set+0x617/0x780 block/blk-mq.c:4976
 nbd_dev_remove drivers/block/nbd.c:269 [inline]
 nbd_dev_remove_work+0x4f/0xe0 drivers/block/nbd.c:284
 process_one_work kernel/workqueue.c:3375 [inline]
 process_scheduled_works+0xc4e/0x1630 kernel/workqueue.c:3458
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3539
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
