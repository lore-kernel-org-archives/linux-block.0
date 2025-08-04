Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5EF2580FB
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310510; cv=none; b=aetKvOnJATGzw8udnqePhPlWKPFyW7NRhfB7lzYniWzUXArQxwnn/41LlVkTBBlnw2QQAghs/rVdALn0sBaVHFy6/LEik21Xm/vhSkmVA/up3wH6pBwTcg9OkAb6ionryKZ8iUjkkV2LXXdcl2B1iqt9+NaYX8LdkjkeQ0ZY5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310510; c=relaxed/simple;
	bh=dg9MHfSL1mqm2jlem/FZ5DA6tExDDneAVHkzXPvORPM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kDzZcoBNX1WOm6DTZxZeZnMdy3PDx1B9xe7Z8kn+8YC10h9ODypbyk3ab+NRuZqv3qkJoOPmyxc5H4DdrMDM83xochuMVzv6SUEPbU0wglhWZSUIgAR600G7FHG/qpnqN02RlEkJ7ry0X9SWdXAwjYQxrmFYc8+K88IqrguRv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e3e69b2951so39290745ab.0
        for <linux-block@vger.kernel.org>; Mon, 04 Aug 2025 05:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310508; x=1754915308;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIv8jQfYkJ/obO9NaYRXD+nFUDYKwhETeJ/3UnKt9RU=;
        b=WnepH7vGabr40uS/qG9tP/BOGNSmB13k3/4uBx6RhweGriciSGjNkhLb8eBT53e4Nn
         L64BBxW6Q/y/5t283CDqjJbOx2d5mivjGcjukpONoyeugxUzgbtZCkqcfDnEG8CGWBKe
         Qgg7sHWEpsCz2OSwB4qrnEvYBpeRm27h3miSxfWvh/2Ab8yZAzw9vXP8+dAW6Lr7y1u1
         euOFvupsisKi8k6T56jlXTARPdISRs2wjvP4oG3tEimq0xdfw6rEYnehso5sg32H80yb
         X/eQLnVKAQVY1+vpXGkgjKDTu5l0vnaZ8TL0Bcox7LLQq4cdURayaV5ajgKjwGs9T8PF
         C0mw==
X-Forwarded-Encrypted: i=1; AJvYcCXnjKipatXgnGFwrBq0y5dmQY6ulgy8MudBrBTuspcXj7moDkN08y0PYXWHMoQsUfYGTFby3qD+t6XnXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQyTEDgr6JSwxPLdKDnbj7OzuTIQSXOzUpySF4O84j1Tq5xVH2
	Ccwo9gfJyHuycDJBSHkk9Mczvj0to/GdxG4npd8cb1UN2yNSYxrnf2aZGbxaLK20loU1wRtDPoi
	tEI+V++1RyqY0wUnCz8UsrczCGxeAC/5bFDO4J570uByHJXF7LRib5ZhrkZg=
X-Google-Smtp-Source: AGHT+IFFweYJjxxi9b3tNr12OISP41q+OuF27ZU+oPT1vgViH2n67tV75P3e2mxiM9Ogyl2U0s6ESjT6hnz48c9uJwdfmZ541wos
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:370c:b0:3e2:c21d:ea12 with SMTP id
 e9e14a558f8ab-3e415e1a2ffmr150916335ab.7.1754310507813; Mon, 04 Aug 2025
 05:28:27 -0700 (PDT)
Date: Mon, 04 Aug 2025 05:28:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6890a76b.050a0220.7f033.0009.GAE@google.com>
Subject: [syzbot] [block?] INFO: rcu detected stall in blkdev_release (3)
From: syzbot <syzbot+07d6f9c5d7633ed4a5c8@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a6923c06a3b2 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cc9f82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f81cd75c44834c1
dashboard link: https://syzkaller.appspot.com/bug?extid=07d6f9c5d7633ed4a5c8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2a74fc5b80ca/disk-a6923c06.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a2267e0785c/vmlinux-a6923c06.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4dbddcb2f621/bzImage-a6923c06.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07d6f9c5d7633ed4a5c8@syzkaller.appspotmail.com

bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:ee:f7:1c:32:6f, vlan:0)
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6214/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=15065, q=4570 ncpus=2)
task:syz.3.57        state:R  running task     stack:24424 pid:6214  tgid:6206  ppid:5858   task_flags:0x20400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:arch_stack_walk+0x85/0x100 arch/x86/kernel/stacktrace.c:27
Code: c0 74 50 49 8b 8e 98 00 00 00 4c 89 f2 4c 89 fe 48 89 df e8 5d 20 09 00 8b 95 70 ff ff ff 85 d2 75 21 eb 2f 4c 89 ef 41 ff d4 <0f> 1f 00 84 c0 74 22 48 89 df e8 8c ff 08 00 8b 85 70 ff ff ff 85
RSP: 0018:ffffc9000b376ac8 EFLAGS: 00000292
RAX: 0000000000000001 RBX: ffffc9000b376ac8 RCX: ffffc9000b376a1c
RDX: 1ffff9200166ed95 RSI: ffffffff81f4541a RDI: ffffc9000b376b94
RBP: ffffc9000b376b58 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000003b941 R12: ffffffff81a672b0
R13: ffffc9000b376b88 R14: 0000000000000000 R15: ffff8880287c5a00
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:548
 slab_free_hook mm/slub.c:2378 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x15a/0x4d0 mm/slub.c:4782
 mempool_free+0x102/0x710 mm/mempool.c:580
 bio_put_percpu_cache block/bio.c:801 [inline]
 bio_put+0x355/0x5b0 block/bio.c:820
 bio_endio+0x70d/0x850 block/bio.c:1651
 blk_update_request+0x93e/0x15f0 block/blk-mq.c:989
 blk_mq_end_request+0x5b/0x630 block/blk-mq.c:1151
 blk_mq_complete_request block/blk-mq.c:1329 [inline]
 blk_mq_complete_request+0x8b/0xb0 block/blk-mq.c:1326
 nullb_complete_cmd drivers/block/null_blk/main.c:1402 [inline]
 null_handle_cmd drivers/block/null_blk/main.c:1454 [inline]
 null_queue_rq+0xb69/0xfd0 drivers/block/null_blk/main.c:1693
 null_queue_rqs+0xe9/0x2f0 drivers/block/null_blk/main.c:1707
 __blk_mq_flush_list block/blk-mq.c:2828 [inline]
 __blk_mq_flush_list+0x97/0xc0 block/blk-mq.c:2824
 blk_mq_dispatch_queue_requests+0x184/0x7b0 block/blk-mq.c:2873
 blk_mq_flush_plug_list+0x1f2/0x600 block/blk-mq.c:2961
 blk_add_rq_to_plug+0x1ca/0x540 block/blk-mq.c:1390
 blk_mq_submit_bio+0x1a1c/0x2880 block/blk-mq.c:3212
 __submit_bio+0x3cf/0x690 block/blk-core.c:635
 __submit_bio_noacct_mq block/blk-core.c:722 [inline]
 submit_bio_noacct_nocheck+0x660/0xd30 block/blk-core.c:751
 submit_bio_noacct+0xb49/0x1eb0 block/blk-core.c:874
 __block_write_full_folio+0x735/0xe00 fs/buffer.c:1933
 block_write_full_folio+0x341/0x400 fs/buffer.c:2753
 blkdev_writepages+0xb8/0x140 block/fops.c:483
 do_writepages+0x27a/0x600 mm/page-writeback.c:2634
 filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
 filemap_fdatawrite_wbc+0x104/0x160 mm/filemap.c:376
 __filemap_fdatawrite_range+0xb9/0x100 mm/filemap.c:419
 filemap_write_and_wait_range mm/filemap.c:691 [inline]
 filemap_write_and_wait_range+0xa3/0x130 mm/filemap.c:682
 filemap_write_and_wait include/linux/pagemap.h:68 [inline]
 sync_blockdev block/bdev.c:260 [inline]
 sync_blockdev block/bdev.c:256 [inline]
 bdev_release+0x4d3/0x6d0 block/bdev.c:1126
 blkdev_release+0x15/0x20 block/fops.c:699
 __fput+0x3ff/0xb70 fs/file_table.c:468
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 get_signal+0x1d1/0x26d0 kernel/signal.c:2807
 arch_do_signal_or_restart+0x8f/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x3f6/0x490 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9f23f8eb69
RSP: 002b:00007f9f24d3e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: 0000000000c00000 RBX: 00007f9f241b6080 RCX: 00007f9f23f8eb69
RDX: 0000000080000000 RSI: 0000200000000000 RDI: 0000000000000008
RBP: 00007f9f24011df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9f241b6080 R15: 00007ffd71e55dc8
 </TASK>
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:ee:f7:1c:32:6f, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:ee:f7:1c:32:6f, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:ee:f7:1c:32:6f, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:ee:f7:1c:32:6f, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:ee:f7:1c:32:6f, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:ee:f7:1c:32:6f, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:ee:f7:1c:32:6f, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:ee:f7:1c:32:6f, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:ee:f7:1c:32:6f, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:ee:f7:1c:32:6f, vlan:0)


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
