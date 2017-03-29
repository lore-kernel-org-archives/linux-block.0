Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33907 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbdC2RCY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2017 13:02:24 -0400
Received: by mail-wr0-f180.google.com with SMTP id l43so24555871wre.1
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2017 10:02:23 -0700 (PDT)
Received: from [192.168.64.116] (bzq-82-81-101-184.red.bezeqint.net. [82.81.101.184])
        by smtp.gmail.com with ESMTPSA id 140sm1154720wmk.12.2017.03.29.10.02.20
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Mar 2017 10:02:20 -0700 (PDT)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: kmemleak complaints on request queue stats (virtio)
Message-ID: <c1659bc3-82e1-7d05-cec7-d5a6e78bd8e5@grimberg.me>
Date: Wed, 29 Mar 2017 20:02:19 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

I just got the below kmemleak report. Just thought I'd send it
out as I don't have time to look into it just now...

--
unreferenced object 0xffff8ab236717920 (size 32):
   comm "swapper/0", pid 1, jiffies 4294892551 (age 9966.044s)
   hex dump (first 32 bytes):
     20 79 71 36 b2 8a ff ff 20 79 71 36 b2 8a ff ff   yq6.... yq6....
     00 00 00 00 ff ff ff ff e0 c1 4b 9b ff ff ff ff  ..........K.....
   backtrace:
     [<ffffffff9b84212a>] kmemleak_alloc+0x4a/0xa0
     [<ffffffff9b1ff780>] kmem_cache_alloc_trace+0x110/0x230
     [<ffffffff9b3cd74f>] blk_alloc_queue_stats+0x1f/0x40
     [<ffffffff9b3bacd4>] blk_alloc_queue_node+0x94/0x2e0
     [<ffffffff9b3cbdd0>] blk_mq_init_queue+0x20/0x60
     [<ffffffff9b593665>] loop_add+0xe5/0x270
     [<ffffffff9bfe348b>] loop_init+0x10b/0x149
     [<ffffffff9b002193>] do_one_initcall+0x53/0x1a0
     [<ffffffff9bf8b133>] kernel_init_freeable+0x16d/0x1f3
     [<ffffffff9b83ed0e>] kernel_init+0xe/0x100
     [<ffffffff9b84d27c>] ret_from_fork+0x2c/0x40
     [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff8ab23666d440 (size 32):
   comm "swapper/0", pid 1, jiffies 4294892552 (age 9966.040s)
   hex dump (first 32 bytes):
     40 d4 66 36 b2 8a ff ff 40 d4 66 36 b2 8a ff ff  @.f6....@.f6....
     00 00 00 00 00 00 00 00 2a 21 84 9b ff ff ff ff  ........*!......
   backtrace:
     [<ffffffff9b84212a>] kmemleak_alloc+0x4a/0xa0
     [<ffffffff9b1ff780>] kmem_cache_alloc_trace+0x110/0x230
     [<ffffffff9b3cd74f>] blk_alloc_queue_stats+0x1f/0x40
     [<ffffffff9b3bacd4>] blk_alloc_queue_node+0x94/0x2e0
     [<ffffffff9b3cbdd0>] blk_mq_init_queue+0x20/0x60
     [<ffffffff9b596382>] virtblk_probe+0x172/0x700
     [<ffffffff9b4e3193>] virtio_dev_probe+0x143/0x1f0
     [<ffffffff9b56eb7f>] driver_probe_device+0x2bf/0x460
     [<ffffffff9b56edff>] __driver_attach+0xdf/0xf0
     [<ffffffff9b56c914>] bus_for_each_dev+0x64/0xa0
     [<ffffffff9b56e3ce>] driver_attach+0x1e/0x20
     [<ffffffff9b56decd>] bus_add_driver+0x1fd/0x270
     [<ffffffff9b56f910>] driver_register+0x60/0xe0
     [<ffffffff9b4e2e10>] register_virtio_driver+0x20/0x30
     [<ffffffff9bfe351a>] init+0x51/0x7e
     [<ffffffff9b002193>] do_one_initcall+0x53/0x1a0
--
