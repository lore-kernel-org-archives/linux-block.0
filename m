Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17192C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 21:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD755206BB
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 21:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfAGVV5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:21:57 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:33129 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVV5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 16:21:57 -0500
Received: by mail-pl1-f171.google.com with SMTP id z23so763683plo.0
        for <linux-block@vger.kernel.org>; Mon, 07 Jan 2019 13:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=gdzA9S3iM7kvTddVeNwaD1KHl8S9kwSZaLy3W9LsiGc=;
        b=K67rHWkeC4W8Jj/ZQI88d/DM1M40zxmQHBXj16gWM+Sk1WILXHxJ8jcInopxYTRXHH
         CwyZIdhwGdpRfhoQBjT+zeCWsyx7/sje55cDh1jbKpfWqliGe+lhrq0Yc6iESRGxLiHM
         BCWLdmcV6b6xmyPBMYLqERkrLl9d1iG74JeHXJ/YVuU74sXjF4+2UrhDw9PrPnJM+wNJ
         +NGrLVCnC22KYATF3izjt3sY5Z2JGG0Wk7sGy6wik1uo7eTNuOtoAkGAiD+RpP2JdwRN
         TDQ75MCMSbeRRZdrpuK/oBWSnFOhL4GIjkhFWs5EOS5vFrNzvEiEG4QVwadDuiskhROb
         yIDQ==
X-Gm-Message-State: AJcUukdxtQFd88j82hug5HEBgth2j8sJmMonmTu/D4YEFYj0NdNvicj3
        1Eu5kMG7XgYggQ9ad4xeCobshEC/+KY=
X-Google-Smtp-Source: ALg8bN6rLZrWzxaSiGDvu8TQQbhX3h/UIB4XjIEdyq0KbyCdLUrlnaDiI+3NTZ+qfjANAK5VeXVRtQ==
X-Received: by 2002:a17:902:2887:: with SMTP id f7mr61084433plb.176.1546896115789;
        Mon, 07 Jan 2019 13:21:55 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id x28sm136276551pge.66.2019.01.07.13.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 13:21:55 -0800 (PST)
Message-ID: <1546896114.83374.22.camel@acm.org>
Subject: Kernel v5.0-rc1 and blk-mq
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 07 Jan 2019 13:21:54 -0800
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

When I tried to run the SRP tests from the blktests repository against the
v5.0 kernel several issues were reported. The same tests pass against kernel
v4.20.

WARNING: CPU: 0 PID: 262 at block/blk-mq.c:683 blk+AF8-mq+AF8-start+AF8-request+-0x234/0x280
Modules linked in: ib+AF8-srp scsi+AF8-transport+AF8-srp target+AF8-core+AF8-pscsi target+AF8-core+AF8-file ib+AF8-srpt target+AF8-core+AF8-iblock target+AF8-core+AF8-mod rdma+AF8-cm iw+AF8-cm ib+AF8-cm scsi+AF8-debug rdma+AF8-rxe ip6+AF8-udp+AF8-tunnel udp+AF8-tunnel null+AF8-blk
dm+AF8-service+AF8-time ib+AF8-umad ib+AF8-uverbs ib+AF8-core mq+AF8-deadline kyber+AF8-iosched bfq scsi+AF8-dh+AF8-rdac scsi+AF8-dh+AF8-emc scsi+AF8-dh
ath crct10dif+AF8-pclmul crc32+AF8-pclmul ghash+AF8-clmulni+AF8-intel aesni+AF8-intel aes+AF8-x86+AF8-64 crypto+AF8-simd cryptd glue+AF8-helper joydev virtio+AF8-console virtio+AF8-balloon serio+AF8-raw qemu+AF8-fw+AF8-cfg iscsi+AF8-tcp libiscsi+AF8-tcp libiscsi
scsi+AF8-transport+AF8-iscsi ip+AF8-tables x+AF8-tables hid+AF8-generic usbhid hid psmouse virtio+AF8-net virtio+AF8-scsi net+AF8-failo
io+AF8-blk failover pata+AF8-acpi i2c+AF8-piix4 +AFs-last unloaded: null+AF8-blk+AF0
+AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9
sd 4:0:0:0: Power-on or device reset occurred
CPU: 0 PID: 262 Comm: kworker/0:1H Not tainted 5.0.0-rc1-dbg+- +ACM-1
Hardware name: QEMU Standard PC (i440FX +- PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Workqueue: kblockd blk+AF8-mq+AF8-run+AF8-work+AF8-fn
BUG: KASAN: null-ptr-deref in blk+AF8-mq+AF8-dispatch+AF8-rq+AF8-list+-0x116/0xb10
RIP: 0010:blk+AF8-mq+AF8-start+AF8-request+-0x234/0x280
Code: 01 e8 d0 d6 ad ff 85 c0 74 09 80 3d ec 2e b0 01 00 74 2c 65 ff 0d cc c7 97 7e 0f 85 53 fe ff ff e8 bc 11 96 ff e9 49 fe ff ff +ADw-0f+AD4 0b e9 79 fe ff ff 0f 0b e9 2b fe ff ff 0f 0b e9 db fe ff ff e8
Read of size 8 at addr 0000000000000138 by task kworker/2:1H/350
RSP: 0018:ffff88811468fa88 EFLAGS: 00010202
CPU: 2 PID: 350 Comm: kworker/2:1H Not tainted 5.0.0-rc1-dbg+- +ACM-1
RAX: 0000000000000001 RBX: ffff888038c24c00 RCX: ffffffff816a1546
RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff888038c24cd4
Hardware name: QEMU Standard PC (i440FX +- PIIX, 1996), BIOS 1.10.2-1 04/01/2014
RBP: ffff88811468faa8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810b1124f0
Workqueue: kblockd blk+AF8-mq+AF8-run+AF8-work+AF8-fn
R13: ffff888038c24cd4 R14: ffff888038c24c1c R15: ffff88803ffe4400
Call Trace:
 dump+AF8-stack+-0x86/0xca
FS:  0000000000000000(0000) GS:ffff88811b600000(0000) knlGS:0000000000000000
 ? blk+AF8-mq+AF8-dispatch+AF8-rq+AF8-list+-0x116/0xb10
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kasan+AF8-report.cold.3+-0x5/0x3e
CR2: 0000565114f33710 CR3: 00000001140cc003 CR4: 00000000003606f0
 ? blk+AF8-mq+AF8-dispatch+AF8-rq+AF8-list+-0x116/0xb10
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 +AF8AXw-asan+AF8-load8+-0x54/0x90
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 blk+AF8-mq+AF8-dispatch+AF8-rq+AF8-list+-0x116/0xb10
Call Trace:
 scsi+AF8-queue+AF8-rq+-0x9d6/0x1360
 ? blk+AF8-mq+AF8-flush+AF8-busy+AF8-ctxs+-0x172/0x380
 blk+AF8-mq+AF8-dispatch+AF8-rq+AF8-list+-0x5fc/0xb10
 ? blk+AF8-mq+AF8-get+AF8-driver+AF8-tag+-0x270/0x270
 ? blk+AF8-mq+AF8-flush+AF8-busy+AF8-ctxs+-0x172/0x380
 ? mark+AF8-held+AF8-locks+-0xb0/0xb0
 ? blk+AF8-mq+AF8-get+AF8-driver+AF8-tag+-0x270/0x270
 blk+AF8-mq+AF8-sched+AF8-dispatch+AF8-requests+-0x2f7/0x300
 ? mark+AF8-held+AF8-locks+-0xb0/0xb0
 ? blk+AF8-mq+AF8-sched+AF8-restart+-0x40/0x40
 blk+AF8-mq+AF8-sched+AF8-dispatch+AF8-requests+-0x2f7/0x300
 ? rcu+AF8-dynticks+AF8-curr+AF8-cpu+AF8-in+AF8-eqs+-0x4c/0x60
 ? blk+AF8-mq+AF8-sched+AF8-restart+-0x40/0x40
 ? rcu+AF8-is+AF8-watching+-0x10/0x30
 ? rcu+AF8-dynticks+AF8-curr+AF8-cpu+AF8-in+AF8-eqs+-0x4c/0x60
 +AF8AXw-blk+AF8-mq+AF8-run+AF8-hw+AF8-queue+-0xd6/0x180
 ? rcu+AF8-is+AF8-watching+-0x10/0x30
 ? blk+AF8-mq+AF8-end+AF8-request+-0x210/0x210
 +AF8AXw-blk+AF8-mq+AF8-run+AF8-hw+AF8-queue+-0xd6/0x180
 blk+AF8-mq+AF8-run+AF8-work+AF8-fn+-0x27/0x30
 ? blk+AF8-mq+AF8-end+AF8-request+-0x210/0x210
 process+AF8-one+AF8-work+-0x4ae/0xa20
 blk+AF8-mq+AF8-run+AF8-work+AF8-fn+-0x27/0x30
 ? pwq+AF8-dec+AF8-nr+AF8-in+AF8-flight+-0x130/0x130
 process+AF8-one+AF8-work+-0x4ae/0xa20
 worker+AF8-thread+-0x67/0x5b0
 ? pwq+AF8-dec+AF8-nr+AF8-in+AF8-flight+-0x130/0x130
 kthread+-0x1cf/0x1f0
 worker+AF8-thread+-0x67/0x5b0
 ? process+AF8-one+AF8-work+-0xa20/0xa20
 kthread+-0x1cf/0x1f0
 ? kthread+AF8-create+AF8-on+AF8-node+-0xa0/0xa0
 ? process+AF8-one+AF8-work+-0xa20/0xa20
 ret+AF8-from+AF8-fork+-0x24/0x30
 ? kthread+AF8-create+AF8-on+AF8-node+-0xa0/0xa0
+AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9
 ret+AF8-from+AF8-fork+-0x24/0x30
Disabling lock debugging due to kernel taint
irq event stamp: 3962924
BUG: unable to handle kernel NULL pointer dereference at 0000000000000138
hardirqs last  enabled at (3962923): +AFsAPA-ffffffff811a18d3+AD4AXQ ktime+AF8-get+-0xe3/0x120
hardirqs last disabled at (3962924): +AFsAPA-ffffffff81002859+AD4AXQ trace+AF8-hardirqs+AF8-off+AF8-thunk+-0x1a/0x1c
+ACM-PF error: +AFs-normal kernel read fault+AF0

Bart.
