Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED45320CD3
	for <linux-block@vger.kernel.org>; Sun, 31 May 2026 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780190430; cv=none; b=DEaOwB81eKcJzqQxTfftqbUtRb7111/sm36W9FxVFxDQPXqF8wrzsQtCXYYGLqNV5UkOaxzrpqRkj9WWeOBMtorEFSr6V3Kx2rDNiJnEFb1llCtrXZRhluCAzTl5Wlipu2iOYnUh1hcyxEKZRc5CLTQiNxXbsoedCKB2aZcZrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780190430; c=relaxed/simple;
	bh=8OyXgjc+ClKNVnnz4l/huDfPrC6PiDWrvQIPXLPWNY4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UyMMGm0lOPyosFE0DfCkBciVfkOIq1I+fduSGeS48+0OGSEYe0wqsE7XNP68sput5Xr0KGdV7RKPb272Bv/996MBc9Y/qkASJWCmr4uKwIapjlfTmIAPkSNw8g4X3XDLX7SeUgk3ZEoz0jyWLji8P2ugjgvI1WkuFv72M+vxLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-69d941fbbe1so7997782eaf.2
        for <linux-block@vger.kernel.org>; Sat, 30 May 2026 18:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780190428; x=1780795228;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sb7TaJlP+gKN0lpcGNJ9QSuNZF4bp8IcojnjkQzbeEA=;
        b=MPog+GFSwnzemGVeuhlmhrZSbr/66OhrFhnC3rYwBJCWAKdcYAGhTrV6vd5I4Xz1vq
         8UnFgWttJAMHZObCmgnAfjFhByULXM7IOqxzCsV54STAJ6H+IVNrCXxlLJnc37bDVQ+G
         qIwiVKkNTGTytdtYYSGiETghd9zexNGeKIroGdXbrD/ZUBega7alItZTbszUbj+F/kO3
         ftC1COLuv1brXMsFkj6Guq5vwdFlZEkqvZTxp1JlxDUMuwXOplTn7Ir23US9pGBnwNR3
         eXFiVc9zIHm/yur8kjlFUCSyBPJ5J4aKgTYsPQ5VhLuVCPOmPnq7ypI120/uYkd974Po
         EcAg==
X-Forwarded-Encrypted: i=1; AFNElJ/J3oKGwY7tAxcCU2z9smkkf9Q4q2ozUn1EUGJ0t22aa6Mg2vXLPY1uduIXfsE/uoc4IHdoa4zAk9k1Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyjCXlLy1Q9KTvWEyprnIQfRCZgJfqBzl6ZoRCadMXjoAtzslH
	i3q2+uGAzxecAxcOdOtQ+oCRpSt7uiaobaUGm35TcoAKbGKwTRr9rhT9bNd4uNVp09a2vGedqmn
	crvl2Lo/bS6CgztSx+JCvn1wRGdZqq1a54yVxr68GB+GDHVLBCAlPlDyt8i0=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a04:b0:696:1432:eca2 with SMTP id
 006d021491bc7-69e105ba640mr2530053eaf.52.1780190428486; Sat, 30 May 2026
 18:20:28 -0700 (PDT)
Date: Sat, 30 May 2026 18:20:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1b8cdc.0a9e871e.332604.000f.GAE@google.com>
Subject: [syzbot] [block?] general protection fault in ublk_queue_rq
From: syzbot <syzbot+415b9ec753cd2a196087@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4b4362973b6f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=165f17a6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f52fb4a6d220c448
dashboard link: https://syzkaller.appspot.com/bug?extid=415b9ec753cd2a196087
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a33a0e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115f17a6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cdc9dd8cab69/disk-4b436297.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6bb74747f86d/vmlinux-4b436297.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a20d7153214f/Image-4b436297.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+415b9ec753cd2a196087@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000003
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000003] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 4778 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: events ublk_partition_scan_work
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ublk_queue_cmd drivers/block/ublk_drv.c:2095 [inline]
pc : ublk_queue_rq+0x114/0x1dc drivers/block/ublk_drv.c:2223
lr : ublk_queue_cmd drivers/block/ublk_drv.c:2092 [inline]
lr : ublk_queue_rq+0xec/0x1dc drivers/block/ublk_drv.c:2223
sp : ffff800099646b10
x29: ffff800099646b20 x28: ffff7000132c8d80 x27: ffff0000c610b280
x26: ffff0000c610b2c8 x25: 1fffe00018c21652 x24: dfff800000000000
x23: 0000000000000004 x22: 0000000000000002 x21: 0000000000000000
x20: ffff0000c610b280 x19: 0000000000000000 x18: 00000000ffffffff
x17: ffff80008a186c80 x16: ffff80008a4b54f8 x15: ffff0000d9c0c550
x14: ffff0000d9c0c530 x13: 0000000000000001 x12: 0000000000000000
x11: ffff80008a3fcd08 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000003 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000008 x3 : ffff800082559f20
x2 : 0000000000000004 x1 : ffff0000d9c0ba00 x0 : 0000000000000018
Call trace:
 ublk_queue_cmd drivers/block/ublk_drv.c:2095 [inline] (P)
 ublk_queue_rq+0x114/0x1dc drivers/block/ublk_drv.c:2223 (P)
 blk_mq_dispatch_rq_list+0x3bc/0x13a4 block/blk-mq.c:2148
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
 __blk_mq_sched_dispatch_requests+0xa40/0x10bc block/blk-mq-sched.c:307
 blk_mq_sched_dispatch_requests+0xa4/0x154 block/blk-mq-sched.c:329
 blk_mq_run_hw_queue+0x3c0/0x4dc block/blk-mq.c:2386
 blk_mq_dispatch_list+0xa2c/0xb2c block/blk-mq.c:-1
 blk_mq_flush_plug_list+0x3a4/0x484 block/blk-mq.c:2997
 __blk_flush_plug+0x338/0x410 block/blk-core.c:1230
 blk_finish_plug block/blk-core.c:1257 [inline]
 __submit_bio+0x39c/0x478 block/blk-core.c:649
 __submit_bio_noacct_mq block/blk-core.c:722 [inline]
 submit_bio_noacct_nocheck+0x284/0xa98 block/blk-core.c:753
 submit_bio_noacct+0xd90/0x1814 block/blk-core.c:884
 submit_bio+0x38c/0x528 block/blk-core.c:926
 blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
 submit_bh_wbc+0x4b0/0x594 fs/buffer.c:2737
 submit_bh fs/buffer.c:2742 [inline]
 block_read_full_folio+0x69c/0x734 fs/buffer.c:2358
 blkdev_read_folio+0x28/0x38 block/fops.c:494
 filemap_read_folio+0xf0/0x2fc mm/filemap.c:2502
 do_read_cache_folio+0x368/0x5b8 mm/filemap.c:4107
 read_cache_folio+0x68/0x84 mm/filemap.c:4139
 read_mapping_folio include/linux/pagemap.h:1017 [inline]
 read_part_sector+0xcc/0x708 block/partitions/core.c:724
 adfspart_check_ICS+0xa4/0x6fc block/partitions/acorn.c:356
 check_partition block/partitions/core.c:143 [inline]
 blk_add_partitions block/partitions/core.c:591 [inline]
 bdev_disk_changed+0x6fc/0x11c8 block/partitions/core.c:695
 ublk_partition_scan_work+0x74/0xf4 drivers/block/ublk_drv.c:2467
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0x79c/0x1098 kernel/workqueue.c:3397
 worker_thread+0x754/0xba0 kernel/workqueue.c:3478
 kthread+0x2f8/0x3c8 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:842
Code: 979832c3 f94002b5 910062a0 d343fc08 (38786908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	979832c3 	bl	0xfffffffffe60cb0c
   4:	f94002b5 	ldr	x21, [x21]
   8:	910062a0 	add	x0, x21, #0x18
   c:	d343fc08 	lsr	x8, x0, #3
* 10:	38786908 	ldrb	w8, [x8, x24] <-- trapping instruction


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
