Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1E5C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 12:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461CA61183
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 12:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbhHXM7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237234AbhHXM7E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 08:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629809900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hOke2fYZKQH5YpPMVyniPmmS5X/O46jFtYpCuo5pIEQ=;
        b=MBRmnKO1iRdQgEeoGRdkidThGDcO4nqFMhepVTfN87m+KwwypQroAiQUeo6dX4RICdx70P
        WmzIe70s9UiDI3LvOiIDCbtFQ1hxhhstk0DtFwjqivN5Ut7iFuQkMWJA4vOz3Xii2IPV93
        5rapEwi/iu9ibu8x4ILkLp06twNUWQc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-xG1Z4vWmMIOI-AWtkHTVCQ-1; Tue, 24 Aug 2021 08:58:19 -0400
X-MC-Unique: xG1Z4vWmMIOI-AWtkHTVCQ-1
Received: by mail-ot1-f70.google.com with SMTP id m32-20020a9d1d230000b02905103208125aso12351196otm.3
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 05:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hOke2fYZKQH5YpPMVyniPmmS5X/O46jFtYpCuo5pIEQ=;
        b=C9VFt0MrjoZhoWtmk+5bOmAw0prdsWWj+Py3VTvn4YoAF0h+7OC5WJbvJkOGENYRiC
         C1CK+GoHWcgPVNvqVQd0KYDZZJHSPzADQ6uv+0/0dm4T8lFNZ4YrGpFHVdbRvxdoDzdr
         RpFCmQq7gmUKsFEHXNUTJw9UiHs/nUoS3Igxn4XZaSpGj46eryFdIyEOnrjf1tfeHrtc
         GFUJpNBymjXNx7zcYL8pvA8nt5a9sRSvaqpgqnMfZkZzIpixpHztwwTZ9JDie3+RVHqq
         9i2K6YJ5qvTZaiwjRAmsCRM1qh6QBOZPQ01LWTTIjC9Og3KhXNTaeXbGkwu7Ka0ZdffL
         dY8w==
X-Gm-Message-State: AOAM532vcV842XQ3JN2AeqqqgVlOvwhJVAiOUoendYH9J3ipOvyMFC1R
        r8ZKfnc2aWIuMl2iw7mbkwP0Q48rIf00ZzsgfG/rBcgRIhtGQ3qA6akUOGLrh8FcGT+PkeQi6SY
        R7HoznGmjg5s0sfvuX+gzBdaS/T8GPGrFzjMRZkE=
X-Received: by 2002:a9d:6046:: with SMTP id v6mr28675216otj.234.1629809897679;
        Tue, 24 Aug 2021 05:58:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXbTCyaxvlHxCZHFn1cvNNVZZrmTXvzyQfKTQXneNlsaKIvX3sle57zm3YrWTze7v7ghobg3/mI6Rxodgj/Ug=
X-Received: by 2002:a9d:6046:: with SMTP id v6mr28675206otj.234.1629809897415;
 Tue, 24 Aug 2021 05:58:17 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 24 Aug 2021 14:58:06 +0200
Message-ID: <CA+QYu4oZN2Z-z1uRjPQO6UL4d5CuRM6NCsSAPG0+BKb5K2o23A@mail.gmail.com>
Subject: WARNING: CPU: 0 PID: 11219 at block/genhd.c:594 del_gendisk+0x1f8/0x218
To:     linux-block@vger.kernel.org, Yi Zhang <yizhan@redhat.com>
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When testing commit "9d09cba59515 - Merge branch
'io_uring-bio-cache.5'" we hit the following issue during the nvme
test part of blktests [1]. We've reproduced the issue on aarch64,
ppc64le and s390x.

[ 2785.043085] run blktests nvme/004 at 2021-08-23 17:55:00
[ 2785.085351] loop0: detected capacity change from 0 to 2097152
[ 2785.262427] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2785.367706] nvmet: creating controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:e154be55ec2a4a138eb3b9b18d514d7e.
[ 2785.381385] nvme nvme0: creating 128 I/O queues.
[ 2785.396302] nvme nvme0: new ctrl: "blktests-subsystem-1"
[ 2786.428981] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 2786.508421] ------------[ cut here ]------------
[ 2786.513027] WARNING: CPU: 90 PID: 906579 at block/genhd.c:594
del_gendisk+0x1b4/0x1c0
[ 2786.520851] Modules linked in: nvme_loop nvme_fabrics nvmet
nvme_core loop dm_log_writes dm_flakey mlx5_ib ib_uverbs ib_core
rfkill sunrpc coresight_etm4x i2c_smbus coresight_replicator
coresight_tpiu coresight_tmc joydev mlx5_core mlxfw psample tls
acpi_ipmi ipmi_ssif ipmi_devintf ipmi_msghandler coresight_funnel
thunderx2_pmu coresight vfat fat fuse zram ip_tables xfs ast
i2c_algo_bit crct10dif_ce drm_vram_helper ghash_ce drm_kms_helper
syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm
drm gpio_xlp i2c_xlp9xx uas usb_storage aes_neon_bs [last unloaded:
null_blk]
[ 2786.572480] CPU: 90 PID: 906579 Comm: nvme Not tainted 5.14.0-rc7 #1
[ 2786.578823] Hardware name: HPE Apollo 70             /C01_APACHE_MB
        , BIOS L50_5.13_1.15 05/08/2020
[ 2786.588548] pstate: 20400009 (nzCv daif +PAN -UAO -TCO BTYPE=--)
[ 2786.594542] pc : del_gendisk+0x1b4/0x1c0
[ 2786.598453] lr : del_gendisk+0x24/0x1c0
[ 2786.602276] sp : ffff800026ee3b90
[ 2786.605577] x29: ffff800026ee3b90 x28: ffff0008c019c180 x27: 0000000000000000
[ 2786.612702] x26: 0000000000000000 x25: 0000000000000000 x24: ffff00080dcd2720
[ 2786.619825] x23: ffff800026ee3d50 x22: fffffffffffffff2 x21: ffff0008cc2dc530
[ 2786.626948] x20: ffff800026ee3c40 x19: ffff0008ca50fa00 x18: 0000000000000000
[ 2786.634071] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000030
[ 2786.641194] x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
[ 2786.648318] x11: ffff80001162b370 x10: 0000000000001c60 x9 : ffff80001116219c
[ 2786.655441] x8 : ffff0008c019de40 x7 : 0000000000000004 x6 : 00000008cbf74261
[ 2786.662564] x5 : 0000000000001cd0 x4 : 0000000000000000 x3 : ffffffffffffefff
[ 2786.669687] x2 : 0000000000000000 x1 : ffff800011a6bc80 x0 : 0000000000000000
[ 2786.676811] Call trace:
[ 2786.679245]  del_gendisk+0x1b4/0x1c0
[ 2786.682808]  nvme_ns_remove.part.0+0x9c/0x224 [nvme_core]
[ 2786.688209]  nvme_ns_remove+0x3c/0x5c [nvme_core]
[ 2786.692908]  nvme_remove_namespaces+0xac/0xe0 [nvme_core]
[ 2786.698301]  nvme_do_delete_ctrl+0x4c/0x74 [nvme_core]
[ 2786.703434]  nvme_sysfs_delete+0x84/0x90 [nvme_core]
[ 2786.708392]  dev_attr_store+0x24/0x40
[ 2786.712044]  sysfs_kf_write+0x50/0x60
[ 2786.715696]  kernfs_fop_write_iter+0x134/0x1c4
[ 2786.720127]  new_sync_write+0xdc/0x15c
[ 2786.723866]  vfs_write+0x22c/0x2c0
[ 2786.727255]  ksys_write+0x64/0xec
[ 2786.730558]  __arm64_sys_write+0x28/0x34
[ 2786.734469]  invoke_syscall+0x50/0x120
[ 2786.738206]  el0_svc_common+0x48/0x100
[ 2786.741942]  do_el0_svc+0x34/0xa0
[ 2786.745244]  el0_svc+0x2c/0x54
[ 2786.748288]  el0t_64_sync_handler+0x1a4/0x1b0
[ 2786.752632]  el0t_64_sync+0x19c/0x1a0
[ 2786.756283] ---[ end trace 6548b7e0fd94a185 ]---
[ 2786.760916] ------------[ cut here ]------------
[ 2786.765521] WARNING: CPU: 90 PID: 906579 at block/blk-core.c:373
blk_cleanup_queue+0x100/0x110
[ 2786.774122] Modules linked in: nvme_loop nvme_fabrics nvmet
nvme_core loop dm_log_writes dm_flakey mlx5_ib ib_uverbs ib_core
rfkill sunrpc coresight_etm4x i2c_smbus coresight_replicator
coresight_tpiu coresight_tmc joydev mlx5_core mlxfw psample tls
acpi_ipmi ipmi_ssif ipmi_devintf ipmi_msghandler coresight_funnel
thunderx2_pmu coresight vfat fat fuse zram ip_tables xfs ast
i2c_algo_bit crct10dif_ce drm_vram_helper ghash_ce drm_kms_helper
syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm
drm gpio_xlp i2c_xlp9xx uas usb_storage aes_neon_bs [last unloaded:
null_blk]
[ 2786.825734] CPU: 90 PID: 906579 Comm: nvme Tainted: G        W
   5.14.0-rc7 #1
[ 2786.833464] Hardware name: HPE Apollo 70             /C01_APACHE_MB
        , BIOS L50_5.13_1.15 05/08/2020
[ 2786.843188] pstate: 20400009 (nzCv daif +PAN -UAO -TCO BTYPE=--)
[ 2786.849182] pc : blk_cleanup_queue+0x100/0x110
[ 2786.853613] lr : blk_cleanup_queue+0x24/0x110
[ 2786.857957] sp : ffff800026ee3bb0
[ 2786.861258] x29: ffff800026ee3bb0 x28: ffff0008c019c180 x27: 0000000000000000
[ 2786.868381] x26: 0000000000000000 x25: 0000000000000000 x24: ffff00080dcd2720
[ 2786.875504] x23: ffff800026ee3d50 x22: fffffffffffffff2 x21: ffff0008cc2dc530
[ 2786.882627] x20: ffff800026ee3c40 x19: ffff0008c75d54b0 x18: 0000000000000000
[ 2786.889750] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000030
[ 2786.896873] x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
[ 2786.903996] x11: ffff80001162b370 x10: 0000000000001c60 x9 : ffff8000102d340c
[ 2786.911119] x8 : 0000000000000019 x7 : 0000000000000000 x6 : 0000000000006541
[ 2786.918242] x5 : 0000000000000022 x4 : ffff000f5c955968 x3 : dead000000000122
[ 2786.925365] x2 : ffff000f5c955968 x1 : 0000000000000001 x0 : 00000000205641d0
[ 2786.932489] Call trace:
[ 2786.934922]  blk_cleanup_queue+0x100/0x110
[ 2786.939006]  nvme_ns_remove.part.0+0xa4/0x224 [nvme_core]
[ 2786.944400]  nvme_ns_remove+0x3c/0x5c [nvme_core]
[ 2786.949098]  nvme_remove_namespaces+0xac/0xe0 [nvme_core]
[ 2786.954491]  nvme_do_delete_ctrl+0x4c/0x74 [nvme_core]
[ 2786.959623]  nvme_sysfs_delete+0x84/0x90 [nvme_core]
[ 2786.964581]  dev_attr_store+0x24/0x40
[ 2786.968232]  sysfs_kf_write+0x50/0x60
[ 2786.971882]  kernfs_fop_write_iter+0x134/0x1c4
[ 2786.976313]  new_sync_write+0xdc/0x15c
[ 2786.980050]  vfs_write+0x22c/0x2c0
[ 2786.983440]  ksys_write+0x64/0xec
[ 2786.986742]  __arm64_sys_write+0x28/0x34
[ 2786.990653]  invoke_syscall+0x50/0x120
[ 2786.994389]  el0_svc_common+0x48/0x100
[ 2786.998124]  do_el0_svc+0x34/0xa0
[ 2787.001426]  el0_svc+0x2c/0x54
[ 2787.004468]  el0t_64_sync_handler+0x1a4/0x1b0
[ 2787.008813]  el0t_64_sync+0x19c/0x1a0
[ 2787.012462] ---[ end trace 6548b7e0fd94a186 ]---

More logs can be found checking out dmesg logs on:
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/08/23/358062328/build_aarch64_redhat%3A1527263217/tests/Storage_blktests/10535235_aarch64_1_dmesg.log
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/08/23/358062328/build_ppc64le_redhat%3A1527263220/tests/Storage_blktests/10535245_ppc64le_1_dmesg.log
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/08/23/358062328/build_s390x_redhat%3A1527263223/tests/Storage_blktests/10535243_s390x_1_dmesg.log

[1] https://gitlab.com/cki-project/kernel-tests/-/tree/main/storage/blktests/blk

Thank you,
Bruno Goncalves

