Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE074CD37B5
	for <linux-block@archiver.kernel.org>; Sat, 16 Sep 2023 05:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjIPFq3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Sep 2023 01:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjIPFqB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Sep 2023 01:46:01 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45681BDA
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 22:45:54 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3ab27eff294so4694333b6e.2
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 22:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694843154; x=1695447954;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNuaOXSaOO8dIy+6fOQaCbir5/pyuJoNg7bHCoCtKlY=;
        b=c1avfzjuzXHJ8kvTNG6NU6xE4BFLmP0YxRQbgxy4ZghQupk4EvCjOhv+j/uRa+NCg+
         xerOFYIDPgZOExwF8Y6gqAX0qZkJls4s3PVizmCM6RL4DnVltbMwBNqfVIyRuHV96hfn
         YEeDNZQALMbx/k7QQcpQuyMM5qasQYugI/IuT3Zj4VFtTMDbYZ26ie/Tplsc77sPBpTW
         gqyTbgPVrOfniRte7aWXDfaEGKhkgJnsxcymNuUGUkfyB2rjn3TLEc0Lsl+aLSx8F5op
         +V8xGZ+Fwwzekdzx8X2gqq1VdoJDgvIp2Upe6eDB3hYz6e0cV2Ygu6EPMx8UxtR1brWi
         W7Sg==
X-Gm-Message-State: AOJu0YxHOWGkiqXql176Sz2Mb25FW1kBuYSeSgboY5zznlb1wbD+3z72
        lH3V59IItaChybPVVoTJVzalYYqF76iGYn33Vqa340TjU4Oo
X-Google-Smtp-Source: AGHT+IFETru2iM1tpVdN7+01nnxbuisCUwb3WmtisGEGQhE5Xm9TYSudKp5In9ZzfxbPvhxChoc2ecD4jd1SYEHVuaHftdkWRayq
MIME-Version: 1.0
X-Received: by 2002:a05:6808:20a4:b0:3a8:74ff:6c01 with SMTP id
 s36-20020a05680820a400b003a874ff6c01mr1514811oiw.5.1694843153968; Fri, 15 Sep
 2023 22:45:53 -0700 (PDT)
Date:   Fri, 15 Sep 2023 22:45:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002475cc0605736cf8@google.com>
Subject: [syzbot] [block?] INFO: task hung in truncate_inode_pages
From:   syzbot <syzbot+bae3c73c7bf2fe3a740b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0bb80ecc33a8 Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174f44e8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7435f9f9f66fcd9
dashboard link: https://syzkaller.appspot.com/bug?extid=bae3c73c7bf2fe3a740b
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1381f8d8680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1365c2a0680000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-0bb80ecc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa2698d36fcb/vmlinux-0bb80ecc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/077f03e6d621/Image-0bb80ecc.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bae3c73c7bf2fe3a740b@syzkaller.appspotmail.com

INFO: task udevd:3125 blocked for more than 450 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:0     pid:3125  ppid:2924   flags:0x0000000d
Call trace:
 __switch_to+0x1d0/0x348 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xac4/0x2ae4 kernel/sched/core.c:6695
 schedule+0xc8/0x19c kernel/sched/core.c:6771
 io_schedule+0xac/0x114 kernel/sched/core.c:9026
 folio_wait_bit_common+0x2a8/0x6d8 mm/filemap.c:1301
 __folio_lock mm/filemap.c:1629 [inline]
 folio_lock include/linux/pagemap.h:1042 [inline]
 folio_lock include/linux/pagemap.h:1038 [inline]
 __filemap_get_folio+0x418/0x840 mm/filemap.c:1882
 truncate_inode_pages_range+0x270/0xb4c mm/truncate.c:376
 truncate_inode_pages+0x14/0x20 mm/truncate.c:448
 kill_bdev block/bdev.c:76 [inline]
 blkdev_flush_mapping+0x100/0x250 block/bdev.c:630
 blkdev_put_whole+0xd4/0xf0 block/bdev.c:661
 blkdev_put+0x284/0x6a8 block/bdev.c:898
 blkdev_release+0x74/0xa8 block/fops.c:604
 __fput+0x2a8/0x830 fs/file_table.c:384
 ____fput+0x10/0x1c fs/file_table.c:412
 task_work_run+0x124/0x20c kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x75c/0x1ecc kernel/exit.c:874
 do_group_exit+0xa4/0x208 kernel/exit.c:1024
 get_signal+0x19a4/0x1ae8 kernel/signal.c:2892
 do_signal arch/arm64/kernel/signal.c:1249 [inline]
 do_notify_resume+0x480/0x3028 arch/arm64/kernel/signal.c:1302
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:144 [inline]
 el0_svc+0x11c/0x140 arch/arm64/kernel/entry-common.c:679
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
INFO: task syz-executor137:3128 blocked for more than 450 seconds.
      Not tainted 6.6.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor137 state:D stack:0     pid:3128  ppid:3121   flags:0x00000005
Call trace:
 __switch_to+0x1d0/0x348 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xac4/0x2ae4 kernel/sched/core.c:6695
 schedule+0xc8/0x19c kernel/sched/core.c:6771
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6830
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x4e8/0x840 kernel/locking/mutex.c:747
 mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:799
 blkdev_get_by_dev.part.0+0x3ec/0x810 block/bdev.c:786
 blkdev_get_by_dev+0x68/0x7c block/bdev.c:829
 blkdev_open+0xec/0x288 block/fops.c:589
 do_dentry_open+0x4e8/0x1138 fs/open.c:929
 vfs_open+0x90/0xc8 fs/open.c:1063
 do_open fs/namei.c:3639 [inline]
 path_openat+0x1488/0x2058 fs/namei.c:3796
 do_filp_open+0x16c/0x330 fs/namei.c:3823
 do_sys_openat2+0x12c/0x160 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __arm64_sys_openat+0x12c/0x1b8 fs/open.c:1448
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x140 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
INFO: lockdep is turned off.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
