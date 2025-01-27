Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C083A14
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737965422; cv=none; b=pS7U3ZxCQZwyrl1PkNSzCwm7NpHBUD9nfte9f3XzC0QSNdcYafDAphGc87YLRcw5suLNEut7eY1/zRXpzyCNW7fB0INeNIvGJ8pJ+mhBq63yOl63tODkNHCccAddnapn6Lw10jRivKMMc8BO7VsP/13Eqw0jXOET4crnE+ni8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737965422; c=relaxed/simple;
	bh=C9pYneibZk73QXwsLxgnGJEmCvOzSxSCsfcjg8vzRDc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cWY7uwxKxOfXIaWO/RF5st27OO3BA5sFRmBo3ryHs1E+GwCXDD7Z56dp3shSzUP3pZjss1wcxKlLXZEAfU3zfTgQ80ew4lKEFO4ia94FJbz1MTLCh1GqJcDfITBdSLTwcrfSA9jZw/gYs8y8cRF62xkrio4MAP06cgSxe2vcUwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3cdd61a97easo28781095ab.2
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 00:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737965420; x=1738570220;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KgnREquH1CliVJWJcEuukeDspVYHbC6xD5uVKynzhDg=;
        b=h2wEheNBxhgn3tPVwI58BZsEhuLixC0uqwaSpXHBkex3mjFWxgMHN8O5NAuDMz8lRv
         9VqIKGk6Wm7wxtYRG/X55RRD4yoZ4qQluM+cue1RSjGG7VKvh/qIy6F5Jm9cBeF5d1oR
         0BU8pdbXBX7evJXhuinTIAZdXrUyjE5Twy0V+xgmfcASAFPF7HqGVtDzPbRAWw2fBdjU
         PSGNoJMq3pFxjtasuS+YdEYSvgN1QIaLf0Qy3gJr+XowZS5VbCDHmJSIdUwTdjMqGaNV
         M5V/aTqtNstDS/o5XbwUmd+IYILWgakZ2pP2mNb+dflUjBoToUdYmFlnEp/b26L5RyBi
         PP9w==
X-Forwarded-Encrypted: i=1; AJvYcCX/lUh3Ga4TY1tMTYYv8siIy7+frpxVHV5iNEE83IXPyrdvdIQvXo2UPQZTqv3UtyktzE9pBVlICMIaLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCOw4RWZL6111cXefhZItAJarFWqymSeH+LrlqUzza/1VdjZ9
	1xOPG/qt8ITo8eR1RjCK4Qq4PMQRrYKGzDdbes+xrMCeAqztmB+qazI2sIPlGDMfrnezvJUiZtb
	2R8qT2rpq68REuLViI3Y1ZFHJTdoeo/K74NBlshjJAA8S3e3/g3b+cUk=
X-Google-Smtp-Source: AGHT+IHvfLxMn1Hi3Hl7dL9ZV+t1d9keLTPMSna1O9XQqsGXtiS9GIjO9wMH3pa11mnWqVv7qbLQ6ot2DIb3TE7cuu7ap0qAXk+w
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1381:b0:3cf:b7c0:8809 with SMTP id
 e9e14a558f8ab-3cfb7c08be4mr160212985ab.8.1737965420388; Mon, 27 Jan 2025
 00:10:20 -0800 (PST)
Date: Mon, 27 Jan 2025 00:10:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67973f6c.050a0220.2eae65.0045.GAE@google.com>
Subject: [syzbot] [block?] KCSAN: data-race in __mod_timer / blk_add_timer (10)
From: syzbot <syzbot+87ab99ec8b81ae79bae2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b9d8a295ed6b Merge tag 'x86_misc_for_v6.14_rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165fe824580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53a413b6b1edf42
dashboard link: https://syzkaller.appspot.com/bug?extid=87ab99ec8b81ae79bae2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5cd1021b471b/disk-b9d8a295.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/034a042761ab/vmlinux-b9d8a295.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c985aefa760/bzImage-b9d8a295.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87ab99ec8b81ae79bae2@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __mod_timer / blk_add_timer

write to 0xffff8881026b9c00 of 8 bytes by task 4008 on cpu 1:
 __mod_timer+0x578/0x7f0 kernel/time/timer.c:1172
 mod_timer+0x1f/0x30 kernel/time/timer.c:1241
 blk_add_timer+0x17e/0x190 block/blk-timeout.c:164
 blk_mq_start_request+0x185/0x3b0 block/blk-mq.c:1351
 scsi_queue_rq+0x14aa/0x1a10 drivers/scsi/scsi_lib.c:1846
 blk_mq_dispatch_rq_list+0x630/0xfa0 block/blk-mq.c:2120
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0x604/0xd50 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0x88/0x120 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x18a/0x230 block/blk-mq.c:2354
 blk_mq_flush_plug_list+0xbd5/0xef0 block/blk-mq.c:2917
 __blk_flush_plug+0x216/0x290 block/blk-core.c:1214
 blk_finish_plug+0x48/0x70 block/blk-core.c:1241
 swap_cluster_readahead+0x342/0x3f0 mm/swap_state.c:698
 swapin_readahead+0xe4/0x6f0 mm/swap_state.c:882
 do_swap_page+0x31b/0x2550 mm/memory.c:4341
 handle_pte_fault mm/memory.c:5804 [inline]
 __handle_mm_fault mm/memory.c:5944 [inline]
 handle_mm_fault+0x8e4/0x2ac0 mm/memory.c:6112
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x296/0x650 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
 __get_user_8+0x18/0x30 arch/x86/lib/getuser.S:98
 fetch_robust_entry kernel/futex/core.c:762 [inline]
 exit_robust_list+0x31/0x280 kernel/futex/core.c:790
 futex_cleanup kernel/futex/core.c:1022 [inline]
 futex_exit_release+0xe3/0x130 kernel/futex/core.c:1123
 exit_mm_release+0x1a/0x30 kernel/fork.c:1655
 exit_mm+0x38/0x190 kernel/exit.c:543
 do_exit+0x559/0x17f0 kernel/exit.c:925
 do_group_exit+0x102/0x150 kernel/exit.c:1087
 get_signal+0xeb9/0x1000 kernel/signal.c:3036
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x62/0x120 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881026b9c00 of 8 bytes by task 4015 on cpu 0:
 blk_add_timer+0x112/0x190
 blk_mq_start_request+0x185/0x3b0 block/blk-mq.c:1351
 scsi_queue_rq+0x14aa/0x1a10 drivers/scsi/scsi_lib.c:1846
 blk_mq_dispatch_rq_list+0x630/0xfa0 block/blk-mq.c:2120
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0x604/0xd50 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0x88/0x120 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x18a/0x230 block/blk-mq.c:2354
 blk_mq_flush_plug_list+0xbd5/0xef0 block/blk-mq.c:2917
 __blk_flush_plug+0x216/0x290 block/blk-core.c:1214
 blk_finish_plug+0x48/0x70 block/blk-core.c:1241
 swap_cluster_readahead+0x342/0x3f0 mm/swap_state.c:698
 swapin_readahead+0xe4/0x6f0 mm/swap_state.c:882
 do_swap_page+0x31b/0x2550 mm/memory.c:4341
 handle_pte_fault mm/memory.c:5804 [inline]
 __handle_mm_fault mm/memory.c:5944 [inline]
 handle_mm_fault+0x8e4/0x2ac0 mm/memory.c:6112
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x296/0x650 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
 __get_user_8+0x18/0x30 arch/x86/lib/getuser.S:98
 fetch_robust_entry kernel/futex/core.c:762 [inline]
 exit_robust_list+0x31/0x280 kernel/futex/core.c:790
 futex_cleanup kernel/futex/core.c:1022 [inline]
 futex_exit_release+0xe3/0x130 kernel/futex/core.c:1123
 exit_mm_release+0x1a/0x30 kernel/fork.c:1655
 exit_mm+0x38/0x190 kernel/exit.c:543
 do_exit+0x559/0x17f0 kernel/exit.c:925
 do_group_exit+0x102/0x150 kernel/exit.c:1087
 get_signal+0xeb9/0x1000 kernel/signal.c:3036
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x62/0x120 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000ffff9e3f -> 0x00000000ffffa0d4

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 4015 Comm: syz.1.204 Not tainted 6.13.0-syzkaller-01005-gb9d8a295ed6b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
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
