Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8421BC433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 05:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiBHFkd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Feb 2022 00:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiBHFkc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Feb 2022 00:40:32 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA77C0401EF
        for <linux-block@vger.kernel.org>; Mon,  7 Feb 2022 21:40:30 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id q5-20020a0566022f0500b00638278a161fso5114077iow.11
        for <linux-block@vger.kernel.org>; Mon, 07 Feb 2022 21:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NVEYrJM0C3B0DWqVYowPI6bzh3KUToVqmgGzHv+vXCQ=;
        b=hVWg8EhUuUhpa4Q6GpL+T5IpOjk7yB6tnYOXesAPIWDCqNf5g77O4Xg90xvq/wF3K3
         OUsHuBXA3alicsmFpKmy8ODdArlEjNio2Hxzgh2EG8yhcxA7r1xyu2QWM45jMmOEn77/
         p3lFeof/Gk/JR0wPcgJDT+qJaN76hfCe08S4e0ZeOl/zsG78U7AzuhdFP8yiRyxb23Xc
         vhr8XFhEf0VEsKG0q9JWUrymo+lwmbbqrO3TR+cGdWMY6YzZkikRboo3HeWrw8bXMkwE
         4eqfzppxd6ahTpx5eB4kAgWINwYSuAlLVItAuBFw442ESVkHEs9C6IxXTQVU0l9k7cDn
         pBEg==
X-Gm-Message-State: AOAM533E9tM0CRNGFW6UXY7wCjKLtkzn/TDQP6/yrvLC0l7gdAo/BCkD
        bFMMkzqa6toY365iZb5p/TTo/moM9BozVkTNTJu1rWm1RGE8
X-Google-Smtp-Source: ABdhPJwLZLDaZfItvI/FjsAH813l0hh7diG5+FTlYeAhKB9UntHVkhqPOESjyLXH9GxA56pxarOniC87xi34KrKsGbjRmS+msCyo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1348:: with SMTP id u8mr1445462jad.204.1644298830219;
 Mon, 07 Feb 2022 21:40:30 -0800 (PST)
Date:   Mon, 07 Feb 2022 21:40:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae0f7b05d77b27b5@google.com>
Subject: [syzbot] WARNING in blk_register_tracepoints
From:   syzbot <syzbot+c54ded83396afee31eb1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d8ad2ce873ab Merge tag 'ext4_for_linus_stable' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15665db2700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee3797346aa03884
dashboard link: https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e00d84700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119fd0c2700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=171a984fb00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=149a984fb00000
console output: https://syzkaller.appspot.com/x/log.txt?x=109a984fb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c54ded83396afee31eb1@syzkaller.appspotmail.com

RBP: 00007ffc2d88d100 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3595 at kernel/trace/blktrace.c:1090 blk_register_tracepoints+0x2dc/0x3a0 kernel/trace/blktrace.c:1090
Modules linked in:
CPU: 0 PID: 3595 Comm: syz-executor147 Not tainted 5.17.0-rc2-syzkaller-00398-gd8ad2ce873ab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:blk_register_tracepoints+0x2dc/0x3a0 kernel/trace/blktrace.c:1090
Code: 48 c7 c7 00 3d 82 8d e8 f2 69 fb ff 31 ff 89 c3 89 c6 e8 e7 a8 f9 ff 85 db 0f 85 ba 00 00 00 5b e9 b9 a6 f9 ff e8 b4 a6 f9 ff <0f> 0b e9 4b fd ff ff e8 a8 a6 f9 ff 0f 0b e9 6c fd ff ff e8 9c a6
RSP: 0018:ffffc9000279fbc0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: 0000000000000000
RDX: ffff888023011d00 RSI: ffffffff817ed1dc RDI: 0000000000000003
RBP: ffff8881469d4300 R08: 0000000000000000 R09: ffffc9000279fa67
R10: ffffffff817ecf26 R11: 0000000000000000 R12: ffffc9000279fc70
R13: ffff8881469d4328 R14: ffff8881470196d0 R15: ffff8881469d4330
FS:  0000555556142300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc2d88d0c8 CR3: 00000000715ef000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 get_probe_ref kernel/trace/blktrace.c:326 [inline]
 do_blk_trace_setup+0x9c3/0xc80 kernel/trace/blktrace.c:570
 __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:589
 blk_trace_setup+0x43/0x60 kernel/trace/blktrace.c:607
 sg_ioctl_common drivers/scsi/sg.c:1123 [inline]
 sg_ioctl+0x257/0x2780 drivers/scsi/sg.c:1165
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f7e080026d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc2d88d0e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f7e080026d9
RDX: 0000000020000140 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007ffc2d88d100 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
