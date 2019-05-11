Return-Path: <SRS0=UHms=TL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CAEC04AB1
	for <linux-block@archiver.kernel.org>; Sat, 11 May 2019 06:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC02217F9
	for <linux-block@archiver.kernel.org>; Sat, 11 May 2019 06:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q19lVkR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfEKG7M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 May 2019 02:59:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46561 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfEKG7M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 May 2019 02:59:12 -0400
Received: by mail-io1-f65.google.com with SMTP id q21so3030823iog.13
        for <linux-block@vger.kernel.org>; Fri, 10 May 2019 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=b2xCFyfKUDgJzoyJULAvSS67YqEu5Mxlcn+7FepU89I=;
        b=Q19lVkR8kd96OjNZAAvx6JHLHtn5CWqueLRPbS+QxrhUB7jtIuC0Cii2X7hZ7M3lkZ
         0PI/TjCF89szM5oejL0Q3g5qlEE6SgZniFDhKGdc5p8qNeJP2fxwUu2D2DUnuZUZmt3a
         QSkJeHO3lSWh8VkTwuJsIwTwGwTyHzx2IDhOCuUgWpt4TNn7a2sUHYMDSw20bb5lOP5I
         6TLnMFWTDyCaWBuycuq/sGocdqCtVoIb2nLlvsERPj5GMqBgXglJl588z0H9aWoul9GD
         6iJu1TN56VPekL+FzCJebDXQD2lC2VSWPXMGqM9VTUumiEK9IUIRFoWVSV4ESCb41tYy
         Bu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=b2xCFyfKUDgJzoyJULAvSS67YqEu5Mxlcn+7FepU89I=;
        b=UkQ1XYZ59KXNpG8a3Kd7HSaY18JYs2++xJKcGZ41qErSuLwJ/amhkLoqUxiAYWGWkD
         Tey3ESnveuq+ZeGHAB2mfVVW0J+687tHSHPvTQ6OJOxdIrSPYE67BbjAXcLk1KPX80v9
         cjCX+55asj/ugeW3j/S+j2PmJEZqEIoWajSsQWSLb8ZrWM/W6z7r4XPn8Mt5y2uWKCdx
         PBnwKl/eMjHgUMubgkVUzB9v1LOtPhBx10heehk8wzNqwwWcULd6VZdufaC1RF8wlveb
         /cjApwXTRGskPcE55+DN8Pz5e1AqA/v1PZbDntwNgvzycPk6/uG9Zb5AAmPHxRxkGf8m
         KVxA==
X-Gm-Message-State: APjAAAW+AeoPcYf3ojTztt0ZDMzF9NpBQ76ONMR+L5BzseTcXj2fqXzs
        VAX+2cEEb86LiHCiDHQakxAnlZSZKAuoeX2n4zPHidIo
X-Google-Smtp-Source: APXvYqyI8sv1HlouWcCDhnAgfKIXbePkIm36N4HfMc+UrOYNcPItNtl/aclXb5kl0XGUiim30GsQb7eU3P8Z6RXL9nU=
X-Received: by 2002:a6b:dc0d:: with SMTP id s13mr8150716ioc.144.1557557950632;
 Fri, 10 May 2019 23:59:10 -0700 (PDT)
MIME-Version: 1.0
From:   Piotr Gabriel Kosinski <pg.kosinski@gmail.com>
Date:   Sat, 11 May 2019 08:58:59 +0200
Message-ID: <CAFMLSdPMbvwoPTEAsgM9CoRzwzCrX1R3EXzWiO1b+9=VsA=UeA@mail.gmail.com>
Subject: md raid hangs when using multi-queue schedulers
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On kernel 5.0.13, when trying to use (newly created) md raid1 arrays
with multi-queue schedulers, a hang always happens (usually within a
few hours) in the kernel.

Initially I assumed that the patch
https://patchwork.kernel.org/patch/10787903/ will fix all the
mq/mdraid related freezes, but they still occur.

I have experienced similar problems on the 4.19 kernels, but I was
able to workaround them using scsi_mod.use_blk_mq=0.

Since kernel 5.0 that is not possible anymore as the single-queue
schedulers have been removed.

Relevant parts of the kernel log:

May 10 17:51:08 server kernel: INFO: task md0_raid1:435 blocked for
more than 120 seconds.
May 10 17:51:08 server kernel:       Not tainted 5.0.13-arch1-1-ARCH #1
May 10 17:51:08 server kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 10 17:51:08 server kernel: md0_raid1       D    0   435      2 0x80000080
May 10 17:51:08 server kernel: Call Trace:
May 10 17:51:08 server kernel:  ? __schedule+0x30b/0x8b0
May 10 17:51:08 server kernel:  ? preempt_count_add+0x79/0xb0
May 10 17:51:08 server kernel:  schedule+0x32/0x80
May 10 17:51:08 server kernel:  md_super_wait+0x69/0xa0 [md_mod]
May 10 17:51:08 server kernel:  ? wait_woken+0x80/0x80
May 10 17:51:08 server kernel:  md_bitmap_wait_writes+0x8e/0xa0 [md_mod]
May 10 17:51:08 server kernel:  md_bitmap_unplug+0xf9/0x110 [md_mod]
May 10 17:51:08 server kernel:  flush_bio_list+0x1e/0xe0 [raid1]
May 10 17:51:08 server kernel:  flush_pending_writes+0x81/0xc0 [raid1]
May 10 17:51:08 server kernel:  raid1d+0xa3/0x12d0 [raid1]
May 10 17:51:08 server kernel:  ? preempt_count_add+0x79/0xb0
May 10 17:51:08 server kernel:  ? _raw_spin_lock_irqsave+0x25/0x50
May 10 17:51:08 server kernel:  ? lock_timer_base+0x67/0x80
May 10 17:51:08 server kernel:  ? _raw_spin_unlock_irqrestore+0x20/0x40
May 10 17:51:08 server kernel:  ? try_to_del_timer_sync+0x4d/0x80
May 10 17:51:08 server kernel:  ? md_register_thread+0xd0/0xd0 [md_mod]
May 10 17:51:08 server kernel:  ? md_thread+0xf9/0x160 [md_mod]
May 10 17:51:08 server kernel:  ? abort_sync_write.isra.5+0x70/0x70 [raid1]
May 10 17:51:08 server kernel:  md_thread+0xf9/0x160 [md_mod]
May 10 17:51:08 server kernel:  ? wait_woken+0x80/0x80
May 10 17:51:08 server kernel:  kthread+0x112/0x130
May 10 17:51:08 server kernel:  ? kthread_park+0x80/0x80
May 10 17:51:08 server kernel:  ret_from_fork+0x35/0x40

May 10 17:51:08 server kernel: INFO: task md0_resync:443 blocked for
more than 120 seconds.
May 10 17:51:08 server kernel:       Not tainted 5.0.13-arch1-1-ARCH #1
May 10 17:51:08 server kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 10 17:51:08 server kernel: md0_resync      D    0   443      2 0x80000080
May 10 17:51:09 server kernel: Call Trace:
May 10 17:51:09 server kernel:  ? __schedule+0x30b/0x8b0
May 10 17:51:09 server kernel:  schedule+0x32/0x80
May 10 17:51:09 server kernel:  raid1_sync_request+0x97f/0xb90 [raid1]
May 10 17:51:09 server kernel:  ? is_mddev_idle+0xbe/0x137 [md_mod]
May 10 17:51:09 server kernel:  ? wait_woken+0x80/0x80
May 10 17:51:09 server kernel:  md_do_sync.cold.53+0x43c/0x98f [md_mod]
May 10 17:51:09 server kernel:  ? 0xffffffff9a000000
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:51:09 server kernel:  ? wait_woken+0x80/0x80
May 10 17:51:09 server kernel:  ? _raw_spin_unlock_irq+0x1d/0x30
May 10 17:51:09 server kernel:  ? md_register_thread+0xd0/0xd0 [md_mod]
May 10 17:51:09 server kernel:  md_thread+0xf9/0x160 [md_mod]
May 10 17:51:09 server kernel:  ? preempt_count_add+0x79/0xb0
May 10 17:51:09 server kernel:  ? _raw_spin_lock_irqsave+0x25/0x50
May 10 17:51:09 server kernel:  ? _raw_spin_unlock_irqrestore+0x20/0x40
May 10 17:51:09 server kernel:  kthread+0x112/0x130
May 10 17:51:09 server kernel:  ? kthread_park+0x80/0x80
May 10 17:51:09 server kernel:  ret_from_fork+0x35/0x40

May 10 17:51:09 server kernel: INFO: task jbd2/md0-8:498 blocked for
more than 120 seconds.
May 10 17:51:09 server kernel:       Not tainted 5.0.13-arch1-1-ARCH #1
May 10 17:51:09 server kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 10 17:51:09 server kernel: jbd2/md0-8      D    0   498      2 0x80000080
May 10 17:51:09 server kernel: Call Trace:
May 10 17:51:09 server kernel:  ? __schedule+0x30b/0x8b0
May 10 17:51:09 server kernel:  ? __wake_up_common_lock+0x89/0xc0
May 10 17:51:09 server kernel:  ? wait_woken+0x80/0x80
May 10 17:51:09 server kernel:  schedule+0x32/0x80
May 10 17:51:09 server kernel:
jbd2_journal_commit_transaction+0x250/0x18c0 [jbd2]
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x40/0x70
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x40/0x70
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x40/0x70
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x40/0x70
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x40/0x70
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:51:09 server kernel:  ? wait_woken+0x80/0x80
May 10 17:51:09 server kernel:  ? preempt_count_add+0x79/0xb0
May 10 17:51:09 server kernel:  ? lock_timer_base+0x67/0x80
May 10 17:51:09 server kernel:  ? _raw_spin_unlock_irqrestore+0x20/0x40
May 10 17:51:09 server kernel:  kjournald2+0xc0/0x270 [jbd2]
May 10 17:51:09 server kernel:  ? __wake_up_common+0x77/0x140
May 10 17:51:09 server kernel:  ? wait_woken+0x80/0x80
May 10 17:51:09 server kernel:  ? commit_timeout+0x10/0x10 [jbd2]
May 10 17:51:09 server kernel:  kthread+0x112/0x130
May 10 17:51:09 server kernel:  ? kthread_park+0x80/0x80
May 10 17:51:09 server kernel:  ret_from_fork+0x35/0x40

May 10 17:51:09 server kernel: INFO: task ext4lazyinit:500 blocked for
more than 120 seconds.
May 10 17:51:09 server kernel:       Not tainted 5.0.13-arch1-1-ARCH #1
May 10 17:51:09 server kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 10 17:51:09 server kernel: ext4lazyinit    D    0   500      2 0x80000080
May 10 17:51:09 server kernel: Call Trace:
May 10 17:51:09 server kernel:  ? __schedule+0x30b/0x8b0
May 10 17:51:09 server kernel:  ? __wake_up_common_lock+0x89/0xc0
May 10 17:51:09 server kernel:  schedule+0x32/0x80
May 10 17:51:09 server kernel:  schedule_timeout+0x311/0x4a0
May 10 17:51:09 server kernel:  ? blk_flush_plug_list+0xb1/0xf0
May 10 17:51:09 server kernel:  io_schedule_timeout+0x19/0x40
May 10 17:51:09 server kernel:  wait_for_common_io.constprop.2+0x9f/0x130
May 10 17:51:09 server kernel:  ? wake_up_q+0x70/0x70
May 10 17:51:09 server kernel:  submit_bio_wait+0x5b/0x80
May 10 17:51:09 server kernel:  blkdev_issue_zeroout+0x142/0x220
May 10 17:51:09 server kernel:  ext4_init_inode_table+0x17d/0x390 [ext4]
May 10 17:51:09 server kernel:  ext4_lazyinit_thread+0x2ae/0x390 [ext4]
May 10 17:51:09 server kernel:  ?
ext4_unregister_li_request.isra.13+0x60/0x60 [ext4]
May 10 17:51:09 server kernel:  kthread+0x112/0x130
May 10 17:51:09 server kernel:  ? kthread_park+0x80/0x80
May 10 17:51:09 server kernel:  ret_from_fork+0x35/0x40

May 10 17:51:09 server kernel: INFO: task rsync:1728 blocked for more
than 120 seconds.
May 10 17:51:09 server kernel:       Not tainted 5.0.13-arch1-1-ARCH #1
May 10 17:51:09 server kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 10 17:51:09 server kernel: rsync           D    0  1728   1727 0x00000080
May 10 17:51:09 server kernel: Call Trace:
May 10 17:51:09 server kernel:  ? __schedule+0x30b/0x8b0
May 10 17:51:09 server kernel:  ? bit_wait+0x50/0x50
May 10 17:51:09 server kernel:  schedule+0x32/0x80
May 10 17:51:09 server kernel:  io_schedule+0x12/0x40
May 10 17:51:09 server kernel:  bit_wait_io+0xd/0x50
May 10 17:51:09 server kernel:  __wait_on_bit_lock+0x5d/0xa0
May 10 17:51:09 server kernel:  out_of_line_wait_on_bit_lock+0x91/0xb0
May 10 17:51:09 server kernel:  ? init_wait_var_entry+0x40/0x40
May 10 17:51:09 server kernel:  do_get_write_access+0x1f6/0x530 [jbd2]
May 10 17:51:09 server kernel:  ? ext4_dirty_inode+0x46/0x60 [ext4]
May 10 17:51:09 server kernel:  jbd2_journal_get_write_access+0x2c/0x50 [jbd2]
May 10 17:51:09 server kernel:  __ext4_journal_get_write_access+0x2c/0x70 [ext4]
May 10 17:51:09 server kernel:  ext4_reserve_inode_write+0x96/0xc0 [ext4]
May 10 17:51:09 server kernel:  ext4_mark_inode_dirty+0x4e/0x1d0 [ext4]
May 10 17:51:09 server kernel:  ext4_dirty_inode+0x46/0x60 [ext4]
May 10 17:51:09 server kernel:  __mark_inode_dirty+0x41/0x3e0
May 10 17:51:09 server kernel:  ext4_setattr+0x380/0xad0 [ext4]
May 10 17:51:09 server kernel:  notify_change+0x269/0x440
May 10 17:51:09 server kernel:  utimes_common.isra.0+0xdf/0x1b0
May 10 17:51:09 server kernel:  do_utimes+0xeb/0x160
May 10 17:51:09 server kernel:  __se_sys_utimensat+0x76/0xc0
May 10 17:51:09 server kernel:  do_syscall_64+0x5b/0x170
May 10 17:51:09 server kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
May 10 17:51:09 server kernel: RIP: 0033:0x7f939757cb43
May 10 17:51:09 server kernel: Code: Bad RIP value.
May 10 17:51:09 server kernel: RSP: 002b:00007ffff78cb998 EFLAGS:
00000206 ORIG_RAX: 0000000000000118
May 10 17:51:09 server kernel: RAX: ffffffffffffffda RBX:
00007ffff78cde50 RCX: 00007f939757cb43
May 10 17:51:09 server kernel: RDX: 00007ffff78cb9a0 RSI:
00007ffff78cde50 RDI: 00000000ffffff9c
May 10 17:51:09 server kernel: RBP: 000000002f5265f0 R08:
0000000000000000 R09: 000055b37a77d7a0
May 10 17:51:09 server kernel: R10: 0000000000000100 R11:
0000000000000206 R12: 00000000000041c0
May 10 17:51:09 server kernel: R13: 00007ffff78cbd20 R14:
000055b37a6a9368 R15: 0000000000000000

May 10 17:51:09 server kernel: INFO: task rsync:1729 blocked for more
than 120 seconds.
May 10 17:51:09 server kernel:       Not tainted 5.0.13-arch1-1-ARCH #1
May 10 17:51:09 server kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 10 17:51:09 server kernel: rsync           D    0  1729   1728 0x00000080
May 10 17:51:09 server kernel: Call Trace:
May 10 17:51:09 server kernel:  ? __schedule+0x30b/0x8b0
May 10 17:51:09 server kernel:  schedule+0x32/0x80
May 10 17:51:09 server kernel:  wait_transaction_locked+0x87/0xc0 [jbd2]
May 10 17:51:09 server kernel:  ? wait_woken+0x80/0x80
May 10 17:51:09 server kernel:  add_transaction_credits+0xd8/0x290 [jbd2]
May 10 17:51:09 server kernel:  ? ext4_dirty_inode+0x46/0x60 [ext4]
May 10 17:51:09 server kernel:  start_this_handle+0x104/0x450 [jbd2]
May 10 17:51:09 server kernel:  ? find_get_entry+0x116/0x180
May 10 17:51:09 server kernel:  jbd2__journal_start+0xd9/0x200 [jbd2]
May 10 17:51:09 server kernel:  ext4_da_write_begin+0x199/0x480 [ext4]
May 10 17:51:09 server kernel:  generic_perform_write+0xb7/0x1c0
May 10 17:51:09 server kernel:  ? file_update_time+0x5e/0x130
May 10 17:51:09 server kernel:  __generic_file_write_iter+0xfa/0x1c0
May 10 17:51:09 server kernel:  ? generic_write_checks+0x4c/0xb0
May 10 17:51:09 server kernel:  ext4_file_write_iter+0xc6/0x3f0 [ext4]
May 10 17:51:09 server kernel:  __vfs_write+0x14d/0x1b0
May 10 17:51:09 server kernel:  vfs_write+0xa9/0x1a0
May 10 17:51:09 server kernel:  ksys_write+0x4f/0xb0
May 10 17:51:09 server kernel:  do_syscall_64+0x5b/0x170
May 10 17:51:09 server kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
May 10 17:51:09 server kernel: RIP: 0033:0x7f9397577cc8
May 10 17:51:09 server kernel: Code: Bad RIP value.
May 10 17:51:09 server kernel: RSP: 002b:00007ffff78cac18 EFLAGS:
00000246 ORIG_RAX: 0000000000000001
May 10 17:51:09 server kernel: RAX: ffffffffffffffda RBX:
0000000000000000 RCX: 00007f9397577cc8
May 10 17:51:09 server kernel: RDX: 0000000000000400 RSI:
000055b379198e50 RDI: 0000000000000001
May 10 17:51:09 server kernel: RBP: 0000000000000400 R08:
0000000000000400 R09: 00000000a2b05d8a
May 10 17:51:09 server kernel: R10: 00000000f5111859 R11:
0000000000000246 R12: 000055b379198e50
May 10 17:51:09 server kernel: R13: 000055b379198e50 R14:
0000000000003400 R15: 0000000000000400

May 10 17:51:09 server kernel: INFO: task kworker/u8:1:21252 blocked
for more than 120 seconds.
May 10 17:51:09 server kernel:       Not tainted 5.0.13-arch1-1-ARCH #1
May 10 17:51:09 server kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 10 17:51:09 server kernel: kworker/u8:1    D    0 21252      2 0x80000080
May 10 17:51:09 server kernel: Workqueue: writeback wb_workfn (flush-9:0)
May 10 17:51:09 server kernel: Call Trace:
May 10 17:51:09 server kernel:  ? __schedule+0x30b/0x8b0
May 10 17:51:09 server kernel:  ? bit_wait+0x50/0x50
May 10 17:51:09 server kernel:  schedule+0x32/0x80
May 10 17:51:09 server kernel:  io_schedule+0x12/0x40
May 10 17:51:09 server kernel:  bit_wait_io+0xd/0x50
May 10 17:51:09 server kernel:  __wait_on_bit_lock+0x5d/0xa0
May 10 17:51:09 server kernel:  out_of_line_wait_on_bit_lock+0x91/0xb0
May 10 17:51:09 server kernel:  ? init_wait_var_entry+0x40/0x40
May 10 17:51:09 server kernel:  do_get_write_access+0x1f6/0x530 [jbd2]
May 10 17:51:09 server kernel:  jbd2_journal_get_write_access+0x2c/0x50 [jbd2]
May 10 17:51:09 server kernel:  __ext4_journal_get_write_access+0x2c/0x70 [ext4]
May 10 17:51:09 server kernel:  ? ext4_read_block_bitmap+0x14/0x50 [ext4]
May 10 17:51:09 server kernel:  ext4_mb_mark_diskspace_used+0x9c/0x490 [ext4]
May 10 17:51:09 server kernel:  ext4_mb_new_blocks+0x2a2/0xb70 [ext4]
May 10 17:51:09 server kernel:  ? __kmalloc+0x188/0x210
May 10 17:51:09 server kernel:  ? ext4_find_extent+0x272/0x300 [ext4]
May 10 17:51:09 server kernel:  ? ext4_find_extent+0x272/0x300 [ext4]
May 10 17:51:09 server kernel:  ext4_ext_map_blocks+0xbd3/0x12b0 [ext4]
May 10 17:51:09 server kernel:  ? nr_free_zone_pages+0x80/0x90
May 10 17:51:09 server kernel:  ext4_map_blocks+0xed/0x5c0 [ext4]
May 10 17:51:09 server kernel:  ext4_writepages+0xa20/0xf50 [ext4]
May 10 17:51:09 server kernel:  ? generic_writepages+0x61/0x90
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x35/0x70
May 10 17:51:09 server kernel:  ? do_writepages+0x41/0xd0
May 10 17:51:09 server kernel:  ? ext4_mark_inode_dirty+0x1d0/0x1d0 [ext4]
May 10 17:51:09 server kernel:  do_writepages+0x41/0xd0
May 10 17:51:09 server kernel:  ? _raw_spin_unlock_irq+0x1d/0x30
May 10 17:51:09 server kernel:  ? finish_task_switch+0x84/0x2d0
May 10 17:51:09 server kernel:  ? __switch_to_asm+0x40/0x70
May 10 17:51:09 server kernel:  ? preempt_count_add+0x79/0xb0
May 10 17:51:09 server kernel:  __writeback_single_inode+0x3d/0x3c0
May 10 17:51:09 server kernel:  ? _raw_spin_lock+0x13/0x30
May 10 17:51:09 server kernel:  writeback_sb_inodes+0x1e8/0x4c0
May 10 17:51:09 server kernel:  __writeback_inodes_wb+0x5d/0xb0
May 10 17:51:09 server kernel:  wb_writeback+0x28f/0x340
May 10 17:51:09 server kernel:  ? 0xffffffff9a000000
May 10 17:51:09 server kernel:  ? cpumask_next+0x16/0x20
May 10 17:51:09 server kernel:  wb_workfn+0x35d/0x430
May 10 17:51:09 server kernel:  process_one_work+0x1eb/0x410
May 10 17:51:09 server kernel:  worker_thread+0x2d/0x3d0
May 10 17:51:09 server kernel:  ? process_one_work+0x410/0x410
May 10 17:51:09 server kernel:  kthread+0x112/0x130
May 10 17:51:09 server kernel:  ? kthread_park+0x80/0x80
May 10 17:51:09 server kernel:  ret_from_fork+0x35/0x40



May 10 17:53:11 server kernel: INFO: task md0_raid1:435 blocked for
more than 120 seconds.
May 10 17:53:11 server kernel:       Not tainted 5.0.13-arch1-1-ARCH #1
May 10 17:53:11 server kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 10 17:53:11 server kernel: md0_raid1       D    0   435      2 0x80000080
May 10 17:53:11 server kernel: Call Trace:
May 10 17:53:11 server kernel:  ? __schedule+0x30b/0x8b0
May 10 17:53:11 server kernel:  ? preempt_count_add+0x79/0xb0
May 10 17:53:11 server kernel:  schedule+0x32/0x80
May 10 17:53:11 server kernel:  md_super_wait+0x69/0xa0 [md_mod]
May 10 17:53:11 server kernel:  ? wait_woken+0x80/0x80
May 10 17:53:11 server kernel:  md_bitmap_wait_writes+0x8e/0xa0 [md_mod]
May 10 17:53:11 server kernel:  md_bitmap_unplug+0xf9/0x110 [md_mod]
May 10 17:53:11 server kernel:  flush_bio_list+0x1e/0xe0 [raid1]
May 10 17:53:11 server kernel:  flush_pending_writes+0x81/0xc0 [raid1]
May 10 17:53:11 server kernel:  raid1d+0xa3/0x12d0 [raid1]
May 10 17:53:11 server kernel:  ? preempt_count_add+0x79/0xb0
May 10 17:53:11 server kernel:  ? _raw_spin_lock_irqsave+0x25/0x50
May 10 17:53:11 server kernel:  ? lock_timer_base+0x67/0x80
May 10 17:53:11 server kernel:  ? _raw_spin_unlock_irqrestore+0x20/0x40
May 10 17:53:11 server kernel:  ? try_to_del_timer_sync+0x4d/0x80
May 10 17:53:11 server kernel:  ? md_register_thread+0xd0/0xd0 [md_mod]
May 10 17:53:11 server kernel:  ? md_thread+0xf9/0x160 [md_mod]
May 10 17:53:11 server kernel:  ? abort_sync_write.isra.5+0x70/0x70 [raid1]
May 10 17:53:11 server kernel:  md_thread+0xf9/0x160 [md_mod]
May 10 17:53:11 server kernel:  ? wait_woken+0x80/0x80
May 10 17:53:11 server kernel:  kthread+0x112/0x130
May 10 17:53:11 server kernel:  ? kthread_park+0x80/0x80
May 10 17:53:11 server kernel:  ret_from_fork+0x35/0x40

May 10 17:53:11 server kernel: INFO: task md0_resync:443 blocked for
more than 120 seconds.
May 10 17:53:11 server kernel:       Not tainted 5.0.13-arch1-1-ARCH #1
May 10 17:53:11 server kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 10 17:53:11 server kernel: md0_resync      D    0   443      2 0x80000080
May 10 17:53:11 server kernel: Call Trace:
May 10 17:53:11 server kernel:  ? __schedule+0x30b/0x8b0
May 10 17:53:11 server kernel:  schedule+0x32/0x80
May 10 17:53:11 server kernel:  raid1_sync_request+0x97f/0xb90 [raid1]
May 10 17:53:11 server kernel:  ? is_mddev_idle+0xbe/0x137 [md_mod]
May 10 17:53:11 server kernel:  ? wait_woken+0x80/0x80
May 10 17:53:11 server kernel:  md_do_sync.cold.53+0x43c/0x98f [md_mod]
May 10 17:53:11 server kernel:  ? 0xffffffff9a000000
May 10 17:53:11 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:53:11 server kernel:  ? wait_woken+0x80/0x80
May 10 17:53:11 server kernel:  ? _raw_spin_unlock_irq+0x1d/0x30
May 10 17:53:11 server kernel:  ? md_register_thread+0xd0/0xd0 [md_mod]
May 10 17:53:11 server kernel:  md_thread+0xf9/0x160 [md_mod]
May 10 17:53:11 server kernel:  ? preempt_count_add+0x79/0xb0
May 10 17:53:11 server kernel:  ? _raw_spin_lock_irqsave+0x25/0x50
May 10 17:53:11 server kernel:  ? _raw_spin_unlock_irqrestore+0x20/0x40
May 10 17:53:11 server kernel:  kthread+0x112/0x130
May 10 17:53:11 server kernel:  ? kthread_park+0x80/0x80
May 10 17:53:11 server kernel:  ret_from_fork+0x35/0x40

May 10 17:53:11 server kernel: INFO: task jbd2/md0-8:498 blocked for
more than 120 seconds.
May 10 17:53:11 server kernel:       Not tainted 5.0.13-arch1-1-ARCH #1
May 10 17:53:11 server kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 10 17:53:11 server kernel: jbd2/md0-8      D    0   498      2 0x80000080
May 10 17:53:11 server kernel: Call Trace:
May 10 17:53:11 server kernel:  ? __schedule+0x30b/0x8b0
May 10 17:53:11 server kernel:  ? __wake_up_common_lock+0x89/0xc0
May 10 17:53:11 server kernel:  ? wait_woken+0x80/0x80
May 10 17:53:11 server kernel:  schedule+0x32/0x80
May 10 17:53:11 server kernel:
jbd2_journal_commit_transaction+0x250/0x18c0 [jbd2]
May 10 17:53:11 server kernel:  ? __switch_to_asm+0x40/0x70
May 10 17:53:11 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:53:11 server kernel:  ? __switch_to_asm+0x40/0x70
May 10 17:53:11 server kernel:  ? __switch_to_asm+0x40/0x70
May 10 17:53:11 server kernel:  ? __switch_to_asm+0x40/0x70
May 10 17:53:11 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:53:11 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:53:11 server kernel:  ? __switch_to_asm+0x40/0x70
May 10 17:53:11 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:53:11 server kernel:  ? __switch_to_asm+0x34/0x70
May 10 17:53:11 server kernel:  ? wait_woken+0x80/0x80
May 10 17:53:11 server kernel:  ? preempt_count_add+0x79/0xb0
May 10 17:53:11 server kernel:  ? lock_timer_base+0x67/0x80
May 10 17:53:11 server kernel:  ? _raw_spin_unlock_irqrestore+0x20/0x40
May 10 17:53:11 server kernel:  kjournald2+0xc0/0x270 [jbd2]
May 10 17:53:11 server kernel:  ? __wake_up_common+0x77/0x140
May 10 17:53:11 server kernel:  ? wait_woken+0x80/0x80
May 10 17:53:11 server kernel:  ? commit_timeout+0x10/0x10 [jbd2]
May 10 17:53:11 server kernel:  kthread+0x112/0x130
May 10 17:53:11 server kernel:  ? kthread_park+0x80/0x80
May 10 17:53:11 server kernel:  ret_from_fork+0x35/0x40
