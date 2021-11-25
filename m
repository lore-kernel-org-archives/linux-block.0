Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EF6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 11:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhKYLIJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:08:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238074AbhKYLGI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 06:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637838177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=riKTGmB1twtXdrYnwEH5vMw1b0PhVceFsEem714JIPU=;
        b=ZkgK29el+Q+SGri23MD8/KXzegHQTs+3acO1SL1EFiXRpQOW74UfYE4P1M/HotvDe0PPHH
        XtNKla8l3TX/zpc0T0jcN8X1uQqAcHgbZQpQdBvyXeUnFVe7Z0a9Yc2Y7pXn4RqnNDX4zh
        nrHhykVD/4bE1E9A7q0KD94ne8GpadU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-ZdW8HS7xMLSm-3Zyi2lPEQ-1; Thu, 25 Nov 2021 06:02:55 -0500
X-MC-Unique: ZdW8HS7xMLSm-3Zyi2lPEQ-1
Received: by mail-yb1-f199.google.com with SMTP id j204-20020a2523d5000000b005c21574c704so5769924ybj.13
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 03:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=riKTGmB1twtXdrYnwEH5vMw1b0PhVceFsEem714JIPU=;
        b=FEPj8MNJk0pvZxxNUdWRT5gz0e0hUfq3HEFg1cMHQ3tco7hfO9DD3Mu4UKXCVY+eFf
         ltScK8Q7mx5voHYetRyWiZC5HaDnZBpGq3pwgnMxjzoO8+Mc90oxgykFLFc4H4nkjeTo
         UBko5kV6y/XgBgKTHOzNPG4BI3G/H5BfidSPqLraZMpGN3iP3qW5OWMV2+YVXuqL3XJ9
         41qBRhQsyQLsJhfZgJTvGEnZMZyJU9998UUJUnphTbk6cpG35g9FPo0cci2FSVFao6ef
         l5t0zwN+zpKhbZzVxYPHIwfFZ0QSQSnJ4aBhGgil0QIEklT1aqvv1jfQJ3Mgw0cIKGoM
         ZhoQ==
X-Gm-Message-State: AOAM532gUY5ewpRT6w/gYOUpXlGpIwlFzSP72qAkPybUsn4/0M7Ygmuc
        uoUqjWB0P7aCefecN2p0tqiQ3hhBQdyqD/XdFb+7K7eDTHgZdkm9/gO5cB8hRFuaQMgbYzrMm2T
        zYAJBAtGd89l2KUueWoKE+Rnc8HVa/CAYyAuNOhI=
X-Received: by 2002:a25:6b4e:: with SMTP id o14mr5372593ybm.86.1637838174952;
        Thu, 25 Nov 2021 03:02:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpkWZmt2pKPvauNh+F7iZxY9Q2/1ctu1VXYsw13F4nPFsi0XGLz8nhBBbH+aUOP0Ejo0VSn9O9TL9tRmQ7c60=
X-Received: by 2002:a25:6b4e:: with SMTP id o14mr5372561ybm.86.1637838174665;
 Thu, 25 Nov 2021 03:02:54 -0800 (PST)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 25 Nov 2021 19:02:43 +0800
Message-ID: <CAHj4cs8=xDxBZF62-OekAGtHDtP6ynALKXm7fK2D2ChpNXnGAw@mail.gmail.com>
Subject: [bug report] WARNING at block/mq-deadline.c:600 dd_exit_sched+0x1c6/0x260
 triggered with blktests block/031
To:     linux-block <linux-block@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

blktests block/031 triggered below WARNING with latest
linux-block/for-next[1], pls check it.

[1]
f0afafc21027 (HEAD, origin/for-next) Merge branch 'for-5.17/io_uring'
into for-next

[2]
[ 1801.516136] run blktests block/031 at 2021-11-25 05:51:22
[ 1801.691193] null_blk: module loaded
[ 1847.593539] ------------[ cut here ]------------
[ 1847.598906] statistics for priority 1: i 90452 m 0 d 182486 c 90326
[ 1847.606024] WARNING: CPU: 8 PID: 12958 at block/mq-deadline.c:600
dd_exit_sched+0x1c6/0x260
[ 1847.615439] Modules linked in: null_blk sr_mod cdrom
rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache
netfs rfkill sunrpc vfat fat dm_multipath intel_rapl_msr
intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel kvm mgag200 i2c_algo_bit drm_kms_helper irqbypass
crct10dif_pclmul crc32_pclmul syscopyarea ghash_clmulni_intel
sysfillrect rapl sysimgblt intel_cstate fb_sys_fops iTCO_wdt
iTCO_vendor_support drm intel_uncore pcspkr cdc_ether mxm_wmi usbnet
mii lpc_ich ipmi_ssif mei_me mei ipmi_si ipmi_devintf ipmi_msghandler
acpi_power_meter acpi_pad xfs libcrc32c sd_mod sg nvme crc32c_intel
nvme_core t10_pi ahci libahci tg3 libata megaraid_sas wmi dm_mirror
dm_region_hash dm_log dm_mod [last unloaded: null_blk]
[ 1847.691165] CPU: 8 PID: 12958 Comm: rmdir Tainted: G S
  5.16.0-rc2+ #2
[ 1847.699888] Hardware name: Dell Inc. PowerEdge R730xd/=C9=B2\xdePow,
BIOS 2.13.0 05/14/2021
[ 1847.708633] RIP: 0010:dd_exit_sched+0x1c6/0x260
[ 1847.713782] Code: 34 48 89 f8 48 c1 e8 03 42 0f b6 04 38 84 c0 74
04 3c 03 7e 63 8b 55 30 41 89 d9 44 89 f6 48 c7 c7 a0 f3 47 a5 e8 6e
09 28 01 <0f> 0b e9 08 ff ff ff 0f 0b e9 e0 fe ff ff 48 89 d7 48 89 14
24 e8
[ 1847.734845] RSP: 0018:ffff88816917fb18 EFLAGS: 00010282
[ 1847.740763] RAX: 0000000000000000 RBX: 00000000000160d6 RCX: 00000000000=
00000
[ 1847.748810] RDX: 0000000000000001 RSI: ffffffffa548e4a0 RDI: ffffffffa89=
e2c40
[ 1847.756856] RBP: ffff8882b8584880 R08: ffffed103cb3fad1 R09: ffffed103cb=
3fad1
[ 1847.764901] R10: ffff8881e59fd687 R11: ffffed103cb3fad0 R12: ffff8882b85=
84800
[ 1847.772936] R13: ffff8882b8584948 R14: 0000000000000001 R15: dffffc00000=
00000
[ 1847.780974] FS:  00007f50bb899540(0000) GS:ffff8881e5800000(0000)
knlGS:0000000000000000
[ 1847.790078] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1847.796574] CR2: 000055bb317c00a8 CR3: 0000000139ecc003 CR4: 00000000001=
706e0
[ 1847.804608] Call Trace:
[ 1847.807418]  <TASK>
[ 1847.810232]  blk_mq_exit_sched+0x1db/0x2d0
[ 1847.814888]  ? blk_release_queue+0xda/0x2d0
[ 1847.819674]  elevator_exit+0x44/0x60
[ 1847.823752]  blk_release_queue+0x13a/0x2d0
[ 1847.828416]  kobject_release+0x10c/0x3a0
[ 1847.832893]  disk_release+0x195/0x250
[ 1847.837066]  device_release+0x9b/0x210
[ 1847.841333]  kobject_release+0x10c/0x3a0
[ 1847.845799]  null_del_dev.part.36+0x1e5/0x500 [null_blk]
[ 1847.851837]  nullb_group_drop_item+0xa4/0xd0 [null_blk]
[ 1847.857754]  configfs_rmdir+0x631/0x830
[ 1847.862185]  ? configfs_unregister_subsystem+0x500/0x500
[ 1847.868226]  vfs_rmdir+0x150/0x4c0
[ 1847.872124]  do_rmdir+0x1bd/0x330
[ 1847.876260]  ? __x64_sys_mkdir+0x80/0x80
[ 1847.880741]  ? __check_object_size+0x272/0x330
[ 1847.885805]  ? strncpy_from_user+0x66/0x340
[ 1847.890554]  ? lockdep_hardirqs_on+0x79/0x100
[ 1847.895522]  ? getname_flags+0xf8/0x510
[ 1847.899907]  __x64_sys_rmdir+0x3e/0x50
[ 1847.904197]  do_syscall_64+0x3a/0x80
[ 1847.908275]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1847.913995] RIP: 0033:0x7f50bb39f1cb
[ 1847.918062] Code: 73 01 c3 48 8b 0d bd fc 2c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 54 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8d fc 2c 00 f7 d8 64 89
01 48
[ 1847.939096] RSP: 002b:00007ffc5d7789c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000054
[ 1847.947629] RAX: ffffffffffffffda RBX: 00007ffc5d779271 RCX: 00007f50bb3=
9f1cb
[ 1847.955690] RDX: 00007f50bb6725c0 RSI: 0000000000000001 RDI: 00007ffc5d7=
79271
[ 1847.963729] RBP: 00007ffc5d778af8 R08: 0000000000000000 R09: 00000000000=
00000
[ 1847.971768] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00002
[ 1847.979804] R13: 00007f50bb66f374 R14: 0000000000000000 R15: 00000000000=
00000
[ 1847.987916]  </TASK>
[ 1847.990429] irq event stamp: 25523
[ 1847.994295] hardirqs last  enabled at (25533): [<ffffffffa2d97e02>]
__up_console_sem+0x52/0x60
[ 1848.003992] hardirqs last disabled at (25542): [<ffffffffa2d97de7>]
__up_console_sem+0x37/0x60
[ 1848.013675] softirqs last  enabled at (25344): [<ffffffffa500064a>]
__do_softirq+0x64a/0xa4c
[ 1848.023200] softirqs last disabled at (25247): [<ffffffffa2c149ae>]
irq_exit_rcu+0x1ce/0x250
[ 1848.032702] ---[ end trace 622a93ec5416c956 ]---



--=20
Best Regards,
  Yi Zhang

