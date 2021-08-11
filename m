Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B2C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 13:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B4860FDA
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 13:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhHKNgE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 09:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231612AbhHKNgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 09:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628688939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JYY8jzUaG77wgdENrPTQ2prDW2UwKD47Ze5vmv57gWA=;
        b=N7nnhnZXjLux9t1NBVP6t1yUtDV/pLUCVfyqCBph8Yd/ecSKxs3Epdcpgz7XCzPIpGh5Pk
        F0hhNXhi/N4aZr9oj7gy8QsegSHnJowu+8MJJrlsyiMJPLJg1dJ3qf2OypC0hRNxk9vNBt
        Gv82tlxM6hMSUrmFf66yEFqvRZCMR7U=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-xQn3FvzVNHWQDxFblJMBIg-1; Wed, 11 Aug 2021 09:35:38 -0400
X-MC-Unique: xQn3FvzVNHWQDxFblJMBIg-1
Received: by mail-ot1-f70.google.com with SMTP id 65-20020a9d0ec70000b02904d36d33dcf7so937101otj.4
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 06:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JYY8jzUaG77wgdENrPTQ2prDW2UwKD47Ze5vmv57gWA=;
        b=LV/mD731W43vEhihFqX5isQaLVENS/gLxO3/obqggeOnFLGCdGPtJ8rBJRTk7BPBnP
         MqUs9aJDs7d3+B15t6Hw8hpcGtYfrUaS/hFeZ5GsxF/8Kxm/+VrCG4C4QCwPTfBl6dMH
         IDG+/EJ2Nw4tMFmIIW9LzOhQAv1/SkaltQyaAE3e3ywAyaJN6iPrB27bahRCXDERBZEc
         9xTpd8Hep/dKRIAAJai69l/gZwADdYUwuSdlVWRRLVsyfTPFWTeloZQ6/MAi/tclKeMB
         sSEwGjxfapBR9mlo5AZkV1jMsBw/+teBL5pn6SUPuZyEPcL70RYpVEYCbfwGJJfNvBN+
         KYVQ==
X-Gm-Message-State: AOAM531YOu6CgwDrI+B3CtOaetAs69rLFvM87ZB1Q5oF2yJtUy2G0FFb
        YsKXPf6YGpnhVVjgZFOBc32MTWR16kDWoOylWcfWuSWxLmbLLi3etV2/93jbyfsBKNUtdufIGQs
        8YThyTtRwber7TlygVB5JZc+aqiwXq/pBOUwWf8w=
X-Received: by 2002:aca:180c:: with SMTP id h12mr358836oih.60.1628688937036;
        Wed, 11 Aug 2021 06:35:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaVYkxDigIhim59dFgrpYnCvYC7+S3S9cXeINmrUXeSq5JwtSvoCIuOpkN7lI83FEwkbPgv/Xit/URAP54D2g=
X-Received: by 2002:aca:180c:: with SMTP id h12mr358829oih.60.1628688936809;
 Wed, 11 Aug 2021 06:35:36 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Wed, 11 Aug 2021 15:35:25 +0200
Message-ID: <CA+QYu4qo0uLomBiZuMU3nBdk-zQRQJWVf1TyPUmg-ziyCRS7kQ@mail.gmail.com>
Subject: call trace at pc : __blkdev_direct_IO+0x45c/0x4dc
To:     linux-block@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>,
        Xiong Zhou <xzhou@redhat.com>, Yi Zhang <yizhan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

We've hit the issue below twice during our tests on kernel 5.14.0-rc5,
the issues happened only on aarch64 when using xfstests [1]. More logs
are available at [2].

The commits we hit this are:
Commit: 39a7b1209b44 - Merge branch 'io_uring-bio-cache.3' into for-next
Commit: 4a23f3da70f0 - Merge branch 'io_uring-bio-cache.3' into for-next

[ 1984.069676] XFS (sda4): Mounting V5 Filesystem
[ 1984.099258] XFS (sda4): Ending clean mount
[ 1984.104770] xfs filesystem being mounted at /mnt/xfstests/mnt1
supports timestamps until 2038 (0x7fffffff)
[ 1984.185598] run fstests generic/006 at 2021-08-10 18:02:37
[ 1985.746695] XFS (sda4): Unmounting Filesystem
[ 1986.007696] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000020
[ 1986.016515] Mem abort info:
[ 1986.019298]   ESR = 0x96000004
[ 1986.022368]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1986.027671]   SET = 0, FnV = 0
[ 1986.030732]   EA = 0, S1PTW = 0
[ 1986.033863]   FSC = 0x04: level 0 translation fault
[ 1986.038730] Data abort info:
[ 1986.041609]   ISV = 0, ISS = 0x00000004
[ 1986.045434]   CM = 0, WnR = 0
[ 1986.048390] user pgtable: 4k pages, 48-bit VAs, pgdp=000000881c5e2000
[ 1986.054831] [0000000000000020] pgd=0000000000000000, p4d=0000000000000000
[ 1986.061625] Internal error: Oops: 96000004 [#1] SMP
[ 1986.066496] Modules linked in: dm_log_writes dm_flakey rfkill
mlx5_ib ib_uverbs ib_core sunrpc coresight_etm4x i2c_smbus
coresight_replicator coresight_tpiu coresight_tmc joydev mlx5_core
mlxfw psample tls acpi_ipmi ipmi_ssif ipmi_devintf ipmi_msghandler
thunderx2_pmu coresight_funnel coresight cppc_cpufreq vfat fat fuse
zram ip_tables xfs ast crct10dif_ce i2c_algo_bit drm_vram_helper
ghash_ce drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
cec drm_ttm_helper ttm drm gpio_xlp i2c_xlp9xx uas usb_storage
aes_neon_bs
[ 1986.113226] CPU: 115 PID: 246060 Comm: xfs_repair Not tainted 5.14.0-rc5 #1
[ 1986.120179] Hardware name: HPE Apollo 70             /C01_APACHE_MB
        , BIOS L50_5.13_1.16 07/29/2020
[ 1986.129908] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
[ 1986.135905] pc : __blkdev_direct_IO+0x45c/0x4dc
[ 1986.140438] lr : __blkdev_direct_IO+0x44c/0x4dc
[ 1986.144959] sp : ffff80003aa03ba0
[ 1986.148262] x29: ffff80003aa03ba0 x28: ffff8000123936c8 x27: ffff00879948cb18
[ 1986.155391] x26: 0000000000000002 x25: ffff00879948cb18 x24: ffff000f7d92c180
[ 1986.162519] x23: ffff000811325400 x22: 00000000ffffffff x21: 0000000000200000
[ 1986.169646] x20: ffff80003aa03d38 x19: ffff00879948cb00 x18: 0000000000000000
[ 1986.176774] x17: 0000000000000000 x16: 0000000000010000 x15: fffffc021e4f0002
[ 1986.183901] x14: 0000000000000000 x13: ffff8000115b8090 x12: 00000000ffffffff
[ 1986.191029] x11: ffff80001145afe0 x10: 0000000000001c60 x9 : ffff800010401b70
[ 1986.198156] x8 : ffff000f7d92de40 x7 : 0000000000000000 x6 : 00000008e1dbe6bc
[ 1986.205283] x5 : 0000000000001cd0 x4 : 0000000000000000 x3 : ffffffffffffefff
[ 1986.212411] x2 : 0000000000000002 x1 : ffff800011064b70 x0 : 0000000000000000
[ 1986.219539] Call trace:
[ 1986.221975]  __blkdev_direct_IO+0x45c/0x4dc
[ 1986.226149]  blkdev_direct_IO+0x70/0xb0
[ 1986.229977]  generic_file_read_iter+0x8c/0x194
[ 1986.234420]  blkdev_read_iter+0x54/0x90
[ 1986.238246]  new_sync_read+0xdc/0x154
[ 1986.241906]  vfs_read+0x158/0x1e4
[ 1986.245212]  ksys_pread64+0x84/0xcc
[ 1986.248691]  __arm64_sys_pread64+0x2c/0x40
[ 1986.252779]  invoke_syscall+0x50/0x120
[ 1986.256520]  el0_svc_common+0x48/0x100
[ 1986.260259]  do_el0_svc+0x34/0xa0
[ 1986.263563]  el0_svc+0x2c/0x54
[ 1986.266616]  el0t_64_sync_handler+0x1a4/0x1b0
[ 1986.270964]  el0t_64_sync+0x19c/0x1a0
[ 1986.274621] Code: 2a0003f5 35fffda0 f85e8320 b9400a75 (b9402001)
[ 1986.280706] ---[ end trace c7734f7d18437758 ]---

[1] https://gitlab.com/cki-project/kernel-tests/-/tree/main/filesystems/xfs/xfstests
[2] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/08/10/351077219/build_aarch64_redhat%3A1492917811/tests/xfstests_xfs/

Thank you,
Bruno

