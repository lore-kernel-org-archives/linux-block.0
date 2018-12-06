Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BBDC64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A37820850
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A37820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbeLFQjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:39:19 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:37118 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeLFQjT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:39:19 -0500
Received: by mail-pl1-f170.google.com with SMTP id b5so414233plr.4
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=i7tq7FxHHsD2MMYHmaAIPFCoqJd7PQ7bd6N5QGdOaq8=;
        b=reSpBJSeXd7eUkyTK2zMds/ei3sYSGl2QoGIdXD9m5dQNhPpAfsJB3GbSTLCnSqOIB
         NPcDilFQl0O3pv8qB5IjohhOGa44jmoPwbfjtOMN9+Odpvi+cGeToC/bcDNUXELkHqV/
         COpao3g5WOhTGMAepfpDty2RNZRSJ4/5Y5omwQ2UPRlQzE1rPJeARhRrSR8syQSflsYo
         xfGWD/KhN9HCpK5NuKAZrSfXjjQ+qmHUkKRBYj5RNsZU83e5fo/4HfBTc1qgZYecUFGS
         gZhWE/7OPX7nQLrZuYgc5DotD2PTZMqzdSb+cmN8tv0kg8/3Mc+JxCqxlz1Lg6Njn+Vt
         dETg==
X-Gm-Message-State: AA+aEWZ4x1G/LS1s/Vaasix9YxznFU1rhhmCYAfWTI/OzWXXdIO8jh+p
        lG35YXOAaaZHSkt9qM/ov4I=
X-Google-Smtp-Source: AFSGD/XXKunXn7HmJocyLgN2b3FMFzO5FP5vO8jTpVbh31ZPhegHXcxCyfmnUVS9rV7hRTx4WLRH6g==
X-Received: by 2002:a17:902:4464:: with SMTP id k91mr29317094pld.13.1544114357774;
        Thu, 06 Dec 2018 08:39:17 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z127sm1073614pfb.80.2018.12.06.08.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:39:16 -0800 (PST)
Message-ID: <1544114355.185366.245.camel@acm.org>
Subject: for-next branch and throttling
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 06 Dec 2018 08:39:15 -0800
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

If I merge Jens' for-next branch with Linus' master branch and boot the
resulting kernel in a VM then the call trace shown below appears. This call
trace does not appear when building and booting the code from Linus' master
branch. Is this perhaps a regression?

WARNING: CPU: 1 PID: 257 at block/blk-throttle.c:2128 blk+AF8-throtl+AF8-bio+-0xc00/0x1120
Modules linked in: floppy(+-) virtio+AF8-blk(+-) virtio+AF8-net net+AF8-failover failover i2c+AF8-piix4 pata+AF8-acpi
CPU: 1 PID: 257 Comm: systemd-udevd Not tainted 4.20.0-rc5-dbg+- +ACM-1
Hardware name: QEMU Standard PC (i440FX +- PIIX, 1996), BIOS 1.10.2-1 04/01/2014
RIP: 0010:blk+AF8-throtl+AF8-bio+-0xc00/0x1120
Call Trace:
 ? create+AF8-task+AF8-io+AF8-context+-0x1a2/0x1e0
 ? lock+AF8-downgrade+-0x2e0/0x2e0
 ? kasan+AF8-check+AF8-read+-0x11/0x20
 ? do+AF8-raw+AF8-spin+AF8-unlock+-0xa8/0x140
 ? preempt+AF8-count+AF8-sub+-0x18/0xd0
 generic+AF8-make+AF8-request+AF8-checks+-0x432/0xcc0
 ? trace+AF8-event+AF8-raw+AF8-event+AF8-block+AF8-rq+AF8-requeue+-0x290/0x290
 ? +AF8AXw-lock+AF8-acquire+-0x5b0/0x17e0
 ? +AF8AXw-bio+AF8-associate+AF8-blkg.isra.33+-0x1d0/0x3c0
 generic+AF8-make+AF8-request+-0x151/0x950
 ? blk+AF8-queue+AF8-enter+-0x7e0/0x7e0
 submit+AF8-bio+-0x9b/0x250
 ? submit+AF8-bio+-0x9b/0x250
 ? generic+AF8-make+AF8-request+-0x950/0x950
 ? guard+AF8-bio+AF8-eod+-0x120/0x2d0
 submit+AF8-bh+AF8-wbc+-0x2df/0x310
 block+AF8-read+AF8-full+AF8-page+-0x34c/0x4c0
 ? I+AF8-BDEV+-0x20/0x20
 ? +AF8AXw-bread+AF8-gfp+-0x170/0x170
 ? add+AF8-to+AF8-page+AF8-cache+AF8-locked+-0x20/0x20
 ? blkdev+AF8-writepages+-0x10/0x10
 ? blkdev+AF8-writepages+-0x10/0x10
 blkdev+AF8-readpage+-0x18/0x20
 do+AF8-read+AF8-cache+AF8-page+-0x5ed/0xbf0
 ? blkdev+AF8-writepages+-0x10/0x10
 ? find+AF8-valid+AF8-gpt+-0x1a8/0x8b0
 ? efi+AF8-partition+-0x147/0x6c1
 ? check+AF8-partition+-0x1b2/0x314
 ? blkdev+AF8-get+-0x1f2/0x5a0
 ? +AF8AXw-device+AF8-add+AF8-disk+-0x6c1/0x7e0
 ? device+AF8-add+AF8-disk+-0x13/0x20
 ? pagecache+AF8-get+AF8-page+-0x420/0x420
 ? driver+AF8-probe+AF8-device+-0x118/0x180
 ? +AF8AXw-driver+AF8-attach+-0x167/0x190
 ? bus+AF8-for+AF8-each+AF8-dev+-0x105/0x160
 ? driver+AF8-attach+-0x2b/0x30
 ? bus+AF8-add+AF8-driver+-0x23d/0x350
 ? driver+AF8-register+-0xdc/0x160
 ? register+AF8-virtio+AF8-driver+-0x3c/0x60
 ? init+-0x51/0x1000 +AFs-virtio+AF8-blk+AF0
 ? do+AF8-one+AF8-initcall+-0xb4/0x3a1
 ? do+AF8-init+AF8-module+-0x103/0x360
 ? load+AF8-module+-0x443e/0x4630
 ? +AF8AXw-do+AF8-sys+AF8-finit+AF8-module+-0x12d/0x1b0
 ? +AF8AXw-x64+AF8-sys+AF8-finit+AF8-module+-0x43/0x50
 ? do+AF8-syscall+AF8-64+-0x71/0x210
 ? entry+AF8-SYSCALL+AF8-64+AF8-after+AF8-hwframe+-0x49/0xbe
 ? match+AF8-held+AF8-lock+-0x20/0x250
 ? match+AF8-held+AF8-lock+-0x35/0x250
 ? blkdev+AF8-writepages+-0x10/0x10
 read+AF8-cache+AF8-page+-0x3a/0x50
 read+AF8-dev+AF8-sector+-0x64/0x170
 read+AF8-lba+-0x1f9/0x3a0
 ? msdos+AF8-partition+-0x1370/0x1370
 ? find+AF8-valid+AF8-gpt+-0x1a8/0x8b0
 ? kmem+AF8-cache+AF8-alloc+AF8-trace+-0x151/0x340
 ? find+AF8-valid+AF8-gpt+-0x1a8/0x8b0
 find+AF8-valid+AF8-gpt+-0x1c6/0x8b0
 ? is+AF8-gpt+AF8-valid.part.5+-0x640/0x640
 ? +AF8AXw-alloc+AF8-pages+AF8-nodemask+-0x1c4/0x4d0
 ? lockdep+AF8-hardirqs+AF8-on+-0x182/0x260
 ? get+AF8-page+AF8-from+AF8-freelist+-0x648/0x2070
 ? mark+AF8-lock+-0x69/0x8d0
 ? trace+AF8-hardirqs+AF8-on+-0x24/0x130
 ? kasan+AF8-unpoison+AF8-shadow+-0x35/0x50
 ? get+AF8-page+AF8-from+AF8-freelist+-0x648/0x2070
 ? +AF8AXw-asan+AF8-loadN+-0xf/0x20
 ? widen+AF8-string+-0x73/0x170
 ? +AF8AXw-asan+AF8-loadN+-0xf/0x20
 ? widen+AF8-string+-0x73/0x170
 ? get+AF8-page+AF8-from+AF8-freelist+-0x1eea/0x2070
 ? set+AF8-precision+-0x90/0x90
 ? string+-0x135/0x180
 efi+AF8-partition+-0x147/0x6c1
 ? format+AF8-decode+-0xce/0x550
 ? enable+AF8-ptr+AF8-key+AF8-workfn+-0x30/0x30
 ? find+AF8-valid+AF8-gpt+-0x8b0/0x8b0
 ? vsnprintf+-0x11d/0x820
 ? pointer+-0x4d0/0x4d0
 ? snprintf+-0x88/0xa0
 ? snprintf+-0x88/0xa0
 ? vsprintf+-0x20/0x20
 ? find+AF8-valid+AF8-gpt+-0x8b0/0x8b0
 check+AF8-partition+-0x1b2/0x314
 rescan+AF8-partitions+-0x13b/0x440
 +AF8AXw-blkdev+AF8-get+-0x61f/0x930
 ? check+AF8-disk+AF8-change+-0xa0/0xa0
 ? lock+AF8-downgrade+-0x2e0/0x2e0
 ? var+AF8-wake+AF8-function+-0x90/0x90
 blkdev+AF8-get+-0x1f2/0x5a0
 ? preempt+AF8-count+AF8-sub+-0x18/0xd0
 ? +AF8-raw+AF8-spin+AF8-unlock+-0x31/0x50
 ? bd+AF8-may+AF8-claim+-0x80/0x80
 ? bdget+-0x26b/0x280
 ? blkdev+AF8-writepage+-0x20/0x20
 ? kasan+AF8-check+AF8-read+-0x11/0x20
 ? kobject+AF8-put+-0x23/0x220
 +AF8AXw-device+AF8-add+AF8-disk+-0x6c1/0x7e0
 ? blk+AF8-alloc+AF8-devt+-0x150/0x150
 ? +AF8AXw-asan+AF8-storeN+-0x12/0x20
 device+AF8-add+AF8-disk+-0x13/0x20
 virtblk+AF8-probe+-0x839/0xace +AFs-virtio+AF8-blk+AF0
 ? virtblk+AF8-restore+-0xd0/0xd0 +AFs-virtio+AF8-blk+AF0
 ? mutex+AF8-unlock+-0x12/0x20
 ? kernfs+AF8-activate+-0xd0/0xe0
 ? kasan+AF8-check+AF8-write+-0x14/0x20
 ? kernfs+AF8-put+-0x2c/0x280
 ? vring+AF8-transport+AF8-features+-0x19/0x70
 ? vp+AF8-finalize+AF8-features+-0xe6/0x160
 ? vp+AF8-get+AF8-status+-0x29/0x30
 ? virtio+AF8-finalize+AF8-features+-0xbe/0xe0
 virtio+AF8-dev+AF8-probe+-0x27d/0x390
 really+AF8-probe+-0x191/0x560
 ? driver+AF8-probe+AF8-device+-0x180/0x180
 driver+AF8-probe+AF8-device+-0x118/0x180
 ? driver+AF8-probe+AF8-device+-0x180/0x180
 +AF8AXw-driver+AF8-attach+-0x167/0x190
 bus+AF8-for+AF8-each+AF8-dev+-0x105/0x160
 ? subsys+AF8-dev+AF8-iter+AF8-exit+-0x10/0x10
 ? kasan+AF8-check+AF8-read+-0x11/0x20
 ? preempt+AF8-count+AF8-sub+-0x18/0xd0
 ? +AF8-raw+AF8-spin+AF8-unlock+-0x31/0x50
 driver+AF8-attach+-0x2b/0x30
 bus+AF8-add+AF8-driver+-0x23d/0x350
 driver+AF8-register+-0xdc/0x160
 ? 0xffffffffa0070000
 register+AF8-virtio+AF8-driver+-0x3c/0x60
 init+-0x51/0x1000 +AFs-virtio+AF8-blk+AF0
 do+AF8-one+AF8-initcall+-0xb4/0x3a1
 ? trace+AF8-event+AF8-raw+AF8-event+AF8-initcall+AF8-finish+-0x120/0x120
 ? kasan+AF8-unpoison+AF8-shadow+-0x35/0x50
 ? +AF8AXw-asan+AF8-register+AF8-globals+-0x7b/0xa0
 do+AF8-init+AF8-module+-0x103/0x360
 load+AF8-module+-0x443e/0x4630
 ? module+AF8-frob+AF8-arch+AF8-sections+-0x20/0x20
 ? vfs+AF8-read+-0xe6/0x1e0
 ? kernel+AF8-read+-0x79/0xa0
 ? kasan+AF8-check+AF8-write+-0x14/0x20
 ? kernel+AF8-read+AF8-file+-0x259/0x310
 ? do+AF8-mmap+-0x431/0x6c0
 +AF8AXw-do+AF8-sys+AF8-finit+AF8-module+-0x12d/0x1b0
 ? +AF8AXw-do+AF8-sys+AF8-finit+AF8-module+-0x12d/0x1b0
 ? +AF8AXw-do+AF8-sys+AF8-init+AF8-module+-0x200/0x200
 ? kasan+AF8-check+AF8-write+-0x14/0x20
 ? fput+-0x1d/0xc0
 ? do+AF8-syscall+AF8-64+-0x19/0x210
 ? entry+AF8-SYSCALL+AF8-64+AF8-after+AF8-hwframe+-0x49/0xbe
 +AF8AXw-x64+AF8-sys+AF8-finit+AF8-module+-0x43/0x50
 do+AF8-syscall+AF8-64+-0x71/0x210
 entry+AF8-SYSCALL+AF8-64+AF8-after+AF8-hwframe+-0x49/0xbe
