Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8A6C433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Feb 2022 21:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiBGVPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbiBGVPW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Feb 2022 16:15:22 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EAEC061355
        for <linux-block@vger.kernel.org>; Mon,  7 Feb 2022 13:15:21 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id k5-20020a926f05000000b002be190db91cso3093450ilc.11
        for <linux-block@vger.kernel.org>; Mon, 07 Feb 2022 13:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Q04Lfm5jkwz+yscbqKxM+OCLcVdT1wPW/kSPJYuzo3E=;
        b=KMuPTwXqtfo2t05sFWbS8KaltWpLnTpRIq542I+LurrjGQWliY/8NcwX7gqZju1blv
         zk5ULt8FfbPLMLpifWDS67JrJp0rTt4+gpcmfsngAHYeeZQCnf8YXiSzML45fsu9z4ao
         l+by1lgqkqAaxhvS1V0wQ8uptLzwXYhrt7keGjnPcWp11hYIMJz4iYb3SHJZQqYZLCYi
         YTn+wEMTzpMyzJ9nGdZWY1hUgFSPuSA/gZKrwsKEYegXCjswGSbUteFwa1Njz9QceZGP
         LgOfILizEZ2PgoLITnWovajF/SMF1EdBlq/INpebnYYmgi+WMqcFcwvH+Rhf4CSLWLeO
         A1qg==
X-Gm-Message-State: AOAM5302aJ2j+npSFmy2rsFPEM2zn0CNCpuX51XhNvvZjpMq1kiSbDBJ
        FbgY7uN/46S/VyLHyEyklLHocz6bmQYqKrvUcWeH189lrvd7
X-Google-Smtp-Source: ABdhPJwcG15q2cwpMieUm4wQkcyVruS93jcXOM1DtU0+s6L3dCWSrW34PO8FXy8+s+zH5D8xY01EufTIQrFlfl/1KHKVDUm0qCkL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e08:: with SMTP id g8mr757607ila.22.1644268520680;
 Mon, 07 Feb 2022 13:15:20 -0800 (PST)
Date:   Mon, 07 Feb 2022 13:15:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001733e105d77419fe@google.com>
Subject: [syzbot] WARNING in schedule_bh (2)
From:   syzbot <syzbot+e89a1109c376e2c3c389@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    dfd42facf1e4 Linux 5.17-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145b5a28700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=e89a1109c376e2c3c389
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15572b0c700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1220d968700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e89a1109c376e2c3c389@syzkaller.appspotmail.com

floppy1: floppy timeout called
------------[ cut here ]------------
WARNING: CPU: 0 PID: 11 at drivers/block/floppy.c:1000 schedule_bh+0x5f/0x70 drivers/block/floppy.c:1000
Modules linked in:
CPU: 0 PID: 11 Comm: kworker/u16:1 Not tainted 5.17.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: floppy floppy_shutdown
RIP: 0010:schedule_bh+0x5f/0x70 drivers/block/floppy.c:1000
Code: d7 65 fd fc 48 89 2d 20 c8 03 0c 5b 48 c7 c2 80 d0 6a 8c 48 8b 35 f1 cc 03 0c bf 08 00 00 00 5d e9 46 9a d1 fc e8 b1 65 fd fc <0f> 0b eb d1 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 e8 9b 65 fd fc
RSP: 0018:ffffc900003cfcf8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888010feba00 RSI: ffffffff847b12df RDI: 0000000000000003
RBP: ffffffff847bc790 R08: 0000000000000000 R09: ffffffff8c6ad087
R10: ffffffff847b12af R11: 0000000000000000 R12: 0000000000000001
R13: ffffc900003cfdb8 R14: ffff888010db3e00 R15: ffff888010c71800
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f7ea1db0 CR3: 000000001f15c000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_shutdown+0x129/0x170 drivers/block/floppy.c:1890
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

