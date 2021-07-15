Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B257C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 09:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09EC9610C7
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 09:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhGOJT2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbhGOJT2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 05:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626340595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rQkCwB3PjmSSNkHN1xOfrruRwkpvkiUrPRk/ObYbxmg=;
        b=NbChIgxj507ClMpaN8m9o8aFF/8Nzmcvp0XiW30kGt5RombUdeAV98aTR9uy/MiwBL2SgG
        d9hniWh3xxk8nzLx5UJmAtBIa2YUNUiuBtRyAQHcSYhiu6EKBWeilaIoVoYYb0K1+Y/wp4
        Spor/MGKGJBYm6GGukGYoiBQT61jwrQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-8lzWoMqCPECgs50igMk9OQ-1; Thu, 15 Jul 2021 05:16:33 -0400
X-MC-Unique: 8lzWoMqCPECgs50igMk9OQ-1
Received: by mail-ed1-f70.google.com with SMTP id z13-20020a05640235cdb02903aa750a46efso2792665edc.8
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 02:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=rQkCwB3PjmSSNkHN1xOfrruRwkpvkiUrPRk/ObYbxmg=;
        b=mX2K6unNjZ255tC+nO+u3WiqiGTxSCB1pJxNF48hB5hZbc6ag/ds5ruiJyAgyF8O7q
         BtgyNhaykhgmmfEK8xvk9u0gv5hQpSMCGRMszcFmqjbxggEr3tlj6ZaFU1Ajt7IWzecT
         2td54nmS28W77BMeda9LeUZoETzUm+Xh6qMl09M6DkNA4pm/ctNPqzRlJRbTViR0u866
         qVp/n8YRp+8uLx+9gGBjkqUVEE/QHTT/EkPKkqwWMGajUAmOoZYJU5S/RlOVHCTE2ZBE
         nlnqfjdtC5ZWlamDs2NQs9Ac/dYEC1PQSE7e1gzdbi9VqrK4X+WwVrBJZoBEPC5AwQPN
         dd6g==
X-Gm-Message-State: AOAM531HqS+Ta2RknqN5M7xbZsf81pCvajDkYlwwoQVMzajI5kzOBDYq
        Ibpe1/mS36oJ+NRaHOw7Z/jqvkqWGRbNpxgqlvR4o9ZRtXkSvzC7LxOBgP4OgvIyksle8iuJypo
        CwsLxJu760TsR5GYtIJ53Zes=
X-Received: by 2002:a17:907:2d23:: with SMTP id gs35mr4464160ejc.222.1626340592558;
        Thu, 15 Jul 2021 02:16:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrF1DeIlWLw3NJml16Su+o7SSbmg9PG4wFP14gBmcJwEXfXtkYQ4qqpERXjhYqJbulctjJhg==
X-Received: by 2002:a17:907:2d23:: with SMTP id gs35mr4464141ejc.222.1626340592359;
        Thu, 15 Jul 2021 02:16:32 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q9sm1608796ejf.70.2021.07.15.02.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 02:16:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     xen-devel@lists.xenproject.org
Cc:     linux-block@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?utf-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [BUG report] Deadlock in xen-blkfront upon device hot-unplug
Date:   Thu, 15 Jul 2021 11:16:30 +0200
Message-ID: <87pmvk0wep.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm observing a deadlock every time I try to unplug a xen-blkfront
device. With 5.14-rc1+ the deadlock looks like:

[  513.682405] ============================================
[  513.686617] WARNING: possible recursive locking detected
[  513.691020] 5.14.0-rc1+ #370 Not tainted
[  513.694272] --------------------------------------------
[  513.698528] xenwatch/144 is trying to acquire lock:
[  513.702424] ffff96dc4a4c1d28 (&disk->open_mutex){+.+.}-{3:3}, at: del_gendisk+0x53/0x210
[  513.708768] 
               but task is already holding lock:
[  513.713320] ffff96dc4a4c1d28 (&disk->open_mutex){+.+.}-{3:3}, at: blkback_changed+0x118/0xeb9 [xen_blkfront]
[  513.720369] 
               other info that might help us debug this:
[  513.724901]  Possible unsafe locking scenario:

[  513.729241]        CPU0
[  513.731326]        ----
[  513.733404]   lock(&disk->open_mutex);
[  513.736679]   lock(&disk->open_mutex);
[  513.739988] 
                *** DEADLOCK ***

[  513.745524]  May be due to missing lock nesting notation

[  513.751438] 2 locks held by xenwatch/144:
[  513.755344]  #0: ffffffff8c9f3c70 (xenwatch_mutex){+.+.}-{3:3}, at: xenwatch_thread+0xe6/0x190
[  513.762137]  #1: ffff96dc4a4c1d28 (&disk->open_mutex){+.+.}-{3:3}, at: blkback_changed+0x118/0xeb9 [xen_blkfront]
[  513.770381] 
               stack backtrace:
[  513.774785] CPU: 1 PID: 144 Comm: xenwatch Not tainted 5.14.0-rc1+ #370
[  513.780131] Hardware name: Xen HVM domU, BIOS 4.2.amazon 08/24/2006
[  513.785097] Call Trace:
[  513.787920]  dump_stack_lvl+0x6a/0x9a
[  513.791223]  __lock_acquire.cold+0x14a/0x2ba
[  513.794918]  ? mark_held_locks+0x50/0x80
[  513.798453]  lock_acquire+0xd3/0x2f0
[  513.801819]  ? del_gendisk+0x53/0x210
[  513.805334]  ? kernfs_put.part.0+0xe8/0x1b0
[  513.808905]  ? del_gendisk+0x53/0x210
[  513.812230]  __mutex_lock+0x8d/0x8c0
[  513.815415]  ? del_gendisk+0x53/0x210
[  513.818931]  ? kernfs_put.part.0+0xe8/0x1b0
[  513.822594]  del_gendisk+0x53/0x210
[  513.825782]  xlvbd_release_gendisk+0x6f/0xb0 [xen_blkfront]
[  513.830186]  blkback_changed+0x20e/0xeb9 [xen_blkfront]
[  513.834458]  ? xenbus_read_driver_state+0x39/0x60
[  513.838540]  xenwatch_thread+0x94/0x190
[  513.841936]  ? do_wait_intr_irq+0xb0/0xb0
[  513.845451]  ? xenbus_dev_request_and_reply+0x90/0x90
[  513.849885]  kthread+0x149/0x170
[  513.853039]  ? set_kthread_struct+0x40/0x40
[  513.857027]  ret_from_fork+0x22/0x30

My suspicion is that the problem was introduced by:

commit c76f48eb5c084b1e15c931ae8cc1826cd771d70d
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 6 08:22:56 2021 +0200

    block: take bd_mutex around delete_partitions in del_gendisk

blkfront_closing() takes '&bdev->bd_disk->open_mutex' around
xlvbd_release_gendisk() call which in its turn calls del_gendisk() which
after the above mentioned commit tries to take the same mutex. I may be
completely wrong though.

If I try to avoid taking the mutex from blkfront_closing(): 

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8d49f8fa98bb..9af6831492d4 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2145,8 +2145,6 @@ static void blkfront_closing(struct blkfront_info *info)
                return;
        }
 
-       mutex_lock(&bdev->bd_disk->open_mutex);
-
        if (bdev->bd_openers) {
                xenbus_dev_error(xbdev, -EBUSY,
                                 "Device in use; refusing to close");
@@ -2156,7 +2154,6 @@ static void blkfront_closing(struct blkfront_info *info)
                xenbus_frontend_closed(xbdev);
        }
 
-       mutex_unlock(&bdev->bd_disk->open_mutex);
        bdput(bdev);
 }
 
the situation becomes even worse:

[   74.371465] general protection fault, probably for non-canonical address 0xb0fa8ce8ee8a2234: 0000 [#1] SMP PTI
[   74.381294] CPU: 3 PID: 144 Comm: xenwatch Not tainted 5.14.0-rc1+ #370
[   74.386172] Hardware name: Xen HVM domU, BIOS 4.2.amazon 08/24/2006
[   74.390918] RIP: 0010:del_timer+0x1f/0x80
[   74.394282] Code: 71 af a3 00 eb c1 31 c0 c3 66 90 0f 1f 44 00 00 41 55 41 54 45 31 e4 55 48 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 <48> 8b 47 08 48 85 c0 74 2d 48 89 e6 48 89 fd e8 dd e8 ff ff 48 89
[   74.407591] RSP: 0018:ffffbab68423bcc8 EFLAGS: 00010082
[   74.411691] RAX: dd931e09aefb8f00 RBX: b0fa8ce8ee8a21dc RCX: 0000000000005e7f
[   74.417041] RDX: 0000000000005e80 RSI: 0000000000000001 RDI: b0fa8ce8ee8a222c
[   74.422425] RBP: ffffbab68423bd20 R08: 0000000000000001 R09: 0000000000000001
[   74.427595] R10: 0000000000000001 R11: 0000000000000002 R12: 0000000000000000
[   74.432886] R13: ffffa0484f3e4000 R14: 0000000000000000 R15: ffffa0484691c000
[   74.438784] FS:  0000000000000000(0000) GS:ffffa083c8e00000(0000) knlGS:0000000000000000
[   74.444592] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   74.448917] CR2: 00007ff618903ff8 CR3: 0000000111e16001 CR4: 00000000001706e0
[   74.454309] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   74.460128] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   74.465872] Call Trace:
[   74.468467]  try_to_grab_pending+0x13f/0x2e0
[   74.472202]  cancel_delayed_work+0x2e/0xd0
[   74.475980]  blk_mq_stop_hw_queues+0x2d/0x50
[   74.479732]  blkfront_remove+0x40/0x210 [xen_blkfront]
[   74.484154]  xenbus_dev_remove+0x6d/0xf0
[   74.487872]  __device_release_driver+0x180/0x240
[   74.491561]  device_release_driver+0x26/0x40
[   74.497134]  bus_remove_device+0xef/0x160
[   74.500180]  device_del+0x18c/0x3e0
[   74.503451]  ? xenbus_probe_devices+0x120/0x120
[   74.506975]  ? klist_iter_exit+0x14/0x20
[   74.511649]  device_unregister+0x13/0x60
[   74.515237]  xenbus_dev_changed+0x174/0x1e0
[   74.518923]  xenwatch_thread+0x94/0x190
[   74.522208]  ? do_wait_intr_irq+0xb0/0xb0
[   74.525690]  ? xenbus_dev_request_and_reply+0x90/0x90
[   74.529973]  kthread+0x149/0x170
[   74.533007]  ? set_kthread_struct+0x40/0x40
[   74.537023]  ret_from_fork+0x22/0x30
[   74.540411] Modules linked in: vfat fat i2c_piix4 xfs libcrc32c crct10dif_pclmul crc32_pclmul crc32c_intel xen_blkfront ghash_clmulni_intel ena
[   74.549144] ---[ end trace 296bd6f709c05e9e ]---

At this point I can only say that something is certainly
wrong. Apologies if this is an already known problem.

-- 
Vitaly

