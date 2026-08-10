Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B381E0E14
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380695; cv=none; b=J+ZkgYh5hphr+ITcoGjyHRrSRrTolG/fjj+VJ20QW56s2HJaSYmfnxaOdhshBvH1gJTunyloxIwodpuRO77+ZqK7LBWKLMIOUu1lU9zjXeSKeOJO6LTlFxp/+mDMsWVUWOjxpekxGnbizpwW5BR5m1JtrdA/Scbob/SF99pC0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380695; c=relaxed/simple;
	bh=6sqH55ep68Ya6IEwe16g+wGjVSX2q8UmDCx5cSQ5KSw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZGuQjThMZmPt3AF7XEqZmNyLqulkO9Q6Mabn5Nebf96QCVUWIIies4N5uLbnPCoTGAYVLmYWRrpEhoZJDjZrVYIVfkVJmEd+QeD0K4Wkm9pJDEoVZlNZoMGmjPccqKQMvlWplqBDol2woBkzyT5+IPJMj15McTQLjAM/UKZOBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6acaccb8b0cso1436651eaf.0
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 09:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380692; x=1786985492;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PC9GWSk76hEJ1F+5OzpZ9Uz/1Ud8LBhqu7/qzPG48E4=;
        b=RJ8Z54EzMOr0gvlG75BTf22MLX8LFF3d9/BWihCMNoZVG+/b89IW/hEOERs8cs1iip
         eiQaeKM29xHZDcc8CVQq5oM8sKEZuVXAUd+LsAverEFPcVcXvpeGJiyasGpINEF6xorx
         ufQuDyXPGHxY788ZMaBcgNvmr055lveuAhV+W3J3v4Y36QbwoQD6VG72t+0n/pw9iq1n
         Oc1DFbd5YvIkaIdV+DzZMkDJ6PezVIGor+w3dWs1SgQTOTzULYjpeuVqKhLSysxx1f+l
         FEuvX3eNKoiwKDQ/Rnly0cUtUgCLeLdoDRE4mxJgzuf/ntfAHO56etLqKEBLqGolKO81
         pEZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqTctmPv53gJOqw7JxA2XpUuN7gZ7yedLh2R7pLnWbQ5Iz+wFngyea7fQhuvmViv6prAWdDTdCAoJAcJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLgDUyXesh56zjoR6kp8SHkklsVHXhAJhWJWIKpOd5nUNOSKS
	Nh2Jd+ba5NCeQtK2wXvDURSwv5+00GBXvPVNGyytldfR1adMeX2En/qSLDd3Zn0b/5ek/MghilW
	11cw9gmi02Fzi+TV5YruKqqD4qNp2cRnZlNwelYGlOhe2kB1qo/T2WOPC+rc=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e84a:0:b0:6a3:7ee4:11c7 with SMTP id
 006d021491bc7-6ae96f9d0e9mr21439965eaf.29.1786380692411; Mon, 10 Aug 2026
 09:51:32 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:51:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7a0194.b50370da.49fe0.0056.GAE@google.com>
Subject: [syzbot] [io-uring?] [block?] memory leak in io_submit_sqes (6)
From: syzbot <syzbot+a4ccdd7ebf452e4d4701@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06cf61899d64 Merge tag 'x86-urgent-2026-08-08' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118c1132580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6843f8fd2336602d
dashboard link: https://syzkaller.appspot.com/bug?extid=a4ccdd7ebf452e4d4701
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128c5fb9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b37fb9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e023ff6ad9bc/disk-06cf6189.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea49527ba5df/vmlinux-06cf6189.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3d6468d0490/bzImage-06cf6189.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4ccdd7ebf452e4d4701@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888112726000 (size 248):
  comm "syz.0.17", pid 5956, jiffies 4294942148
  hex dump (first 32 bytes):
    80 5d 3a 0e 81 88 ff ff d0 03 59 15 81 88 ff ff  .]:.......Y.....
    04 75 20 c0 02 00 00 80 00 00 00 00 00 00 00 00  .u .............
  backtrace (crc e2966ca0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    kmem_cache_alloc_bulk_noprof+0x272/0x3f0 mm/slub.c:7435
    __io_alloc_req_refill+0x4a/0x150 io_uring/io_uring.c:988
    io_alloc_req io_uring/io_uring.h:536 [inline]
    io_submit_sqes.cold+0x16e/0x20b io_uring/io_uring.c:2046
    __do_sys_io_uring_enter+0x56d/0xd60 io_uring/io_uring.c:2646
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881155903c0 (size 192):
  comm "syz.0.17", pid 5956, jiffies 4294942148
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    2e 20 00 00 03 00 00 00 04 75 20 c0 00 00 00 00  . .......u .....
  backtrace (crc db88fe21):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __do_kmalloc_node mm/slub.c:5333 [inline]
    __kmalloc_noprof+0x3bf/0x550 mm/slub.c:5359
    _kmalloc_noprof include/linux/slab.h:992 [inline]
    io_cache_alloc_new+0x20/0x80 io_uring/alloc_cache.c:40
    io_cache_alloc io_uring/alloc_cache.h:61 [inline]
    io_uring_alloc_async_data io_uring/io_uring.h:355 [inline]
    io_uring_cmd_prep+0x157/0x1f0 io_uring/uring_cmd.c:208
    io_init_req io_uring/io_uring.c:1842 [inline]
    io_submit_sqe io_uring/io_uring.c:1889 [inline]
    io_submit_sqes+0x446/0xd00 io_uring/io_uring.c:2057
    __do_sys_io_uring_enter+0x56d/0xd60 io_uring/io_uring.c:2646
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888112726100 (size 248):
  comm "syz.0.18", pid 5972, jiffies 4294942449
  hex dump (first 32 bytes):
    80 d7 55 02 81 88 ff ff d0 a0 50 15 81 88 ff ff  ..U.......P.....
    04 75 20 c0 02 00 00 80 00 00 00 00 00 00 00 00  .u .............
  backtrace (crc dcaddc4c):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    kmem_cache_alloc_bulk_noprof+0x272/0x3f0 mm/slub.c:7435
    __io_alloc_req_refill+0x4a/0x150 io_uring/io_uring.c:988
    io_alloc_req io_uring/io_uring.h:536 [inline]
    io_submit_sqes.cold+0x16e/0x20b io_uring/io_uring.c:2046
    __do_sys_io_uring_enter+0x56d/0xd60 io_uring/io_uring.c:2646
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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
