Return-Path: <SRS0=EAuX=OL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A425C64EB4
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 02:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E380F2081C
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 02:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E380F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725759AbeLBN1A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:27:00 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:37149 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeLBN1A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 08:27:00 -0500
Received: by mail-io1-f72.google.com with SMTP id d63so10391302iog.4
        for <linux-block@vger.kernel.org>; Sat, 01 Dec 2018 18:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LINITKU8wtxfed/nAUhJDbpO45KO4FFUqwUKZ0LL3S4=;
        b=TTWhvtdz96r150yz6WSJ76bVXdwFimJNlCWYj69bJKdaDPV81BzBQsEh2+tXgKzqvf
         BU+WxkhMUh3uuDf7W0eWZe/lDYWRbGF+fAx/LzYAUfB6c7cjG9Vy+jhJ8ftOC45RTorj
         yE4X3VNNwhNO6CdnMiCi+tisTAAEsULlzrzhEVWpYR0aOI3tFtXhMcmdJaOQy4gChL/P
         fLpeRzAuvXydGISotCoJx1b9ILbw2/qL0pmAii+6Q5hml+dnKnraw+apfLw0lkascuOF
         a/vztfogIxv9te1iQu6FwCBx+k3IpFxu3nGNhhQr0jbOOwIJfyt/kNZVdgRHklISVvi2
         9aDw==
X-Gm-Message-State: AA+aEWY7dJHl01WwC8Wy6anmK3DuZlqHgcQG04s97wZIwCefmau00MZ4
        FqboHygUS69DrcHJ9dDnu1bmJcW1DFDdXOnr7iTgdLEGLqzk
X-Google-Smtp-Source: AFSGD/WpOIKbi/AlCK3X44i2JPxN+zz6/C23NM3KbtxrClh3EsHrHHU7QDiOgKJcHwStNQSlz2c6lBejIfTKbiaLIPrbPDw3bI0S
MIME-Version: 1.0
X-Received: by 2002:a24:42c3:: with SMTP id i186mr3551971itb.2.1543716784234;
 Sat, 01 Dec 2018 18:13:04 -0800 (PST)
Date:   Sat, 01 Dec 2018 18:13:04 -0800
In-Reply-To: <000000000000140c370577db5ece@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008eedbd057c00922c@google.com>
Subject: Re: KASAN: use-after-free Read in debugfs_remove (3)
From:   syzbot <syzbot+903b72a010ad6b7a40f2@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d8f190ee836a Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cfcab9400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4602730af4f872ef
dashboard link: https://syzkaller.appspot.com/bug?extid=903b72a010ad6b7a40f2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12adc87d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12feb87d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+903b72a010ad6b7a40f2@syzkaller.appspotmail.com

sshd (5946) used greatest stack depth: 15744 bytes left
==================================================================
BUG: KASAN: use-after-free in debugfs_remove+0x10b/0x130  
fs/debugfs/inode.c:682
Read of size 8 at addr ffff8881b6a51bc0 by task kworker/0:2/2931

CPU: 0 PID: 2931 Comm: kworker/0:2 Not tainted 4.20.0-rc4+ #358
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events __blk_release_queue
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  debugfs_remove+0x10b/0x130 fs/debugfs/inode.c:682
  blk_trace_free+0x35/0x130 kernel/trace/blktrace.c:312
  blk_trace_cleanup kernel/trace/blktrace.c:339 [inline]
  __blk_trace_remove+0x7a/0xa0 kernel/trace/blktrace.c:352
  blk_trace_shutdown+0x63/0x80 kernel/trace/blktrace.c:752
  __blk_release_queue+0x235/0x510 block/blk-sysfs.c:865
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 5965:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  __d_alloc+0xc8/0xb90 fs/dcache.c:1599
  d_alloc+0x96/0x380 fs/dcache.c:1678
  d_alloc_parallel+0x15a/0x1f40 fs/dcache.c:2421
  __lookup_slow+0x1e6/0x540 fs/namei.c:1654
  lookup_one_len+0x1d8/0x220 fs/namei.c:2543
  start_creating+0xc6/0x200 fs/debugfs/inode.c:308
  __debugfs_create_file+0x63/0x400 fs/debugfs/inode.c:347
  debugfs_create_file+0x57/0x70 fs/debugfs/inode.c:399
  do_blk_trace_setup+0x45d/0xdb0 kernel/trace/blktrace.c:528
  __blk_trace_setup+0xd5/0x180 kernel/trace/blktrace.c:577
  blk_trace_ioctl+0x17a/0x2f0 kernel/trace/blktrace.c:716
  blkdev_ioctl+0x9e9/0x21b0 block/ioctl.c:591
  block_ioctl+0xee/0x130 fs/block_dev.c:1883
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

kobject: 'slaves' (00000000689664f7): kobject_add_internal:  
parent: 'loop0', set: '<NULL>'
Freed by task 0:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3760
  __d_free+0x20/0x30 fs/dcache.c:257
  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
  rcu_do_batch kernel/rcu/tree.c:2437 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2716 [inline]
  rcu_process_callbacks+0x100a/0x1ac0 kernel/rcu/tree.c:2697
kobject: 'loop0' (000000009adfb848): kobject_uevent_env
  __do_softirq+0x308/0xb7e kernel/softirq.c:292
kobject: 'loop0' (000000009adfb848): fill_kobj_path: path  
= '/devices/virtual/block/loop0'

The buggy address belongs to the object at ffff8881b6a51b80
  which belongs to the cache dentry of size 288
kobject: 'queue' (00000000d475bda4): kobject_add_internal: parent: 'loop0',  
set: '<NULL>'
The buggy address is located 64 bytes inside of
  288-byte region [ffff8881b6a51b80, ffff8881b6a51ca0)
The buggy address belongs to the page:
page:ffffea0006da9440 count:1 mapcount:0 mapping:ffff8881da980c80 index:0x0
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea0006da8448 ffffea0006da94c8 ffff8881da980c80
raw: 0000000000000000 ffff8881b6a51080 000000010000000b 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881b6a51a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
kobject: 'mq' (00000000a3db6337): kobject_add_internal: parent: 'loop0',  
set: '<NULL>'
  ffff8881b6a51b00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8881b6a51b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff8881b6a51c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b6a51c80: fb fb fb fb fc fc fc fc fc fc fc fc 00 00 00 00
==================================================================

