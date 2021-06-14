Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C814BC2B9F4
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 12:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC78613F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 12:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhFNM4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 08:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233218AbhFNM4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 08:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623675288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=72k3cwOorNAdILL6+MKQPLr9C3IidmWsPMOXKdiIsx8=;
        b=FmS0sKDxqU/fyQg8sdTyFLftaypd4wFxapr8uXoHve8AOw4J1be7U1Ov6e6ZX+VPVH4rPe
        IQ+iZ4pnw166/uKHf+eXNYJcXxJN1kS4HtT6HZhL+xKc/fy0yRVllXKX6hVItNPeXZqEpS
        Ol0alB0XJqoIzemwBrK5WteFNy9pGrs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-I53KyqIUNvmQ761R0xoopg-1; Mon, 14 Jun 2021 08:54:45 -0400
X-MC-Unique: I53KyqIUNvmQ761R0xoopg-1
Received: by mail-oi1-f200.google.com with SMTP id l136-20020acaed8e0000b02901f3ebfedbf2so5519240oih.11
        for <linux-block@vger.kernel.org>; Mon, 14 Jun 2021 05:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=72k3cwOorNAdILL6+MKQPLr9C3IidmWsPMOXKdiIsx8=;
        b=dABQRK7b6OYFkQkFzhsH0HMuKAXcpflJ+a5IusAM2P0aZjRB2io8yTN0Yln89agAm3
         V1aPQXB/EVI7aZcTMoq1S461H1oK/GFrWgDDDT8UBQv1vDf2vhENrPp+3oaa/7SdjONy
         glVNMZX5Ww4POT4IpimqqB9Ch1pnOcPCFMcI3JLZ0THJht6mkzt9NryHfA4FbT3ZZGt9
         o0Exi3zIitBz8XP060UJl5g2l+KxaBmKQN6yHSguGxcDtyp0a52cF83hf/Ba6u1GNQAF
         5JJ7x+uof61a5kS6yd3htY+1l/lRMTWBQ2kR4Z8NNnYmDNNwlXg6LF/SG7dpa2MF3GlV
         HZaA==
X-Gm-Message-State: AOAM533ZDe9F67X4C5m423m4EoBk+RRo4nj/0hO/2npqmXbzV1nQIGsx
        YlQ3ITpzzOz+R6TFPkBDYNcUETW+JAHc7Il2JZ9FKzjHX/ZI4mKtXu5IrKUB14zT7d4l2N9um5v
        ChGIOEFLx8HjNFFH7CNzezC8XFIbqlMLGEEV8wls=
X-Received: by 2002:a05:6830:19c2:: with SMTP id p2mr12838962otp.234.1623675284239;
        Mon, 14 Jun 2021 05:54:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbNJWhgsNZ8kEs+pPwxbvJFN4z2H0wmof+Ravry/w+0jQeuX+2j6pPDmXfkfLp6xrRVmHojILQebMm3bfMSmY=
X-Received: by 2002:a05:6830:19c2:: with SMTP id p2mr12838940otp.234.1623675283933;
 Mon, 14 Jun 2021 05:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <cki.E3198A727A.0A5WS1XUPX@redhat.com>
In-Reply-To: <cki.E3198A727A.0A5WS1XUPX@redhat.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Mon, 14 Jun 2021 14:54:32 +0200
Message-ID: <CA+QYu4qZE5T6oUKL26WS5mAREnGzjfupgw4VC4oisdW8dYk95A@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=F0=9F=92=A5_PANICKED=3A_Test_report_for_kernel_5=2E13=2E0=2Drc3?=
        =?UTF-8?Q?_=28block=2C_30ec225a=29?=
To:     CKI Project <cki-project@redhat.com>
Cc:     skt-results-master@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Fine Fan <ffan@redhat.com>,
        Jeff Bastian <jbastian@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Sorry about the duplicated message, but it looks like my previous
email contained some html code that got rejected by the linux-block
list.

We've noticed a kernel oops during the stress-ng test on aarch64 more
log details on [1]. Christoph, do you think this could be related to
the recent blk_cleanup_disk changes [2]?

[15259.574356] loop32292: detected capacity change from 0 to 4096
[15259.574436] loop6370: detected capacity change from 0 to 4096
[15259.638249] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000008
[15259.647046] Mem abort info:
[15259.649830]   ESR =3D 0x96000006
[15259.652875]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[15259.653800] loop46040: detected capacity change from 4096 to 8192
[15259.658191]   SET =3D 0, FnV =3D 0
[15259.667311]   EA =3D 0, S1PTW =3D 0
[15259.670442] Data abort info:
[15259.673311]   ISV =3D 0, ISS =3D 0x00000006
[15259.677145]   CM =3D 0, WnR =3D 0
[15259.680102] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000093ce30000
[15259.686547] [0000000000000008] pgd=3D080000092b670003,
p4d=3D080000092b670003, pud=3D0800000911225003, pmd=3D0000000000000000
[15259.697181] Internal error: Oops: 96000006 [#1] SMP
[15259.702069] Modules linked in: binfmt_misc fcrypt sm4_generic
crc32_generic md4 michael_mic nhpoly1305_neon nhpoly1305
poly1305_generic libpoly1305 poly1305_neon rmd160 sha3_generic
sm3_generic streebog_generic wp512 blowfish_generic blowfish_common
cast5_generic des_generic libdes chacha_generic chacha_neon libchacha
camellia_generic cast6_generic cast_common serpent_generic
twofish_generic twofish_common dm_thin_pool dm_persistent_data
dm_bio_prison nvme nvme_core loop dm_log_writes dm_flakey rfkill
mlx5_ib ib_uverbs ib_core sunrpc mlx5_core joydev acpi_ipmi psample
ipmi_ssif i2c_smbus mlxfw ipmi_devintf ipmi_msghandler thunderx2_pmu
vfat fat cppc_cpufreq fuse zram ip_tables xfs crct10dif_ce ast
ghash_ce i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm gpio_xlp
i2c_xlp9xx uas usb_storage aes_neon_bs [last unloaded: nvmet]
[15259.781079] CPU: 2 PID: 2800640 Comm: stress-ng Not tainted 5.13.0-rc3 #=
1
[15259.787865] Hardware name: HPE Apollo 70             /C01_APACHE_MB
        , BIOS L50_5.13_1.11 06/18/2019
[15259.797601] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=3D--)
[15259.803605] pc : blk_mq_run_hw_queues+0xec/0x10c
[15259.808226] lr : blk_freeze_queue_start+0x80/0x90
[15259.812925] sp : ffff80003b55bd00
[15259.816233] x29: ffff80003b55bd00 x28: ffff000a559320c0 x27: 00000000000=
00000
[15259.823375] x26: 0000000000000000 x25: 0000000000000000 x24: 00000000000=
00000
[15259.830513] x23: 0000000000000007 x22: 0000000000000000 x21: 00000000000=
00000
[15259.837645] x20: ffff00081aa6d3c0 x19: ffff00081aa6d3c0 x18: 00000000fff=
ffffa
[15259.844776] x17: 0000000000000000 x16: 0000000000000000 x15: 00000400000=
00000
[15259.851905] x14: ffff000000000000 x13: 0000000000001000 x12: ffff000e782=
5b0a0
[15259.859034] x11: 0000000000000000 x10: ffff000e7825b098 x9 : ffff8000106=
d2950
[15259.866164] x8 : ffff000f7cfeab20 x7 : fffffffc00000000 x6 : ffff8000115=
54000
[15259.873292] x5 : 0000000000000000 x4 : ffff000a559320c0 x3 : ffff00081aa=
6da28
[15259.880421] x2 : 0000000000000002 x1 : 0000000000000000 x0 : ffff0008b69=
f0a80
[15259.887551] Call trace:
[15259.889987]  blk_mq_run_hw_queues+0xec/0x10c
[15259.894253]  blk_freeze_queue_start+0x80/0x90
[15259.898603]  blk_cleanup_queue+0x40/0x114
[15259.902606]  blk_cleanup_disk+0x28/0x50
[15259.906434]  loop_control_ioctl+0x17c/0x190 [loop]
[15259.911224]  __arm64_sys_ioctl+0xb4/0x100
[15259.915229]  invoke_syscall+0x50/0x120
[15259.918972]  el0_svc_common.constprop.0+0x4c/0xd4
[15259.923666]  do_el0_svc+0x30/0x9c
[15259.926971]  el0_svc+0x2c/0x54
[15259.930022]  el0_sync_handler+0x1a4/0x1b0
[15259.934023]  el0_sync+0x19c/0x1c0
[15259.937335] Code: 91000000 b8626802 f9400021 f9402680 (b8627821)
[15259.943418] ---[ end trace 975879698e5c9146 ]---
[15260.113777] loop62523: detected capacity change from 4096 to 8192
[15260.113783] loop58780: detected capacity change from 4096 to 8192
[15260.113794] loop7620: detected capacity change from 4096 to 8192


[1] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehous=
e-public/2021/06/11/319533768/build_aarch64_redhat%3A1340796730/tests/10127=
520_aarch64_2_console.log
[2] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/l=
og/?h=3Dfor-next

Thanks,
Bruno


On Mon, Jun 14, 2021 at 2:35 PM CKI Project <cki-project@redhat.com> wrote:
>
>
> Hello,
>
> We ran automated tests on a recent commit from this kernel tree:
>
>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe=
/linux-block.git
>             Commit: 30ec225aae2e - Merge branch 'for-5.14/block' into for=
-next
>
> The results of these automated tests are provided below.
>
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: PANICKED
>
> All kernel binaries, config files, and logs are available for download he=
re:
>
>   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?p=
refix=3Ddatawarehouse-public/2021/06/11/319533768
>
> One or more kernel tests failed:
>
>     ppc64le:
>       Boot test
>
>     aarch64:
>      =E2=9D=8C storage: software RAID testing
>       stress: stress-ng
>
> We hope that these logs can help you find the problem quickly. For the fu=
ll
> detail on our testing procedures, please scroll to the bottom of this mes=
sage.
>
> Please reply to this email if you have any questions about the tests that=
 we
> ran or if you have any suggestions on how to make future tests more effec=
tive.
>
>         ,-.   ,-.
>        ( C ) ( K )  Continuous
>         `-',-.`-'   Kernel
>           ( I )     Integration
>            `-'
> _________________________________________________________________________=
_____
>
> Compile testing
> ---------------
>
> We compiled the kernel for 4 architectures:
>
>     aarch64:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>     ppc64le:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>     s390x:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>     x86_64:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>
>
> Hardware testing
> ----------------
> We booted each kernel and ran the following tests:
>
>   aarch64:
>     Host 1:
>        =E2=9C=85 Boot test
>        =E2=9C=85 ACPI table test
>        =E2=9C=85 LTP
>        =E2=9C=85 CIFS Connectathon
>        =E2=9C=85 POSIX pjd-fstest suites
>        =E2=9C=85 Loopdev Sanity
>        =E2=9C=85 Memory: fork_mem
>        =E2=9C=85 Memory function: memfd_create
>        =E2=9C=85 AMTU (Abstract Machine Test Utility)
>        =E2=9C=85 Ethernet drivers sanity
>        =E2=9C=85 storage: SCSI VPD
>         =E2=9C=85 xarray-idr-radixtree-test
>
>     Host 2:
>        =E2=9C=85 Boot test
>        =E2=9C=85 xfstests - ext4
>        =E2=9C=85 xfstests - xfs
>        =E2=9D=8C storage: software RAID testing
>        =E2=9C=85 Storage: swraid mdadm raid_module test
>         =E2=9C=85 xfstests - btrfs
>         =E2=9C=85 Storage blktests
>         =E2=9C=85 Storage block - filesystem fio test
>         =E2=9C=85 Storage block - queue scheduler test
>         =E2=9C=85 Storage nvme - tcp
>         =E2=9C=85 Storage: lvm device-mapper test
>         stress: stress-ng
>
>   ppc64le:
>     Host 1:
>        =E2=9C=85 Boot test
>        =E2=9C=85 LTP
>        =E2=9C=85 CIFS Connectathon
>        =E2=9C=85 POSIX pjd-fstest suites
>        =E2=9C=85 Loopdev Sanity
>        =E2=9C=85 Memory: fork_mem
>        =E2=9C=85 Memory function: memfd_create
>        =E2=9C=85 AMTU (Abstract Machine Test Utility)
>        =E2=9C=85 Ethernet drivers sanity
>         =E2=9C=85 xarray-idr-radixtree-test
>
>     Host 2:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - ext4
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: software RAID testing
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_module test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - filesystem fio test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - queue scheduler test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: lvm device-mapper test
>
>     Host 3:
>         Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - ext4
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: software RAID testing
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_module test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - filesystem fio test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - queue scheduler test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: lvm device-mapper test
>
>   s390x:
>     Host 1:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9C=85 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 LTP
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 CIFS Connectathon
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest suites
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory: fork_mem
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility)
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>
>     Host 2:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - ext4
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_module test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>     Host 3:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - ext4
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_module test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>     Host 4:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - ext4
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_module test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>   x86_64:
>     Host 1:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage SAN device stress - qedf drive=
r
>
>     Host 2:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - ext4
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - nfsv4.2
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: software RAID testing
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_module test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - cifsv3.11
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - filesystem fio test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - queue scheduler test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: lvm device-mapper test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>     Host 3:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage SAN device stress - qla2xxx dr=
iver
>
>     Host 4:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9C=85 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage SAN device stress - mpt3sas_ge=
n1
>
>     Host 5:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9C=85 Boot test
>        =E2=9C=85 ACPI table test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 LTP
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 CIFS Connectathon
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest suites
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory: fork_mem
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility)
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: SCSI VPD
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>
>     Host 6:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage SAN device stress - lpfc drive=
r
>
>     Host 7:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage SAN device stress - qedf drive=
r
>
>     Host 8:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage SAN device stress - lpfc drive=
r
>
>   Test sources: https://gitlab.com/cki-project/kernel-tests
>     Pull requests are welcome for new tests or improvements to existing t=
ests!
>
> Aborted tests
> -------------
> Tests that didn't complete running successfully are marked with =E2=9A=A1=
=E2=9A=A1=E2=9A=A1.
> If this was caused by an infrastructure issue, we try to mark that
> explicitly in the report.
>
> Waived tests
> ------------
> If the test run included waived tests, they are marked with . Such tests =
are
> executed but their results are not taken into account. Tests are waived w=
hen
> their results are not reliable enough, e.g. when they're just introduced =
or are
> being fixed.
>
> Testing timeout
> ---------------
> We aim to provide a report within reasonable timeframe. Tests that haven'=
t
> finished running yet are marked with =E2=8F=B1.
>
>

