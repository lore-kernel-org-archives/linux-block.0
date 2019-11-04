Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBA4CA9EA0
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 11:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD25222C1
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 11:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfKDL3K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:29:10 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:38813 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfKDL3K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 06:29:10 -0500
Received: by mail-io1-f72.google.com with SMTP id c2so12925178ioc.5
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 03:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RIm6RUmV98ceI6JpEEZxU6F8gTuyxH9inbdlIYhEiEE=;
        b=RD+q4S6yvBY23JxKXTw0J6cS94dhL2qe8j5RNMmu63kmRPywenx5Hx4AARhdZ2oq/J
         dy8Eh75igeME2ApqORCYCNpYoHRiSgT6D4KMXavkWcGc10aij1/b9lQ8H50Nybhf6G9L
         wTCUvxoWhQ+wRHbEx2J0n10Ynaav7Fgrbla1ky1BibMVMWujdEFI5rrhjD0rq+8DYO+V
         J/MQAwY0T+3PZUWesb3VdDZJll8yMsJK7Uq8wfn4npLWrlhZsAMT3dgPmWpNlmvyNS93
         W6k3LJFdXDFinpydiYcNaBTV5+KqtlHMvZ/PtmTEX6PxFCQOfKa5tkxC1odEYYDsYlzY
         Okug==
X-Gm-Message-State: APjAAAW77x5rsFkUdmBpSMuHlCVwyDpUX9V8XdJGullG4oLBXGwJuzC7
        f68ZsqQLbsTZIXdDzGhma1E5m/OuGfHFnA4MFocDT1QsU4TN
X-Google-Smtp-Source: APXvYqxuMRooZI5EVRwo9a2FtTxWSKBlbUNC3S+1y488ojt53I2BesR3VcyVnHGw27gL3vdrKMwKKXrA0YrYbfmYif4c1ZYsljLJ
MIME-Version: 1.0
X-Received: by 2002:a02:9f8b:: with SMTP id a11mr1433768jam.10.1572866947906;
 Mon, 04 Nov 2019 03:29:07 -0800 (PST)
Date:   Mon, 04 Nov 2019 03:29:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b587670596839fab@google.com>
Subject: KCSAN: data-race in process_srcu / synchronize_srcu
From:   syzbot <syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, elver@google.com, justin@coraid.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=17ade7ef600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
dashboard link: https://syzkaller.appspot.com/bug?extid=08f3e9d26e5541e1ecf2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in process_srcu / synchronize_srcu

write to 0xffffffff8604e8a0 of 8 bytes by task 17 on cpu 1:
  srcu_gp_end kernel/rcu/srcutree.c:533 [inline]
  srcu_advance_state kernel/rcu/srcutree.c:1146 [inline]
  process_srcu+0x207/0x780 kernel/rcu/srcutree.c:1237
  process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
  worker_thread+0xa0/0x800 kernel/workqueue.c:2415
  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

read to 0xffffffff8604e8a0 of 8 bytes by task 12515 on cpu 0:
  srcu_might_be_idle kernel/rcu/srcutree.c:784 [inline]
  synchronize_srcu+0x107/0x214 kernel/rcu/srcutree.c:996
  fsnotify_connector_destroy_workfn+0x63/0xb0 fs/notify/mark.c:164
  process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
  worker_thread+0xa0/0x800 kernel/workqueue.c:2415
  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 12515 Comm: kworker/u4:8 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound fsnotify_connector_destroy_workfn
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12515 Comm: kworker/u4:8 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound fsnotify_connector_destroy_workfn
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xf5/0x159 lib/dump_stack.c:113
  panic+0x210/0x640 kernel/panic.c:221
  kcsan_report.cold+0xc/0x10 kernel/kcsan/report.c:302
  __kcsan_setup_watchpoint+0x32e/0x4a0 kernel/kcsan/core.c:411
  __tsan_read8 kernel/kcsan/kcsan.c:36 [inline]
  __tsan_read8+0x2c/0x30 kernel/kcsan/kcsan.c:36
  srcu_might_be_idle kernel/rcu/srcutree.c:784 [inline]
  synchronize_srcu+0x107/0x214 kernel/rcu/srcutree.c:996
  fsnotify_connector_destroy_workfn+0x63/0xb0 fs/notify/mark.c:164
  process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
  worker_thread+0xa0/0x800 kernel/workqueue.c:2415
  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
