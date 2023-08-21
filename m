Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1931EE49A6
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 01:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjHUBoZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Aug 2023 21:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjHUBoZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Aug 2023 21:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DD99C
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 18:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692582216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hfqQv/VpYEjguMRzOp/h+H56tjCnPn79ClyWEj9huUs=;
        b=Boq3QSQcEGWEmESN87cbOKx0irUtNRPpDSlaM1HNiMmmBnN4plijucYhMMtTPlyRJaBADg
        63jKJlGlTPG7k7O8/m5z7EM8OgJ+cUYo0Deu4i1Bns9D6RhqLMxJgeE7twxsltH/KD1Ye+
        b/kv55c6Go+fYV6TFBCLC3K9AxfSIqM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-jT-N1BcWPoiAFAnJPIlmMw-1; Sun, 20 Aug 2023 21:43:34 -0400
X-MC-Unique: jT-N1BcWPoiAFAnJPIlmMw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bdd75d2f73so45950075ad.1
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 18:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692582213; x=1693187013;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfqQv/VpYEjguMRzOp/h+H56tjCnPn79ClyWEj9huUs=;
        b=NIsHjzob7kHchgLcCz4T0qViRzVQj7cX+w9Axrz3XpCO9YWphWdE5C3wl4x+dGNbMC
         DFrd+1zMaYq+V45M0UtazTMXXUFOVvxdHmhK2RkDZZP67fRRD/oA0fm/HWAYxEUKmGIG
         4pAoC/+V/dTEbla45Yivlg18qg+25eW1TjZlUpiIJTHSxzT9onaMAdnpHrlvm9awpqNz
         KGol3lvd3Qx6dlUneWxVn2Ut0EguqDe/gqDee+1A3vXwWKvFDPX9PQ6rnZwJ8w1erJ0D
         zI25/dFXaYzUOJL8EMy2Ssgp/wFk2suH4vPQ7At4sQozU3btIrndLPU5TM1h0AAOOda0
         uVUw==
X-Gm-Message-State: AOJu0Yxh+xFUhJLEcBYOTrNCGAgi+CO1l+XU1XJI0NR4Q2FdOuOigJ3Q
        jsONl4tQAz7y0fowexlDoDtinsl4Ra/QHBxTV2+ELaYuWtwh0gtlU43RMRhHYAb4kB7AwE/dZL4
        jIRIhqvzIRGkLQZLDKkpXZXEH6f69uIR5Rkt8fSGHGDjS1agydbAm
X-Received: by 2002:a17:90a:c08e:b0:26d:49a0:2071 with SMTP id o14-20020a17090ac08e00b0026d49a02071mr8124487pjs.13.1692582213438;
        Sun, 20 Aug 2023 18:43:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmjkHPmy0cNsMq5NCKfKqua35Qb5WSuClVHfzlKo5yk6mTftLZ/epUwGnxnElQY8u8Rx4vgXGBafdXzqHq2Ko=
X-Received: by 2002:a17:90a:c08e:b0:26d:49a0:2071 with SMTP id
 o14-20020a17090ac08e00b0026d49a02071mr8124475pjs.13.1692582213114; Sun, 20
 Aug 2023 18:43:33 -0700 (PDT)
MIME-Version: 1.0
From:   Changhui Zhong <czhong@redhat.com>
Date:   Mon, 21 Aug 2023 09:43:22 +0800
Message-ID: <CAGVVp+Xiz99dpFPn5RYjFfA-8tZH0cSvsmydB=1k08GfbViAFw@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 12 PID: 51497 at block/mq-deadline.c:679 dd_exit_sched+0xd5/0xe0
To:     linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

triggered below warning issue with branch 'block-6.5',

# modprobe null_blk queue_mode=2 shared_tag_bitmap=1 submit_queues=40
# fio --bs=256k --ioengine=libaio --iodepth=64
--iodepth_batch_submit=16 --iodepth_batch_complete_min=16
--filename=/dev/nullb0 --direct=1 --runtime=20 --numjobs=16
--rw=randread --name=test --group_reporting


[ 1473.165718] ------------[ cut here ]------------
[ 1473.170362] statistics for priority 1: i 167532888 m 52 d 167532836
c 167532836
[ 1473.177700] WARNING: CPU: 12 PID: 51497 at block/mq-deadline.c:679
dd_exit_sched+0xd5/0xe0
[ 1473.185987] Modules linked in: null_blk(-) tls rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill
sunrpc vfat fat dm_multipath intel_rapl_msr intel_rapl_common
intel_uncore_frequency intel_uncore_frequency_common isst_if_common
skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp
ipmi_ssif kvm_intel kvm mgag200 irqbypass i2c_algo_bit rapl iTCO_wdt
drm_shmem_helper iTCO_vendor_support dell_smbios intel_cstate
drm_kms_helper intel_uncore acpi_ipmi dcdbas ipmi_si mei_me
dell_wmi_descriptor wmi_bmof pcspkr i2c_i801 mei ipmi_devintf
intel_pch_thermal lpc_ich i2c_smbus ipmi_msghandler acpi_power_meter
drm fuse xfs libcrc32c sd_mod sg nvme ahci crct10dif_pclmul
crc32_pclmul libahci crc32c_intel nvme_core tg3 libata
ghash_clmulni_intel nvme_common megaraid_sas t10_pi wmi dm_mirror
dm_region_hash dm_log dm_mod [last unloaded: scsi_debug]
[ 1473.263733] CPU: 12 PID: 51497 Comm: modprobe Not tainted 6.4.0+ #1
[ 1473.270005] Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS
2.15.1 06/15/2022
[ 1473.277571] RIP: 0010:dd_exit_sched+0xd5/0xe0
[ 1473.281938] Code: 00 75 cf 8b 4b 34 8b 53 30 44 89 fe 48 c7 c7 d8
ca 7c bc 48 8b 04 24 44 8b 43 38 c6 05 f3 68 73 01 01 44 8b 08 e8 fb
13 b2 ff <0f> 0b eb a4 0f 0b e9 78 ff ff ff 90 90 90 90 90 90 90 90 90
90 90
[ 1473.300684] RSP: 0018:ffffbc2a0655fd38 EFLAGS: 00010282
[ 1473.305909] RAX: 0000000000000000 RBX: ffff9cdc5c6fa080 RCX: 0000000000000000
[ 1473.313041] RDX: ffff9cddb7dac880 RSI: ffff9cddb7d9f840 RDI: ffff9cddb7d9f840
[ 1473.320174] RBP: ffff9cdc5c6fa000 R08: 0000000000000000 R09: 00000000ffff7fff
[ 1473.327306] R10: ffffbc2a0655fbd8 R11: ffffffffbcde6148 R12: ffff9cdc5c6fa148
[ 1473.334439] R13: 0000000009fc5924 R14: 0000000009fc5958 R15: 0000000000000001
[ 1473.341572] FS:  00007fcd87ad5740(0000) GS:ffff9cddb7d80000(0000)
knlGS:0000000000000000
[ 1473.349656] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1473.355402] CR2: 000055d9de41a120 CR3: 000000010a2c4004 CR4: 00000000007706e0
[ 1473.362536] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1473.369668] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1473.376798] PKRU: 55555554
[ 1473.379512] Call Trace:
[ 1473.381966]  <TASK>
[ 1473.384071]  ? __warn+0x80/0x130
[ 1473.387310]  ? dd_exit_sched+0xd5/0xe0
[ 1473.391065]  ? report_bug+0x195/0x1a0
[ 1473.394738]  ? handle_bug+0x3c/0x70
[ 1473.398239]  ? exc_invalid_op+0x14/0x70
[ 1473.402078]  ? asm_exc_invalid_op+0x16/0x20
[ 1473.406274]  ? dd_exit_sched+0xd5/0xe0
[ 1473.410026]  ? dd_exit_sched+0xd5/0xe0
[ 1473.413779]  blk_mq_exit_sched+0xf4/0x140
[ 1473.417791]  elevator_exit+0x34/0x50
[ 1473.421370]  del_gendisk+0x28b/0x350
[ 1473.424951]  null_del_dev.part.0+0x50/0x160 [null_blk]
[ 1473.430097]  null_exit+0x50/0xbc [null_blk]
[ 1473.434292]  __do_sys_delete_module.constprop.0+0x177/0x2f0
[ 1473.439874]  ? syscall_trace_enter.constprop.0+0x126/0x1a0
[ 1473.445365]  do_syscall_64+0x59/0x90
[ 1473.448947]  ? exit_to_user_mode_prepare+0xc4/0xd0
[ 1473.453739]  ? syscall_exit_to_user_mode+0x12/0x30
[ 1473.458530]  ? do_syscall_64+0x69/0x90
[ 1473.462284]  ? exc_page_fault+0x65/0x150
[ 1473.466208]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 1473.471262] RIP: 0033:0x7fcd8723f5ab
[ 1473.474840] Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89
01 48
[ 1473.493587] RSP: 002b:00007fffb33c5cc8 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[ 1473.501154] RAX: ffffffffffffffda RBX: 000055982fc0ad00 RCX: 00007fcd8723f5ab
[ 1473.508285] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055982fc0ad68
[ 1473.515416] RBP: 000055982fc0ad00 R08: 0000000000000000 R09: 0000000000000000
[ 1473.522550] R10: 00007fcd8739eac0 R11: 0000000000000206 R12: 000055982fc0ad68
[ 1473.529681] R13: 0000000000000000 R14: 000055982fc0ad68 R15: 00007fffb33c7ff8
[ 1473.536815]  </TASK>
[ 1473.539007] ---[ end trace 0000000000000000 ]---

-- 
Best Regards,
  Changhui

