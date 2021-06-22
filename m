Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655A6C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2A66128A
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFVIG4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhFVIGz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 04:06:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E57C061756
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 01:04:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c7so21462652edn.6
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 01:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wRiv4b5WCsNmBOe8z/0E9iqnsbLYuXJBYt7Qh5py9mM=;
        b=HLm23EB6zBptzHrcAEoEks0I4zvtC/VAJT6ENIws+DrAvg4yGraj4Om3t+uddwhoLw
         4DIrfJzE2PQlgYP+PaNRwQzDtOX6QPrPHjkmTnncleg/vaWGzHEzlGxPs/nVVv/ky3zH
         +T96BBVKtLqPBH9h5K1QNKD2QkD/6Ubm0Oo8zyDVqdKNlR6+hbsMQK1zmCZq3iVrhpTD
         7aiztrNLL/gcW1gg6HG6KdyNO41EN9afxz8rKW07wrJmABnLg8XeLue6XsfPCVTSQaiq
         lIwOjtz3ZGjaVdHdw0pmOX42bhCpP4+tfZmzYDM5391aF6wCBuYWTV0uK09Zj5fgj+Cw
         7EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wRiv4b5WCsNmBOe8z/0E9iqnsbLYuXJBYt7Qh5py9mM=;
        b=edJNIN3v7BAXUvEf5Eem0MeyAXhrVSj4eLpNb60S4sLJXVqWXAg04m6El1DJtVHFjy
         cjPBcKKvWGPqy5gEPo4spFrQzbQdf0Wzx/KGlcJ2i/IOjKCaJ8Cj5kbToX91mYfxXBkH
         JTjw+DrtQLJ4UMm9nFpCfuccv6hIVA4yVH6fl8k68bUFo7YsJGLXduwg2pzHA5zKWd+D
         WywTIe1Fs00BLNxoZ7kUiKbx46TVEhlqZwf3ycfOA8wpiKvblEgDmyWp+jCwsnCOABL1
         KceATG/k+OVHri24iRmI56eSbYoGXxw206bwFu2S88eP6+BKkyrkvQsZnblt+3d0s0gw
         ABbw==
X-Gm-Message-State: AOAM531e/0pNxwVdH3XDGnsAnTIbWy7C207PFz8sjQrNgFGfywKQs+Mg
        oxAPc5EY2Kt1skWPFRuPDX7anvSlgYs6N3N2YQ6tUjlgVZb7cGOs
X-Google-Smtp-Source: ABdhPJwk7iWH/SwmyWjCBAA5vY2Aq8e+nQIhbDPhgVLEN1LsG8pEcH/C2WYn5b7mXKfKSe9Oay+A5YEwHqh5Gy79Tuc=
X-Received: by 2002:a05:6402:90a:: with SMTP id g10mr3180781edz.365.1624349076439;
 Tue, 22 Jun 2021 01:04:36 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Jun 2021 13:34:25 +0530
Message-ID: <CA+G9fYtbNfqqM6Hs9XpweFjYALHGTJ9yo3xkg8O3=Lq2grFDSQ@mail.gmail.com>
Subject: WARNING: at block/genhd.c:491 __device_add_disk
To:     linux-block <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, yukuai3@huawei.com,
        chengzhihao1@huawei.com, alexander.sverdlin@nokia.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[Please ignore if is already reported]

Regression found,

The following kernel warnings reported on Linux next 20210621 while booting
arm64 hikey and db410c and arm BeagleBoard-X15 devices.

This crash is always reproducible on these devices while booting with the
provided config link.

Crash log:
-------------
[    0.698533] mmcblk1: mmc1:aaaa SC16G 14.8 GiB
[    0.699161] ------------[ cut here ]------------
[    0.699167] WARNING: CPU: 6 PID: 55 at block/genhd.c:491
__device_add_disk+0x3f0/0x468
[    0.699189] Modules linked in:
[    0.699202] CPU: 6 PID: 55 Comm: kworker/6:1 Not tainted
5.13.0-rc7-next-20210621 #1
[    0.699211] Hardware name: HiKey Development Board (DT)
[    0.699219] Workqueue: events_freezable mmc_rescan
[    0.699236] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[    0.699244] pc : __device_add_disk+0x3f0/0x468
[    0.699252] lr : __device_add_disk+0x3b4/0x468
[    0.699259] sp : ffff800012cfb960
[    0.699264] x29: ffff800012cfb960 x28: ffff000001e3a000 x27: ffff000001be7008
[    0.699280] x26: 000000000000ffff x25: ffff800011ab4980 x24: ffff8000129b2600
[    0.699297] x23: 0000000000000001 x22: ffff000001e3a008 x21: 0000000000000000
[    0.699312] x20: 00000000006d4c00 x19: ffff000000881400 x18: 0000000000000000
[    0.699328] x17: 000000040044ffff x16: 00400032b5503510 x15: 0000000000000068
[    0.699344] x14: 00000000000000c0 x13: ffff000077bd3e28 x12: ffff000077bd3e38
[    0.699360] x11: 0000000000000000 x10: ffff000077bd3e18 x9 : ffff80001058b910
[    0.699376] x8 : ffff000000b08280 x7 : 000004e20000007d x6 : 0000000000000001
[    0.699392] x5 : ffff8000125af000 x4 : 0000000000000000 x3 : ffff000002078630
[    0.699408] x2 : 0000000000000000 x1 : 00000000000000b3 x0 : 0000000000000000
[    0.699424] Call trace:
[    0.699428]  __device_add_disk+0x3f0/0x468
[    0.699436]  device_add_disk+0x1c/0x28
[    0.699444]  mmc_add_disk+0x34/0x130
[    0.699458]  mmc_blk_probe+0x22c/0x5c0
[    0.699465]  mmc_bus_probe+0x28/0x38
[    0.699474]  really_probe+0xf0/0x4d0
[    0.699485]  driver_probe_device+0x108/0x178
[    0.699494]  __device_attach_driver+0xa0/0x128
[    0.699503]  bus_for_each_drv+0x80/0xd8
[    0.699511]  __device_attach+0xfc/0x180
[    0.699519]  device_initial_probe+0x1c/0x28
[    0.699528]  bus_probe_device+0xa4/0xb0
[    0.699535]  device_add+0x3b0/0x888
[    0.699543]  mmc_add_card+0x130/0x2c8
[    0.699552]  mmc_attach_sd+0x108/0x180
[    0.699559]  mmc_rescan+0x264/0x2e8
[    0.699567]  process_one_work+0x1c8/0x488
[    0.699577]  worker_thread+0x54/0x428
[    0.699584]  kthread+0x140/0x158
[    0.699594]  ret_from_fork+0x10/0x18
[    0.699605] ---[ end trace 8adf6c66e7d9ad4a ]---
[    0.702534]  mmcblk1: p1
[    0.704019] mmc0: new high speed MMC card at address 0001
[    0.705185] mmcblk0: mmc0:000#
1 008GE0 7.28 GiB
[    0.705582] mmcblk0boot0: mmc0:0001 008GE0 4.00 MiB
[    0.705968] mmcblk0boot1: mmc0:0001 008GE0 4.00 MiB
[    0.706274] mmcblk0rpmb: mmc0:0001 008GE0 4.00 MiB, chardev (511:0)
[    0.707032] ------------[ cut here ]------------
[    0.707038] WARNING: CPU: 2 PID: 24 at block/genhd.c:491
__device_add_disk+0x3f0/0x468
[    0.707059] Modules linked in:
[    0.707070] CPU: 2 PID: 24 Comm: kworker/2:0 Tainted: G        W
     5.13.0-rc7-next-20210621 #1
[    0.707079] Hardware name: HiKey Development Board (DT)
[    0.707086] Workqueue: events_freezable mmc_rescan
[    0.707102] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[    0.707110] pc : __device_add_disk+0x3f0/0x468
[    0.707118] lr : __device_add_disk+0x3b4/0x468
[    0.707126] sp : ffff800012c03960
[    0.707131] x29: ffff800012c03960 x28: ffff000000b50800 x27: ffff000000b50dc0
[    0.707148] x26: 0000000000000003 x25: ffff000000b4cc00 x24: ffff800012ab54e8
[    0.707165] x23: 0000000000000001 x22: ffff000000b50808 x21: 0000000000000000
[    0.707182] x20: 0000000000000000 x19: ffff000001158e00 x18: 0000000000000001
[    0.707198] x17: 000000040044ffff x16: 00400032b5503510 x15: 0000000000000068
[    0.707215] x14: 00000000000000c0 x13: ffff000077bd3e28 x12: ffff000077bd3e38
[    0.707232] x11: 0000000000000000 x10: ffff000077bd3e18 x9 : ffff80001058b910
[    0.707249] x8 : ffff000000b8ad80 x7 : 000004e20000007d x6 : 0000000000000001
[    0.707266] x5 : ffff8000125af000 x4 : 0000000000000000 x3 : ffff000002210630
[    0.707282] x2 : 0000000000000000 x1 : 00000000000000b3 x0 : 0000000000000000
[    0.707298] Call trace:
[    0.707303]  __device_add_disk+0x3f0/0x468
[    0.707311]  device_add_disk+0x1c/0x28
[    0.707319]  mmc_add_disk+0x34/0x130
[    0.707330]  mmc_blk_probe+0x22c/0x5c0
[    0.707337]  mmc_bus_probe+0x28/0x38
[    0.707346]  really_probe+0xf0/0x4d0
[    0.707356]  driver_probe_device+0x108/0x178
[    0.707365]  __device_attach_driver+0xa0/0x128
[    0.707374]  bus_for_each_drv+0x80/0xd8
[    0.707382]  __device_attach+0xfc/0x180
[    0.707390]  device_initial_probe+0x1c/0x28
[    0.707399]  bus_probe_device+0xa4/0xb0
[    0.707407]  device_add+0x3b0/0x888
[    0.707415]  mmc_add_card+0x130/0x2c8
[    0.707424]  mmc_attach_mmc+0x100/0x188
[    0.707434]  mmc_rescan+0x278/0x2e8
[    0.707442]  process_one_work+0x1c8/0x488
[    0.707452]  worker_thread+0x54/0x428
[    0.707459]  kthread+0x140/0x158
[    0.707469]  ret_from_fork+0x10/0x18
[    0.707479] ---[ end trace 8adf6c66e7d9ad4b ]---
[    0.709232] #
ssp-pl022 f7106000.spi: mapped registers from 0x00000000f7106000 to
(____ptrval____)
[    0.709548] random: fast init done
[    0.711961] Alternate GPT is invalid, using primary GPT.
[    0.712006]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9
[    0.716939] ------------[ cut here ]------------
[    0.716948] WARNING: CPU: 2 PID: 24 at block/genhd.c:491
__device_add_disk+0x3f0/0x468
[    0.723287] ssp-pl022 f7106000.spi: setup for DMA on RX dma0chan0,
TX dma0chan1
[    0.726001] Modules linked in:
[    0.726013] CPU: 2 PID: 24 Comm: kworker/2:0 Tainted: G        W
     5.13.0-rc7-next-20210621 #1
[    0.737893] i2c 2-0039: Fixing up cyclic dependency with f7118000.i2s
[    0.742981] Hardware name: HiKey Development Board (DT)
[    0.742989] Workqueue: events_freezable mmc_rescan
[    0.743007] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[    0.743015] pc : __device_add_disk+0x3f0/0x468
[    0.743024] lr : __device_add_disk+0x3b4/0x468
[    0.743031] sp : ffff800012c03960
[    0.749384] i2c 2-0039: Fixing up cyclic dependency with f4107800.dsi
[    0.755557] x29: ffff800012c03960 x28: ffff000000b50800 x27: ffff000000b50dc0
[    0.755575] x26: 0000000000000003
[    0.768296] dwc2 f72c0000.usb: supply vusb_d not found, using dummy regulator
[    0.774353]  x25: ffff000000b4cc00 x24: ffff000000b4bc00
[    0.774366] x23: 0000000000000001 x22: ffff000002480040 x21: 0000000000000000
[    0.774382] x20: 0000000000000000
[    0.780881] dwc2 f72c0000.usb: supply vusb_a not found, using dummy regulator
[    0.786905]  x19: ffff00000115a600 x18: 0000000000000000
[    0.786918] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000068
[    3.165562] x14: 00000000000000c0 x13: ffff000077bd3e28 x12: ffff000077bd3e38
[    3.172714] x11: 0000000000000000 x10: ffff000077bd3e18 x9 : ffff80001058b910
[    3.179866] x8 : ffff000002398200 x7 : 000004e20000007d x6 : 0000000000000001
[    3.187018] x5 : ffff8000125af000 x4 : 0000000000000000 x3 : ffff000002211680
[    3.194170] x2 : 0000000000000000 x1 : 00000000000000b3 x0 : 0000000000000000
[    3.201323] Call trace:
[    3.203768]  __device_add_disk+0x3f0/0x468
[    3.207870]  device_add_disk+0x1c/0x28
[    3.211622]  mmc_add_disk+0x34/0x130
[    3.215204]  mmc_blk_probe+0x4c4/0x5c0
[    3.218956]  mmc_bus_probe+0x28/0x38
[    3.222536]  really_probe+0xf0/0x4d0
[    3.226118]  driver_probe_device+0x108/0x178
[    3.230393]  __device_attach_driver+0xa0/0x128
[    3.234842]  bus_for_each_drv+0x80/0xd8
[    3.238683]  __device_attach+0xfc/0x180
[    3.242523]  device_initial_probe+0x1c/0x28
[    3.246711]  bus_probe_device+0xa4/0xb0
[    3.250550]  device_add+0x3b0/0x888
[    3.254041]  mmc_add_card+0x130/0x2c8
[    3.257707]  mmc_attach_mmc+0x100/0x188
[    3.261549]  mmc_rescan+0x278/0x2e8
[    3.265041]  process_one_work+0x1c8/0x488
[    3.269056]  worker_thread+0x54/0x428
[    3.272721]  kthread+0x140/0x158
[    3.275955]  ret_from_fork+0x10/0x18
[    3.279537] ---[ end trace 8adf6c66e7d9ad4c ]---
[    3.286558] ------------[ cut here ]------------
[    3.291203] WARNING: CPU: 2 PID: 24 at block/genhd.c:491
__device_add_disk+0x3f0/0x468
[    3.299142] Modules linked in:
[    3.302205] CPU: 2 PID: 24 Comm: kworker/2:0 Tainted: G        #
W         5.13.0-rc7-next-20210621 #1
[    3.311350] Hardware name: HiKey Development Board (DT)
[    3.316580] Workqueue: events_freezable mmc_rescan
[    3.321383] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[    3.327396] pc : __device_add_disk+0x3f0/0x468
[    3.331843] lr : __device_add_disk+0x3b4/0x468
[    3.336291] sp : ffff800012c03960
[    3.339605] x29: ffff800012c03960 x28: ffff000000b50800 x27: ffff000000b50dc0
[    3.346759] x26: 0000000000000003 x25: ffff000000b4cc00 x24: ffff000000b4ac00
[    3.353911] x23: 0000000000000001 x22: ffff000002480040 x21: 0000000000000000
[    3.361064] x20: 0000000000000000 x19: ffff000001159a00 x18: 0000000000000000
[    3.368216] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000068
[    3.375367] x14: 00000000000000c0 x13: ffff000077bd3e28 x12: ffff000077bd3e38
[    3.382520] x11: 0000000000000000 x10: ffff000077bd3e18 x9 : ffff80001058b910
[    3.389672] x8 : ffff000002398280 x7 : 000004e20000007d x6 : 0000000000000001
[    3.396825] x5 : ffff8000125af000 x4 : 0000000000000000 x3 : ffff000002210e58
[    3.403977] x2 : 0000000000000000 x1 : 00000000000000b3 x0 : 0000000000000000
[    3.411129] Call trace:
[    3.413574]  __device_add_disk+0x3f0/0x468
[    3.417674]  device_add_disk+0x1c/0x28
[    3.421427]  mmc_add_disk+0x34/0x130
[    3.425009]  mmc_blk_probe+0x4c4/0x5c0
[    3.428760]  mmc_bus_probe+0x28/0x38
[    3.432339]  really_probe+0xf0/0x4d0
[    3.435920]  driver_probe_device+0x108/0x178
[    3.440195]  __device_attach_driver+0xa0/0x128
[    3.441134] dwc2 f72c0000.usb: EPs: 16, dedicated fifos, 1920
entries in SPRAM
[    3.444644]  bus_for_each_drv+0x80/0xd8
[    3.452320] dwc2 f72c0000.usb: DWC OTG Controller
[    3.455701]  __device_attach+0xfc/0x180
[    3.455710]  device_initial_probe+0x1c/0x28
[    3.455718]  bus_probe_device+0xa4/0xb0
[    3.460467] dwc2 f72c0000.usb: new USB bus registered, assigned bus number 1
[    3.464257]  device_add+0x3b0/0x888
[    3.464265]  mmc_add_card+0x130/0x2c8
[    3.468531] dwc2 f72c0000.usb: irq 47, io mem 0xf72c0000
[    3.472282]  mmc_attach_mmc+0x100/0x188
[    3.472292]  mmc_rescan+0x278/0x2e8
[    3.481061] hub 1-0:1.0: USB hub found
[    3.482831]  process_one_work+0x1c8/0x488
[    3.486589] hub 1-0:1.0: 1 port detected
[    3.491822]  worker_thread+0x54/0x428
[    3.491830]  kthread+0x140/0x158
[    3.491840]  ret_from_fork+0x10/0x18
[    3.491852] ---[ end trace 8adf6c66e7d9ad4d ]---

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git describe: next-20210621
  kernel-config: https://builds.tuxbuild.com/1uG71M0P29j62n5g5DXGExv8HJi/config
  vmlinux: https://builds.tuxbuild.com/1uG71M0P29j62n5g5DXGExv8HJi/vmlinux.xz
  System.map: https://builds.tuxbuild.com/1uG71M0P29j62n5g5DXGExv8HJi/System.map
  Image: https://builds.tuxbuild.com/1uG71M0P29j62n5g5DXGExv8HJi/Image.gz


Reported-by: Naresh.Kamboju <naresh.kamboju@linaro.org>

ref:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210621/testrun/4962284/suite/linux-log-parser/test/check-kernel-exception-2935013/log
https://lkft.validation.linaro.org/scheduler/job/2935013#L2142

--
Linaro LKFT
https://lkft.linaro.org
