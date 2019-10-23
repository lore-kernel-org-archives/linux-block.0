Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7DFCA9EB6
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 07:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C208C2084C
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 07:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390063AbfJWH4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:56:07 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:35259 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390062AbfJWH4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 03:56:07 -0400
Received: by mail-il1-f197.google.com with SMTP id o12so11865046ilf.2
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2019 00:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hcjJVRwc1+TysqwG1xy3Kr2XSirYtzqWV+iH6zvgq70=;
        b=C84pmVcGVwK0Z0hihAuopjfxchgyJ2nAGLeCllk9ByepEd6TzBJ4MAjUaUsb37DX+J
         6CqpgJsGlHiza53a0Ehp4U+IUUoYeUR2BpSh8mwYxjNqfU5FFWUl7pHCf6a8434Wqf4o
         jXZfM86tXjf+KuINnYh77HzIpDEIpFFPZseekcVAvCt2EXhTspo3GqXQUhWnBNVQwm0Q
         pYrGEoZgrfXzkPDnJiUurUX13cre7OO0og9As1gLIzJJGfGGGXd1zEC+p4ZxrIqtrVS7
         oxejYQ6KN0UAcqL/QZac3K8PFcDES+WjcoFUSJyfc6B0yuSyV8JK3r3j41+Z+CWT0+X6
         YBIg==
X-Gm-Message-State: APjAAAWDFWQYQBYBr3ogs5afCNVisHdH6Z528aE44uHNLb+rSgu4Y+PX
        qUM96RD64EQDIn4yyNxZgaB3t2FFqq7hNEFhSewt7mzC3uas
X-Google-Smtp-Source: APXvYqzX/H8PQdx9qWXwBz6LVvhCcZ3aitqs3xBOCb+6ChwIvDMjh25mW/blONfTGRFpKLE0jjn1Ed5hX+uHCYHlibVK2Vsq42Ch
MIME-Version: 1.0
X-Received: by 2002:a92:8f94:: with SMTP id r20mr37645539ilk.41.1571817366295;
 Wed, 23 Oct 2019 00:56:06 -0700 (PDT)
Date:   Wed, 23 Oct 2019 00:56:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c52dbf05958f3f3a@google.com>
Subject: INFO: task syz-executor can't die for more than 143 seconds. (2)
From:   syzbot <syzbot+b48daca8639150bc5e73@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c4b9850b Add linux-next specific files for 20191018
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177b3ab0e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c940ef12efcd1ec
dashboard link: https://syzkaller.appspot.com/bug?extid=b48daca8639150bc5e73
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1356b8ff600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f48687600000

Bisection is inconclusive: the first bad commit could be any of:

9211bfbf netfilter: add missing IS_ENABLED(CONFIG_BRIDGE_NETFILTER) checks  
to header-file.
47e640af netfilter: add missing IS_ENABLED(CONFIG_NF_TABLES) check to  
header-file.
a1b2f04e netfilter: add missing includes to a number of header-files.
0abc8bf4 netfilter: add missing IS_ENABLED(CONFIG_NF_CONNTRACK) checks to  
some header-files.
bd96b4c7 netfilter: inline four headers files into another one.
43dd16ef netfilter: nf_tables: store data in offload context registers
78458e3e netfilter: add missing IS_ENABLED(CONFIG_NETFILTER) checks to some  
header-files.
20a9379d netfilter: remove "#ifdef __KERNEL__" guards from some headers.
bd8699e9 netfilter: nft_bitwise: add offload support
2a475c40 kbuild: remove all netfilter headers from header-test blacklist.
7e59b3fe netfilter: remove unnecessary spaces
1b90af29 ipvs: Improve robustness to the ipvs sysctl
5785cf15 netfilter: nf_tables: add missing prototypes.
0a30ba50 netfilter: nf_nat_proto: make tables static
e84fb4b3 netfilter: conntrack: use shared sysctl constants
10533343 netfilter: connlabels: prefer static lock initialiser
8c0bb787 netfilter: synproxy: rename mss synproxy_options field
c162610c Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143869e8e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b48daca8639150bc5e73@syzkaller.appspotmail.com

INFO: task syz-executor350:8656 can't die for more than 143 seconds.
syz-executor350 R  running task    27256  8656   8654 0x00004006
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x94a/0x1e70 kernel/sched/core.c:4069
  schedule+0xd9/0x260 kernel/sched/core.c:4136
  io_schedule+0x1c/0x70 kernel/sched/core.c:5780
  rq_qos_wait+0x301/0x3f0 block/blk-rq-qos.c:288
  __wbt_wait block/blk-wbt.c:526 [inline]
  wbt_wait+0x20b/0x370 block/blk-wbt.c:591
  __rq_qos_throttle+0x56/0xa0 block/blk-rq-qos.c:72
  rq_qos_throttle block/blk-rq-qos.h:182 [inline]
  blk_mq_make_request+0x3d0/0x2280 block/blk-mq.c:1943
  generic_make_request block/blk-core.c:1093 [inline]
  generic_make_request+0x23c/0xb50 block/blk-core.c:1035
  submit_bio+0x113/0x600 block/blk-core.c:1219
  blk_next_bio+0x4a/0x60 block/blk-lib.c:19
  __blkdev_issue_zero_pages+0x151/0x430 block/blk-lib.c:284
  blkdev_issue_zeroout+0x434/0x4c0 block/blk-lib.c:378
  blkdev_fallocate+0x2fc/0x410 fs/block_dev.c:2089
  vfs_fallocate+0x4aa/0xa50 fs/open.c:309
  ksys_fallocate+0x58/0xa0 fs/open.c:332
  __do_sys_fallocate fs/open.c:340 [inline]
  __se_sys_fallocate fs/open.c:338 [inline]
  __x64_sys_fallocate+0x97/0xf0 fs/open.c:338
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441269
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc6d0e55e8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441269
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000400000000200 R11: 0000000000000246 R12: 0000000000401fe0
R13: 0000000000402070 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor350:8661 can't die for more than 144 seconds.
syz-executor350 R  running task    27256  8661   8660 0x00004006
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x94a/0x1e70 kernel/sched/core.c:4069
  schedule+0xd9/0x260 kernel/sched/core.c:4136
  io_schedule+0x1c/0x70 kernel/sched/core.c:5780
  rq_qos_wait+0x301/0x3f0 block/blk-rq-qos.c:288
  __wbt_wait block/blk-wbt.c:526 [inline]
  wbt_wait+0x20b/0x370 block/blk-wbt.c:591
  __rq_qos_throttle+0x56/0xa0 block/blk-rq-qos.c:72
  rq_qos_throttle block/blk-rq-qos.h:182 [inline]
  blk_mq_make_request+0x3d0/0x2280 block/blk-mq.c:1943
  generic_make_request block/blk-core.c:1093 [inline]
  generic_make_request+0x23c/0xb50 block/blk-core.c:1035
  submit_bio+0x113/0x600 block/blk-core.c:1219
  blk_next_bio+0x4a/0x60 block/blk-lib.c:19
  __blkdev_issue_zero_pages+0x151/0x430 block/blk-lib.c:284
  blkdev_issue_zeroout+0x434/0x4c0 block/blk-lib.c:378
  blkdev_fallocate+0x2fc/0x410 fs/block_dev.c:2089
  vfs_fallocate+0x4aa/0xa50 fs/open.c:309
  ksys_fallocate+0x58/0xa0 fs/open.c:332
  __do_sys_fallocate fs/open.c:340 [inline]
  __se_sys_fallocate fs/open.c:338 [inline]
  __x64_sys_fallocate+0x97/0xf0 fs/open.c:338
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441269
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc6d0e55e8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441269
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000400000000200 R11: 0000000000000246 R12: 0000000000401fe0
R13: 0000000000402070 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor350:8662 can't die for more than 144 seconds.
syz-executor350 R  running task    27256  8662   8658 0x00004006
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x94a/0x1e70 kernel/sched/core.c:4069
INFO: task syz-executor350:8663 can't die for more than 145 seconds.
syz-executor350 D27256  8663   8655 0x00004006
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x94a/0x1e70 kernel/sched/core.c:4069
  schedule+0xd9/0x260 kernel/sched/core.c:4136
  io_schedule+0x1c/0x70 kernel/sched/core.c:5780
  rq_qos_wait+0x301/0x3f0 block/blk-rq-qos.c:288
  __wbt_wait block/blk-wbt.c:526 [inline]
  wbt_wait+0x20b/0x370 block/blk-wbt.c:591
  __rq_qos_throttle+0x56/0xa0 block/blk-rq-qos.c:72
  rq_qos_throttle block/blk-rq-qos.h:182 [inline]
  blk_mq_make_request+0x3d0/0x2280 block/blk-mq.c:1943
  generic_make_request block/blk-core.c:1093 [inline]
  generic_make_request+0x23c/0xb50 block/blk-core.c:1035
  submit_bio+0x113/0x600 block/blk-core.c:1219
  blk_next_bio+0x4a/0x60 block/blk-lib.c:19
  __blkdev_issue_zero_pages+0x151/0x430 block/blk-lib.c:284
  blkdev_issue_zeroout+0x434/0x4c0 block/blk-lib.c:378
  blkdev_fallocate+0x2fc/0x410 fs/block_dev.c:2089
  vfs_fallocate+0x4aa/0xa50 fs/open.c:309
  ksys_fallocate+0x58/0xa0 fs/open.c:332
  __do_sys_fallocate fs/open.c:340 [inline]
  __se_sys_fallocate fs/open.c:338 [inline]
  __x64_sys_fallocate+0x97/0xf0 fs/open.c:338
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441269
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc6d0e55e8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441269
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000400000000200 R11: 0000000000000246 R12: 0000000000401fe0
R13: 0000000000402070 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor350:8664 can't die for more than 146 seconds.
syz-executor350 R  running task    27336  8664   8659 0x00004006
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x94a/0x1e70 kernel/sched/core.c:4069
  schedule+0xd9/0x260 kernel/sched/core.c:4136
  io_schedule+0xc/0x70 kernel/sched/core.c:5779
  rq_qos_wait+0x301/0x3f0 block/blk-rq-qos.c:288
  __wbt_wait block/blk-wbt.c:526 [inline]
  wbt_wait+0x20b/0x370 block/blk-wbt.c:591
  __rq_qos_throttle+0x56/0xa0 block/blk-rq-qos.c:72
  rq_qos_throttle block/blk-rq-qos.h:182 [inline]
  blk_mq_make_request+0x3d0/0x2280 block/blk-mq.c:1943
  generic_make_request block/blk-core.c:1093 [inline]
  generic_make_request+0x23c/0xb50 block/blk-core.c:1035
  submit_bio+0x113/0x600 block/blk-core.c:1219
  blk_next_bio+0x4a/0x60 block/blk-lib.c:19
  __blkdev_issue_zero_pages+0x151/0x430 block/blk-lib.c:284
  blkdev_issue_zeroout+0x434/0x4c0 block/blk-lib.c:378
  blkdev_fallocate+0x2fc/0x410 fs/block_dev.c:2089
  vfs_fallocate+0x4aa/0xa50 fs/open.c:309
  ksys_fallocate+0x58/0xa0 fs/open.c:332
  __do_sys_fallocate fs/open.c:340 [inline]
  __se_sys_fallocate fs/open.c:338 [inline]
  __x64_sys_fallocate+0x97/0xf0 fs/open.c:338
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441269
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc6d0e55e8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441269
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000400000000200 R11: 0000000000000246 R12: 0000000000401fe0
R13: 0000000000402070 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor350:8665 can't die for more than 147 seconds.
syz-executor350 D27256  8665   8657 0x00004006
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x94a/0x1e70 kernel/sched/core.c:4069

Showing all locks held in the system:
1 lock held by khungtaskd/1073:
  #0: ffffffff88fab740 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5336
1 lock held by rsyslogd/8538:
  #0: ffff888098390620 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/8628:
  #0: ffff8880a1d05090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f252e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8629:
  #0: ffff8880a9790090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f4b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8630:
  #0: ffff8880a47ae090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f3f2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8631:
  #0: ffff88809fc6a090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f472e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8632:
  #0: ffff8880946cf090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f2d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8633:
  #0: ffff888092b6e090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f432e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/8634:
  #0: ffff88809a971090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f192e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1073 Comm: khungtaskd Not tainted 5.4.0-rc3-next-20191018 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:269 [inline]
  watchdog+0xc8f/0x1350 kernel/hung_task.c:353
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.4.0-rc3-next-20191018 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50 kernel/kcov.c:95
Code: 89 25 c4 94 3d 09 41 bc f4 ff ff ff e8 1d 8c e9 ff 48 c7 05 ae 94 3d  
09 00 00 00 00 e9 77 e9 ff ff 90 90 90 90 90 90 90 90 90 <55> 48 89 e5 65  
48 8b 04 25 80 fe 01 00 65 8b 15 74 b0 8e 7e 81 e2
RSP: 0018:ffff8880a989f9f0 EFLAGS: 00000092
RAX: 0000000000000286 RBX: ffff88809962f0c0 RCX: ffffffff81915655
RDX: 0000000000000100 RSI: ffff88809962f0c0 RDI: ffff88821acc9540
RBP: ffff8880a989fa28 R08: ffff8880a9886240 R09: ffff8880a9886ad8
R10: fffffbfff138fe50 R11: ffffffff89c7f287 R12: ffff88821acc9540
R13: ffff88809962f0c0 R14: 0000000000000286 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 000000008fe26000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kmem_cache_free+0x5b/0x320 mm/slab.c:3690
  mempool_free_slab+0x1e/0x30 mm/mempool.c:520
  mempool_free+0xeb/0x370 mm/mempool.c:502
  bio_free+0x268/0x420 block/bio.c:255
  bio_put+0xda/0x110 block/bio.c:549
  __bio_chain_endio block/bio.c:307 [inline]
  bio_endio+0x2c2/0xaf0 block/bio.c:1804
  req_bio_endio block/blk-core.c:271 [inline]
  blk_update_request+0x49e/0x10d0 block/blk-core.c:1491
  blk_mq_end_request+0x5b/0x560 block/blk-mq.c:552
  end_cmd drivers/block/null_blk_main.c:648 [inline]
  end_cmd+0x111/0x310 drivers/block/null_blk_main.c:642
  null_complete_rq+0x19/0x20 drivers/block/null_blk_main.c:675
  blk_done_softirq+0x2fe/0x4d0 block/blk-softirq.c:37
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:603 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:595
  smpboot_thread_fn+0x6a3/0xa40 kernel/smpboot.c:165
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
