Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB3AC4332F
	for <linux-block@archiver.kernel.org>; Tue, 31 Oct 2023 10:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjJaK3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Oct 2023 06:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJaK3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Oct 2023 06:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82AA83
        for <linux-block@vger.kernel.org>; Tue, 31 Oct 2023 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698748114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2br/4T4iTM9SA6K9a3wh2iteZ1ik76aOcELSjD9dl0=;
        b=RxZwMxDhG9+ToffgyAfVhSsfzCzmcTMgVwlaia3tJymrhELz+L048WXUwuEN2lp27z7Cxa
        lSOFfixA5WoOdyVKqdb6Y+74CF06atBCdi+t/VHkuD5PSi/bA39jgSXiIdyi6/JuTmeug9
        Njt4OZZSwaDuFDdwHXxswDeS70OSvZI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-JYaCB1eHMgSEftEgrXplVA-1; Tue, 31 Oct 2023 06:28:33 -0400
X-MC-Unique: JYaCB1eHMgSEftEgrXplVA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28003f0ecedso3710007a91.2
        for <linux-block@vger.kernel.org>; Tue, 31 Oct 2023 03:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698748112; x=1699352912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2br/4T4iTM9SA6K9a3wh2iteZ1ik76aOcELSjD9dl0=;
        b=sF1Ah+k5OcL+A90KWpz40tO/gXe0sR4OsLNtem7ZoOE8/2xjSwaBkoZIUUM0oWZbOQ
         dtJhL5FGFgLXwNDU54dCIaBvYuy8rDuMeS9tVbbp78Puuj9vodr0kr/aICrY5+NvU1mK
         /Bl3cRkWU5CAGMU9d/qlSPDN+KJTEiS+egt5AZYxgvqXOuqEmRoQgxrBU4nMGd1Ug0dz
         oKsQ1EHpQiCuKFq+0CJN9SNhDqMHJP36raW5aImKwL9wsFmXxzq4EHI8wQv1r+ZfKq+m
         yWC5sozsqO8yZJJp6QXS+GjOjapL4T8MTPnoHYH/zs5JDSnZnocVXP9b4VqU5u80zYFX
         bEcg==
X-Gm-Message-State: AOJu0Yzq6L3BLLiEnZ2v1PfrXBb4tFa9E9nktWt/PkGIhpYnKr5I+YBW
        fnQiYBmoRZ+CnHsvDkeiXEbqyuHfqmPywKeD75qKq8MyRz+gdqDUyei/ne10cMvsSwrAB3IRad1
        cCnYZHj8wvAqLCbO7UgBVsePvNvSynJMJrSExoYCyCBqhedNHNQ==
X-Received: by 2002:a17:90a:77c1:b0:280:14ac:a6db with SMTP id e1-20020a17090a77c100b0028014aca6dbmr7114913pjs.18.1698748112150;
        Tue, 31 Oct 2023 03:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeDH2fO0tGz9giWoN2tPiguCWx9Wkf8G5caFeaGM0/A2Temy8ufug7Gx3ZIdZa/MSXAx0HEPKeIFvsDd5jBvw=
X-Received: by 2002:a17:90a:77c1:b0:280:14ac:a6db with SMTP id
 e1-20020a17090a77c100b0028014aca6dbmr7114897pjs.18.1698748111797; Tue, 31 Oct
 2023 03:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+VTPpuD5BditV_frdgbW5zJFkCqMe-JqZhRBkrRQGHsUg@mail.gmail.com>
 <86a416e5-8738-6d4a-094f-9d2e763f7092@huaweicloud.com>
In-Reply-To: <86a416e5-8738-6d4a-094f-9d2e763f7092@huaweicloud.com>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Tue, 31 Oct 2023 18:28:20 +0800
Message-ID: <CAGVVp+V+W1W1NPPGDM7rTkgKuxPcw44d9XNy3_97ekmeoQ9xLQ@mail.gmail.com>
Subject: Re: [bug report] RIP: 0010:throtl_trim_slice+0xc6/0x320 caused kernel panic
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Linux Block Devices <linux-block@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi=EF=BC=8CYu Kuai

the "master" branch I use, already contain the patch you provide, but
I  still can triggered this issue

Thanks,


On Tue, Oct 31, 2023 at 11:29=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2023/10/31 11:08, Changhui Zhong =E5=86=99=E9=81=93:
> > Hello,
> >
> > triggered below issue with branch 'master',please help check,
> >
> > INFO: HEAD of cloned kernel
> > commit 888cf78c29e223fd808682f477c18cf8f61ad995
> > Merge: 09a4a03c073b 6e6c6d6bc6c9
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Fri Oct 27 05:43:05 2023 -1000
> >
> >      Merge tag 'iommu-fix-v6.6-rc7' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
> >
> >      Pull iommu fix from Joerg Roedel:
> >
> >       - Fix boot regression for Sapphire Rapids with Intel VT-d driver
> >
> >      * tag 'iommu-fix-v6.6-rc7' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu:
> >        iommu: Avoid unnecessary cache invalidations
> >
> > steps:
> > echo "+cpuset +cpu +io" > /sys/fs/cgroup/cgroup.subtree_control
> > mkdir /sys/fs/cgroup/test
> > MAJ=3D$(ls -l /dev/"$disk" | awk -F ',' '{print $1}' | awk -F ' ' '{pri=
nt $NF}')
> > MIN=3D$(ls -l /dev/"$disk" | awk -F ',' '{print $2}' | awk -F ' ' '{pri=
nt $1}')
> > echo "$MAJ:$MIN wbps=3D1024" > /sys/fs/cgroup/test/io.max
> > echo $$ > /sys/fs/cgroup/test/cgroup.procs
> > dd if=3D/dev/zero of=3D/dev/$disk bs=3D10k count=3D1 oflag=3Ddirect &
> > dd if=3D/dev/zero of=3D/dev/$disk bs=3D10k count=3D1 oflag=3Ddirect &
> > wait
> >
> > console log:
> > [ 6502.907379] divide error: 0000 [#1] PREEMPT SMP NOPTI
> This is already fixed by:
>
> https://lore.kernel.org/all/20231020223617.2739774-1-khazhy@google.com/
>
> Thanks,
> Kuai
> > [ 6502.912447] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 6.6.0-rc7+ #1
> > [ 6502.918711] Hardware name: Dell Inc. PowerEdge R650xs/0PPTY2, BIOS
> > 1.4.4 10/07/2021
> > [ 6502.926364] RIP: 0010:throtl_trim_slice+0xc6/0x320
> > [ 6502.931156] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
> > f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
> > 48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
> > ff ff
> > [ 6502.949902] RSP: 0018:ffa00000006ccdc0 EFLAGS: 00010887
> > [ 6502.955128] RAX: ffffffffffffd8f0 RBX: ff110001061aa000 RCX: 0000000=
0000003e8
> > [ 6502.962260] RDX: 000000000000270f RSI: 0000000000000001 RDI: ff11000=
1061aa000
> > [ 6502.969394] RBP: 0000000000002710 R08: ffffffffffffffff R09: ff11000=
10fa74818
> > [ 6502.976527] R10: ff110001061aa010 R11: ff1100010fa74830 R12: 0000000=
000000001
> > [ 6502.983660] R13: ff110001061aa008 R14: 0000000000000001 R15: 0000000=
000000021
> > [ 6502.990793] FS:  0000000000000000(0000) GS:ff1100046fd80000(0000)
> > knlGS:0000000000000000
> > [ 6502.998879] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 6503.004624] CR2: 000055d60b15b000 CR3: 00000001dce20005 CR4: 0000000=
000771ee0
> > [ 6503.011757] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 6503.018891] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [ 6503.026023] PKRU: 55555554
> > [ 6503.028735] Call Trace:
> > [ 6503.031187]  <IRQ>
> > [ 6503.033207]  ? die+0x33/0x90
> > [ 6503.036093]  ? do_trap+0xe0/0x110
> > [ 6503.039413]  ? throtl_trim_slice+0xc6/0x320
> > [ 6503.043599]  ? do_error_trap+0x65/0x80
> > [ 6503.047351]  ? throtl_trim_slice+0xc6/0x320
> > [ 6503.051538]  ? exc_divide_error+0x36/0x50
> > [ 6503.055549]  ? throtl_trim_slice+0xc6/0x320
> > [ 6503.059735]  ? asm_exc_divide_error+0x16/0x20
> > [ 6503.064098]  ? throtl_trim_slice+0xc6/0x320
> > [ 6503.068281]  tg_dispatch_one_bio+0xf0/0x1e0
> > [ 6503.072469]  throtl_pending_timer_fn+0x1e5/0x510
> > [ 6503.077086]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
> > [ 6503.082226]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
> > [ 6503.087365]  call_timer_fn+0x24/0x130
> > [ 6503.091034]  __run_timers.part.0+0x1ee/0x280
> > [ 6503.095304]  ? __hrtimer_run_queues+0x121/0x2b0
> > [ 6503.099839]  ? sched_clock+0xc/0x30
> > [ 6503.103329]  run_timer_softirq+0x26/0x50
> > [ 6503.107256]  __do_softirq+0xc8/0x2ab
> > [ 6503.110834]  __irq_exit_rcu+0xa1/0xc0
> > [ 6503.114501]  sysvec_apic_timer_interrupt+0x72/0x90
> > [ 6503.119295]  </IRQ>
> > [ 6503.121400]  <TASK>
> > [ 6503.123507]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [ 6503.128646] RIP: 0010:cpuidle_enter_state+0xc2/0x420
> > [ 6503.133611] Code: 00 e8 22 cf 4e ff e8 4d f4 ff ff 8b 53 04 49 89
> > c5 0f 1f 44 00 00 31 ff e8 0b a8 4d ff 45 84 ff 0f 85 3a 02 00 00 fb
> > 45 85 f6 <0f> 88 6e 01 00 00 49 63 d6 4c 2b 2c 24 48 8d 04 52 48 8d 04
> > 82 49
> > [ 6503.152357] RSP: 0018:ffa00000001ebe80 EFLAGS: 00000206
> > [ 6503.157582] RAX: ff1100046fdb2100 RBX: ff1100046fdbc7e0 RCX: 0000000=
00000001f
> > [ 6503.164707] RDX: 0000000000000006 RSI: 000000003d1877c2 RDI: 0000000=
000000000
> > [ 6503.171842] RBP: 0000000000000003 R08: 000005ea137b9428 R09: 0000000=
000000000
> > [ 6503.178972] R10: 00000000000003dc R11: ff1100046fdb0be4 R12: fffffff=
fbe2b1900
> > [ 6503.186104] R13: 000005ea137b9428 R14: 0000000000000003 R15: 0000000=
000000000
> > [ 6503.193232]  cpuidle_enter+0x29/0x40
> > [ 6503.196811]  cpuidle_idle_call+0xfa/0x160
> > [ 6503.200822]  do_idle+0x7b/0xe0
> > [ 6503.203882]  cpu_startup_entry+0x26/0x30
> > [ 6503.207808]  start_secondary+0x115/0x140
> > [ 6503.211735]  secondary_startup_64_no_verify+0x17d/0x18b
> > [ 6503.216961]  </TASK>
> > [ 6503.219154] Modules linked in: binfmt_misc dm_crypt raid10 raid1
> > raid0 dm_raid raid456 async_raid6_recov async_memcpy async_pq
> > async_xor xor async_tx raid6_pq loop nf_tables nfnetlink tls
> > rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache
> > netfs rfkill sunrpc ipmi_ssif vfat fat intel_rapl_msr
> > intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
> > i10nm_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp
> > coretemp kvm_intel kvm mgag200 irqbypass rapl iTCO_wdt i2c_algo_bit
> > acpi_ipmi drm_shmem_helper iTCO_vendor_support dax_hmem intel_cstate
> > ipmi_si cxl_acpi drm_kms_helper mei_me dell_smbios i2c_i801
> > ipmi_devintf isst_if_mbox_pci isst_if_mmio dcdbas cxl_core
> > intel_uncore dell_wmi_descriptor wmi_bmof pcspkr mei isst_if_common
> > intel_pch_thermal intel_vsec i2c_smbus ipmi_msghandler
> > acpi_power_meter drm fuse xfs libcrc32c sd_mod t10_pi sg ahci libahci
> > crct10dif_pclmul crc32_pclmul crc32c_intel libata tg3
> > ghash_clmulni_intel wmi dm_mirror dm_region_hash dm_log dm_mod
> > [ 6503.219202]  [last unloaded: scsi_debug]
> > [ 6503.311377] ---[ end trace 0000000000000000 ]---
> > [ 6503.346804] RIP: 0010:throtl_trim_slice+0xc6/0x320
> > [ 6503.351597] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
> > f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
> > 48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
> > ff ff
> > [ 6503.370344] RSP: 0018:ffa00000006ccdc0 EFLAGS: 00010887
> > [ 6503.375569] RAX: ffffffffffffd8f0 RBX: ff110001061aa000 RCX: 0000000=
0000003e8
> > [ 6503.382703] RDX: 000000000000270f RSI: 0000000000000001 RDI: ff11000=
1061aa000
> > [ 6503.389836] RBP: 0000000000002710 R08: ffffffffffffffff R09: ff11000=
10fa74818
> > [ 6503.396969] R10: ff110001061aa010 R11: ff1100010fa74830 R12: 0000000=
000000001
> > [ 6503.404100] R13: ff110001061aa008 R14: 0000000000000001 R15: 0000000=
000000021
> > [ 6503.411235] FS:  0000000000000000(0000) GS:ff1100046fd80000(0000)
> > knlGS:0000000000000000
> > [ 6503.419320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 6503.425067] CR2: 000055d60b15b000 CR3: 00000001dce20005 CR4: 0000000=
000771ee0
> > [ 6503.432199] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 6503.439332] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [ 6503.446463] PKRU: 55555554
> > [ 6503.449176] Kernel panic - not syncing: Fatal exception in interrupt
> > [ 6503.455610] Kernel Offset: disabled
> > [ 6503.488281] ---[ end Kernel panic - not syncing: Fatal exception in
> > interrupt ]---
> >
> > Thanks,
> >
> > .
> >
>

