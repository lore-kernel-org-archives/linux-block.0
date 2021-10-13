Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D13C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D05610A1
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 08:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbhJMIwd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 04:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238783AbhJMIwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 04:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634115027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ex+8vLOe4mH/lB2MNfs/RaaIe281CC92WxWdsdVGcDQ=;
        b=Knip9juIKrBVATrcdyDjEeBpLFHKiydaSSE5Eh2GOLtNVT9qdOEt5m9G0MQ6GIlhe6DQHe
        0Bt91x6SCw85aW/OBap/7430aao2sJ6njsyHLA7x8kRXE5dr12rOMMwN5QorimFTwq7MpC
        OacADE4cZQ0U0Smivi93fdyhQLCWyOo=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-y6g6SepiOOaPIv5V_-ATAA-1; Wed, 13 Oct 2021 04:50:25 -0400
X-MC-Unique: y6g6SepiOOaPIv5V_-ATAA-1
Received: by mail-yb1-f200.google.com with SMTP id z130-20020a256588000000b005b6b4594129so2413949ybb.15
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 01:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ex+8vLOe4mH/lB2MNfs/RaaIe281CC92WxWdsdVGcDQ=;
        b=Unhn8tv6FscUm/NoaN717TMkkO+FQcUojWQ+J5fDXyMnABtRsA0Cd43NV2IiMj25SX
         Jd+BDXvGmH5azwDS3RZLGUzhzdDtGsBLuT/J3nGLMxHzAn39UYp+4FqoEEBPNwzc95Yj
         +c2F6gpVkEoP9yIG68xO9Co+cP6wVUjM+DoSVp/gR/QmWSU26EXTEvQMEKiRuDTarpPy
         hqN+YEfBQ0J0txmyxQAOTTQAQdtnKns+cHEyQn/YJ99m+ttrBHZYYCdFgk1VBVHqMq3Q
         EbhTSJHMsbJdW7S2Zf7v4XHYfTxPR5CpjaGoKrCCPUmValpvOeywgS42KuXQh/AGmVlk
         ycCw==
X-Gm-Message-State: AOAM532Y2kiTOlsHJy5ewveM3rmlaXIGROupUoy24FjaW+7xpRdk6ywt
        Rg4pfQA2qa0Ne8V7IuotHu0ZljD+LdJpKZ2nlG54pUXGTdn9kASODly/EwMHXYhRGfmgiGEzJUo
        kpXptxl7uiKpzfMqwHcH+AKs/8WIT7Hs+O29W2og=
X-Received: by 2002:a25:496:: with SMTP id 144mr33529464ybe.522.1634115025083;
        Wed, 13 Oct 2021 01:50:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzxeAa6GAP2UCAPtvKrGM9WM5w9pFxjd1ZCmEa8RQviH9GBlYI06VeR96wYUGOg/qhLh7qP+cSA39n28uK5SY=
X-Received: by 2002:a25:496:: with SMTP id 144mr33529446ybe.522.1634115024773;
 Wed, 13 Oct 2021 01:50:24 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 13 Oct 2021 16:50:13 +0800
Message-ID: <CAHj4cs8poXTLdC+j6u7zypLKR7RpAaG-vxK4dWDz6bCMfPOjsQ@mail.gmail.com>
Subject: kernel NULL pointer triggered with blktests block/025 on latest linux-block/for-next
To:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
The below NULL pointer issue was triggered on the latest
linux-block/for-next with blktests, is it one known issue?

[  536.985788] run blktests block/025 at 2021-10-13 04:26:03
[  537.196048] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw =3D (0/1)
[  537.206830] sd 11:0:0:0: Power-on or device reset occurred
[  550.149333] BUG: kernel NULL pointer dereference, address: 0000000000000=
098
[  550.157111] #PF: supervisor read access in kernel mode
[  550.162843] #PF: error_code(0x0000) - not-present page
[  550.168576] PGD 0 P4D 0
[  550.171403] Oops: 0000 [#1] SMP PTI
[  550.175294] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G S
  5.15.0-rc5+ #1
[  550.183938] Hardware name: Dell Inc. PowerEdge R730xd/=C9=B2=EF=BF=BDPow=
, BIOS
2.13.0 05/14/2021
[  550.192578] RIP: 0010:wb_timer_fn+0x37/0x320
[  550.197351] Code: 48 8b 5f 60 4c 8b 67 50 8b ab 98 00 00 00 8b 93
b8 00 00 00 8b 83 d8 00 00 00 4c 8b 6b 28 01 d5 01 c5 48 8b 43 60 48
8b 40 78 <4c> 8b b0 98 00 00 00 4d 85 ed 0f 84 c0 00 00 00 48 83 7b 30
00 0f
[  550.218308] RSP: 0018:ffffb52981c34e80 EFLAGS: 00010246
[  550.224139] RAX: 0000000000000000 RBX: ffff9650c7a59700 RCX: 00000000000=
0000c
[  550.232103] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff965111a=
72500
[  550.240064] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[  550.248027] R10: 000000000000000b R11: 0000000000000030 R12: ffff964f44c=
3c1e0
[  550.255991] R13: 0000000000000000 R14: ffff965111a72510 R15: ffff9652b7c=
d7f70
[  550.263954] FS:  0000000000000000(0000) GS:ffff9652b7cc0000(0000)
knlGS:0000000000000000
[  550.272985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  550.279396] CR2: 0000000000000098 CR3: 000000040a610003 CR4: 00000000001=
706e0
[  550.287360] Call Trace:
[  550.290087]  <IRQ>
[  550.292675]  ? blk_stat_free_callback_rcu+0x30/0x30
[  550.298120]  call_timer_fn+0x26/0xf0
[  550.302114]  run_timer_softirq+0x1c7/0x3d0
[  550.306678]  ? update_process_times+0xb0/0xc0
[  550.311541]  ? tick_sched_handle.isra.24+0x1f/0x60
[  550.316890]  ? timerqueue_add+0x6f/0x80
[  550.321170]  ? enqueue_hrtimer+0x2f/0x70
[  550.325548]  ? recalibrate_cpu_khz+0x10/0x10
[  550.330316]  ? ktime_get+0x3e/0xa0
[  550.334108]  ? setup_local_APIC+0x350/0x350
[  550.338779]  __do_softirq+0xc9/0x285
[  550.342762]  irq_exit_rcu+0xa6/0xc0
[  550.346657]  sysvec_apic_timer_interrupt+0x6e/0x90
[  550.352006]  </IRQ>
[  550.354345]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  550.360081] RIP: 0010:cpuidle_enter_state+0xd6/0x350
[  550.365626] Code: 49 89 c4 0f 1f 44 00 00 31 ff e8 95 5b 98 ff 45
84 ff 74 12 9c 58 f6 c4 02 0f 85 32 02 00 00 31 ff e8 6e fb 9e ff fb
45 85 f6 <0f> 88 e0 00 00 00 49 63 d6 4c 2b 24 24 48 8d 04 52 48 8d 04
82 49
[  550.386582] RSP: 0018:ffffb52980187e80 EFLAGS: 00000202
[  550.392411] RAX: ffff9652b7ce7c00 RBX: 0000000000000004 RCX: 00000000000=
0001f
[  550.400374] RDX: 0000008017745c51 RSI: 000000005000068d RDI: 00000000000=
00000
[  550.408337] RBP: ffffd5297fcc0308 R08: 0000000000000002 R09: 00000000000=
27440
[  550.416300] R10: 00000beeb045c510 R11: ffff9652b7ce6944 R12: 00000080177=
45c51
[  550.424264] R13: ffffffffb3acac00 R14: 0000000000000004 R15: 00000000000=
00000
[  550.432228]  cpuidle_enter+0x29/0x40
[  550.436210]  do_idle+0x257/0x2a0
[  550.439814]  cpu_startup_entry+0x19/0x20
[  550.444192]  start_secondary+0x116/0x150
[  550.448570]  secondary_startup_64_no_verify+0xc2/0xcb
[  550.454212] Modules linked in: scsi_debug(-) rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill
sunrpc vfat fat dm_multipath intel_rapl_msr intel_rapl_common sb_edac
x86_pkg_temp_thermal intel_powerclamp coretemp mgag200 kvm_intel kvm
iTCO_wdt i2c_algo_bit irqbypass iTCO_vendor_support drm_kms_helper
crct10dif_pclmul crc32_pclmul pcspkr ghash_clmulni_intel syscopyarea
sysfillrect sysimgblt fb_sys_fops cdc_ether rapl intel_cstate usbnet
mei_me drm intel_uncore mii lpc_ich mxm_wmi mei ipmi_ssif ipmi_si
ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad xfs libcrc32c
sd_mod sg nvme ahci nvme_core libahci crc32c_intel libata t10_pi tg3
megaraid_sas wmi dm_mirror dm_region_hash dm_log dm_mod [last
unloaded: scsi_debug]
[  550.528470] CR2: 0000000000000098
[  550.532168] ---[ end trace e450dd0876b8ec06 ]---
[  550.605860] RIP: 0010:wb_timer_fn+0x37/0x320
[  550.610630] Code: 48 8b 5f 60 4c 8b 67 50 8b ab 98 00 00 00 8b 93
b8 00 00 00 8b 83 d8 00 00 00 4c 8b 6b 28 01 d5 01 c5 48 8b 43 60 48
8b 40 78 <4c> 8b b0 98 00 00 00 4d 85 ed 0f 84 c0 00 00 00 48 83 7b 30
00 0f
[  550.631586] RSP: 0018:ffffb52981c34e80 EFLAGS: 00010246
[  550.637416] RAX: 0000000000000000 RBX: ffff9650c7a59700 RCX: 00000000000=
0000c
[  550.645379] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff965111a=
72500
[  550.653341] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[  550.661303] R10: 000000000000000b R11: 0000000000000030 R12: ffff964f44c=
3c1e0
[  550.669265] R13: 0000000000000000 R14: ffff965111a72510 R15: ffff9652b7c=
d7f70
[  550.677227] FS:  0000000000000000(0000) GS:ffff9652b7cc0000(0000)
knlGS:0000000000000000
[  550.686257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  550.692669] CR2: 0000000000000098 CR3: 000000040a610003 CR4: 00000000001=
706e0
[  550.700633] Kernel panic - not syncing: Fatal exception in interrupt
[  550.829274] Kernel Offset: 0x31000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  550.911183] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---
--=20
Best Regards,
  Yi Zhang

