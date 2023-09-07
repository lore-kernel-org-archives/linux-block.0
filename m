Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2180EEC874B
	for <linux-block@archiver.kernel.org>; Thu,  7 Sep 2023 18:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjIGSYx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjIGSYw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Sep 2023 14:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A01BC8
        for <linux-block@vger.kernel.org>; Thu,  7 Sep 2023 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694111001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=e0rtQ+12r6j+vojGds1WrVtQu7RKc2V4Y/CSGl++e0A=;
        b=Gnhynx8DmOykTFYskVe0StNbHOBSPyv2Wnp9Zbx9o1zStDFnS979Pktchu/Y7snvdW2hgf
        nFCX+7nqseXFa5S3h+V86GcIOVQBk91hDNJ2H3Bn6jzoxeyDAyRo3dd9sWsjZDHXujE2eo
        YjRMFO73DihYIUoYQ522qhFdfY0L+Ts=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-JeURYHzVONWjN_aFFw-Uyw-1; Thu, 07 Sep 2023 02:48:44 -0400
X-MC-Unique: JeURYHzVONWjN_aFFw-Uyw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26f3fce5b45so923937a91.3
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2023 23:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694069323; x=1694674123;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0rtQ+12r6j+vojGds1WrVtQu7RKc2V4Y/CSGl++e0A=;
        b=LVAhR7/DQiUzEKjzLBB+b/2guA+ZIv4AdwzzcpvPV8X5ekSLqeYLErPn81A2GeOgat
         pvM6UXI5zsUfXJLQOJTVjfHu1FqGHEGrdlEXF4uBwEW5q10ejYH99TzFZAq12ykCuIAS
         W/OWJYuzIcsyXYxb+z8CGOgr4aOntNQrohy6lumTIq0XmHBa6t2pG5bWNRqClMxXo1Bw
         p/P0PdJozcNaZ/Vag5PI5wDPI9+AYHY3oEbm9efxLeclSgUoJmFJigeDLoZCb02mPMeQ
         VttAAO3+FScL8Mzc7CZ7EMtZkQFDs+N8m38fQV6UG6Qy37V4v/X04mMOx7Mq1d8bLxu7
         kX7w==
X-Gm-Message-State: AOJu0YyGBTESAd3cUtbX0rnbzGDPpCdJ+XTC0a8WTXQH3vvt6X9qtASC
        6vuF78kIC6lpzEIn/Db/GgzAdlxfAD4Ai00eZxR59IsuIrdLUImpyQGOOgQBWlACcCd1yeZzqHC
        xEZ6B3WIlOddx/AbawuJ+mdNkny9dlh/qqUnyfOw4vZf5bvkujvkR
X-Received: by 2002:a17:90b:3911:b0:26b:59b7:edb with SMTP id ob17-20020a17090b391100b0026b59b70edbmr16999474pjb.33.1694069323225;
        Wed, 06 Sep 2023 23:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg8MVXJWuXNzFfwu9WmWTBafSvJ6ANzBw2P1MbN4DmOIDeHW/Kyr1CrD/umZFWtZ/gNaZWi28nKEW16FwxSwk=
X-Received: by 2002:a17:90b:3911:b0:26b:59b7:edb with SMTP id
 ob17-20020a17090b391100b0026b59b70edbmr16999466pjb.33.1694069322889; Wed, 06
 Sep 2023 23:48:42 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 7 Sep 2023 14:48:31 +0800
Message-ID: <CAHj4cs_CK63uoDpGBGZ6DN4OCTpzkR3UaVgK=LX8Owr8ej2ieQ@mail.gmail.com>
Subject: [bug report] BUG: KASAN: slab-use-after-free in __lock_acquire+0x1917/0x1c00
 triggered by blktests nvme/048
To:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

Below issue triggered by blktests nvme/tcp 048 on the latest
linux-block/for-next,
pls help check it and let me know if you need any info/test for it.

# cat results/nodev/nvme/048.dmesg
[  475.495841] run blktests nvme/048 at 2023-09-07 02:31:09
[  475.751948] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  475.822431] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  475.997414] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  476.005201] nvme nvme2: creating 16 I/O queues.
[  476.033910] nvme nvme2: mapped 16/0/0 default/read/poll queues.
[  476.054295] nvme nvme2: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[  476.654345] nvme nvme2: starting error recovery
[  476.675699] nvme nvme2: Reconnecting in 2 seconds...
[  478.721724] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  478.725210] nvme nvme2: creating 1 I/O queues.
[  478.773834] nvme nvme2: mapped 1/0/0 default/read/poll queues.
[  478.774507] ==================================================================
[  478.781734] BUG: KASAN: slab-use-after-free in __lock_acquire+0x1917/0x1c00
[  478.788700] Read of size 8 at addr ffff8881f98a1ac8 by task kworker/u32:7/117

[  478.797334] CPU: 3 PID: 117 Comm: kworker/u32:7 Not tainted 6.5.0.v1+ #2
[  478.804041] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.11.4 03/22/2023
[  478.811693] Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
[  478.818229] Call Trace:
[  478.820681]  <TASK>
[  478.822788]  dump_stack_lvl+0x60/0xb0
[  478.826462]  print_address_description.constprop.0+0x2c/0x3e0
[  478.832216]  ? __lock_acquire+0x1917/0x1c00
[  478.836403]  print_report+0xb5/0x270
[  478.839981]  ? srso_return_thunk+0x5/0x10
[  478.843993]  ? kasan_addr_to_slab+0x9/0xa0
[  478.848092]  ? srso_return_thunk+0x5/0x10
[  478.852107]  kasan_report+0x8a/0xc0
[  478.855600]  ? __lock_acquire+0x1917/0x1c00
[  478.859799]  __lock_acquire+0x1917/0x1c00
[  478.863821]  ? srso_return_thunk+0x5/0x10
[  478.867835]  ? find_held_lock+0x33/0x120
[  478.871766]  lock_acquire+0x1da/0x5e0
[  478.875436]  ? __blk_mq_tag_idle+0xbd/0x170
[  478.879634]  ? __pfx_lock_acquire+0x10/0x10
[  478.883829]  ? srso_return_thunk+0x5/0x10
[  478.887847]  ? xa_find_after+0x192/0x310
[  478.891781]  ? srso_return_thunk+0x5/0x10
[  478.895797]  _raw_spin_lock_irq+0x3c/0x90
[  478.899815]  ? __blk_mq_tag_idle+0xbd/0x170
[  478.904002]  __blk_mq_tag_idle+0xbd/0x170
[  478.908023]  blk_mq_exit_hctx+0x4fc/0x610
[  478.912044]  ? blk_mq_realloc_hw_ctxs+0x2f5/0x4b0
[  478.916764]  blk_mq_realloc_hw_ctxs+0x2f5/0x4b0
[  478.921305]  ? __pfx_blk_mq_realloc_hw_ctxs+0x10/0x10
[  478.926360]  ? srso_return_thunk+0x5/0x10
[  478.930381]  ? blk_mq_realloc_tag_set_tags+0x80/0x370
[  478.935444]  __blk_mq_update_nr_hw_queues+0x851/0xd90
[  478.940506]  ? __pfx___up_read+0x10/0x10
[  478.944437]  ? __pfx___blk_mq_update_nr_hw_queues+0x10/0x10
[  478.950013]  ? srso_return_thunk+0x5/0x10
[  478.954038]  blk_mq_update_nr_hw_queues+0x29/0x40
[  478.958749]  nvme_tcp_configure_io_queues+0x5b1/0xa10 [nvme_tcp]
[  478.964762]  ? srso_return_thunk+0x5/0x10
[  478.968786]  ? __pfx_nvme_tcp_configure_io_queues+0x10/0x10 [nvme_tcp]
[  478.975316]  ? srso_return_thunk+0x5/0x10
[  478.979337]  nvme_tcp_setup_ctrl+0x40c/0xc70 [nvme_tcp]
[  478.984576]  nvme_tcp_reconnect_ctrl_work+0x59/0x1b0 [nvme_tcp]
[  478.990498]  ? srso_return_thunk+0x5/0x10
[  478.994514]  process_one_work+0x955/0x1660
[  478.998628]  ? __lock_acquired+0x207/0x7b0
[  479.002729]  ? __pfx_process_one_work+0x10/0x10
[  479.007260]  ? __pfx___lock_acquired+0x10/0x10
[  479.011715]  ? worker_thread+0x15a/0xef0
[  479.015645]  worker_thread+0x5be/0xef0
[  479.019414]  ? __pfx_worker_thread+0x10/0x10
[  479.023696]  kthread+0x2f4/0x3d0
[  479.026934]  ? __pfx_kthread+0x10/0x10
[  479.030688]  ret_from_fork+0x30/0x70
[  479.034272]  ? __pfx_kthread+0x10/0x10
[  479.038028]  ret_from_fork_asm+0x1b/0x30
[  479.041967]  </TASK>

[  479.045661] Allocated by task 1348:
[  479.049155]  kasan_save_stack+0x1e/0x40
[  479.052994]  kasan_set_track+0x21/0x30
[  479.056746]  __kasan_kmalloc+0x7b/0x90
[  479.060497]  blk_mq_init_tags+0x57/0x150
[  479.064423]  blk_mq_alloc_map_and_rqs+0xaa/0x310
[  479.069043]  __blk_mq_alloc_map_and_rqs+0x104/0x1f0
[  479.073922]  blk_mq_alloc_tag_set+0x73e/0xfa0
[  479.078281]  nvme_alloc_io_tag_set+0x344/0x600 [nvme_core]
[  479.083794]  nvme_tcp_configure_io_queues+0x3af/0xa10 [nvme_tcp]
[  479.089808]  nvme_tcp_setup_ctrl+0x40c/0xc70 [nvme_tcp]
[  479.095041]  nvme_tcp_create_ctrl+0x9d8/0xeb0 [nvme_tcp]
[  479.100364]  nvmf_create_ctrl+0x2e7/0x6a0 [nvme_fabrics]
[  479.105685]  nvmf_dev_write+0xd3/0x170 [nvme_fabrics]
[  479.110745]  vfs_write+0x20f/0xc40
[  479.114152]  ksys_write+0xf1/0x1d0
[  479.117559]  do_syscall_64+0x5c/0x90
[  479.121138]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

[  479.127697] Freed by task 117:
[  479.130758]  kasan_save_stack+0x1e/0x40
[  479.134596]  kasan_set_track+0x21/0x30
[  479.138347]  kasan_save_free_info+0x27/0x40
[  479.142535]  __kasan_slab_free+0x106/0x190
[  479.146633]  slab_free_freelist_hook+0x127/0x1e0
[  479.151252]  __kmem_cache_free+0xc2/0x2c0
[  479.155266]  __blk_mq_free_map_and_rqs+0x165/0x240
[  479.160057]  blk_mq_realloc_tag_set_tags+0x80/0x370
[  479.164936]  __blk_mq_update_nr_hw_queues+0x753/0xd90
[  479.169989]  blk_mq_update_nr_hw_queues+0x29/0x40
[  479.174694]  nvme_tcp_configure_io_queues+0x5b1/0xa10 [nvme_tcp]
[  479.180709]  nvme_tcp_setup_ctrl+0x40c/0xc70 [nvme_tcp]
[  479.185944]  nvme_tcp_reconnect_ctrl_work+0x59/0x1b0 [nvme_tcp]
[  479.191873]  process_one_work+0x955/0x1660
[  479.195973]  worker_thread+0x5be/0xef0
[  479.199725]  kthread+0x2f4/0x3d0
[  479.202958]  ret_from_fork+0x30/0x70
[  479.206535]  ret_from_fork_asm+0x1b/0x30

[  479.211961] The buggy address belongs to the object at ffff8881f98a1a00
                which belongs to the cache kmalloc-256 of size 256
[  479.224467] The buggy address is located 200 bytes inside of
                freed 256-byte region [ffff8881f98a1a00, ffff8881f98a1b00)

[  479.238213] The buggy address belongs to the physical page:
[  479.243787] page:000000001f2b6860 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x1f98a0
[  479.253179] head:000000001f2b6860 order:2 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[  479.261263] anon flags:
0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[  479.269091] page_type: 0xffffffff()
[  479.272586] raw: 0017ffffc0000840 ffff888100042b40 0000000000000000
dead000000000001
[  479.280323] raw: 0000000000000000 0000000000200020 00000001ffffffff
0000000000000000
[  479.288061] page dumped because: kasan: bad access detected

[  479.295133] Memory state around the buggy address:
[  479.299925]  ffff8881f98a1980: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[  479.307147]  ffff8881f98a1a00: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  479.314363] >ffff8881f98a1a80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  479.321583]                                               ^
[  479.327155]  ffff8881f98a1b00: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[  479.334376]  ffff8881f98a1b80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[  479.341595] ==================================================================
[  479.348815] Disabling lock debugging due to kernel taint
[  479.358515] nvme nvme2: Successfully reconnected (1 attempt)
[  480.172416] nvme nvme2: starting error recovery
[  480.178198] nvme nvme2: Reconnecting in 2 seconds...
[  482.238214] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  482.240080] nvme nvme2: creating 2 I/O queues.
[  482.251102] nvme nvme2: mapped 2/0/0 default/read/poll queues.
[  482.256264] nvme nvme2: Successfully reconnected (1 attempt)
[  482.490958] nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"


--
Best Regards,
  Yi Zhang

