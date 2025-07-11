Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507722D374C
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240511; cv=none; b=BV7LT4ATRmgdb0lHTAjlKBd/FykZf9k4fS+YYb46BpL6rR1oqHl505OFS0XjRvB8So8XcATs2TFrMeemfCCB/Kpp24CmjE8jtz9E7XcyqORcLIITCE6MFASQ61QrnXhPCnUQPD5pwQUlRckps4YuGgZ84DKWWtxckdFDaq75D5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240511; c=relaxed/simple;
	bh=KS5ocbqX0FF1hnw5J38qYC23heeQPzkvl00k3AEgQDY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QG/sHQ2VFF9c9JKUdED7kQssdhwQBg+rVZ5C8suHnjzTJlQVkXaJxtsTArGnit+VQ/RNKvXm6mVS6e1Z+Wu+IoLVtJwxaCWfJq6IX7CchbIZphEZ4dInaRJZEKlXkBL5zyxaczVFABUNRD4i/R9foK7iCyb1oMVkS21gzEDCicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86cf9bad8e9so213993739f.2
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 06:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240509; x=1752845309;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cc2r00gptjEXB9DYmo8MfLC6dklfFqmtD3BvU6kM+z4=;
        b=CF3DvvlXa0YZvetEaKstEDLDLBRPSIATOiOH0Gmcg7AID2KqD5j1a/LpmXvzwIXBnf
         LbmfuNjbKfUaH1c2TStAi1nihazqDpxnh1DLVQOU6/a6mtFa3goP3c6HAXmLYFlkIx05
         GTqjOSuOxkZZi/78XklbA85Of5FVPeCYkN0RCLC6mL3wg8k4F4NxbtiyYYB7p2a1n1Ms
         1aVXrL6cVJT3Zc0rXimbyXZiA11oJN/m4vhtZBK+l4p7D9ptYn9RI3cllWLdXCIjvisZ
         G1d2/5jKPduw6CQaiLzrV63No8zuWdZ5nmwOiGFJX/JPrIeJTsHoFIkXiFAtoKdPuJT+
         Tq/A==
X-Forwarded-Encrypted: i=1; AJvYcCUd6+3J2Gh22ODSywC/ULLNu51f4vDHQecAqpymM9oCK0G5EtJDqFBMK78EUQb+OlN4Sie9S2PMwWU3Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dbROmJuJmryeAKBBGLgYLA8tRHn42plq6YAu2CeQt8WJuY0I
	xNsD/U8LAl73FaOAb3t+rGZhN7sre4O1Pxj60XZCQv81nOZvYuxEN5oVBC8OAqiIuC3IO3KY6Us
	ENiof4QyMkyTdmx9BhjJwV6W9jX2cp9TKR8oCgOxcQS5U4nQ17E8wkbE/rlc=
X-Google-Smtp-Source: AGHT+IFYNCW/5OElYY9y2/eqJ3+DQrfWRVtd/Oy0Z9jnJes9SVeme26Iyt6q9WGWAASErtvT2vIhlgBoiXOT0fvKc/4+8SyNloh5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d03:b0:86c:cf7e:d85d with SMTP id
 ca18e2360f4ac-8797888c692mr365097639f.12.1752240509314; Fri, 11 Jul 2025
 06:28:29 -0700 (PDT)
Date: Fri, 11 Jul 2025 06:28:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6871117d.a00a0220.26a83e.004c.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in wb_workfn (4)
From: syzbot <syzbot+5b4f4f81240931b16844@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a4128c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f51185bd4f40ad44
dashboard link: https://syzkaller.appspot.com/bug?extid=5b4f4f81240931b16844
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f933e0e4a6c5/disk-d7b8f8e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a82be954c91b/vmlinux-d7b8f8e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66dbc3de1264/bzImage-d7b8f8e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b4f4f81240931b16844@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P49/2:b..l
rcu: 	(detected by 1, t=10503 jiffies, g=31169, q=1383791 ncpus=2)
task:kworker/u8:3    state:R  running task     stack:21880 pid:49    tgid:49    ppid:2      task_flags:0x24208160 flags:0x00004000
Workqueue: writeback wb_workfn (flush-250:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x116a/0x5de0 kernel/sched/core.c:6790
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7113
 irqentry_exit+0x36/0x90 kernel/entry/common.c:307
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_release+0xa/0x2f0 kernel/locking/lockdep.c:5879
Code: 8b 4c 24 18 4c 8b 54 24 10 44 8b 5c 24 0c eb 8c 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 41 55 <41> 54 49 89 f4 53 48 89 fb 48 83 ec 18 65 48 8b 05 f9 07 38 12 48
RSP: 0018:ffffc90000b966d8 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffc90000b96bd0 RCX: ffffc90000b98001
RDX: 0000000000000000 RSI: ffffffff816acad4 RDI: ffffffff8e5c4940
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000000f4f1 R12: ffffc90000b967b8
R13: ffffc90000b96768 R14: ffffc90000b96bd0 R15: ffffc90000b9679c
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0x3f9/0x20a0 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:548
 __call_rcu_common.constprop.0+0xa5/0xa10 kernel/rcu/tree.c:3094
 slab_free_hook mm/slub.c:2345 [inline]
 slab_free mm/slub.c:4643 [inline]
 kmem_cache_free+0x16d/0x4d0 mm/slub.c:4745
 mempool_free+0xe7/0x3b0 mm/mempool.c:548
 bio_put_percpu_cache block/bio.c:801 [inline]
 bio_put+0x355/0x5b0 block/bio.c:820
 bio_endio+0x70a/0x850 block/bio.c:1645
 blk_update_request+0x96b/0x1630 block/blk-mq.c:987
 blk_mq_end_request+0x5b/0x630 block/blk-mq.c:1149
 blk_mq_complete_request block/blk-mq.c:1327 [inline]
 blk_mq_complete_request+0x8b/0xb0 block/blk-mq.c:1324
 nullb_complete_cmd drivers/block/null_blk/main.c:1402 [inline]
 null_handle_cmd drivers/block/null_blk/main.c:1454 [inline]
 null_queue_rq+0xb69/0xfd0 drivers/block/null_blk/main.c:1693
 null_queue_rqs+0xe9/0x2f0 drivers/block/null_blk/main.c:1707
 __blk_mq_flush_list block/blk-mq.c:2826 [inline]
 __blk_mq_flush_list+0x97/0xc0 block/blk-mq.c:2822
 blk_mq_dispatch_queue_requests+0x184/0x7b0 block/blk-mq.c:2871
 blk_mq_flush_plug_list+0x1f2/0x600 block/blk-mq.c:2959
 blk_add_rq_to_plug+0x1ca/0x540 block/blk-mq.c:1388
 blk_mq_submit_bio+0x18d5/0x26a0 block/blk-mq.c:3208
 __submit_bio+0x3cf/0x690 block/blk-core.c:635
 __submit_bio_noacct_mq block/blk-core.c:722 [inline]
 submit_bio_noacct_nocheck+0x660/0xd30 block/blk-core.c:751
 submit_bio_noacct+0x50d/0x1eb0 block/blk-core.c:874
 __block_write_full_folio+0x735/0xe00 fs/buffer.c:1939
 block_write_full_folio+0x341/0x400 fs/buffer.c:2760
 blkdev_writepages+0xb8/0x140 block/fops.c:483
 do_writepages+0x27a/0x600 mm/page-writeback.c:2636
 __writeback_single_inode+0x160/0xfb0 fs/fs-writeback.c:1680
 writeback_sb_inodes+0x601/0xf90 fs/fs-writeback.c:1976
 __writeback_inodes_wb+0xf8/0x2d0 fs/fs-writeback.c:2047
 wb_writeback+0x7f3/0xb70 fs/fs-writeback.c:2158
 wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
 wb_do_writeback fs/fs-writeback.c:2315 [inline]
 wb_workfn+0x8ca/0xbe0 fs/fs-writeback.c:2343
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
