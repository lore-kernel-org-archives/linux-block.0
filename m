Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC655C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 07:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D9B60E0B
	for <linux-block@archiver.kernel.org>; Fri,  3 Sep 2021 07:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhICHiD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbhICHiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 03:38:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AEBC061575;
        Fri,  3 Sep 2021 00:37:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso3338168pjb.3;
        Fri, 03 Sep 2021 00:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FKvnkYvCCV9yybeFJ+/WkttMSAftWgrhCoPh7G7odr0=;
        b=aYrKPW6qNSFPaFNpkVKwOlb4QB+sg685XkMN+79F/Pwl7dK3Fct3zpubwjDfJWzC9l
         T2k9GMmxiVG6o1hkV6EjWjdcR3HuHQ+JHvFGIR4Pq/KRXNz2G4Lv5R8q/DP32sVRVOt2
         SrkOPdJXFfnqs0Lxnsxs6mSObay6kFc8Oq0FCqWGspvhbIrLUB0u820Zk49MhYYOLF3k
         vGjaVkkfEfyZD78lGPiBmr7WLt9Si1+Sac9Kb/cK/YRRL0jf8HgpEzRAq4SeERTbFvNN
         NMMYt//CkCT4wP8RnGUb3emyXWr58O9tZly0zBbvxXaglVlQvoIhML5tRcdgPyPY4aGa
         h1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FKvnkYvCCV9yybeFJ+/WkttMSAftWgrhCoPh7G7odr0=;
        b=iiXh/7kx4KaQwD2VbapG0el5yBs7CrRvo2kLE9kBHvi/fo+cidkTGk5mhE9RpigleG
         4iEjQZG8+km/px1TLbwhUPuLk4VGuS1Bsx1HR5+TziSQI/qNKYojDz4w6Pi0NaueqhRm
         2Kd7pxlsIK9eApb9pA/NHQe3IDnSMAuidnEubAfseeO5jXO9Zi9qfZ5B7MS62DQKlgD/
         5K5Bf+9YqRrh6FlHtNJkMcgLe32ThPMvyx6DTuGtrz7vnwFT1quQp1STuxxGTPDMCqmG
         5s+HZhEGIp4A8cSKofWAJUDNMdtwKMadn6ZBYio0desI+PA3cegmfRNP/NaQOuRF+j9b
         vX6w==
X-Gm-Message-State: AOAM532q3+OiB7rOnvzisBzoQ1BCzywMKZzyUUAyMxksJlSNVP4b1une
        n8myI7s94uJ+bcgd6KAzwJtWD1/9PiGZBHlxU+ECBOXflAKXVO4=
X-Google-Smtp-Source: ABdhPJxcnc4+K6XEzc9rDAJCpy1vOBfHt7N0POPmHwv3kSz7dLrJiSOY9BbHSrU3PjOPPq1UpzmdXrHZuNmyd+pREak=
X-Received: by 2002:a17:902:e5c1:b0:138:bac2:6163 with SMTP id
 u1-20020a170902e5c100b00138bac26163mr2109338plf.63.1630654622809; Fri, 03 Sep
 2021 00:37:02 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 3 Sep 2021 15:36:51 +0800
Message-ID: <CACkBjsabd_SguR27OoZH85SbN7gRFcxTYK+POyHSn9xrzZ9fOA@mail.gmail.com>
Subject: WARNING in loop_add
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 7d2a07b76933 Linux 5.14
git tree: upstream
console output:
https://drive.google.com/file/d/1lL94fy2uAtUMlfTnDDI6ooGLUGGvlDwl/view?usp=sharing
kernel config: https://drive.google.com/file/d/1XD9WYDViQLSXN7RGwH8AGGDvP9JvOghx/view?usp=sharing
C reproducer: https://drive.google.com/file/d/12LXTfEg30h-Y6s5smCLIP7Jtr3g6PFOK/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1mUCxjzeD5w2bOjuw80srDBwpCh0zSpdW/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

oop4: detected capacity change from 0 to 20480
ISOFS: Unable to identify CD-ROM format.
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 10131 Comm: syz-executor Not tainted 5.14.0 #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:105
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail.cold+0x5/0xa lib/fault-inject.c:146
 should_failslab+0x5/0x10 mm/slab_common.c:1326
 slab_pre_alloc_hook mm/slab.h:494 [inline]
 slab_alloc_node mm/slub.c:2880 [inline]
 slab_alloc mm/slub.c:2967 [inline]
 kmem_cache_alloc_trace+0x62/0x350 mm/slub.c:2984
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 device_create_groups_vargs+0x8a/0x280 drivers/base/core.c:3996
 device_create+0xdf/0x120 drivers/base/core.c:4056
 bdi_register_va.part.0+0x9c/0x800 mm/backing-dev.c:871
 bdi_register_va mm/backing-dev.c:906 [inline]
 bdi_register+0x12a/0x140 mm/backing-dev.c:903
 __device_add_disk+0x923/0xd10 block/genhd.c:521
 add_disk include/linux/genhd.h:217 [inline]
 loop_add+0x6ec/0x8c0 drivers/block/loop.c:2395
 loop_control_ioctl+0x130/0x3c0 drivers/block/loop.c:2492
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6e331da198 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 00000000004739cd
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007f6e331da1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000030
R13: 00007ffe496b21bf R14: 00007ffe496b2360 R15: 00007f6e331da300
------------[ cut here ]------------
WARNING: CPU: 1 PID: 10131 at block/genhd.c:523
__device_add_disk+0xba9/0xd10 block/genhd.c:523
Modules linked in:
CPU: 1 PID: 10131 Comm: syz-executor Not tainted 5.14.0 #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__device_add_disk+0xba9/0xd10 block/genhd.c:523
Code: fd ff ff 4c 89 ef 89 44 24 28 e8 22 a5 f3 fd 8b 44 24 28 e9 6f
fd ff ff 4c 89 ef e8 a1 a4 f3 fd e9 d5 fd ff ff e8 f7 b6 ac fd <0f> 0b
e9 8c fd ff ff 48 8b 7c 24 08 e8 96 a4 f3 fd e9 0a f6 ff ff
RSP: 0018:ffffc90006527dc0 EFLAGS: 00010216
RAX: 0000000000027667 RBX: ffff888107d54ec0 RCX: 0000000000040000
RDX: ffffc90000889000 RSI: ffff888104715640 RDI: 0000000000000002
RBP: ffff888110beb400 R08: ffffffff83c84189 R09: 0000000000000000
R10: 0000000000000005 R11: fffffbfff17578ea R12: 0000000000000001
R13: ffff888107d5539c R14: ffff888110beb4a0 R15: 0000000000000000
FS:  00007f6e331da700(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005572256db150 CR3: 0000000104b9f006 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 add_disk include/linux/genhd.h:217 [inline]
 loop_add+0x6ec/0x8c0 drivers/block/loop.c:2395
 loop_control_ioctl+0x130/0x3c0 drivers/block/loop.c:2492
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6e331da198 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 00000000004739cd
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007f6e331da1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000030
R13: 00007ffe496b21bf R14: 00007ffe496b2360 R15: 00007f6e331da300
