Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659DFC433F5
	for <linux-block@archiver.kernel.org>; Sat, 19 Mar 2022 00:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbiCSAHj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbiCSAHi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 20:07:38 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32BE2C2752
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 17:06:18 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso5983966iov.16
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 17:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TldexfC+x4ybJzXXpkOhJtDF8s88uiemOUBWnuW1AjY=;
        b=TdfTB5ILyLG7HoNOGVjUau9ncB7zAN49cdUVkY2NRfU1LIYXt/dEvUgqRjT4XkDXcJ
         6ez69jD8yZz8KNiNmFLVnZXcKAsw9IQcQdh2jq0xxl78H6laWmSIFgIBAQRl0i0DLSso
         58VcHw+kdBTahrRmI+SoOwpVNjEPPR5KGn0FiB7wWlfpogVVIsfWSzqkIQxmtVtqoXCa
         ByHAawprKiv/VLlyb9n6960PifHgfiocm8LrELpIE3K2nGDj2vJqI9Y77kNHY97tcfWo
         A6t/agjeQ4jU70PxLkO2J9b2qeI4nQ2Im1hJp/f1kc4Fh+3T9VRwQVtwrdgE2lHHfEsw
         E5yw==
X-Gm-Message-State: AOAM530SPWGKpZkcweRc5NS+QfnNsx5Gq0KTnIEy9IHA5HNAPzp5Ut/D
        S/6a/5CNBM5+VhOJdZWkia+MqTzPu0UFqvPnsgQOdvnBBk0O
X-Google-Smtp-Source: ABdhPJyYLD4QTVdSn6ZbpL6AG/HH7TH+gDwlLsw81Do+tDZXXiPCdp9tQFzWp6J8wuRZn6teEq3HU4/HxHFOt0SoWapSLhtfdTIC
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d93:b0:317:ca63:2d38 with SMTP id
 l19-20020a0566380d9300b00317ca632d38mr5913727jaj.171.1647648377968; Fri, 18
 Mar 2022 17:06:17 -0700 (PDT)
Date:   Fri, 18 Mar 2022 17:06:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048a02c05da870806@google.com>
Subject: [syzbot] WARNING in floppy_check_events
From:   syzbot <syzbot+43f787e4cfb1ef7b84a8@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    09688c0166e7 Linux 5.17-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d09be9700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
dashboard link: https://syzkaller.appspot.com/bug?extid=43f787e4cfb1ef7b84a8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43f787e4cfb1ef7b84a8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 12378 at drivers/block/floppy.c:1000 schedule_bh drivers/block/floppy.c:1000 [inline]
WARNING: CPU: 3 PID: 12378 at drivers/block/floppy.c:1000 process_fd_request drivers/block/floppy.c:2851 [inline]
WARNING: CPU: 3 PID: 12378 at drivers/block/floppy.c:1000 floppy_check_events+0x44a/0x560 drivers/block/floppy.c:4082
Modules linked in:
CPU: 3 PID: 12378 Comm: kworker/3:181 Not tainted 5.17.0-rc8-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events_freezable_power_ disk_events_workfn
RIP: 0010:schedule_bh drivers/block/floppy.c:1000 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2851 [inline]
RIP: 0010:floppy_check_events+0x44a/0x560 drivers/block/floppy.c:4082
Code: 05 17 81 02 0c 60 9b 7c 84 e8 62 f0 cf fc e9 ba fd ff ff 45 31 e4 e9 6e fc ff ff e8 20 70 43 fd e9 5b fd ff ff e8 86 f6 fb fc <0f> 0b eb b8 48 89 de 48 c7 c7 20 9f 6a 8c e8 33 e3 84 ff e9 e4 fb
RSP: 0018:ffffc90028107cb0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88805cdd8000 RSI: ffffffff847cc9aa RDI: 0000000000000003
RBP: ffffffff907f72f0 R08: 0000000000000000 R09: ffffffff8c6b07a7
R10: ffffffff847cc961 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f58f6db0 CR3: 0000000073008000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 disk_check_events+0xc2/0x420 block/disk-events.c:193
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
