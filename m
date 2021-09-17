Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CB4C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Sep 2021 01:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8753B60F25
	for <linux-block@archiver.kernel.org>; Fri, 17 Sep 2021 01:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242199AbhIQBaH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 21:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhIQBaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 21:30:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7EDC061574;
        Thu, 16 Sep 2021 18:28:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c1so4709769pfp.10;
        Thu, 16 Sep 2021 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IW326X16nDke3bjh48Gr8eo8fY7bb4ZE8FAMGjGxs2s=;
        b=ICinTdi/QwxbfCYhYmgNtQqmHQ8reNEBNLl+qtK82WbzVYplwA2Z5IeVymbYkwdYOf
         KvgFk2LbHa7gpq6+l/+3a5QOae5RMYLcEX+4zZ+EvbobSDXPgXCUD/FfmpOQplpAnkNO
         cjQoJgsqPU8XfN8S0ypbT+BvXQL64kACjZ8kJfDXheFIINSq+LuvG0OpES/rSkb4u32W
         T+0R+rPxKLdKOdzTAiXkYgSq8Mxcf6noMrpQfPZ5OaPwxI5OAYAWd99mLiGAlgObj12Z
         MeYNVtsSaVQs09aWT6BIMoL+aDBD1xIkaVpTZ4Pyy7qBGf7IxRpeuZ7FFHjtIMYaLNMy
         01bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IW326X16nDke3bjh48Gr8eo8fY7bb4ZE8FAMGjGxs2s=;
        b=38xNoyN7tT8qH9aI6O4wII4f494GQpg4aUb7covELie4JKPkGayhhfdKte5ZrSZubc
         cXM3GsLYoBVMiLeThFofeCNGOZMsmD/HXKzdNFt+B1E75IjkfsY93p+tlK3dBM87mozT
         SH4VCz42je+VHiTVcUOSYoJbeyGU9VRWbH8PRtPg+5matEJT5LHM3BC9TXjxSlP93t0a
         a5aDnvg9yP0u+FxUsc0Lu2STjRBboJmCfPvp7mcuP/+/9D9tcsVgphdtU5rQVH/WppF9
         uIvZ7XU2x0Cz0sfhPXBjbw50GtJVgRTnmuqJDD8Oi08s3haKdam0+bCmjkb+gWtgkfwL
         rVnQ==
X-Gm-Message-State: AOAM530wfGLtuaXLWHQfuLR2EuE1XiFzwyDntT5focMAXN78yXYXixEW
        6LifJAjUcNFtq/dBeKyZstGFfDFZTvJxvM5WoPWl1g29V3XrQQQ=
X-Google-Smtp-Source: ABdhPJyTKE8KBatvp6pe8Zomn5+TJgE8wNyX6n7usym5uqNknPVe0LjKwYQ0SfhrIFA6WqZMKvDx+BOSLQzMWuqpEs0=
X-Received: by 2002:a63:36c4:: with SMTP id d187mr7567715pga.205.1631842125213;
 Thu, 16 Sep 2021 18:28:45 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 17 Sep 2021 09:28:34 +0800
Message-ID: <CACkBjsYzTQe2LB6WohxYqaFse8+7sovDh87K0ewKa0vrP9StOw@mail.gmail.com>
Subject: WARNING in loop_control_ioctl
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: ff1ffd71d5f0 Merge tag 'hyperv-fixes-signed-20210915
git tree: upstream
console output:
https://drive.google.com/file/d/1cQP1i5Q3j9Pl_AhjWS9smo4hPdvT0psG/view?usp=sharing
kernel config: https://drive.google.com/file/d/1zXpDhs-IdE7tX17B7MhaYP0VGUfP6m9B/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1MScGjVksMYc8ro56o0h26qEgiFMUYhB0/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/10DAS3f9gacZwFY_rWLjNvRt2FqGjODRd/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 3 PID: 7256 Comm: syz-executor Not tainted 5.15.0-rc1+ #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail+0x13c/0x160 lib/fault-inject.c:146
 should_failslab+0x5/0x10 mm/slab_common.c:1328
 slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
 slab_alloc_node mm/slub.c:3120 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 __kernfs_new_node+0x68/0x350 fs/kernfs/dir.c:585
 kernfs_new_node+0x5a/0x90 fs/kernfs/dir.c:647
 __kernfs_create_file+0x56/0x150 fs/kernfs/file.c:985
 sysfs_add_file_mode_ns+0xe6/0x290 fs/sysfs/file.c:317
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x186/0x4e0 fs/sysfs/group.c:149
 internal_create_groups.part.4+0x4d/0xb0 fs/sysfs/group.c:189
 internal_create_groups fs/sysfs/group.c:185 [inline]
 sysfs_create_groups+0x28/0x40 fs/sysfs/group.c:215
 device_add_groups drivers/base/core.c:2438 [inline]
 device_add_attrs drivers/base/core.c:2592 [inline]
 device_add+0x4c3/0xc60 drivers/base/core.c:3310
 device_add_disk+0x178/0x4f0 block/genhd.c:446
 add_disk include/linux/genhd.h:221 [inline]
 loop_add+0x27c/0x3a0 drivers/block/loop.c:2397
 loop_control_ioctl+0x72/0x290 drivers/block/loop.c:2512
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f91b3049c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007f91b3049c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000042
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffeef5d14f0
------------[ cut here ]------------
WARNING: CPU: 3 PID: 7256 at block/genhd.c:537
device_add_disk+0x237/0x4f0 block/genhd.c:537
Modules linked in:
CPU: 3 PID: 7256 Comm: syz-executor Not tainted 5.15.0-rc1+ #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:device_add_disk+0x237/0x4f0 block/genhd.c:537
Code: 00 0f 85 e7 fe ff ff e9 ce fe ff ff e8 12 6e 15 ff 48 89 df e8
4a 35 01 00 81 3b 03 01 00 00 0f 84 b5 fe ff ff e8 f9 6d 15 ff <0f> 0b
bd 01 00 00 00 e9 c5 fe ff ff e8 e8 6d 15 ff 0f 0b bd ea ff
RSP: 0018:ffffc90003e67e70 EFLAGS: 00010216
RAX: 0000000000023106 RBX: ffff8880192b0400 RCX: ffffc90001241000
RDX: 0000000000040000 RSI: ffffffff82222407 RDI: ffffffff853cbf06
RBP: 00000000fffffff4 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88800d219680
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88800d2196c0
FS:  00007f91b304a700(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efde803d148 CR3: 0000000018ef7000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
 loop_control_ioctl+0x72/0x290 drivers/block/loop.c:2512
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
 entry_SYSCALL_64_after_hwframe+0x44/0xae
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007f91b3049c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000042
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffeef5d14f0
----------------
Code disassembly (best guess):
   0: f7 d8                neg    %eax
   2: 64 89 02              mov    %eax,%fs:(%rdx)
   5: b8 ff ff ff ff        mov    $0xffffffff,%eax
   a: c3                    retq
   b: 66 0f 1f 44 00 00    nopw   0x0(%rax,%rax,1)
  11: 48 89 f8              mov    %rdi,%rax
  14: 48 89 f7              mov    %rsi,%rdi
  17: 48 89 d6              mov    %rdx,%rsi
  1a: 48 89 ca              mov    %rcx,%rdx
  1d: 4d 89 c2              mov    %r8,%r10
  20: 4d 89 c8              mov    %r9,%r8
  23: 4c 8b 4c 24 08        mov    0x8(%rsp),%r9
  28: 0f 05                syscall
* 2a: 48 3d 01 f0 ff ff    cmp    $0xfffffffffffff001,%rax <--
trapping instruction
  30: 73 01                jae    0x33
  32: c3                    retq
  33: 48 c7 c1 bc ff ff ff mov    $0xffffffffffffffbc,%rcx
  3a: f7 d8                neg    %eax
  3c: 64 89 01              mov    %eax,%fs:(%rcx)
  3f: 48                    rex.W
