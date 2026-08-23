Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BB2E2840
	for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787492019; cv=none; b=GJiTXOmJeKI7EQ8buBhX25PPDCZVXG6BXJAticRvdT6TZOxbfRrQqSVYQaTX/NKDLyhV35H0sJOL+XmVr2SZ0x0tpG8kFohgzv0/iMVwtqPj3/tuq2LCa7rLaa2AkrRH/mjSNws0f70W46M5P+ecbizTExX3/ypahqq//zYwVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787492019; c=relaxed/simple;
	bh=vuDsZ58m7adwJlb7O8pPJtCDIIe1SXmOdSl2YM5c37M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=arj++efA5U3YZuBDpFMt/v03E/fQBLPerRObJkx7Ig+IM9p1WAdf6x8+PddW0JKCfHbf+uKbFcn5NZcyzM+0S6S3IKFpY3zG9IuFdQ0X/yyIgILkznQAI1p4QAYK0xvSj7sN7T4EvmvRp0c1MUmEWJM9xGnL/8QNUy7KisA/vVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-495f936d5ecso919883b6e.0
        for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 06:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787492017; x=1788096817;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMnRxvlSXRGYGo8v3JEBUuAG5Qt2o3NIfRPMNhU2QKk=;
        b=WHrv9X0zctv3B9SJ2BveU2qAJp/hUqyyFejXMDnURqLwyReBGXr8LkpiymOTyDnMWV
         YHGCGkuwP4cS5kj51O4au5QczmSiwuPoOBG3VAmaJ/sS/wgRFTiOYk/ong3BVEhnMFGO
         g9KRXWvDhyWxf3B+etnO6LUOlpefQGoCI2dPuhHkuQID8W729piWZRU7bjASDaFl9f6i
         uJzZImXR266L81IBTZIEogI8eXsbZmt06skVz20eow1YXC1XUzKu3l7nM0UnkI6dd6dG
         z2+GuuQJ0GOAAJ76zAepCFmOqy6CZYLoI+ze7h61zUqwiQwEqpjElTi6TNE/28GHNbYF
         HdOA==
X-Forwarded-Encrypted: i=1; AHgh+RpDiLeqsbQxktBn/D9hEQFAwtv6WDSbSwhZlKiikdzTmVhtVLCUl+n7GwEMoAIHYAnbiQ7s1PCm0wQg2w==@vger.kernel.org
X-Gm-Message-State: AFuF++lbWtbwDlAR7nPpReQXG+svdrP5hcYOCd2d7yaKPSg1DzAB4sPt
	G1rndb/nrqLba3gtjwzLLVTieSHh5CNSBcIfuDp0J85f16ttWxZYIbkZarFOcot8OaBXv4Re5Po
	sVgBJ4w0+Y6sN4ZE8LNEfxKCzl5u6NwNrP0qJoi4+SsoNyjejBws8HBdNm9w=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a07:b0:489:93ff:9ea0 with SMTP id
 5614622812f47-4b3099d26e6mr12179248b6e.2.1787492017181; Sun, 23 Aug 2026
 06:33:37 -0700 (PDT)
Date: Sun, 23 Aug 2026 06:33:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8af6b1.ae6ddae5.3da009.0067.GAE@google.com>
Subject: [syzbot] [block?] [trace?] KASAN: slab-out-of-bounds Read in seq_buf_putmem
From: syzbot <syzbot+f179b16e13624138b0f1@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a4ff2be345d0 Merge tag 'v7.3-p1' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cff815580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=795e664af74a515
dashboard link: https://syzkaller.appspot.com/bug?extid=f179b16e13624138b0f1
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c0b102f1cc94/disk-a4ff2be3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f56c62ae89f0/vmlinux-a4ff2be3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/917b1eb284e1/bzImage-a4ff2be3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f179b16e13624138b0f1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in seq_buf_putmem+0x124/0x180 lib/seq_buf.c:241
Read of size 1352 at addr ffff8880295bdb98 by task syz.2.2551/19243

CPU: 1 UID: 0 PID: 19243 Comm: syz.2.2551 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 seq_buf_putmem+0x124/0x180 lib/seq_buf.c:241
 blk_trace_synthesize_old_trace kernel/trace/blktrace.c:1780 [inline]
 blk_trace_event_print_binary+0x130/0x1b0 kernel/trace/blktrace.c:1788
 tracing_read_pipe+0x568/0xb50 kernel/trace/trace.c:5444
 vfs_read+0x213/0xa80 fs/read_write.c:572
 ksys_read+0x150/0x270 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f32fcb9e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f32fd9ac028 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f32fce25fa0 RCX: 00007f32fcb9e0d9
RDX: 00000000fffffe23 RSI: 0000200000001500 RDI: 0000000000000003
RBP: 00007f32fcc35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f32fce26038 R14: 00007f32fce25fa0 R15: 00007ffe116411a8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880295bd000 pfn:0x295bd
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff8880295bd000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x44dc0(GFP_KERNEL|__GFP_ZERO|__GFP_RETRY_MAYFAIL|__GFP_COMP), pid 16263, tgid 16262 (syz.4.1733), ts 1361028187121, free_ts 1361025032368
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x21fe/0x2270 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 __alloc_pages_noprof+0x10/0x100 mm/page_alloc.c:5338
 __alloc_pages_node_noprof include/linux/gfp.h:291 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:318 [inline]
 alloc_cpu_data kernel/trace/ring_buffer.c:438 [inline]
 __rb_allocate_pages+0xe97/0x17f0 kernel/trace/ring_buffer.c:2496
 ring_buffer_resize+0x51d/0x1670 kernel/trace/ring_buffer.c:3327
 __tracing_resize_ring_buffer+0x9c/0x310 kernel/trace/trace.c:4738
 tracing_set_tracer+0x83/0x790 kernel/trace/trace.c:5014
 tracing_set_trace_write+0x147/0x210 kernel/trace/trace.c:5131
 vfs_write+0x296/0xba0 fs/read_write.c:685
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 23 tgid 23 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0xc22/0xd20 mm/page_alloc.c:2950
 __tlb_remove_table_free mm/mmu_gather.c:228 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:291
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x794/0x10b0 kernel/rcu/tree.c:2897
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1108
 smpboot_thread_fn+0x565/0xa70 kernel/smpboot.c:160
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880295bdf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880295be000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880295be080: 00 00 00 00 00 00 00 00 01 fc fc fc fc fc fc fc
                                           ^
 ffff8880295be100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880295be180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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
