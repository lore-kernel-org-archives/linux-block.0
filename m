Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B27C433EF
	for <linux-block@archiver.kernel.org>; Sun, 12 Jun 2022 07:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiFLHX5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Jun 2022 03:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFLHX4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Jun 2022 03:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 378BE2E9DA
        for <linux-block@vger.kernel.org>; Sun, 12 Jun 2022 00:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655018631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=MmcE7duW7Kv9hljlDQrUwDV3dtaPk2KpHKeurBsiEjc=;
        b=AY9D8rHB8fd0yURCwNn4QHfGCTZFCvU7l3IqCPSRCStncaphO9g0+lBrQA7eEGIbz2KXqz
        lLOC9AbcQfFs/alrzR7Iozoee3rHWIQLjWLPq3k/0VYVqIuCI+F9hd3DVBmMb/XaAjBZF8
        ORKKD3cljw2kDQKqSX8bKpX7hrIlTgo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-JdANefoOMVm1IlnxdJBNSg-1; Sun, 12 Jun 2022 03:23:49 -0400
X-MC-Unique: JdANefoOMVm1IlnxdJBNSg-1
Received: by mail-pj1-f71.google.com with SMTP id c11-20020a17090a4d0b00b001e4e081d525so4190688pjg.7
        for <linux-block@vger.kernel.org>; Sun, 12 Jun 2022 00:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MmcE7duW7Kv9hljlDQrUwDV3dtaPk2KpHKeurBsiEjc=;
        b=2Vp0TrF9NhiZLEYCcJzIOXynrjn/rJBs/AEBeEXU5RQ1du1VuFyetxmdQekqE0Vuzr
         U75GzzGLhLNe4UGBBOGdShujcLX7l5Nt9D+XHIDpge3KX74OENcFoCzo/OkeAvcz9ny3
         GX+cv3yMRUjXUR90KY2KPU/QTPQnWg+N8dZDtx4xLsB+6phpRqZoVv85B1beX9AJPS4d
         MxwEPnxjsbnw3qdgEN+t3JsDMrT3dvyyCQR+XFZ9L/vYyx5fSeMvfnOnkVKAs/bgN4jT
         H2yzaGSDCug/ab/b8tzrl9W0kD0mgxUHL/9TjymNyxnZ8tTWceoTpSdkCYquMxh+L2K3
         BCFA==
X-Gm-Message-State: AOAM530qJFEggUgfSkjUnRMZE5gUzwylLh4i0OwqiLa7qVpZ+T9lLsOI
        /97h0JAjlYOXlcTM7/v/MKEQdRPkUnYOzouGPJL+fkQzEkGYKqMl5dfZtNTu9phj4VMLdUtF5Ix
        UfaiOW6CuViBySi1neo9+DSC3ZFun/go8RYlHnSs=
X-Received: by 2002:a17:90a:5ae1:b0:1db:d0a4:30a4 with SMTP id n88-20020a17090a5ae100b001dbd0a430a4mr8915765pji.128.1655018627916;
        Sun, 12 Jun 2022 00:23:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnnnlMbkwBLneNa3SCjjbXuuQ+10i1Ooyz31Fy+abA98lUIu7tjgrSe87DdDY2EMnvhvTZu4DIw2XfpExVjEY=
X-Received: by 2002:a17:90a:5ae1:b0:1db:d0a4:30a4 with SMTP id
 n88-20020a17090a5ae100b001dbd0a430a4mr8915739pji.128.1655018627578; Sun, 12
 Jun 2022 00:23:47 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sun, 12 Jun 2022 15:23:36 +0800
Message-ID: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
Subject: [bug report] kmemleak observed from blktests on latest linux-block/for-next
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
I found below kmemleak with the latest linux-block/for-next[1], pls
help check it, thanks.

[1]
75d6654eb3ab (origin/for-next) Merge branch 'for-5.19/block' into for-next


unreferenced object 0xffff88831d0fe800 (size 256):
  comm "check", pid 15430, jiffies 4306578361 (age 70450.608s)
  hex dump (first 32 bytes):
    a0 08 80 ab ff ff ff ff 00 80 76 a6 83 88 ff ff  ..........v.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004bf8f45a>] blk_iolatency_init+0x4b/0x470
    [<00000000bdbef6c6>] blkcg_init_queue+0x122/0x4c0
    [<00000000549164e5>] __alloc_disk_node+0x23c/0x5b0
    [<0000000059f8cecc>] __blk_alloc_disk+0x31/0x60
    [<00000000a875060e>] nbd_config_put+0x6c1/0x7e0 [nbd]
    [<0000000086fab6c1>] nbd_start_device_ioctl+0x454/0x4a0 [nbd]
    [<000000009305a7c9>] configfs_write_iter+0x2b0/0x480
    [<0000000047e9815b>] new_sync_write+0x2ef/0x530
    [<0000000009113f79>] vfs_write+0x626/0x910
    [<00000000ef2d7042>] ksys_write+0xf9/0x1d0
    [<00000000ca06addd>] do_syscall_64+0x5c/0x80
    [<00000000e1ffe4b5>]
entry_SYSCALL_64_after_hwframe+0x46/0xb0unreferenced object
0xffff88818f43fe00 (size 256):
  comm "kworker/u32:13", pid 53617, jiffies 4370965500 (age 6066.292s)
  hex dump (first 32 bytes):
    a0 08 80 ab ff ff ff ff c0 62 c1 0d 81 88 ff ff  .........b......
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004bf8f45a>] blk_iolatency_init+0x4b/0x470
    [<00000000bdbef6c6>] blkcg_init_queue+0x122/0x4c0
    [<00000000549164e5>] __alloc_disk_node+0x23c/0x5b0
    [<0000000059f8cecc>] __blk_alloc_disk+0x31/0x60
    [<0000000031ca7691>] nvme_mpath_alloc_disk+0x28a/0x8a0 [nvme_core]
    [<000000002038acbe>] nvme_alloc_ns_head+0x40c/0x740 [nvme_core]
    [<00000000e54cea22>] nvme_init_ns_head+0x4a3/0xa40 [nvme_core]
    [<000000007694f30a>] nvme_alloc_ns+0x3c7/0x1690 [nvme_core]
    [<0000000085ede1e2>] nvme_validate_or_alloc_ns+0x240/0x400 [nvme_core]
    [<000000001de40492>] nvme_scan_ns_list+0x20b/0x550 [nvme_core]
    [<00000000e799d365>] nvme_scan_work+0x2d2/0x760 [nvme_core]
    [<000000005b788977>] process_one_work+0x8d4/0x14d0
    [<00000000c452e193>] worker_thread+0x5ac/0xec0
    [<000000005065b8e4>] kthread+0x2a7/0x350
    [<00000000fe3dc1db>] ret_from_fork+0x22/0x30
unreferenced object 0xffff888720279c00 (size 256):
  comm "kworker/u32:2", pid 62305, jiffies 4370965926 (age 6065.866s)
  hex dump (first 32 bytes):
    a0 08 80 ab ff ff ff ff 58 8c b0 88 85 88 ff ff  ........X.......
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004bf8f45a>] blk_iolatency_init+0x4b/0x470
    [<00000000bdbef6c6>] blkcg_init_queue+0x122/0x4c0
    [<00000000549164e5>] __alloc_disk_node+0x23c/0x5b0
    [<0000000059f8cecc>] __blk_alloc_disk+0x31/0x60
    [<0000000031ca7691>] nvme_mpath_alloc_disk+0x28a/0x8a0 [nvme_core]
    [<000000002038acbe>] nvme_alloc_ns_head+0x40c/0x740 [nvme_core]
    [<00000000e54cea22>] nvme_init_ns_head+0x4a3/0xa40 [nvme_core]
    [<000000007694f30a>] nvme_alloc_ns+0x3c7/0x1690 [nvme_core]
    [<0000000085ede1e2>] nvme_validate_or_alloc_ns+0x240/0x400 [nvme_core]
    [<000000001de40492>] nvme_scan_ns_list+0x20b/0x550 [nvme_core]
    [<00000000e799d365>] nvme_scan_work+0x2d2/0x760 [nvme_core]
    [<000000005b788977>] process_one_work+0x8d4/0x14d0
    [<00000000c452e193>] worker_thread+0x5ac/0xec0
    [<000000005065b8e4>] kthread+0x2a7/0x350
    [<00000000fe3dc1db>] ret_from_fork+0x22/0x30
unreferenced object 0xffff888163681c00 (size 256):
  comm "kworker/u32:13", pid 53617, jiffies 4370966347 (age 6065.585s)
  hex dump (first 32 bytes):
    a0 08 80 ab ff ff ff ff 60 31 b2 9c 82 88 ff ff  ........`1......
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004bf8f45a>] blk_iolatency_init+0x4b/0x470
    [<00000000bdbef6c6>] blkcg_init_queue+0x122/0x4c0
    [<00000000549164e5>] __alloc_disk_node+0x23c/0x5b0
    [<0000000059f8cecc>] __blk_alloc_disk+0x31/0x60
    [<0000000031ca7691>] nvme_mpath_alloc_disk+0x28a/0x8a0 [nvme_core]
    [<000000002038acbe>] nvme_alloc_ns_head+0x40c/0x740 [nvme_core]
    [<00000000e54cea22>] nvme_init_ns_head+0x4a3/0xa40 [nvme_core]
    [<000000007694f30a>] nvme_alloc_ns+0x3c7/0x1690 [nvme_core]
    [<0000000085ede1e2>] nvme_validate_or_alloc_ns+0x240/0x400 [nvme_core]
    [<000000001de40492>] nvme_scan_ns_list+0x20b/0x550 [nvme_core]
    [<00000000e799d365>] nvme_scan_work+0x2d2/0x760 [nvme_core]
    [<000000005b788977>] process_one_work+0x8d4/0x14d0
    [<00000000c452e193>] worker_thread+0x5ac/0xec0
    [<000000005065b8e4>] kthread+0x2a7/0x350
    [<00000000fe3dc1db>] ret_from_fork+0x22/0x30
-- 
Best Regards,
  Yi Zhang

