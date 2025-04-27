Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6471C862E
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745770444; cv=none; b=GGnnAVjykUZtEl09ndkySPeZYs+GeCMz6DiyAfWA4ghOKwVhJ6E4psfmw9LU/jQBpDJcnKbffZh/55g4ljPHcMHJpznIZLg/f9A3uHjaDJbWSDfxrpm3TE8m+tRY1STPmZxbca50jYHUaMtUe3KQMluibIO17hibMsWncdKnyBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745770444; c=relaxed/simple;
	bh=hx8hAIbVZKXJ6NdczBq4hsXhxoMiVDDi5Djd78nRAA0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=epfSfvlkDu58/aiKd1Iqrz9LR8OxhLx6ensK7WzH2YpiS/YkMFuNHw/pLRi00hePf/sWMsAfvNby6ZL6ohSq/pe8la6Fczi1pnkEDDo3XsNpcrYoToGGVM/mMnRIUR04yQ+aFPWELq7Wux0CfqBg0J/t8ZYeyvtCgoduDqlpVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b3a6c37e2so374944139f.0
        for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 09:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745770442; x=1746375242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/24+5yhqgAMZJMq09oV46bPc+VDFkdU0uH5+23nwk0=;
        b=rxL/mJiAr0eSfp8nRpScXSEiF5NDr7P/h0w+KxYxRvl3jca54NJpddWiJ8MW2In1Y5
         xaeL4PU3krHKm1ml3OOlo8Xb824o47d6RsGVGXHODBu4AKdP8HAcnOm4O8kL+3Qer4yh
         tUrpjSQ8Gp54b+jbmYbbu41D1YKBYqvzJoyD6UHuDyjO+638PVh+TRsPG/OTUOd9c4cH
         7SJhGUlINrDFy8W2okbusPdsywjJ4/n04CIF2P3Gw1MbBU9VO6F89hFcCuTB2R9dZmKF
         y/sA9w7SEdRVdj66BCmjJ2natj5Pa/Kzr3MEu69R5mm63x+ZriBjBMkK9EAuZySvKecU
         NvuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHrguWSKJRU+0yuZdIDwL67gJkoHm5P9+fnplNz47niSq4uPJ96eQ9C5ji23KG4feIbM4NLq28mJnlQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyavYSdjhXQTnJtK8PBHhSEXBh/UhKsK8CEjufEMYF2hQapKV
	S3TD7Q4uWpyYv/PeXTzJX9F/iCZC8f1WEw1NUaMq1H97J6w/xW7KQNFbq1+GthEAMRlvEnXYLAz
	ojRoXuS4Yl8RkAAtxLzkJYnxAwkgqGCkEI0h4X7pY90MCvDlAz/AS2/I=
X-Google-Smtp-Source: AGHT+IEbDj4X1qOn6/mM7rZmyNSgw/gA80oF4b/ios748ScLtAy65IDqJ3XE6BOQ17NyE3vsPFrvC9mj/znxzju28t4jxkOQlT8T
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b06:b0:864:58a6:5916 with SMTP id
 ca18e2360f4ac-8645cd61441mr852292039f.10.1745770442467; Sun, 27 Apr 2025
 09:14:02 -0700 (PDT)
Date: Sun, 27 Apr 2025 09:14:02 -0700
In-Reply-To: <20250427160341.70153-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680e57ca.050a0220.2b69d1.00e3.GAE@google.com>
Subject: Re: [syzbot] [block?] BUG: unable to handle kernel NULL pointer
 dereference in guard_bio_eod
From: syzbot <syzbot+3291296495fc970e4b1c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, contact@arnaud-lcm.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel NULL pointer dereference in submit_bio_noacct

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0,
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 52-bit VAs, pgdp=000000004592d480
[0000000000000018] pgd=0800000046c2f403, p4d=0800000052289403, pud=080000005227c403, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 3990 Comm: syz.1.17 Not tainted 6.15.0-rc3-syzkaller-g5bc1018675ec-dirty #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
pstate: 41402009 (nZcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : bdev_get_queue include/linux/blkdev.h:951 [inline]
pc : submit_bio_noacct+0x20/0x500 block/blk-core.c:780
lr : submit_bio+0xa8/0x1e0 block/blk-core.c:916
sp : ffff80008975b8a0
x29: ffff80008975b8a0 x28: f8f0000003f32000 x27: ffff80008975b9e0
x26: 0000000000000000 x25: ffff80008975b9c0 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000000 x21: ffffc1ffc044c900
x20: 0000000000000000 x19: f8f0000003f32000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: ffffc1ffc044c900 x13: 0000000000000000 x12: f8f0000003f32000
x11: 0000000000000000 x10: fff000007f9ff330 x9 : 0000000000000002
x8 : 00000000000000b0 x7 : f7f000000446467c x6 : f7f00000032e0c00
x5 : f7f00000032e0c00 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000078 x1 : 0000000000000000 x0 : 0000000000080000
Call trace:
 submit_bio_noacct+0x20/0x500 block/blk-core.c:789 (P)
 submit_bio+0xa8/0x1e0 block/blk-core.c:916
 mpage_bio_submit_read fs/mpage.c:75 [inline]
 do_mpage_readpage+0x2d8/0x6dc fs/mpage.c:296
 mpage_readahead+0xcc/0x164 fs/mpage.c:371
 blkdev_readahead+0x18/0x24 block/fops.c:472
 read_pages+0x70/0x2b8 mm/readahead.c:160
 page_cache_ra_order+0x238/0x400 mm/readahead.c:515
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
Code: aa0003f3 a9025bf5 f9400414 b9401000 (f9400e96) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa0003f3 	mov	x19, x0
   4:	a9025bf5 	stp	x21, x22, [sp, #32]
   8:	f9400414 	ldr	x20, [x0, #8]
   c:	b9401000 	ldr	w0, [x0, #16]
* 10:	f9400e96 	ldr	x22, [x20, #24] <-- trapping instruction


Tested on:

commit:         5bc10186 Merge tag 'pci-v6.15-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cd2374580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb8161d1e10a2d09
dashboard link: https://syzkaller.appspot.com/bug?extid=3291296495fc970e4b1c
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1625a368580000

