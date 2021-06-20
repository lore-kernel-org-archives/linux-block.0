Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EACC48BDF
	for <linux-block@archiver.kernel.org>; Sun, 20 Jun 2021 12:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE2461007
	for <linux-block@archiver.kernel.org>; Sun, 20 Jun 2021 12:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhFTMWE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Jun 2021 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhFTMWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Jun 2021 08:22:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E39BC061574;
        Sun, 20 Jun 2021 05:19:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so3530448pjb.0;
        Sun, 20 Jun 2021 05:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BCc0kG9LkOMMwY6XxlvP8/WyTLaOkPIDy6QIabCboTs=;
        b=i31jNnaLZaINU4tY9qZ5hrsFP11sO0JMoP8jpYVO6bSYel1QWJ6wBCTaiKZ39t7dey
         FtAuJGM03Ymo8iAOz8uCZ/NwSw1l49nImW7CIg+LQvWZWnjo6zKVut0tK8j3iQW8NWbp
         cyRHFzTArkR9S8emjGbpw1jI4dKKYeEubvJQRlpfn+2765gBC7hm4g8OtrwFbS56nhE7
         rIRd++/2Jq5XklQ82YpxIjlD1Dxx252QwG7Ekw3/G/I/3uwZaw5q0Sy8EZBhDpTmvskm
         D65g2MUObOKP7FBlpXI5H0m/5mAnybb9lGCThFNbJyLWxGopGq64nRpFX5Y7LTCj+kCn
         nwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BCc0kG9LkOMMwY6XxlvP8/WyTLaOkPIDy6QIabCboTs=;
        b=UjvnG8tEItPu/Ldjfx5/BmF2vtCGLEvxYqEYvPiwPIms0O+oQxwgejtg1kh4Dd8Q7i
         dfjfkvmE2yybdA/BJpqVWJSt9TSyxmOBZ/ez+q/jz/qNYvoOOqfNrNFqT5zMCnTS8RjS
         wSZ9roPRpn5SV7b+imzjaXgql/QDtrswB6yoPz2wBOD6jllRldezUYSGm31Q9zf8Ltfg
         br0WNN+AEbcnC4NgQIa4KNeDk5G39zTNQoAIyP2X9+bGyVH96XpOJQXjO1R+MWFHdERz
         ek5hkmb3BAq27l9soPk8NHA6Hl2d1sb4HNgb434BdAzJcAg9YNN5CGuQm3Jge3coFMSF
         qJEQ==
X-Gm-Message-State: AOAM5321ZYGf+C7q9onKq+9AsHGd6yBRbOHmU5NjvB87aYu84kuwenFJ
        O2dDJSSnowcDJ+kA3lR2hg==
X-Google-Smtp-Source: ABdhPJz6ECQ66FTEAlLfWUHxhugzdAmvRsNaBrKSpHoWi3yx8/cD6mdGckbtGCBSMhO+F812afOfVg==
X-Received: by 2002:a17:90b:b03:: with SMTP id bf3mr32651498pjb.47.1624191589771;
        Sun, 20 Jun 2021 05:19:49 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id m3sm2870950pfa.70.2021.06.20.05.19.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 05:19:49 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     axboe@kernel.dk, liushixin2@huawei.com, bhelgaas@google.com,
        lee.jones@linaro.org, ulf.hansson@linaro.org,
        guoqing.jiang@cloud.ionos.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] block: mtip32xx: set the pointer of queue to null after cleaning
Date:   Sun, 20 Jun 2021 12:19:17 +0000
Message-Id: <1624191557-5385-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When 'mtip_block_initialize' fails at 'mtip_hw_get_identify', a series
of cleanup operations will be performed. But when the execution reaches
'put_disk', it will cause refcount underflow. The reason for this error
is that after cleaning 'dd->queue', 'dd->disk->queue' was not set to
null at the same time, which caused repeated cleanup work.

Fix this by set 'dd->disk->queue' to null after cleaning

This log reveals it:

[   59.590163] refcount_t: underflow; use-after-free.
[   59.591650] Modules linked in:
[   59.591867] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.12.4-g70e7f0549188-dirty #137
[   59.592407] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   59.593178] RIP: 0010:refcount_warn_saturate+0x140/0x150
[   59.593551] Code: 05 d1 3b dd 04 01 e8 af d4 5f ff 0f 0b e9 13 ff ff ff e8 b3 75 73 ff 48 c7 c7 30 31 df 85 c6 05 b4 3b dd 04 01 e8 90 d4 5f ff <0f> 0b e9 f4 fe ff ff 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 55
[   59.594942] RSP: 0000:ffffc90000017918 EFLAGS: 00010286
[   59.595357] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
[   59.595858] RDX: 0000000000000000 RSI: ffffffff8123f301 RDI: 00000000ffffffff
[   59.596346] RBP: ffffc90000017928 R08: 0000000000000001 R09: 0000000000000001
[   59.596926] R10: 0000000000000000 R11: 0000000000000001 R12: ffff888105494270
[   59.597429] R13: ffff888105494270 R14: ffffffff82498b30 R15: 0000000000000000
[   59.597931] FS:  0000000000000000(0000) GS:ffff88817bd40000(0000) knlGS:0000000000000000
[   59.598500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.598899] CR2: 0000000000000000 CR3: 000000000642e000 CR4: 00000000000006e0
[   59.599401] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   59.599900] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   59.600400] Call Trace:
[   59.600579]  kobject_put+0x1b0/0x2e0
[   59.600839]  ? dev_attr_show+0x70/0x70
[   59.601112]  blk_put_queue+0x19/0x20
[   59.601372]  disk_release+0xb7/0xf0
[   59.601628]  ? show_partition_start+0x80/0x80
[   59.601943]  device_release+0x40/0xd0
[   59.602207]  kobject_put+0x10b/0x2e0
[   59.602468]  put_device+0x1f/0x30
[   59.602708]  put_disk+0x2a/0x40
[   59.602938]  mtip_block_initialize+0x35f/0x1570
[   59.603264]  ? __pci_enable_msi_range+0x32c/0x470
[   59.603606]  mtip_pci_probe+0x92a/0xc80
[   59.603899]  local_pci_probe+0x4a/0xb0
[   59.604173]  pci_device_probe+0x126/0x1d0
[   59.604478]  ? pci_device_remove+0x100/0x100
[   59.604790]  really_probe+0x27e/0x650
[   59.605059]  driver_probe_device+0x84/0x1d0
[   59.605359]  ? mutex_lock_nested+0x16/0x20
[   59.605660]  device_driver_attach+0x63/0x70
[   59.605963]  __driver_attach+0x117/0x1a0
[   59.606247]  ? device_driver_attach+0x70/0x70
[   59.606607]  bus_for_each_dev+0xb6/0x110
[   59.606919]  ? rdinit_setup+0x40/0x40
[   59.607177]  driver_attach+0x22/0x30
[   59.607431]  bus_add_driver+0x1e6/0x2a0
[   59.607703]  driver_register+0xa4/0x180
[   59.607974]  __pci_register_driver+0x77/0x80
[   59.608273]  ? drbd_debugfs_init+0x78/0x78
[   59.608560]  mtip_init+0x15c/0x18f
[   59.608820]  do_one_initcall+0x7a/0x3d0
[   59.609140]  ? rdinit_setup+0x40/0x40
[   59.609464]  ? rcu_read_lock_sched_held+0x4a/0x70
[   59.609879]  kernel_init_freeable+0x2a7/0x2f9
[   59.610268]  ? rest_init+0x2c0/0x2c0
[   59.610561]  kernel_init+0x13/0x180
[   59.610807]  ? rest_init+0x2c0/0x2c0
[   59.611058]  ? rest_init+0x2c0/0x2c0
[   59.611312]  ret_from_fork+0x1f/0x30
[   59.611574] Kernel panic - not syncing: panic_on_warn set ...
[   59.611973] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.12.4-g70e7f0549188-dirty #137
[   59.612514] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   59.613303] Call Trace:
[   59.613476]  dump_stack+0xba/0xf5
[   59.613718]  ? refcount_warn_saturate+0x140/0x150
[   59.614055]  panic+0x155/0x3ed
[   59.614281]  ? __warn+0xed/0x150
[   59.614468]  ? refcount_warn_saturate+0x140/0x150
[   59.614468]  __warn+0x103/0x150
[   59.614468]  ? refcount_warn_saturate+0x140/0x150
[   59.614468]  report_bug+0x119/0x1c0
[   59.614468]  handle_bug+0x3b/0x80
[   59.614468]  exc_invalid_op+0x18/0x70
[   59.614468]  asm_exc_invalid_op+0x12/0x20
[   59.614468] RIP: 0010:refcount_warn_saturate+0x140/0x150
[   59.614468] Code: 05 d1 3b dd 04 01 e8 af d4 5f ff 0f 0b e9 13 ff ff ff e8 b3 75 73 ff 48 c7 c7 30 31 df 85 c6 05 b4 3b dd 04 01 e8 90 d4 5f ff <0f> 0b e9 f4 fe ff ff 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 55
[   59.614468] RSP: 0000:ffffc90000017918 EFLAGS: 00010286
[   59.614468] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
[   59.614468] RDX: 0000000000000000 RSI: ffffffff8123f301 RDI: 00000000ffffffff
[   59.614468] RBP: ffffc90000017928 R08: 0000000000000001 R09: 0000000000000001
[   59.614468] R10: 0000000000000000 R11: 0000000000000001 R12: ffff888105494270
[   59.614468] R13: ffff888105494270 R14: ffffffff82498b30 R15: 0000000000000000
[   59.614468]  ? dev_attr_show+0x70/0x70
[   59.614468]  ? vprintk_func+0x71/0x110
[   59.614468]  ? refcount_warn_saturate+0x140/0x150
[   59.614468]  kobject_put+0x1b0/0x2e0
[   59.614468]  ? dev_attr_show+0x70/0x70
[   59.614468]  blk_put_queue+0x19/0x20
[   59.614468]  disk_release+0xb7/0xf0
[   59.614468]  ? show_partition_start+0x80/0x80
[   59.614468]  device_release+0x40/0xd0
[   59.614468]  kobject_put+0x10b/0x2e0
[   59.614468]  put_device+0x1f/0x30
[   59.614468]  put_disk+0x2a/0x40
[   59.614468]  mtip_block_initialize+0x35f/0x1570
[   59.614468]  ? __pci_enable_msi_range+0x32c/0x470
[   59.614468]  mtip_pci_probe+0x92a/0xc80
[   59.614468]  local_pci_probe+0x4a/0xb0
[   59.614468]  pci_device_probe+0x126/0x1d0
[   59.614468]  ? pci_device_remove+0x100/0x100
[   59.614468]  really_probe+0x27e/0x650
[   59.614468]  driver_probe_device+0x84/0x1d0
[   59.614468]  ? mutex_lock_nested+0x16/0x20
[   59.614468]  device_driver_attach+0x63/0x70
[   59.614468]  __driver_attach+0x117/0x1a0
[   59.614468]  ? device_driver_attach+0x70/0x70
[   59.614468]  bus_for_each_dev+0xb6/0x110
[   59.614468]  ? rdinit_setup+0x40/0x40
[   59.614468]  driver_attach+0x22/0x30
[   59.614468]  bus_add_driver+0x1e6/0x2a0
[   59.614468]  driver_register+0xa4/0x180
[   59.614468]  __pci_register_driver+0x77/0x80
[   59.614468]  ? drbd_debugfs_init+0x78/0x78
[   59.614468]  mtip_init+0x15c/0x18f
[   59.614468]  do_one_initcall+0x7a/0x3d0
[   59.614468]  ? rdinit_setup+0x40/0x40
[   59.614468]  ? rcu_read_lock_sched_held+0x4a/0x70
[   59.614468]  kernel_init_freeable+0x2a7/0x2f9
[   59.614468]  ? rest_init+0x2c0/0x2c0
[   59.614468]  kernel_init+0x13/0x180
[   59.614468]  ? rest_init+0x2c0/0x2c0
[   59.614468]  ? rest_init+0x2c0/0x2c0
[   59.614468]  ret_from_fork+0x1f/0x30
[   59.614468] Dumping ftrace buffer:
[   59.614468]    (ftrace buffer empty)
[   59.614468] Kernel Offset: disabled
[   59.614468] Rebooting in 1 seconds..

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 589cb0f1e030..305be06868df 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3726,6 +3726,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 read_capacity_error:
 init_hw_cmds_error:
 	blk_cleanup_queue(dd->queue);
+	dd->disk->queue = NULL;
 block_queue_alloc_init_error:
 	blk_mq_free_tag_set(&dd->tags);
 block_queue_alloc_tag_error:
-- 
2.17.6

