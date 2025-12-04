Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8523C4F2
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764862953; cv=none; b=hsFCdkewmrwcs87wuSjhlbEMfuRWFxHWE4yvxauoaLgMA9G22xYWLtjErqcvYPh2T39EpiHoUkPCUvKX6BrKFiT3D+XSiTaJPkGKR0G+X4B1DYP67u6WCoSe3vIxkX5hXYOgl8qXzZutkWXvCxF4YRSlb2Z74Zjrlv21Q6J7zc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764862953; c=relaxed/simple;
	bh=hCUX2AKJN4Fc25CcRWA9lfePlZVkLcHCU5UsU9tOgZQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CmsJOfEf1ar72MyWwh2Hxb8+Ol6h1iTdPeAxc3WDLRVnIyQ166AjJjsCKiy7htqSPhhvoTkzDII6CvrZQfa3MefD6jdH67qLpqRGxFeNR6TPh+OpW5PalqnH7JNpZGK58oy9+PLeZZspwSIWaxM9qfh9AsVj1d0dv3FiZZ1OEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-44fe73611fdso1250974b6e.0
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 07:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764862951; x=1765467751;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jte0T+zzjhauetn4VvSPBanKQRm1ISFdJopkd25SNzI=;
        b=Jw1PCpIuFUZHQ6PZyUe173vN3xbTrVwO6Wkc+oTAJMgZFbkSx473Qa5p+t20vRHXIj
         djctMDlpti5BJdHQCx0d3fjwjYTqcStfhU4HMjTgQ4GMMLxEIiRj8PnaUXIteUOqnOk0
         g2n2FQz9V5Z7zK4ueAtM3uWLR0XYGNz4VTjwSz2nVCos6f2J9u1Fr6KBus0rRwo5KGze
         OsCc8zB5ZgnVdJR6PYdFxRrKnzfUNcuyzEToKF/9Imaz1Fn+TtXbB/YHri3QGtxs/M0B
         PcUlT5SJT3MO9DzeOcS2mDY9ebp3u0nu6yKCk78FR2Sd04wrbb9azVu/QQaMgyI0l8Z6
         WjVA==
X-Forwarded-Encrypted: i=1; AJvYcCX1fUtFQgss/x9yOsOh4Xxu2wi+ZRlUYobJUG0K1f1jJm/RhjC2hhpvW+NEMrrQRlAOvMTS9fLF6I3j0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyznzt9ZTORdHqMk3ig//GIAYBMj8XmgQndRGza2nTD4QLa+p2U
	DGTjikNlMT3nU7DDB5dcLKc2lHNrvL1nWyDUrsR50/7arCMF22rSRskOaX3It7fQagG3qQ8qHxu
	J7EMSylluCXSJPz+q3PjaNb6TDDV1V5SpNRQxaHsa7Te78KdWgm4YVri7V/A=
X-Google-Smtp-Source: AGHT+IE7glub4ozibI79wiAFUltYaCp5HVLz4l806orD8VnqdbQME6lho+gMxuXFVNoIRT/NO97X0nljEDxzqVJdphTJSuugDlY9
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:130c:b0:44f:8f27:e39a with SMTP id
 5614622812f47-4536e3a2321mr3762525b6e.8.1764862951434; Thu, 04 Dec 2025
 07:42:31 -0800 (PST)
Date: Thu, 04 Dec 2025 07:42:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6931abe7.a70a0220.2ea503.00e0.GAE@google.com>
Subject: [syzbot] [block?] [udf?] memory leak in __blkdev_issue_zero_pages
From: syzbot <syzbot+527a7e48a3d3d315d862@syzkaller.appspotmail.com>
To: axboe@kernel.dk, jack@suse.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6bda50f4333f Merge tag 'mips-fixes_6.18_2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ad8192580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f30cc590c4f6da44
dashboard link: https://syzkaller.appspot.com/bug?extid=527a7e48a3d3d315d862
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b27cb4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/864951cecf67/disk-6bda50f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4692a21b76e7/vmlinux-6bda50f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2898beb8301/bzImage-6bda50f4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/384c8ab49dd6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+527a7e48a3d3d315d862@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810dd11b00 (size 200):
  comm "syz.3.32", pid 6189, jiffies 4294946488
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 80 70 01 41 81 88 ff ff  .........p.A....
    01 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00  ................
  backtrace (crc fe2a8999):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5295
    mempool_alloc_noprof+0xa0/0x200 mm/mempool.c:426
    bio_alloc_bioset+0x398/0x7b0 block/bio.c:558
    bio_alloc include/linux/bio.h:372 [inline]
    __blkdev_issue_zero_pages+0x109/0x2f0 block/blk-lib.c:205
    blkdev_issue_zero_pages block/blk-lib.c:239 [inline]
    blkdev_issue_zeroout+0x1dc/0x490 block/blk-lib.c:326
    blk_ioctl_zeroout block/ioctl.c:250 [inline]
    blkdev_common_ioctl+0xb40/0x1180 block/ioctl.c:580
    blkdev_ioctl+0x128/0x380 block/ioctl.c:699
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888108a3d000 (size 4096):
  comm "syz.3.32", pid 6189, jiffies 4294946488
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5295
    mempool_alloc_noprof+0xa0/0x200 mm/mempool.c:426
    bvec_alloc+0x9d/0x130 block/bio.c:210
    bio_alloc_bioset+0x3cb/0x7b0 block/bio.c:573
    bio_alloc include/linux/bio.h:372 [inline]
    __blkdev_issue_zero_pages+0x109/0x2f0 block/blk-lib.c:205
    blkdev_issue_zero_pages block/blk-lib.c:239 [inline]
    blkdev_issue_zeroout+0x1dc/0x490 block/blk-lib.c:326
    blk_ioctl_zeroout block/ioctl.c:250 [inline]
    blkdev_common_ioctl+0xb40/0x1180 block/ioctl.c:580
    blkdev_ioctl+0x128/0x380 block/ioctl.c:699
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
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
