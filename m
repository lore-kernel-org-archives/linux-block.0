Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2237C433EF
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 19:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8626561108
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhKCT4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 15:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCT4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 15:56:51 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA23C061714;
        Wed,  3 Nov 2021 12:54:15 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id s7-20020a056830148700b0055ad72acb7eso4070429otq.1;
        Wed, 03 Nov 2021 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IRKf+D/zd6BLYbUqLMNdoacDfMkBwMr/G6Hfc9iGdy8=;
        b=aBzg1B3nKy676j15fQP0xW/OHkTqUJNqxZL+hVmywUVVa7d+jI9R8QvuB1EJDXXi3N
         GNYi6YdVp+r5X/GiCRKT2lndDhKkKPtSwnhutvXutw9aiabxHLzxfqX+CZ4snpBqu5PF
         +zPEK6BFoyJ4B09wbhfWtWQ7P4G2qJqLZfuQS5vowlEWTasETyFrR6tXqxwgvXcv0Vbh
         ayhVV1Qoib2CzvchljZXm4skTynNHwsRgxP/uh8y4+myGtHWhn61FDMhxMpazpSKpZmh
         7E/G5Wqu+k6StwDzL/BFTRyLmjnUilVqzLcuanbQsJQ5jfLZs6qN5DXaAG/fLR6Y6iLI
         gZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IRKf+D/zd6BLYbUqLMNdoacDfMkBwMr/G6Hfc9iGdy8=;
        b=eEJgOO9vbC3UnuH9HzXqAdbskpJKilDgA+6z5qNsqmBr9W8/VvdkUTTrTolpc9XYyb
         KjuKBB0K8hnZEPH6K0GxgRznbzeDA98DGHd12Po1pOpia66SJSNx2lKmtvayWdhzbZ2Q
         VK6TsaC7djhSA3XOTb6pobKPLZAqy96/TKG5PaOVFe8YJgt6BI+WSlEBMeG6ZytXr3bA
         47gbnxiqZjU0DB2OKlOFNqcPF6nazPJVGDubr7RG/5jnnNBmwbpcqyyvmcDfdwF6fKnc
         3I1XWqt4wZwT/SQQDI+mbnLX38TItJnvIazxHWw1rF8AQWetIJ4AdqlHHAe1eXTYZPOi
         prCQ==
X-Gm-Message-State: AOAM531t3PVVjFCnECCrKoe4zJtYklmiaFIeHXnrp9zoqlJaViEHFlwE
        gPvazgiBkOr9TxiF1GHWPcs=
X-Google-Smtp-Source: ABdhPJxvkZe19oX3AH8CHIsTv8knI++FLqSvxymC2HFqJrcvfJEXbJhF1/IpJUK3vgJoGfWeYnxyKw==
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr22154921otp.280.1635969254475;
        Wed, 03 Nov 2021 12:54:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2sm866428oiv.32.2021.11.03.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 12:54:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 3 Nov 2021 12:54:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] block: add rq_flags to struct blk_mq_alloc_data
Message-ID: <20211103195411.GA3156469@roeck-us.net>
References: <20211019153300.623322-1-axboe@kernel.dk>
 <20211019153300.623322-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019153300.623322-2-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Tue, Oct 19, 2021 at 09:32:57AM -0600, Jens Axboe wrote:
> There's a hole here we can use, and it's faster to set this earlier
> rather than need to check q->elevator multiple times.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

This patch results in a warning backtrace with one of my qemu
boot tests.

[   48.268501] ------------[ cut here ]------------
[   48.268620] WARNING: CPU: 0 PID: 1 at block/blk-mq-sched.c:432 blk_mq_sched_insert_request+0x3e/0x150
[   48.268771] Modules linked in:
[   48.268973] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0+ #1
[   48.269198] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   48.269419] RIP: 0010:blk_mq_sched_insert_request+0x3e/0x150
[   48.269613] Code: ec 20 4c 8b 47 08 4c 8b 77 10 65 48 8b 04 25 28 00 00 00 48 89 44 24 18 48 8b 07 4c 8b 78 08 4d 85 ff 74 08 83 7f 20 ff 74 02 <0f> 0b f6 45 1c 10 0f 85 a6 00 00 00 0f b6 45 18 44 0f b6 e6 83 e8
[   48.269851] RSP: 0018:ffff991500013a00 EFLAGS: 00000217
[   48.269955] RAX: ffff88e4c36e8ce8 RBX: 0000000000000001 RCX: 0000000000000000
[   48.270131] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff88e4c369d340
[   48.270232] RBP: ffff88e4c369d340 R08: ffffb914ffc02f80 R09: 0000000000000000
[   48.270328] R10: ffff88e4c2d419e0 R11: 0000000000000001 R12: 0000000000000001
[   48.270423] R13: 0000000000000000 R14: ffff88e4c36e4c00 R15: ffff88e4c3818400
[   48.270566] FS:  0000000000000000(0000) GS:ffff88e4fbc00000(0000) knlGS:0000000000000000
[   48.270679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.270767] CR2: 0000000000000000 CR3: 0000000116422000 CR4: 00000000003506f0
[   48.270926] Call Trace:
[   48.271310]  ? lockdep_init_map_type+0x47/0x240
[   48.271469]  blk_execute_rq+0x5c/0xe0
[   48.271648]  __scsi_execute+0x158/0x2b0
[   48.271744]  __scsi_scan_target+0x2e1/0x4d0
[   48.271897]  scsi_scan_target+0xd4/0xf0
[   48.271990]  sas_rphy_add+0x123/0x180
[   48.272170]  mptsas_add_end_device.isra.0.cold+0x89/0xc8
[   48.272267]  ? mptsas_refreshing_device_handles+0x70/0xd0
[   48.272364]  mptsas_scan_sas_topology+0x147/0x290
[   48.272441]  ? _raw_spin_unlock_irqrestore+0x3d/0x70
[   48.272571]  mptsas_probe+0x3b2/0x470
[   48.272656]  local_pci_probe+0x3d/0x70
[   48.272739]  pci_device_probe+0xc6/0x150
[   48.272835]  really_probe.part.0+0xa0/0x290
[   48.272918]  __driver_probe_device+0x8b/0x120
[   48.272998]  driver_probe_device+0x19/0x90
[   48.273147]  __driver_attach+0x79/0x120
[   48.273212]  ? __device_attach_driver+0x90/0x90
[   48.273289]  bus_for_each_dev+0x76/0xc0
[   48.273376]  bus_add_driver+0x109/0x1b0
[   48.273455]  driver_register+0x8a/0xe0
[   48.273515]  ? fusion_init+0x103/0x103
[   48.273583]  mptsas_init+0x10f/0x128
[   48.273649]  do_one_initcall+0x56/0x2e0
[   48.273741]  ? rcu_read_lock_sched_held+0x3a/0x70
[   48.273828]  kernel_init_freeable+0x24c/0x299
[   48.273898]  ? rest_init+0x250/0x250
[   48.273969]  kernel_init+0x11/0x110
[   48.274099]  ret_from_fork+0x22/0x30
[   48.274304] irq event stamp: 10417319
[   48.274371] hardirqs last  enabled at (10417327): [<ffffffffa6ae0f22>] __up_console_sem+0x62/0x70
[   48.274523] hardirqs last disabled at (10417334): [<ffffffffa6ae0f07>] __up_console_sem+0x47/0x70
[   48.274637] softirqs last  enabled at (10416158): [<ffffffffa6a73db8>] irq_exit_rcu+0xd8/0x120
[   48.274756] softirqs last disabled at (10416145): [<ffffffffa6a73db8>] irq_exit_rcu+0xd8/0x120
[   48.274937] ---[ end trace 3376dfd19d6a9ecf ]---

Bisect log is attached.

Guenter

---
# bad: [dcd68326d29b62f3039e4f4d23d3e38f24d37360] Merge tag 'devicetree-for-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
# good: [8bb7eca972ad531c9b149c0a51ab43a417385813] Linux 5.15
git bisect start 'HEAD' 'v5.15'
# good: [84882cf72cd774cf16fd338bdbf00f69ac9f9194] Revert "net: avoid double accounting for pure zerocopy skbs"
git bisect good 84882cf72cd774cf16fd338bdbf00f69ac9f9194
# bad: [d2fac0afe89fe30c39eaa98dda71f7c4cea190c2] Merge tag 'audit-pr-20211101' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
git bisect bad d2fac0afe89fe30c39eaa98dda71f7c4cea190c2
# bad: [8cb1ae19bfae92def42c985417cd6e894ddaa047] Merge tag 'x86-fpu-2021-11-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 8cb1ae19bfae92def42c985417cd6e894ddaa047
# bad: [71ae42629e65edab618651c8ff9c88e1edd717aa] Merge tag 'for-5.16/passthrough-flag-2021-10-29' of git://git.kernel.dk/linux-block
git bisect bad 71ae42629e65edab618651c8ff9c88e1edd717aa
# bad: [33c8846c814c1c27c6e33af005042d15061f948b] Merge tag 'for-5.16/block-2021-10-29' of git://git.kernel.dk/linux-block
git bisect bad 33c8846c814c1c27c6e33af005042d15061f948b
# good: [057178cf518e699695a4b614a7a08c350b1fdcfd] fs: bdev: fix conflicting comment from lookup_bdev
git bisect good 057178cf518e699695a4b614a7a08c350b1fdcfd
# good: [203a31516616111b8eaaf00c16fa3fcaa25e6f81] mm/writeback: Add __folio_mark_dirty()
git bisect good 203a31516616111b8eaaf00c16fa3fcaa25e6f81
# bad: [02f7eab0095a47b45f48a4321d33de3569c59061] block: improve readability of blk_mq_end_request_batch()
git bisect bad 02f7eab0095a47b45f48a4321d33de3569c59061
# good: [54a88eb838d37af930c9f19e1930a4fba6789cb5] block: add single bio async direct IO helper
git bisect good 54a88eb838d37af930c9f19e1930a4fba6789cb5
# good: [842e39b013465a279fb60348427b9309427a29de] block: add async version of bio_set_polled
git bisect good 842e39b013465a279fb60348427b9309427a29de
# bad: [c7b84d4226adaa601e9f73574ef123d1500cf712] block: re-flow blk_mq_rq_ctx_init()
git bisect bad c7b84d4226adaa601e9f73574ef123d1500cf712
# bad: [fe6134f66906dfa16d4877cab60106275f48eef7] block: pass in blk_mq_tags to blk_mq_rq_ctx_init()
git bisect bad fe6134f66906dfa16d4877cab60106275f48eef7
# bad: [56f8da642bd827ef50a952e7bc3728c5830452be] block: add rq_flags to struct blk_mq_alloc_data
git bisect bad 56f8da642bd827ef50a952e7bc3728c5830452be
# first bad commit: [56f8da642bd827ef50a952e7bc3728c5830452be] block: add rq_flags to struct blk_mq_alloc_data
