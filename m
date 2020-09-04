Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ECDC433E2
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 05:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3635120748
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 05:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIDFsW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:48:22 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:39396 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIDFsU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Sep 2020 01:48:20 -0400
Received: by mail-il1-f197.google.com with SMTP id o1so4078261ilk.6
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 22:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=adSaErrS+NJDZ1sWGnEkBTMPxTpUC1WocPpkg5ogTnk=;
        b=chZO1vkVHbm8aLbE3MQtZf2uFQdlcRmadJrMQ6W73kYTtvfjjLrCl4G3wmQXfxFOR7
         xbYp0fG1xwqSSPOc+TESItz7d0S8OUS6rb7msFwj5gaqE6XdNkVCQwaes02Ul+vpCfV6
         TrKjzH/3CZRQ40ltGt1h9BeEpmJJL1NGQ1mbu2DrJI3snqrA3gt0A0K8YaqTnlfQCOi1
         HO7IAZV0ZSqlPEOt5UtwQjTOhGbSOpoRCpj3WbnPRKsIj9KzB4f8a+YCJlQfkRp6wwrn
         Y0oqtBR/GyN04+Oht1KEJy6EyYNIRVA7neqXqAYjpuXhQ21k4Hkyw2Go5AseL7FQHtMu
         sA5w==
X-Gm-Message-State: AOAM530VtIY2OtVcA3IChjxFO8Kgwu+ivzyhlqa7xYxRMre+739tT68l
        AdGjBEBArAZxVGgvYTc1Ns2tt/SWrtPSiCshlZkp74hWFFPG
X-Google-Smtp-Source: ABdhPJzyUvGdhVGGYWRgQ83jR0N7k+odBtrWn5pX3Pdq4vlCdraGt8u1ZVFoefVHVT6vT2KSCleT0/SItSm+1Fev8iqBUPsbS5MZ
MIME-Version: 1.0
X-Received: by 2002:a92:ce44:: with SMTP id a4mr5797266ilr.240.1599198499477;
 Thu, 03 Sep 2020 22:48:19 -0700 (PDT)
Date:   Thu, 03 Sep 2020 22:48:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ca0e105ae766a11@google.com>
Subject: KASAN: null-ptr-deref Read in percpu_ref_exit
From:   syzbot <syzbot+4264ecfcf0f27a5e4180@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7a695657 Add linux-next specific files for 20200903
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ac984e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39134fcec6c78e33
dashboard link: https://syzkaller.appspot.com/bug?extid=4264ecfcf0f27a5e4180
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13709f15900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147047e9900000

The issue was bisected to:

commit d0c567d60f3730b97050347ea806e1ee06445c78
Author: Ming Lei <ming.lei@redhat.com>
Date:   Wed Sep 2 12:26:42 2020 +0000

    percpu_ref: reduce memory footprint of percpu_ref in fast path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ed5a95900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=141d5a95900000
console output: https://syzkaller.appspot.com/x/log.txt?x=101d5a95900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4264ecfcf0f27a5e4180@syzkaller.appspotmail.com
Fixes: d0c567d60f37 ("percpu_ref: reduce memory footprint of percpu_ref in fast path")

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
BUG: KASAN: null-ptr-deref in atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
BUG: KASAN: null-ptr-deref in percpu_ref_exit+0x102/0x1f0 lib/percpu-refcount.c:136
Read of size 8 at addr 0000000000000000 by task syz-executor932/7175

CPU: 0 PID: 7175 Comm: syz-executor932 Not tainted 5.9.0-rc3-next-20200903-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:517 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
 atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
 percpu_ref_exit+0x102/0x1f0 lib/percpu-refcount.c:136
 hd_free_part block/partitions/../blk.h:391 [inline]
 part_release+0x9d/0xc0 block/partitions/core.c:262
 device_release+0x9f/0x240 drivers/base/core.c:1802
 kobject_cleanup lib/kobject.c:708 [inline]
 kobject_release lib/kobject.c:739 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x171/0x270 lib/kobject.c:756
 put_device+0x1b/0x30 drivers/base/core.c:3031
 add_partition+0x648/0xb00 block/partitions/core.c:493
 blk_add_partition block/partitions/core.c:685 [inline]
 blk_add_partitions+0x9db/0xe00 block/partitions/core.c:761
 bdev_disk_changed+0x208/0x390 fs/block_dev.c:1417
 loop_reread_partitions+0x29/0x50 drivers/block/loop.c:658
 loop_set_status+0x6da/0x1010 drivers/block/loop.c:1427
 loop_set_status64 drivers/block/loop.c:1547 [inline]
 lo_ioctl+0x900/0x1690 drivers/block/loop.c:1715
 __blkdev_driver_ioctl block/ioctl.c:224 [inline]
 blkdev_ioctl+0x28c/0x700 block/ioctl.c:620
 block_ioctl+0xf9/0x140 fs/block_dev.c:1870
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446c27
Code: 48 83 c4 08 48 89 d8 5b 5d c3 66 0f 1f 84 00 00 00 00 00 48 89 e8 48 f7 d8 48 39 c3 0f 92 c0 eb 92 66 90 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 6d 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb6aa64db48 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000446c27
RDX: 00007fb6aa64dbe0 RSI: 0000000000004c04 RDI: 0000000000000004
RBP: 00000000200158a8 R08: fe03f80fe03f80ff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fb6aa64e6d0
R13: 0000000000000003 R14: 0000000000000003 R15: 000a00d800050102
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
