Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD766C433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F72206C3
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 13:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmTM6Qkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgFHNqd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbgFHNqd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 09:46:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D2C08C5C2
        for <linux-block@vger.kernel.org>; Mon,  8 Jun 2020 06:46:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mb16so18384618ejb.4
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2020 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zdz20sXEVAYj7zXkvITERaWxtcf8PqNOJfxHjgNnqUs=;
        b=RmTM6QklWRoqK6ZTyJyANKeVgRA5guc82VjPStbFqSwDtWR+FjjEACJjdwDJY+YrMX
         5k9akbN8KF4K5JczzcyEgs78ldr5YUpjdPlY43ms50lkRrW9mB4nNF7dItV7+5mS71Cr
         4c20gMtuVuFuN2wdZyLolFdQZg6FJTPWL84ZGMpfgB3I6F1/x4Rhxn9zITrhr6nl9ULZ
         LWGZHzsHjrCIUN0N5BLtTsraB3bfstVZRMQYa/ieWBlfXHv2J/nDnUFke1MYPiSkIJFL
         msdgQwZSwFFIgVDjccHHIZy8XTM81XgTtjfLIdFE5stNWT9lB8WG3xWIEsqlDmTIcXCU
         yhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zdz20sXEVAYj7zXkvITERaWxtcf8PqNOJfxHjgNnqUs=;
        b=RrOPyDx7KZ7SxajTfheIylEW0OaW/du91rpjF3KO4sodgwvlpD4OZtF9Zlta2SOSqh
         R16YQ00mofMH4sv68CY+Fw7e+gmdQOD1mwzawbUvGNryMROLivzZ50GI6bMqO/dVJEV0
         ylRu7poKcvl7g3AwEEQeQ5xaTmO3v2X0Y01An93U5rufHSRBCgexnF5pSy5c65b8e8Ht
         Sho8O6ZvvlrQ1uozzW9eSnLHvvZDHwcULMKVdZ0MibtItM7qF7AV3XCtxcP1xTvpOoR2
         1MDexzNMNXcFQVjjTPYo8Q2UU5boLEagwO+dko85gpJrAF/P1xD+J/UvCmLuV6wUD47l
         b0wg==
X-Gm-Message-State: AOAM5311ewvuVxKeUx49Yv3ktXG2TQ3TmshSmtrNFBHZtt1Mvf02gyTO
        gqQuN/P1W9gARxuU/35BJ1C5tjvi/5roZy3cxxZtFYVDV5E=
X-Google-Smtp-Source: ABdhPJxQQM3nwK738xnKoWjfsUeBWpCzdFveuwDSVayvvHBL119fRSCZ94OuQZn7CQeBgOitJ8Xa4KW40kbwtD3iaOg=
X-Received: by 2002:a17:906:aac8:: with SMTP id kt8mr21499907ejb.460.1591623991126;
 Mon, 08 Jun 2020 06:46:31 -0700 (PDT)
MIME-Version: 1.0
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 8 Jun 2020 16:46:20 +0300
Message-ID: <CADxRZqx9-6bN7ETsdHaY+6rTjF=aj-VKm8F_TyqoU05iPt6NFw@mail.gmail.com>
Subject: loop module OOPS
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

A follow-up to
https://github.com/karelzak/util-linux/issues/903

trying to use losetup with big loop number, generating a kernel stack trace:

$ modprobe loop
$ touch somefile
$ losetup /dev/loop1048576 somefile

kernel logs (sparc64):

$ uname -a
Linux ttip 5.7.0-12703-gaf7b4801030c #142 SMP Mon Jun 8 11:34:57 MSK
2020 sparc64 GNU/Linux

[   53.068591] loop: module loaded
[   58.795265] sysfs: cannot create duplicate filename
'/devices/virtual/bdi/7:0'
[   58.795413] CPU: 24 PID: 1246 Comm: losetup Not tainted
5.7.0-12703-gaf7b4801030c #142
[   58.795474] Call Trace:
[   58.795511]  [000000000079d030] sysfs_warn_dup+0x50/0x80
[   58.795557]  [000000000079d154] sysfs_create_dir_ns+0x94/0xe0
[   58.795608]  [0000000000977880] kobject_add_internal+0x140/0x3a0
[   58.795656]  [0000000000977b5c] kobject_add+0x7c/0xa0
[   58.795700]  [00000000009d9104] device_add+0x164/0x7c0
[   58.795743]  [00000000009d98fc] device_create_groups_vargs+0x7c/0xc0
[   58.795792]  [00000000009d996c] device_create+0x2c/0x40
[   58.795839]  [0000000000655088] bdi_register_va+0x48/0x2c0
[   58.795884]  [0000000000655324] bdi_register+0x24/0x40
[   58.795929]  [0000000000920920] __device_add_disk+0x240/0x5a0
[   58.795976]  [0000000000920c98] device_add_disk+0x18/0x40
[   58.796024]  [00000000100400b0] loop_add+0x1f0/0x260 [loop]
[   58.796071]  [0000000010040234] loop_control_ioctl+0x74/0x140 [loop]
[   58.796122]  [00000000006f8d58] ksys_ioctl+0x78/0xc0
[   58.796163]  [00000000006f8db4] sys_ioctl+0x14/0x40
[   58.796207]  [0000000000406294] linux_sparc_syscall+0x34/0x44
[   58.796258] kobject_add_internal failed for 7:0 with -EEXIST, don't
try to register things with the same name in the same directory.

kernel logs ppc64:

$ uname -a
Linux ap-gcc1-ppc64 5.7.0 #78 SMP Mon Jun 1 13:10:19 MSK 2020 ppc64 GNU/Linux

kernel: loop: module loaded
kernel: sysfs: cannot create duplicate filename '/devices/virtual/bdi/7:0'
kernel: CPU: 8 PID: 99033 Comm: losetup Tainted: G            E     5.7.0 #78
kernel: Call Trace:
kernel: [c0000007c9213350] [c00000000068e404] .dump_stack+0xb0/0xfc (unreliable)
kernel: [c0000007c92133e0] [c0000000005632f0] .sysfs_warn_dup+0x80/0xb0
kernel: [c0000007c9213470] [c0000000005634fc] .sysfs_create_dir_ns+0x11c/0x140
kernel: [c0000007c9213510] [c000000000697c18] .kobject_add_internal+0x108/0x460
kernel: [c0000007c92135b0] [c000000000697fd4] .kobject_add+0x64/0xe0
kernel: [c0000007c9213640] [c00000000076a610] .device_add+0x150/0xa10
kernel: [c0000007c9213720] [c00000000076b198]
.device_create_groups_vargs+0x118/0x1e0
kernel: [c0000007c92137d0] [c00000000076b318] .device_create+0x58/0x70
kernel: [c0000007c9213850] [c000000000388c40] .bdi_register_va.part.0+0x70/0x380
kernel: [c0000007c9213900] [c000000000389060] .bdi_register+0x80/0xa0
kernel: [c0000007c9213980] [c0000000003890c4] .bdi_register_owner+0x44/0x90
kernel: [c0000007c9213a10] [c000000000627c98] .__device_add_disk+0x538/0x5f0
kernel: [c0000007c9213ae0] [c0080000003b2d9c] .loop_add+0x25c/0x310 [loop]
kernel: [c0000007c9213b90] [c0080000003b3058]
.loop_control_ioctl+0xf8/0x1b0 [loop]
kernel: [c0000007c9213c50] [c00000000047c96c] .ksys_ioctl+0xfc/0x160
kernel: [c0000007c9213cf0] [c00000000047ca08] .__se_sys_ioctl+0x38/0xa0
kernel: [c0000007c9213d70] [c00000000002ecb4] .system_call_exception+0x144/0x220
kernel: [c0000007c9213e20] [c00000000000d1e8] system_call_common+0xe8/0x214
kernel: kobject_add_internal failed for 7:0 with -EEXIST, don't try to
register things with the same name in the same directory


tested with latest git kernel on sparc64 and 5.7.0 tag on ppc64
