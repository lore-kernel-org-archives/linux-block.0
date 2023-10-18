Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF36ACDB47E
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 14:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjJROHz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjJROHy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2023 10:07:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D0C106
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2023 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697638029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PrbOpdCfViuyDERm7jWcs0LpwXcVG4qrEnluzSRTQwc=;
        b=cmbyirwpSxfv0mWDI0ZWBbkR8upxboWtqUKff1PLzmZ5/2XQrVpsYDw0df3DCkLQPuVLwt
        s+pZnoLn3J1JG77SV1AkozXpjckAva2LI2kh2lwMOazCmfNeKZDCT/v4DqA123UkCfAsR4
        xXMyGVKbLI1NNxPCnlZLhlaR5gSGRz0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-V6FZnBRvMBeYpXygkAgaEA-1; Wed, 18 Oct 2023 10:07:07 -0400
X-MC-Unique: V6FZnBRvMBeYpXygkAgaEA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-692bbab7a4fso6159155b3a.1
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2023 07:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697638026; x=1698242826;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrbOpdCfViuyDERm7jWcs0LpwXcVG4qrEnluzSRTQwc=;
        b=w7I+azmYGVy6cKIhbBTRvOUMLX/3ZtPN8N5NQXEf0KiOAKHDkfm1LgkyrTONbBqbVT
         0C6J26/+xuuZ6+Vd9GJdB46MRs0yaYrJEg6cG3xhwnbBZX5A2krkgloKJ27gVQlNAdTW
         dRB8o66xPeF8+Hi0W++4gaRUzi3w/2nObJYoMaNBkgZLhP8JkUA9BFdsHUZqBa4NRogh
         9FUjYYmm1j01EfUaC+CCQQfEsIkd+l2CfAIgDtlrvyviY2YpkHG0Iap8saX3H5wLO7Kr
         HIGgPD6lUxEx6XBbN11hpd4Kc7JUW5yrSby7tDKvPODnMZg6RxPIm+Aq34Jq6/dnJBXv
         sXWg==
X-Gm-Message-State: AOJu0YyhU3Cz5PDPuMuPSAP49VmizSamApkrntWGzh9/9+U+pP+BzVM+
        UvvqZ3Mq7fFThBUkG8y7+sGFLY3XvXIqYbuHWt6jJ6YvaVh7ISywYdix/doVyDO9kLJecoKi6PC
        Rw9JPShlz/+5Z5hOiii1JDCRKg2z2m7VeU0o2EqPfhSFz+MtKnUJMM14=
X-Received: by 2002:a05:6a20:4306:b0:17b:2813:81de with SMTP id h6-20020a056a20430600b0017b281381demr3874108pzk.10.1697638025872;
        Wed, 18 Oct 2023 07:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOYBoSbiQZpLpWNwK29x4qsKf83558z8Fc9pF2+iZiHpEuIovn0fw47uwOR/xCwXvC8Dg7XtHB0pediu0UCtQ=
X-Received: by 2002:a05:6a20:4306:b0:17b:2813:81de with SMTP id
 h6-20020a056a20430600b0017b281381demr3874074pzk.10.1697638025432; Wed, 18 Oct
 2023 07:07:05 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 18 Oct 2023 22:06:54 +0800
Message-ID: <CAHj4cs_Lprbh1zWsJ2yT6+qhNoqjrGDrBgx+XOYvU9SLpmLTtw@mail.gmail.com>
Subject: [bug report] blktests nvme/tcp failed on the latest linux-block/for-next
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
I found most of the blktests nvme/tcp failed[2] on the latest
linux-block/for-next[1], please help check it, I will try to bisect
it, thanks.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-next
e3db512c4ab6 (HEAD -> for-next, origin/for-next) Merge branch
'for-6.7/block' into for-next

[2]
# nvme_trtype=tcp ./check nvme/003
nvme/003 (test if we're sending keep-alives to a discovery controller) [failed]
    runtime  13.731s  ...  12.676s
    something found in dmesg:
    [ 5149.710328] run blktests nvme/003 at 2023-10-18 09:58:24
    [ 5149.819809] loop0: detected capacity change from 0 to 2097152
    [ 5149.846524] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
    [ 5149.880347] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
    [ 5149.934226] nvmet: creating discovery controller 1 for
subsystem nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
    [ 5149.954001] nvme nvme0: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
    [ 5161.391083] nvme nvme0: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
    [ 5161.400970] ------------[ cut here ]------------
    [ 5161.405594] ODEBUG: assert_init not available (active state 0)
object: 0000000004184194 object type: timer_list hint: 0x0
    [ 5161.416566] WARNING: CPU: 6 PID: 55 at lib/debugobjects.c:514
debug_print_object+0x199/0x2c0
    ...
    (See '/root/blktests/results/nodev/nvme/003.dmesg' for the entire message)

# cat /root/blktests/results/nodev/nvme/003.dmesg
[ 5149.710328] run blktests nvme/003 at 2023-10-18 09:58:24
[ 5149.819809] loop0: detected capacity change from 0 to 2097152
[ 5149.846524] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 5149.880347] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 5149.934226] nvmet: creating discovery controller 1 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 5149.954001] nvme nvme0: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
[ 5161.391083] nvme nvme0: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"
[ 5161.400970] ------------[ cut here ]------------
[ 5161.405594] ODEBUG: assert_init not available (active state 0)
object: 0000000004184194 object type: timer_list hint: 0x0
[ 5161.416566] WARNING: CPU: 6 PID: 55 at lib/debugobjects.c:514
debug_print_object+0x199/0x2c0
[ 5161.425003] Modules linked in: loop nvmet_tcp nvmet nvme_common
nvme_tcp nvme_fabrics nvme_core rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace fscache netfs rfkill sunrpc vfat fat
dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common isst_if_common skx_edac
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200
irqbypass rapl iTCO_wdt iTCO_vendor_support i2c_algo_bit mei_me
ipmi_ssif intel_cstate drm_shmem_helper dell_smbios dcdbas
intel_uncore dell_wmi_descriptor wmi_bmof drm_kms_helper pcspkr
acpi_ipmi mei i2c_i801 lpc_ich intel_pch_thermal i2c_smbus ipmi_si
ipmi_devintf ipmi_msghandler dax_pmem acpi_power_meter drm fuse xfs
libcrc32c nd_pmem nd_btt sd_mod t10_pi sg crct10dif_pclmul
crc32_pclmul crc32c_intel ahci libahci ghash_clmulni_intel tg3 libata
megaraid_sas wmi nfit libnvdimm dm_mirror dm_region_hash dm_log dm_mod
[last unloaded: loop]
[ 5161.506243] CPU: 6 PID: 55 Comm: kworker/6:0 Tainted: G        W
      6.6.0-rc3+ #3
[ 5161.514244] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.17.1 11/15/2022
[ 5161.521808] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tcp]
[ 5161.528516] RIP: 0010:debug_print_object+0x199/0x2c0
[ 5161.533481] Code: 8d 3c dd 80 8a 17 9d 48 89 fa 48 c1 ea 03 80 3c
02 00 75 54 41 55 48 8b 14 dd 80 8a 17 9d 48 c7 c7 a0 7b 17 9d e8 c7
82 fd fe <0f> 0b 58 83 05 c9 a8 33 03 01 48 83 c4 20 5b 5d 41 5c 41 5d
41 5e
[ 5161.552227] RSP: 0018:ffffc900009af998 EFLAGS: 00010096
[ 5161.557454] RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
[ 5161.564586] RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
[ 5161.571719] RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed11c697dfa9
[ 5161.578850] R10: ffff888e34befd4b R11: 0000000000000001 R12: ffffffff9cf2d4e0
[ 5161.585984] R13: 0000000000000000 R14: ffffc900009afa58 R15: ffffffff9cf2d4e0
[ 5161.593116] FS:  0000000000000000(0000) GS:ffff888e34a00000(0000)
knlGS:0000000000000000
[ 5161.601202] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5161.606947] CR2: 00005638a5d9ffea CR3: 00000003bb24e003 CR4: 00000000007706e0
[ 5161.614080] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5161.621211] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5161.628343] PKRU: 55555554
[ 5161.631056] Call Trace:
[ 5161.633511]  <TASK>
[ 5161.635616]  ? __warn+0xc9/0x350
[ 5161.638848]  ? debug_print_object+0x199/0x2c0
[ 5161.643209]  ? report_bug+0x326/0x3c0
[ 5161.646875]  ? handle_bug+0x3c/0x70
[ 5161.650364]  ? exc_invalid_op+0x14/0x50
[ 5161.654206]  ? asm_exc_invalid_op+0x16/0x20
[ 5161.658394]  ? debug_print_object+0x199/0x2c0
[ 5161.662750]  ? debug_print_object+0x199/0x2c0
[ 5161.667108]  ? do_raw_spin_unlock+0x55/0x1f0
[ 5161.671383]  debug_object_assert_init+0x27d/0x3c0
[ 5161.676089]  ? __pfx_debug_object_assert_init+0x10/0x10
[ 5161.681313]  ? lock_acquire+0x4db/0x5e0
[ 5161.685152]  ? __pfx_try_to_wake_up+0x10/0x10
[ 5161.689510]  ? do_raw_spin_trylock+0xb5/0x180
[ 5161.693872]  ? __timer_delete+0x70/0x170
[ 5161.697797]  __timer_delete+0x70/0x170
[ 5161.701550]  ? __pfx___timer_delete+0x10/0x10
[ 5161.705907]  ? __mutex_lock+0x741/0x14b0
[ 5161.709833]  ? try_to_grab_pending+0x70/0x80
[ 5161.714105]  ? rcu_is_watching+0x11/0xb0
[ 5161.718032]  try_to_grab_pending+0x46/0x80
[ 5161.722132]  __cancel_work_timer+0xa0/0x460
[ 5161.726318]  ? mutex_lock_io_nested+0x1273/0x1310
[ 5161.731024]  ? __pfx___cancel_work_timer+0x10/0x10
[ 5161.735816]  ? do_raw_write_trylock+0xb5/0x190
[ 5161.740260]  ? __pfx_do_raw_write_trylock+0x10/0x10
[ 5161.745141]  ? rcu_is_watching+0x11/0xb0
[ 5161.749066]  ? trace_irq_enable.constprop.0+0x13d/0x180
[ 5161.754292]  ? __pfx_sk_stream_write_space+0x10/0x10
[ 5161.759258]  nvmet_tcp_release_queue_work+0x2db/0x1350 [nvmet_tcp]
[ 5161.765438]  ? rcu_is_watching+0x11/0xb0
[ 5161.769362]  ? process_one_work+0x6b5/0x13f0
[ 5161.773637]  process_one_work+0x7c1/0x13f0
[ 5161.777737]  ? __pfx___lock_release+0x10/0x10
[ 5161.782093]  ? __pfx_process_one_work+0x10/0x10
[ 5161.786630]  ? assign_work+0x16c/0x240
[ 5161.790378]  ? rcu_is_watching+0x11/0xb0
[ 5161.794306]  worker_thread+0x721/0xfd0
[ 5161.798060]  ? __pfx_worker_thread+0x10/0x10
[ 5161.802332]  kthread+0x2f8/0x3e0
[ 5161.805562]  ? _raw_spin_unlock_irq+0x24/0x50
[ 5161.809921]  ? __pfx_kthread+0x10/0x10
[ 5161.813674]  ret_from_fork+0x2d/0x70
[ 5161.817254]  ? __pfx_kthread+0x10/0x10
[ 5161.821007]  ret_from_fork_asm+0x1b/0x30
[ 5161.824937]  </TASK>
[ 5161.827125] irq event stamp: 40414
[ 5161.830530] hardirqs last  enabled at (40413): [<ffffffff9caa5aa4>]
_raw_spin_unlock_irq+0x24/0x50
[ 5161.839482] hardirqs last disabled at (40414): [<ffffffff9ca8bc48>]
__schedule+0xa68/0x1d80
[ 5161.847829] softirqs last  enabled at (35660): [<ffffffff9caa8a3b>]
__do_softirq+0x5db/0x8f6
[ 5161.856261] softirqs last disabled at (35653): [<ffffffff9a64c4dc>]
__irq_exit_rcu+0xbc/0x210
[ 5161.864780] ---[ end trace 0000000000000000 ]---
[ 5161.869451] ------------[ cut here ]------------
[ 5161.874112] WARNING: CPU: 6 PID: 55 at kernel/workqueue.c:3400
__flush_work+0x165/0x180
[ 5161.882154] Modules linked in: loop nvmet_tcp nvmet nvme_common
nvme_tcp nvme_fabrics nvme_core rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace fscache netfs rfkill sunrpc vfat fat
dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common isst_if_common skx_edac
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200
irqbypass rapl iTCO_wdt iTCO_vendor_support i2c_algo_bit mei_me
ipmi_ssif intel_cstate drm_shmem_helper dell_smbios dcdbas
intel_uncore dell_wmi_descriptor wmi_bmof drm_kms_helper pcspkr
acpi_ipmi mei i2c_i801 lpc_ich intel_pch_thermal i2c_smbus ipmi_si
ipmi_devintf ipmi_msghandler dax_pmem acpi_power_meter drm fuse xfs
libcrc32c nd_pmem nd_btt sd_mod t10_pi sg crct10dif_pclmul
crc32_pclmul crc32c_intel ahci libahci ghash_clmulni_intel tg3 libata
megaraid_sas wmi nfit libnvdimm dm_mirror dm_region_hash dm_log dm_mod
[last unloaded: loop]
[ 5161.963439] CPU: 6 PID: 55 Comm: kworker/6:0 Tainted: G        W
      6.6.0-rc3+ #3
[ 5161.971480] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.17.1 11/15/2022
[ 5161.979087] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tcp]
[ 5161.985831] RIP: 0010:__flush_work+0x165/0x180
[ 5161.990322] Code: cc cc 48 8d 7c 24 78 88 44 24 07 e8 25 b3 3e 02
48 c7 c6 80 70 ec 9c 4c 89 e7 e8 b6 8e fb 00 0f b6 44 24 07 eb 93 0f
0b eb 8f <0f> 0b 31 c0 eb 89 e8 20 0e 88 00 e9 2c ff ff ff e8 76 99 3c
02 66
[ 5162.009102] RSP: 0018:ffffc900009afa38 EFLAGS: 00010246
[ 5162.014330] RAX: 1ffff1107469886b RBX: 1ffff92000135f48 RCX: dffffc0000000000
[ 5162.021463] RDX: ffffc900009afa40 RSI: 0000000000000001 RDI: ffff8883a34c4358
[ 5162.028596] RBP: ffff8883a34c4340 R08: 0000000000000000 R09: fffffbfff3d319c4
[ 5162.035727] R10: ffffffff9e98ce27 R11: 0000000000000001 R12: ffff8883a34c4340
[ 5162.042860] R13: 1ffff92000135f77 R14: 0000000000000001 R15: ffff88810208bec0
[ 5162.049994] FS:  0000000000000000(0000) GS:ffff888e34a00000(0000)
knlGS:0000000000000000
[ 5162.058079] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5162.063823] CR2: 00005638a5d9ffea CR3: 000000104da6e001 CR4: 00000000007706e0
[ 5162.070956] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5162.078088] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5162.085222] PKRU: 55555554
[ 5162.087934] Call Trace:
[ 5162.090387]  <TASK>
[ 5162.092493]  ? __warn+0xc9/0x350
[ 5162.095727]  ? __flush_work+0x165/0x180
[ 5162.099573]  ? report_bug+0x326/0x3c0
[ 5162.103251]  ? handle_bug+0x3c/0x70
[ 5162.106748]  ? exc_invalid_op+0x14/0x50
[ 5162.110587]  ? asm_exc_invalid_op+0x16/0x20
[ 5162.114778]  ? __flush_work+0x165/0x180
[ 5162.118622]  ? lock_acquire+0x4db/0x5e0
[ 5162.122469]  ? __pfx___flush_work+0x10/0x10
[ 5162.126658]  ? __pfx_try_to_wake_up+0x10/0x10
[ 5162.131025]  ? irqentry_enter+0x28/0x70
[ 5162.134872]  ? rcu_is_watching+0x11/0xb0
[ 5162.138805]  ? trace_irq_enable.constprop.0+0x13d/0x180
[ 5162.144034]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[ 5162.149355]  __cancel_work_timer+0x31a/0x460
[ 5162.153633]  ? mutex_lock_io_nested+0x1273/0x1310
[ 5162.158343]  ? __pfx___cancel_work_timer+0x10/0x10
[ 5162.163141]  ? do_raw_write_trylock+0xb5/0x190
[ 5162.167596]  ? __pfx_do_raw_write_trylock+0x10/0x10
[ 5162.172475]  ? rcu_is_watching+0x11/0xb0
[ 5162.176411]  ? trace_irq_enable.constprop.0+0x13d/0x180
[ 5162.181646]  ? __pfx_sk_stream_write_space+0x10/0x10
[ 5162.186618]  nvmet_tcp_release_queue_work+0x2db/0x1350 [nvmet_tcp]
[ 5162.192807]  ? rcu_is_watching+0x11/0xb0
[ 5162.196741]  ? process_one_work+0x6b5/0x13f0
[ 5162.201024]  process_one_work+0x7c1/0x13f0
[ 5162.205132]  ? __pfx___lock_release+0x10/0x10
[ 5162.209497]  ? __pfx_process_one_work+0x10/0x10
[ 5162.214033]  ? assign_work+0x16c/0x240
[ 5162.217791]  ? rcu_is_watching+0x11/0xb0
[ 5162.221720]  worker_thread+0x721/0xfd0
[ 5162.225482]  ? __pfx_worker_thread+0x10/0x10
[ 5162.229761]  kthread+0x2f8/0x3e0
[ 5162.233000]  ? _raw_spin_unlock_irq+0x24/0x50
[ 5162.237360]  ? __pfx_kthread+0x10/0x10
[ 5162.241122]  ret_from_fork+0x2d/0x70
[ 5162.244709]  ? __pfx_kthread+0x10/0x10
[ 5162.248461]  ret_from_fork_asm+0x1b/0x30
[ 5162.252392]  </TASK>
[ 5162.254587] irq event stamp: 40414
[ 5162.257994] hardirqs last  enabled at (40413): [<ffffffff9caa5aa4>]
_raw_spin_unlock_irq+0x24/0x50
[ 5162.266955] hardirqs last disabled at (40414): [<ffffffff9ca8bc48>]
__schedule+0xa68/0x1d80
[ 5162.275300] softirqs last  enabled at (35660): [<ffffffff9caa8a3b>]
__do_softirq+0x5db/0x8f6
[ 5162.283732] softirqs last disabled at (35653): [<ffffffff9a64c4dc>]
__irq_exit_rcu+0xbc/0x210
[ 5162.292255] ---[ end trace 0000000000000000 ]---

-- 
Best Regards,
  Yi Zhang

