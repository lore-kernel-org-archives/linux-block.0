Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510330;
	b=GkBH4VHTCF3yKrck3JWOU7V3i3lDZX92KW1Usa48ChoabS3Pgs4L2cI2GptnatOgaNA2
	 azkq9nK1DzVo2i8vKVIrgubMCH9pJugqHZhEhH9W8U1gp1M9YJlViEhPnA8AoDL4J5oaN
	 hDUDVPjwBRUlkm0rzSIkQS1ar7ygpX9UjF6tf26xz+6hIidad2m0gkrcP5cRFOq+SuFBb
	 y+qTQ4ZTjHrG6uLEFp79ckpC7+YAk2nFjrv+lgaxmZVg0kb1B8cdLFMtywAPk+cEERmZd
	 MJjPR6iIcJ8fzRtuAvxmHbM0JWSMtrL/UOKBMld1bpXZkgptbHOoTBwMJ59rzZlNrJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510330;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=RpUsNHBHUXRzS2zghI2ldKlR03lTMuoNlBhWk95vYTI=;
	b=BIIsisc0KjjtAUjiTlEkiTdc2aVoAqK+jJGXpHHnMFAhwcMqH20Hi0KDKdfs5m8toApH
	 NUa73qMk7DjHumCBZOs9Q5zrbzcKYFwLF5XuDUpVO0rgBGcwNwEcG9yUHMWfXJ1eylSqq
	 ND7iEOBuyVN8/o97mzmkwzvKSYbXNVHpNr6uSqa56YpExqK+tm7Tap1rZD1nUoeka+nYg
	 K+2i227TGzmxDJk8QUHOLB+2ZbWALmavbCgTn7ngLiySF31AJPV3d8JDVTe7MqEZ6KABG
	 0mW28ENowXOSkJ6KgLSqJ/G+L9wfHiyYian2UQIxtPqknwsSyqh6qXLes474YQK3Ysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC561606A321
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 15:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC561606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b26d8d2498so4932412b6e.2
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 08:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510329; x=1793115129;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RpUsNHBHUXRzS2zghI2ldKlR03lTMuoNlBhWk95vYTI=;
        b=gne9oTq7tgIVRyzsOzizgIZo90IfO/o5/58DnnKyRMBaBLPgiVGcTPrInQ0WPJsAwo
         u88DwNyeBRUEH3RjEhUus6DaI9d3FCAJWRRVFJ88ElJx9SQHVmCaXc1uCYAPI9210m72
         AUCKVS0l2yQNdwh4eJP0kFoy0bcM9m2lot4al97oXvhQcPa7f7faFIAz3RzKopGw6wcA
         NmS2dqRQnPSnR22pAg0JLiAGXogfHMAPxF7hh8XFOLr9KsxC8kF0yPsFqrt1w6e/5lDF
         zKpd0HsotA56P0jP4JjKLNx34ldU3UPj7REBV/cGMOOTQZx0186sObVG3w3AuqfLe10X
         7hEw==
X-Forwarded-Encrypted: i=1; AKwUvBwHFUddz1/i8Y/rq2OOrrmxEd8pfbd732yP6+C55i6kpFmKMb4iBfsOXnf6tqDEmhD2NfbU7n+cFfas2g==@vger.kernel.org
X-Gm-Message-State: AFq9FYLSUifTRSCTxh/Y1Ln5nDkaYYoTjwuOvLqnLXTGMUl6F0hkoz6x
	2pc3TwEJ+ZFEsUjunP1/ooZ8DiuW3QhQdrAYyAbubrepsgIrQbBcewGokC7XV9oTHg7IVix+/YW
	Haq22jwHwuwP+W34rymepNbVkGMdubY3VgspjtNz1R1CFIfk1eRNInBcgFcs=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13c6:b0:4f4:d7:b15b with SMTP id
 5614622812f47-53cc6b003a6mr9914911b6e.4.1792510329007; Tue, 20 Oct 2026
 08:32:09 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:32:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad78978.b5bd089a.6b57.008d.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blkdev_buffered_write
From: syzbot <syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2efb7a11f1aa Add linux-next specific files for 20261016
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15344895580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=129fca4e65ab9877
dashboard link: https://syzkaller.appspot.com/bug?extid=bd975ef54294bec73f0e
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110b0f01580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b99031580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd996cff1b76/disk-2efb7a11.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/59577d58bd5a/vmlinux-2efb7a11.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3dfa3b04143/bzImage-2efb7a11.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2b9971624b86/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.0.40/6005 is trying to acquire lock:
ffff888024956f68 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:1039 [inline]
ffff888024956f68 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: blkdev_buffered_write+0xd7/0x160 block/fops.c:738

but task is already holding lock:
ffff888024956f68 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:1039 [inline]
ffff888024956f68 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: blkdev_write_iter+0x6c5/0x810 block/fops.c:815

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&sb->s_type->i_mutex_key#10);
  lock(&sb->s_type->i_mutex_key#10);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

locks held by syz.0.40/6005: 1, last CPU#1:
 #0: ffff888024956f68 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:1039 [inline]
 #0: ffff888024956f68 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: blkdev_write_iter+0x6c5/0x810 block/fops.c:815

stack backtrace:
CPU: 1 UID: 0 PID: 6005 Comm: syz.0.40 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x27a/0x290 kernel/locking/lockdep.c:3085
 check_deadlock kernel/locking/lockdep.c:3137 [inline]
 validate_chain kernel/locking/lockdep.c:3939 [inline]
 __lock_acquire+0x25db/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 down_read+0x45/0x320 kernel/locking/rwsem.c:1574
 inode_lock_shared include/linux/fs.h:1039 [inline]
 blkdev_buffered_write+0xd7/0x160 block/fops.c:738
 blkdev_write_iter+0x6d5/0x810 block/fops.c:816
 do_iter_readv_writev+0x612/0x8c0 fs/read_write.c:-1
 vfs_writev+0x343/0x990 fs/read_write.c:1768
 do_pwritev fs/read_write.c:1864 [inline]
 __do_sys_pwritev2 fs/read_write.c:1922 [inline]
 __se_sys_pwritev2+0x177/0x2a0 fs/read_write.c:1913
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff2f2b9e559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff19d23ca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007ff2f2e25fa0 RCX: 00007ff2f2b9e559
RDX: 0000000000000001 RSI: 0000200000000240 RDI: 0000000000000004
RBP: 00007ff2f2c35ab8 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000007a00 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff2f2e25fac R14: 00007ff2f2e25fa0 R15: 00007ff2f2e25fa0
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
