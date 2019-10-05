Return-Path: <SRS0=Yov/=X6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C36C47404
	for <linux-block@archiver.kernel.org>; Sat,  5 Oct 2019 06:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9769E222C0
	for <linux-block@archiver.kernel.org>; Sat,  5 Oct 2019 06:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfJEGJI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Oct 2019 02:09:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54192 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfJEGJI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Oct 2019 02:09:08 -0400
Received: by mail-io1-f69.google.com with SMTP id w8so17042349iol.20
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2019 23:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dkLn/xQvQAJMh5x3Vm+ElyVLpeqAPCXNqivf0CCkq/w=;
        b=Sn6+OPl97pFLJMY3kM34VwlaB9Y7NdPDavwPMZg0VxSqQnc+RGrq/o0IQYLITVWDBS
         RJcWDX+u/Xk87Q7O6Qu+oJTyJahBnx71vUVXI4suhnNTuBpdyo1iAPOsEWSwfz6KDaLe
         G3IR9zUGLn+TgNFaVEdYJB2iOLiAcbNyMEpoeHcqEemNo5m8CxkxjSh4ImnyIWxe/eZ6
         h+GHF9m225+aCMC4ZanwgbtaxslOjSLejwrhmnjrTJwr7KvzxF6JurAGSKhmvMWcqrt1
         DifXF0Qos6YLorY/U9pE9VuGh60llnZWtrR27NWBahnjRtT35o2UE2IYT49XAe6KLzA8
         5V1g==
X-Gm-Message-State: APjAAAV0X3YqmjIm0eEccCTXNnd/h++JQFL1A8gVyGt7cpN8sUg60AK1
        +S/ZmWsfekTPllLa+T2Z0NOsrumAsEAkvcdXVxq3TGaYsQJV
X-Google-Smtp-Source: APXvYqwkd4uqkXXH/+v9h2Ickqbdng1y2sNuExip2to8BDg50vXkLdoSbh8PBZitSeQex5S/IeZeR4LiFQXC5uw1zqLXElxQZnzD
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2591:: with SMTP id p17mr15902765ioo.298.1570255747573;
 Fri, 04 Oct 2019 23:09:07 -0700 (PDT)
Date:   Fri, 04 Oct 2019 23:09:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a6fc5059423a8f9@google.com>
Subject: WARNING in __blk_mq_delay_run_hw_queue
From:   syzbot <syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b145b0eb Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146c860d600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ec3be9936e004f6
dashboard link: https://syzkaller.appspot.com/bug?extid=d44e1b26ce5c3e77458d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165fcefb600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162d03db600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com

blk_update_request: I/O error, dev nbd0, sector 4 op 0x0:(READ) flags 0x0  
phys_seg 2 prio class 0
Buffer I/O error on dev nbd0, logical block 2, async page read
Buffer I/O error on dev nbd0, logical block 3, async page read
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2496 at include/linux/cpumask.h:137 cpu_max_bits_warn  
include/linux/cpumask.h:137 [inline]
WARNING: CPU: 0 PID: 2496 at include/linux/cpumask.h:137 cpumask_check  
include/linux/cpumask.h:144 [inline]
WARNING: CPU: 0 PID: 2496 at include/linux/cpumask.h:137 cpumask_check  
include/linux/cpumask.h:142 [inline]
WARNING: CPU: 0 PID: 2496 at include/linux/cpumask.h:137 cpumask_test_cpu  
include/linux/cpumask.h:360 [inline]
WARNING: CPU: 0 PID: 2496 at include/linux/cpumask.h:137  
blk_mq_hctx_next_cpu block/blk-mq.c:1443 [inline]
WARNING: CPU: 0 PID: 2496 at include/linux/cpumask.h:137  
__blk_mq_delay_run_hw_queue+0x498/0x600 block/blk-mq.c:1479
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 2496 Comm: kworker/0:1H Not tainted 5.4.0-rc1+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: kblockd blk_mq_requeue_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:220
  __warn.cold+0x2f/0x3c kernel/panic.c:581
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:137 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:144 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:142 [inline]
RIP: 0010:cpumask_test_cpu include/linux/cpumask.h:360 [inline]
RIP: 0010:blk_mq_hctx_next_cpu block/blk-mq.c:1443 [inline]
RIP: 0010:__blk_mq_delay_run_hw_queue+0x498/0x600 block/blk-mq.c:1479
Code: 01 00 00 41 c7 84 24 24 01 00 00 01 00 00 00 41 bd 40 00 00 00 e9 ab  
fe ff ff 41 bd 40 00 00 00 e9 a0 fe ff ff e8 48 68 41 fe <0f> 0b e9 50 fd  
ff ff e8 3c 68 41 fe 48 c7 c2 40 b9 c5 89 4c 89 fe
RSP: 0018:ffff8880a3287b18 EFLAGS: 00010293
RAX: ffff8880a32720c0 RBX: 0000000000000040 RCX: ffffffff8331a7e6
RDX: 0000000000000000 RSI: ffffffff8331aa98 RDI: 0000000000000005
RBP: ffff8880a3287b58 R08: ffff8880a32720c0 R09: ffffed101141a05a
R10: ffffed101141a059 R11: ffff88808a0d02cf R12: ffff88808a0d0280
R13: 0000000000000040 R14: ffff88808a0d03a4 R15: 0000000000000000
  blk_mq_run_hw_queue+0x19d/0x350 block/blk-mq.c:1508
  blk_mq_run_hw_queues+0x112/0x1a0 block/blk-mq.c:1525
  blk_mq_requeue_work+0x502/0x780 block/blk-mq.c:775
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
