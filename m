Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89215C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 23:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0420874
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 23:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeLSXYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:24:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46383 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeLSXYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 18:24:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so10148816ply.13
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 15:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=9l9Pl4L8jdMg8N5w3TibQ2df2nA6MlDPPtLbh046U2Y=;
        b=PXO2r9yDnqn6G0RnkJPXrxVsLvH15Wh/YAaqAr1Fz988wUNl1WayAvSdAIoFvJSN+E
         Rxbwr68P6KUi8qVLBzJYVG3B2pjBzjNb7mQXnMZcH6lxxhkVSuzoOuznuhsSarZq7yEO
         IuSvHqganlW/dCyQhDaM/g3y7+wNDqcZacHTEl0l2lqlLz5sLQKAGlAEkALDWwZJSvxi
         VVB0lFZCG8/yINJgUPFETwlxEGLuQuflRlnmfs8/DMeY4q85z035Ff/7Mp1JQ+em7yzs
         Xf+VQG40aZvE8n3DJ6CIJ65oil9B0DONYZIYDKn5fqz09tbdXqYRwKtHVGDkcgy6OBKW
         FZSA==
X-Gm-Message-State: AA+aEWbG6M1/TMOyy40/jEvt4YOnchPGWx9Xhw3SSXtVxPvgsma1JHmG
        skKvO9hliE2tb02ZXDPuP/OrPEgIu+s=
X-Google-Smtp-Source: AFSGD/WFCGXNwbf3+QjzhTJ5s0+PeKzZdvoRg5EN4xCI4l7fkbnC5+7N+aj/Kg63FSu6SZTVrYPH/w==
X-Received: by 2002:a17:902:e012:: with SMTP id ca18mr22077365plb.218.1545261887349;
        Wed, 19 Dec 2018 15:24:47 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p24sm27703575pfk.155.2018.12.19.15.24.46
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 15:24:46 -0800 (PST)
Message-ID: <1545261885.185366.488.camel@acm.org>
Subject: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Bart Van Assche <bvanassche@acm.org>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Wed, 19 Dec 2018 15:24:45 -0800
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

If I run the srp blktests in a loop then I see the below call stack appearing
sporadically. I have not yet had the time to analyze this but I'm reporting
this here in case someone else would already have had a look at this.

Bart.

+AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9
BUG: KASAN: use-after-free in bt+AF8-iter+-0x86/0xf0
Read of size 8 at addr ffff88803b335240 by task fio/21412

CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+- +ACM-3
Hardware name: QEMU Standard PC (i440FX +- PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump+AF8-stack+-0x86/0xca
 print+AF8-address+AF8-description+-0x71/0x239
 kasan+AF8-report.cold.5+-0x242/0x301
 +AF8AXw-asan+AF8-load8+-0x54/0x90
 bt+AF8-iter+-0x86/0xf0
 blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter+-0x373/0x5e0
 blk+AF8-mq+AF8-in+AF8-flight+-0x96/0xb0
 part+AF8-in+AF8-flight+-0x40/0x140
 part+AF8-round+AF8-stats+-0x18e/0x370
 blk+AF8-account+AF8-io+AF8-start+-0x3d7/0x670
 blk+AF8-mq+AF8-bio+AF8-to+AF8-request+-0x19c/0x3a0
 blk+AF8-mq+AF8-make+AF8-request+-0x7a9/0xcb0
 generic+AF8-make+AF8-request+-0x41d/0x960
 submit+AF8-bio+-0x9b/0x250
 do+AF8-blockdev+AF8-direct+AF8-IO+-0x435c/0x4c70
 +AF8AXw-blockdev+AF8-direct+AF8-IO+-0x79/0x88
 ext4+AF8-direct+AF8-IO+-0x46c/0xc00
 generic+AF8-file+AF8-direct+AF8-write+-0x119/0x210
 +AF8AXw-generic+AF8-file+AF8-write+AF8-iter+-0x11c/0x280
 ext4+AF8-file+AF8-write+AF8-iter+-0x1b8/0x6f0
 aio+AF8-write+-0x204/0x310
 io+AF8-submit+AF8-one+-0x9d3/0xe80
 +AF8AXw-x64+AF8-sys+AF8-io+AF8-submit+-0x115/0x340
 do+AF8-syscall+AF8-64+-0x71/0x210
 entry+AF8-SYSCALL+AF8-64+AF8-after+AF8-hwframe+-0x49/0xbe
RIP: 0033:0x7f02cf043219
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 +ADw-48+AD4 3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 fc 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007f02a1df78b8 EFLAGS: 00000246 ORIG+AF8-RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f02a1df8ef8 RCX: 00007f02cf043219
RDX: 00007f029804a7c0 RSI: 0000000000000001 RDI: 00007f02c4f67000
RBP: 00007f02c4f67000 R08: 00007f0298007af0 R09: 00007f02a362f0f0
R10: 00007f029804a9c0 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f029804a7c0 R15: 00007f0298049f60

The buggy address belongs to the page:
page:ffffea0000eccd40 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x1fff000000000000()
raw: 1fff000000000000 0000000000000000 ffffffff00ec0201 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88803b335100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88803b335180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+AD4-ffff88803b335200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                           +AF4
 ffff88803b335280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88803b335300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9-
