Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBEE3A3E72
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989740; cv=none; b=PeKIGhTN7G08yHWLJ2K2lPHXTEu/hzi5nlZqQGKwpDMbJj7U9CuwYQaplgB9VTsRK6OCPxDVRFXzh7OAjEN18pi9c8sQcGIf+fm/93tOFn5L8jEZe01u3F2/YOVSXj26P9aEz8Z2T9vqOkuj34cI5nSl0goN0NgM9CPMxd47ZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989740; c=relaxed/simple;
	bh=B16T6VYWn55CTHDD5871lwj9QEByd3VO4bR6nH2Leuw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rXnfGqfVfipesEmr1XRm8jrJE33QtUKA6/yfm360jKzOJ7602odCojd4SABegPa5sFXNib+shI6NShyWRUR8046rnQgKLg3Mxax9iWr23Wb7rkIQhUh2fDf0VJeuJWXyKFIBJ1hxJkJyiNy+8ywN4sZr/kqkuvtNduk8sq6FD10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7f4e4b52404so6948789a34.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 14:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788989726; x=1789594526;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C72TfSHoWHn8VitdFGNxau+dEMnVMylbtdpv+64TlXs=;
        b=mcApSksrjsKmep29e/i9xtXQXKOn51T7e7L5CixMBlUhko2NwPXNyayp9HM+FaHNhJ
         LUUHgghTxzuVITGNgc+Jiv8BmrA9ZTgh8VsOS5s7yLTkpleAtC4juT9od1Nm34/opVc9
         OYqSRaBhYVQ+boS4TI7UdvY+C2L+tIn/WNPsKqFWF8qT+FKR5Y1D3QG0Tu58lnRsuGH9
         BrtBS9uOA7DNfQ0S/6VRJlEZZrvnC8O/mHszYGP3wFGpraUgZfAHjB9dFBzamYGrhonE
         hVenHNlle8Bs/TEM0vTh2bE2bmfqFi3w0rTq8xJmXrS+BJaibtPqyylPfaICOUIl8vrY
         1ifQ==
X-Gm-Message-State: AFuF++k71kotcYg/Rf6KeVcd20jTZ43xLh1xaqIIAD/VnX2KSOC8TQqJ
	eoJoyCGkAOqRXTiLHJ4crwCWwRLKnKR2Fu0PhCWk+dJA0fcIO6Hm0B0JkutZKQsL7cF4MvIHIMA
	TodU3dN3ZEaDf8uBtfIB30R/FDATvNzyh7gZOAykENd2ndxOZ10tV5dr0g18=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8187:b0:6b7:46fa:16a6 with SMTP id
 006d021491bc7-6bee7d17888mr2184433eaf.59.1788989726560; Wed, 09 Sep 2026
 14:35:26 -0700 (PDT)
Date: Wed, 09 Sep 2026 14:35:26 -0700
In-Reply-To: <6a9b44e0.a5e650b3.363816.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa1d11e.f81106d8.2ab401.0001.GAE@google.com>
Subject: Re: [syzbot] [block?] BUG: sleeping function called from invalid
 context in null_insert_page
From: syzbot <syzbot+95fdab36405e5ffdb680@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    893e11787f78 Merge tag 'x86_urgent_for_7.3-rc3' of git://g..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17e50925580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=95fdab36405e5ffdb680
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c13749580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95fdab36405e5ffdb680@syzkaller.appspotmail.com

null_blk: disk syzdev created
BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:322
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6031, name: syz-executor254
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
locks held by syz-executor254/6031: 1, last CPU#0:
 #0: ffffffff8edec2e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8edec2e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8edec2e0 (rcu_read_lock){....}-{1:3}, at: blk_mq_dispatch_queue_requests+0x148/0x7c0 block/blk-mq.c:2872
CPU: 0 UID: 0 PID: 6031 Comm: syz-executor254 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 __might_resched.cold+0x1dc/0x222 kernel/sched/core.c:9256
 might_alloc include/linux/sched/mm.h:322 [inline]
 slab_pre_alloc_hook mm/slub.c:4636 [inline]
 slab_alloc_node mm/slub.c:4974 [inline]
 __kmalloc_cache_noprof+0x3e3/0x6d0 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 null_alloc_page drivers/block/null_blk/main.c:878 [inline]
 null_insert_page+0x10b/0x6c0 drivers/block/null_blk/main.c:1027
 copy_to_nullb drivers/block/null_blk/main.c:1165 [inline]
 null_transfer drivers/block/null_blk/main.c:1279 [inline]
 null_handle_data_transfer+0x7df/0xe20 drivers/block/null_blk/main.c:1308
 null_handle_memory_backed drivers/block/null_blk/main.c:1388 [inline]
 null_process_cmd+0x1e3/0x290 drivers/block/null_blk/main.c:1442
 null_handle_cmd drivers/block/null_blk/main.c:1465 [inline]
 null_queue_rq+0x8e4/0xfb0 drivers/block/null_blk/main.c:1711
 null_queue_rqs+0xe9/0x2f0 drivers/block/null_blk/main.c:1725
 __blk_mq_flush_list block/blk-mq.c:2827 [inline]
 __blk_mq_flush_list+0x9a/0xc0 block/blk-mq.c:2823
 blk_mq_dispatch_queue_requests+0x184/0x7c0 block/blk-mq.c:2872
 blk_mq_flush_plug_list+0x1f2/0x600 block/blk-mq.c:2960
 __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1270
 blk_finish_plug+0x5c/0xa0 block/blk-core.c:1297
 blkdev_writepages+0xf6/0x150 block/fops.c:488
 do_writepages+0x278/0x600 mm/page-writeback.c:2560
 filemap_writeback+0x22d/0x2e0 mm/filemap.c:387
 filemap_fdatawrite_range mm/filemap.c:412 [inline]
 file_write_and_wait_range+0xcd/0x140 mm/filemap.c:786
 blkdev_fsync+0x6c/0xd0 block/fops.c:596
 vfs_fsync_range fs/sync.c:186 [inline]
 vfs_fsync fs/sync.c:200 [inline]
 do_fsync+0xbf/0x220 fs/sync.c:211
 __do_sys_fsync fs/sync.c:216 [inline]
 __se_sys_fsync fs/sync.c:214 [inline]
 __x64_sys_fsync+0x32/0x50 fs/sync.c:214
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f756122f3b7
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007fffc74cf400 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
RAX: ffffffffffffffda RBX: 0000555566674400 RCX: 00007f756122f3b7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 000000000000000a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007f756126bae3
R13: 00007fffc74cf450 R14: 00007f7561268060 R15: 00007f7561268140
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
