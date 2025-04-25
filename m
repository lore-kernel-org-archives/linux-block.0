Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7A748F
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745542655; cv=none; b=pn2LvziZU11P29Fu0b+u83r5HfNm3nb67Vfp6tqiAfp3ZfJ55rN6rM5H7DNtfbCve+/naz9xifrSI7t9AQ82E66tGvpq+OsxjI9De14cEM8mzoxGt85Wgx7mRQ2mukgaOYIjC3ZmbvuJJY2woRn3/bum7V2DbaHALoWSYIRbIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745542655; c=relaxed/simple;
	bh=lPqj20Aj3gUL5srVu24DmxVC2sY+5WHQ2tny0ytUy30=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s2M5wYYsyh5tWGe28eNp5hyV0Vl7OJyNjlg8nnptynCISA64RGzGaJ6IU9Od06MPPL6rbYEqtCBNjQMVCJzcFXHvWL75MD40tKpS/FZyKt745rYIsho5aueMoaJLQMVjkK10r9eVfsxnR5HfrTQ+h5V+ykLNJ55VeX4ACYR8M1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b4ee2e69bso204726039f.2
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 17:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745542653; x=1746147453;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUIKBbBNpV3nz9W2ZbdzznJaqQci7ZwaeOwdPZLKabE=;
        b=E6Wq/brSF+p8s5fwQ6mrRfKv37TLK/EgriN1sWSVUO9e20mu9qrTMbV1gOMIahcrti
         qEvi3aVFdO/vLVI3xN7JvJw/Kyh5AJS6d6lcMWsmgX48N2VqZfAEWPVlhIrRg0uSP55p
         bmK0Ptk+v7GnvRCu6yG0WXn5p0CmuTHKKX/9sDnszsE1KXIpO87rCf7uyicFMfqFrUrJ
         QELwxj3k3uU5qCM9kWLLuLvR60WAP9Ysb04y6VO4CmbWa0E2MpDDRzwC769svPNrhVqe
         ssk5EEKiN2EbjAme4U7GG140IOR96f8YjUInHv1+0Z8UUCwECMZWpbDt99hmEqJNoMyr
         GjJw==
X-Forwarded-Encrypted: i=1; AJvYcCVVUFrYKxOQNovvIKt+jPK09elbJcMH017x7c6b0hv1hlLK3UCm7nPUQLBbvcVcchmETywhNnJS2qPoIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4F6TY9dRxyaVFkUxePAN6l9NXv0DnAZNRAyGPHwLM8lqQ+hq
	XFiPDgeD+BQXgL2e59yRTj1R8kPD5iJseuoXPaItSXw2Y+jqBZ1QBdpr8SF8czvw0Py458HUQvd
	u9gnL8/y4hvwYVYF87FxWiQB0fGC4tDpbdFuQ4rBVzdJ/RBqShmMQI2k=
X-Google-Smtp-Source: AGHT+IGvKeKpi9RR5DCw2+wVK7me3AqVhHOjaT/myiLNN+Quy0+MPDFvbWq5lnmz78a16iCZz7AzA3V5+txifrQF9476fpZy8COw
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144d:b0:3d5:890b:8ee with SMTP id
 e9e14a558f8ab-3d93b397132mr3743235ab.2.1745542652924; Thu, 24 Apr 2025
 17:57:32 -0700 (PDT)
Date: Thu, 24 Apr 2025 17:57:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680addfc.050a0220.2c0118.0c71.GAE@google.com>
Subject: [syzbot] [block?] BUG: unable to handle kernel NULL pointer
 dereference in guard_bio_eod
From: syzbot <syzbot+3291296495fc970e4b1c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6fea5fabd332 Merge tag 'mm-hotfixes-stable-2025-04-19-21-2..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15551ccc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7c08f42e927242f
dashboard link: https://syzkaller.appspot.com/bug?extid=3291296495fc970e4b1c
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17551ccc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a7f4cc580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-6fea5fab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/59473b9bbb43/vmlinux-6fea5fab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2e0095d3721/Image-6fea5fab.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3291296495fc970e4b1c@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 52-bit VAs, pgdp=00000000442aa200
[0000000000000008] pgd=080000004b293403, p4d=080000004b27f403, pud=080000004b237403, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6338 Comm: syz-executor150 Not tainted 6.15.0-rc2-syzkaller-00488-g6fea5fabd332 #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
pstate: 41402009 (nZcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : bdev_nr_sectors include/linux/blkdev.h:831 [inline]
pc : guard_bio_eod+0x18/0x210 block/bio.c:694
lr : mpage_bio_submit_read fs/mpage.c:74 [inline]
lr : do_mpage_readpage+0x2d0/0x6dc fs/mpage.c:296
sp : ffff80008331b820
x29: ffff80008331b820 x28: f4f0000004143e00 x27: ffff80008331b960
x26: 0000000000000001 x25: ffff80008331b940 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000000 x21: ffffc1ffc02c9dc0
x20: 0000000000000010 x19: f4f0000004143e00 x18: 0000000000001000
x17: 0000000000000000 x16: 1e9e000000c6abc1 x15: 0000000000000000
x14: ffffc1ffc02c9dc0 x13: 0000000000000000 x12: f4f0000004143e00
x11: 0000000000000000 x10: ffffc1ffc02ca580 x9 : 0000000000000003
x8 : 00000000000000b8 x7 : fcf0000003f3b97c x6 : f6f0000006355c00
x5 : f6f0000006355c00 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : ffff8000803bbfc0 x0 : 0000000000000000
Call trace:
 bdev_nr_sectors include/linux/blkdev.h:831 [inline] (P)
 guard_bio_eod+0x18/0x210 block/bio.c:694 (P)
 mpage_bio_submit_read fs/mpage.c:74 [inline]
 do_mpage_readpage+0x2d0/0x6dc fs/mpage.c:296
 mpage_readahead+0xcc/0x164 fs/mpage.c:371
 blkdev_readahead+0x18/0x24 block/fops.c:472
 read_pages+0x70/0x2b8 mm/readahead.c:160
 page_cache_ra_unbounded+0x1d4/0x260 mm/readahead.c:280
 do_page_cache_ra mm/readahead.c:327 [inline]
 page_cache_ra_order+0x34c/0x400 mm/readahead.c:532
 do_sync_mmap_readahead mm/filemap.c:3262 [inline]
 filemap_fault+0x444/0x924 mm/filemap.c:3403
 __do_fault+0x3c/0x21c mm/memory.c:5098
 do_shared_fault mm/memory.c:5582 [inline]
 do_fault mm/memory.c:5656 [inline]
 do_pte_missing mm/memory.c:4160 [inline]
 handle_pte_fault mm/memory.c:5997 [inline]
 __handle_mm_fault+0xadc/0x1b00 mm/memory.c:6140
 handle_mm_fault+0x164/0x314 mm/memory.c:6309
 do_page_fault+0x118/0x688 arch/arm64/mm/fault.c:647
 do_translation_fault+0xac/0xbc arch/arm64/mm/fault.c:783
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:919
 el0_da+0x78/0xa8 arch/arm64/kernel/entry-common.c:604
 el0t_64_sync_handler+0xc4/0x138 arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:600
Code: 910003fd a90153f3 aa0003f3 f9400400 (f9400400) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	910003fd 	mov	x29, sp
   4:	a90153f3 	stp	x19, x20, [sp, #16]
   8:	aa0003f3 	mov	x19, x0
   c:	f9400400 	ldr	x0, [x0, #8]
* 10:	f9400400 	ldr	x0, [x0, #8] <-- trapping instruction


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
