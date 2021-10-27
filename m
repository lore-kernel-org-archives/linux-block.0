Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B6CC433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 01:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26CAD61090
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 01:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbhJ0BeD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 21:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbhJ0BeD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 21:34:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F67C061570;
        Tue, 26 Oct 2021 18:31:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gn3so859712pjb.0;
        Tue, 26 Oct 2021 18:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=0OCOLgtmCD/NdE+8kJJ/QK+G9pULnrjrrJ4hvYar2ro=;
        b=VBi55o3suO2xLEXaU3y9d94WWJbrd5Bqf3HFzGLYnX7SECVIIM2NKOhuCn0M34oYYL
         okFxgtiACCLBNfLtRJpRl7gIIhPGd0Q48jrecTbXIknRZxzRL1C0TsIvqaUHsg9RRuv8
         1I3r9/P1KXtRozMVqI7tB+OmDr7hZKyN8ulZG5wCXfllQvvbiy/8kGeBKZeNjENk5koT
         DsVMOTwN1sV/HcbqbwN/jSiWWjYHTYgGAzVsAy3/0OgMHQ74LFjp7zTVcU9aG/bn7Lai
         3QCUjvZhT0CXZfZO+l+vVilDZnv2t89rd2+rGIk5OCrjdRtJVfriMxCT9jSy7KWoJ6zj
         d/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0OCOLgtmCD/NdE+8kJJ/QK+G9pULnrjrrJ4hvYar2ro=;
        b=2wSE0Ls/OjMcOfcSxonJBvqUG1DwpgjbZ+ihcIMW+aHFoLJvygmPn71OLr+DH9fjww
         YMSHUx0lFXkha/LnbXsTg9VLplVAmMf1y0QmSrP8BoViPacyxuQZZtGon089Bq4WQrVD
         8jG5HTO91F2aPz14rAFFnZ0wg0ecsdAs8qhuIbKrDBqgF+Wd6h6s4MOnZJ51CJuUCRto
         zYTNOUQvibG9ziPtGT/55519+YQ14IR2gftUpQcIej/B2EJ+GYaF+AGDXX0W+BcTwvuk
         /6tbU0o4kcpIqDv3l5tXP/ZaYZX+RhktWqAY//NlQuZxIHoOa8O9ccj0yjlvicKSQn4X
         +f6w==
X-Gm-Message-State: AOAM532/YQGtS4B0IAZrmvg4xSObvnWFQ+fuGAbTuAMaWbb1NAKx9TKR
        GDju4lWA/oBUz0VkifUaPgakveuUtbVZAY5JALQDIYsoGZFsBgDvSQ==
X-Google-Smtp-Source: ABdhPJyCOR0fFt8b9iY5GYTgtW5fyidzLu46pZqDn5kU45RFKMjOVpxlCnWidxPCWb8e+FXC+SOmbC1gGhvCbyy8GgE=
X-Received: by 2002:a17:90a:6b0b:: with SMTP id v11mr2580195pjj.178.1635298298108;
 Tue, 26 Oct 2021 18:31:38 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 27 Oct 2021 09:31:25 +0800
Message-ID: <CACkBjsY9Ao5Ri2MRoUHjsTPFZ-KN2xU3E6D7FQCmbh7Xy0BqyA@mail.gmail.com>
Subject: WARNING in disk_release
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 519d81956ee2 Linux 5.15-rc6
git tree: upstream
console output:
https://drive.google.com/file/d/1657ywLUsQk5HIV6DDfHHJydz_PPTdr6V/view?usp=sharing
kernel config: https://drive.google.com/file/d/12PUnxIM1EPBgW4ZJmI7WJBRaY1lA83an/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1PV2erZe9uWRr7cGc3BLKkwBwaSVjksLc/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1A921cPkylfbW2cYCvbtImODZXd0mbg3l/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

------------[ cut here ]------------
WARNING: CPU: 0 PID: 32158 at block/genhd.c:1081
disk_release+0x1c0/0x230 block/genhd.c:1081
Modules linked in:
CPU: 0 PID: 32158 Comm: syz-executor Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:disk_release+0x1c0/0x230 block/genhd.c:1081
Code: 00 00 00 00 fc ff df 48 8d 7b 28 48 89 fa 48 c1 ea 03 80 3c 02
00 75 4e 48 8b 7b 28 5b 5d 41 5c e9 b5 8b ff fd e8 20 2e a5 fd <0f> 0b
e9 06 ff ff ff e8 34 be ec fd e9 2b ff ff ff e8 2a be ec fd
RSP: 0018:ffffc900019efda0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88801a718800 RCX: ffff888113811c80
RDX: 0000000000000000 RSI: ffff888113811c80 RDI: 0000000000000002
RBP: ffff88801a718880 R08: ffffffff83d130a0 R09: ffffed100c7c6542
R10: ffff888063e32a0b R11: ffffed100c7c6541 R12: ffff888103988688
R13: 0000000000000002 R14: ffff8880194fa4d8 R15: ffff888014acee00
FS:  0000555555d8a940(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efdcf048820 CR3: 000000010cd05000 CR4: 0000000000350ee0
Call Trace:
 device_release+0x9f/0x240 drivers/base/core.c:2232
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x530 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3503
 blkdev_close+0x8d/0xb0 block/fops.c:460
 __fput+0x288/0x9f0 fs/file_table.c:280
 task_work_run+0xe0/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x28d/0x2a0 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7efdcefd62cb
Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c
24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 2f 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffdc6a50700 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007ffdc6a50770 RCX: 00007efdcefd62cb
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffdc6a505b0
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000003 R14: 00007ffdc6a507b0 R15: 00007ffdc6a5076c
