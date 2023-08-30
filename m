Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DF7C83F17
	for <linux-block@archiver.kernel.org>; Wed, 30 Aug 2023 18:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243142AbjH3SqQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbjH3LXU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2023 07:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B121BB
        for <linux-block@vger.kernel.org>; Wed, 30 Aug 2023 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693394548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1LCjn/XP3AAmX5frb3HOcwMtnAp7tbHVsdhvjrq6K84=;
        b=OshMVcbfgg6dLEYVP4EaS99a+PbtK5G3/OKmSxea8Ht8i3IDEx38gKocqho0ysnxdlakz/
        vyqdVnXmb4iy9skHogAc25F9/WMoxA8QMscZGI/g/CZEazgJRoTzmyDduOtrFEzBcmeDR/
        xZX94PtxlrgC2cdfJjecRoQJrOa3NMI=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-D6v2LdO8NwaL1ZUqUglf6g-1; Wed, 30 Aug 2023 07:22:27 -0400
X-MC-Unique: D6v2LdO8NwaL1ZUqUglf6g-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1c8c362c080so6434515fac.0
        for <linux-block@vger.kernel.org>; Wed, 30 Aug 2023 04:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693394546; x=1693999346;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LCjn/XP3AAmX5frb3HOcwMtnAp7tbHVsdhvjrq6K84=;
        b=OAhdX78KwrrgHToQtk2h+r8tmRK4MLAUgGRYd37A5rmOK8VNW4N2ZS3r6mHHlFBa67
         /2fm9M1mfxGvnn7ffL3UcXNhBg2KMQdgZTzuMng2Q/r4m/w8XyxeZoQQh25/hiB+Jw/K
         c8V6PlFeksOvodBzPz8IA08YedTQnX+nTquumbJIdprNyM1WqKARAEuIbF7cf8V0N+e8
         qOS5pF4RtRVvot8xWruj97HuVzVnJg+MEIhUhOOV6d9hSZebqZocN3Z648rMq9Pi/WXu
         K+XahiKrmPrb9vXYhycxWX552YkZ4v+1aNS+6w10Jt30j+0kNgQEB+yzoQCthgX5vIa6
         QqUg==
X-Gm-Message-State: AOJu0YysS8iMgLEbRdP0HCR2K8zZ0qN2SUXiunbCwqdqL0yQady8WsvD
        pwXEB9DnEZkzltRu2OPVKKBh1TxQ5rPSy+jZYIbWIRmg545dlSK5G8o9+ek4CDYDQ3VRR9GkVmt
        YahxtZkYaRUnsvJyJbkVt1PT+BTCysTjXcPKG7ndWS0OcG3VT+Q==
X-Received: by 2002:a05:6870:a181:b0:1b0:57f8:dabf with SMTP id a1-20020a056870a18100b001b057f8dabfmr1895479oaf.33.1693394546198;
        Wed, 30 Aug 2023 04:22:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh1KM+U5AmdyTjuA8ZB31LmsdNO0NPZBmaZ5rHUZt929KYEkB5LHpoP8LTNE2uLCYjZYkyfsS2NIZnWvj3ylw=
X-Received: by 2002:a05:6870:a181:b0:1b0:57f8:dabf with SMTP id
 a1-20020a056870a18100b001b057f8dabfmr1895459oaf.33.1693394545729; Wed, 30 Aug
 2023 04:22:25 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 30 Aug 2023 19:22:14 +0800
Message-ID: <CAHj4cs_eZWuYDmxi3T0WbkihLHJS6=36XGyx+xjE6JvgwRR-fA@mail.gmail.com>
Subject: [bug report] blktests nvme/043 nvme/045 failed
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

I found blkests nvme/043 nvme/045 failed on one of our x86_64 servers,
and it works on the other servers, from the log, it failed when
Testing DH group ffdhe6144 and ffdhe8192, is it hw limitation?

# ./check nvme/043 nvme/045
nvme/043 (Test hash and DH group variations for authenticated
connections) [failed]
    runtime  7.057s  ...  7.298s
    --- tests/nvme/043.out 2023-08-30 00:19:38.518253725 -0400
    +++ /root/blktests/results/nodev/nvme/043.out.bad 2023-08-30
07:09:47.805056014 -0400
    @@ -12,7 +12,9 @@
     Testing DH group ffdhe4096
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Testing DH group ffdhe6144
    +tests/nvme/rc: line 780: echo: write error: Invalid argument
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Testing DH group ffdhe8192
    +tests/nvme/rc: line 780: echo: write error: Invalid argument
    ...
    (Run 'diff -u tests/nvme/043.out
/root/blktests/results/nodev/nvme/043.out.bad' to see the entire diff)
nvme/045 (Test re-authentication)                            [failed]
    runtime  1.129s  ...  1.031s
    --- tests/nvme/045.out 2023-08-30 00:19:38.518253725 -0400
    +++ /root/blktests/results/nodev/nvme/045.out.bad 2023-08-30
07:09:49.162053096 -0400
    @@ -5,6 +5,7 @@
     Renew ctrl key on the controller
     Re-authenticate with new ctrl key
     Change DH group to ffdhe8192
    +tests/nvme/rc: line 780: echo: write error: Invalid argument
     Re-authenticate with changed DH group
     Change hash to hmac(sha512)
     Re-authenticate with changed hash
# cat results/nodev/nvme/043.out.bad
Running nvme/043
Testing hash hmac(sha256)
NQN:blktests-subsystem-1 disconnected 1 controller(s)
Testing hash hmac(sha384)
NQN:blktests-subsystem-1 disconnected 1 controller(s)
Testing hash hmac(sha512)
NQN:blktests-subsystem-1 disconnected 1 controller(s)
Testing DH group ffdhe2048
NQN:blktests-subsystem-1 disconnected 1 controller(s)
Testing DH group ffdhe3072
NQN:blktests-subsystem-1 disconnected 1 controller(s)
Testing DH group ffdhe4096
NQN:blktests-subsystem-1 disconnected 1 controller(s)
Testing DH group ffdhe6144
tests/nvme/rc: line 780: echo: write error: Invalid argument
NQN:blktests-subsystem-1 disconnected 1 controller(s)
Testing DH group ffdhe8192
tests/nvme/rc: line 780: echo: write error: Invalid argument
NQN:blktests-subsystem-1 disconnected 1 controller(s)
Test complete

# cat results/nodev/nvme/045.out.bad
Running nvme/045
Re-authenticate with original host key
Renew host key on the controller
Re-authenticate with new host key
Renew ctrl key on the controller
Re-authenticate with new ctrl key
Change DH group to ffdhe8192
tests/nvme/rc: line 780: echo: write error: Invalid argument
Re-authenticate with changed DH group
Change hash to hmac(sha512)
Re-authenticate with changed hash
NQN:blktests-subsystem-1 disconnected 1 controller(s)
Test complete

# dmesg
[   69.957138] run blktests nvme/043 at 2023-08-30 07:09:40
[   69.978405] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   70.014107] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[   70.035854] nvme nvme0: qid 0: authenticated with hash hmac(sha256)
dhgroup null
[   70.044156] nvme nvme0: qid 0: authenticated
[   70.049073] nvme nvme0: creating 56 I/O queues.
[   70.267615] nvme nvme0: new ctrl: "blktests-subsystem-1"
[   70.295125] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[   70.725627] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[   70.747942] nvme nvme0: qid 0: authenticated with hash hmac(sha384)
dhgroup null
[   70.756237] nvme nvme0: qid 0: authenticated
[   70.761208] nvme nvme0: creating 56 I/O queues.
[   70.991654] nvme nvme0: new ctrl: "blktests-subsystem-1"
[   71.017200] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[   71.435492] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[   71.457799] nvme nvme0: qid 0: authenticated with hash hmac(sha512)
dhgroup null
[   71.466085] nvme nvme0: qid 0: authenticated
[   71.471047] nvme nvme0: creating 56 I/O queues.
[   71.699797] nvme nvme0: new ctrl: "blktests-subsystem-1"
[   71.725256] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[   72.153759] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[   72.172640] nvme nvme0: qid 0: authenticated with hash hmac(sha512)
dhgroup ffdhe2048
[   72.181470] nvme nvme0: qid 0: authenticated
[   72.186384] nvme nvme0: creating 56 I/O queues.
[   72.282281] nvme nvme0: new ctrl: "blktests-subsystem-1"
[   72.310214] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[   72.766366] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[   72.787046] nvme nvme0: qid 0: authenticated with hash hmac(sha512)
dhgroup ffdhe3072
[   72.795893] nvme nvme0: qid 0: authenticated
[   72.800826] nvme nvme0: creating 56 I/O queues.
[   72.990987] nvme nvme0: new ctrl: "blktests-subsystem-1"
[   73.020641] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[   73.523419] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[   73.550242] nvme nvme0: qid 0: authenticated with hash hmac(sha512)
dhgroup ffdhe4096
[   73.559040] nvme nvme0: qid 0: authenticated
[   73.563938] nvme nvme0: creating 56 I/O queues.
[   74.113282] nvme nvme0: new ctrl: "blktests-subsystem-1"
[   74.142589] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[   74.548668] alg: ffdhe6144(dh): test failed on vector 1, err=-22
[   74.555389] alg: self-tests for ffdhe6144(dh) using
ffdhe6144(qat-dh) failed (rc=-22)
[   74.555391] ------------[ cut here ]------------
[   74.569289] alg: self-tests for ffdhe6144(dh) using
ffdhe6144(qat-dh) failed (rc=-22)
[   74.569310] WARNING: CPU: 54 PID: 2303 at crypto/testmgr.c:5936
alg_test+0x516/0x630
[   74.586705] Modules linked in: nvme_loop nvmet nvme_fabrics
nvme_core nvme_common rfkill ixgbe sunrpc intel_rapl_msr
intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp
coretemp ipmi_ssif kvm_intel pcspkr i2c_i801 kvm iTCO_wdt
iTCO_vendor_support pktcdvd mei_me irqbypass mdio rapl i2c_smbus
intel_cstate acpi_ipmi mei dca intel_uncore ipmi_si joydev
ipmi_devintf ipmi_msghandler lpc_ich acpi_pad acpi_power_meter fuse
loop zram xfs sd_mod sr_mod cdrom t10_pi ahci libahci qat_dh895xcc
crct10dif_pclmul crc32_pclmul crc32c_intel libata intel_qat
ghash_clmulni_intel mgag200 crc8 i2c_algo_bit wmi dm_mod
[   74.646779] CPU: 54 PID: 2303 Comm: cryptomgr_test Not tainted
6.6.0-0.rc0.20230829git1c59d383390f.59.eln130.x86_64 #1
[   74.658722] Hardware name: Intel Corporation S2600WTT/S2600WTT,
BIOS GRNDSDP1.86B.0046.R00.1502111331 02/11/2015
[   74.670081] RIP: 0010:alg_test+0x516/0x630
[   74.674655] Code: ff ff 4c 89 e6 4c 89 e7 41 89 c7 e8 d4 da fe ff
e9 37 ff ff ff 44 89 f9 48 89 ea 4c 89 ee 48 c7 c7 b8 54 62 ba e8 6a
66 b5 ff <0f> 0b e9 7d fe ff ff 48 89 c2 48 89 ee 48 c7 c7 f0 53 62 ba
45 89
[   74.695613] RSP: 0018:ffffbbb7c885fe10 EFLAGS: 00010286
[   74.701438] RAX: 0000000000000000 RBX: 0000000000000089 RCX: 0000000000000027
[   74.709413] RDX: ffff9058afca0848 RSI: 0000000000000001 RDI: ffff9058afca0840
[   74.717369] RBP: ffff9054ccf5cc00 R08: 0000000000000000 R09: ffffbbb7c885fca0
[   74.725335] R10: 0000000000000003 R11: ffffffffbb1e5f68 R12: 000000000000008a
[   74.733302] R13: ffff9054ccf5cc80 R14: 00000000ffffffff R15: 00000000ffffffea
[   74.741258] FS:  0000000000000000(0000) GS:ffff9058afc80000(0000)
knlGS:0000000000000000
[   74.750289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   74.756701] CR2: 00007f6bbb4a0f08 CR3: 0000000340e20001 CR4: 00000000001706e0
[   74.764665] Call Trace:
[   74.767405]  <TASK>
[   74.769745]  ? alg_test+0x516/0x630
[   74.773640]  ? __warn+0x81/0x130
[   74.777245]  ? alg_test+0x516/0x630
[   74.781139]  ? report_bug+0x171/0x1a0
[   74.785232]  ? console_unlock+0x64/0x110
[   74.789612]  ? handle_bug+0x3a/0x70
[   74.793507]  ? exc_invalid_op+0x17/0x70
[   74.797788]  ? asm_exc_invalid_op+0x1a/0x20
[   74.802462]  ? alg_test+0x516/0x630
[   74.806356]  ? __update_idle_core+0x27/0xd0
[   74.811033]  ? __switch_to_asm+0x3e/0x70
[   74.815416]  ? finish_task_switch.isra.0+0x94/0x2c0
[   74.820862]  ? __schedule+0x28b/0x790
[   74.824954]  ? __pfx_cryptomgr_test+0x10/0x10
[   74.829818]  cryptomgr_test+0x24/0x40
[   74.833898]  kthread+0xe8/0x120
[   74.837412]  ? __pfx_kthread+0x10/0x10
[   74.841597]  ret_from_fork+0x34/0x50
[   74.845588]  ? __pfx_kthread+0x10/0x10
[   74.849773]  ret_from_fork_asm+0x1b/0x30
[   74.854155]  </TASK>
[   74.856594] ---[ end trace 0000000000000000 ]---
[   74.868165] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[   74.895088] nvme nvme0: qid 0: authenticated with hash hmac(sha512)
dhgroup ffdhe4096
[   74.903903] nvme nvme0: qid 0: authenticated
[   74.908814] nvme nvme0: creating 56 I/O queues.
[   75.456877] nvme nvme0: new ctrl: "blktests-subsystem-1"
[   75.490947] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[   75.894980] alg: ffdhe8192(dh): test failed on vector 1, err=-22
[   75.901702] alg: self-tests for ffdhe8192(dh) using
ffdhe8192(qat-dh) failed (rc=-22)
[   75.901703] ------------[ cut here ]------------
[   75.915598] alg: self-tests for ffdhe8192(dh) using
ffdhe8192(qat-dh) failed (rc=-22)
[   75.915607] WARNING: CPU: 54 PID: 2315 at crypto/testmgr.c:5936
alg_test+0x516/0x630
[   75.932994] Modules linked in: nvme_loop nvmet nvme_fabrics
nvme_core nvme_common rfkill ixgbe sunrpc intel_rapl_msr
intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp
coretemp ipmi_ssif kvm_intel pcspkr i2c_i801 kvm iTCO_wdt
iTCO_vendor_support pktcdvd mei_me irqbypass mdio rapl i2c_smbus
intel_cstate acpi_ipmi mei dca intel_uncore ipmi_si joydev
ipmi_devintf ipmi_msghandler lpc_ich acpi_pad acpi_power_meter fuse
loop zram xfs sd_mod sr_mod cdrom t10_pi ahci libahci qat_dh895xcc
crct10dif_pclmul crc32_pclmul crc32c_intel libata intel_qat
ghash_clmulni_intel mgag200 crc8 i2c_algo_bit wmi dm_mod
[   75.993054] CPU: 54 PID: 2315 Comm: cryptomgr_test Tainted: G
 W         -------  ---
6.6.0-0.rc0.20230829git1c59d383390f.59.eln130.x86_64 #1
[   76.007905] Hardware name: Intel Corporation S2600WTT/S2600WTT,
BIOS GRNDSDP1.86B.0046.R00.1502111331 02/11/2015
[   76.019254] RIP: 0010:alg_test+0x516/0x630
[   76.023828] Code: ff ff 4c 89 e6 4c 89 e7 41 89 c7 e8 d4 da fe ff
e9 37 ff ff ff 44 89 f9 48 89 ea 4c 89 ee 48 c7 c7 b8 54 62 ba e8 6a
66 b5 ff <0f> 0b e9 7d fe ff ff 48 89 c2 48 89 ee 48 c7 c7 f0 53 62 ba
45 89
[   76.044777] RSP: 0018:ffffbbb7c88afe10 EFLAGS: 00010286
[   76.050602] RAX: 0000000000000000 RBX: 000000000000008a RCX: 0000000000000027
[   76.058568] RDX: ffff9058afca0848 RSI: 0000000000000001 RDI: ffff9058afca0840
[   76.066533] RBP: ffff9054ccf5e400 R08: 0000000000000000 R09: ffffbbb7c88afca0
[   76.074496] R10: 0000000000000003 R11: ffffffffbb1e5f68 R12: 000000000000008b
[   76.082460] R13: ffff9054ccf5e480 R14: 00000000ffffffff R15: 00000000ffffffea
[   76.090426] FS:  0000000000000000(0000) GS:ffff9058afc80000(0000)
knlGS:0000000000000000
[   76.099450] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   76.105862] CR2: 00007f6bbb4a0f08 CR3: 0000000340e20001 CR4: 00000000001706e0
[   76.113825] Call Trace:
[   76.116553]  <TASK>
[   76.118894]  ? alg_test+0x516/0x630
[   76.122780]  ? __warn+0x81/0x130
[   76.126388]  ? alg_test+0x516/0x630
[   76.130292]  ? report_bug+0x171/0x1a0
[   76.134381]  ? console_unlock+0x64/0x110
[   76.138759]  ? handle_bug+0x3a/0x70
[   76.142652]  ? exc_invalid_op+0x17/0x70
[   76.146933]  ? asm_exc_invalid_op+0x1a/0x20
[   76.151595]  ? alg_test+0x516/0x630
[   76.155480]  ? __update_idle_core+0x27/0xd0
[   76.160150]  ? __switch_to_asm+0x3e/0x70
[   76.164529]  ? finish_task_switch.isra.0+0x94/0x2c0
[   76.169973]  ? __schedule+0x28b/0x790
[   76.174060]  ? __pfx_cryptomgr_test+0x10/0x10
[   76.178922]  cryptomgr_test+0x24/0x40
[   76.183008]  kthread+0xe8/0x120
[   76.186515]  ? __pfx_kthread+0x10/0x10
[   76.190699]  ret_from_fork+0x34/0x50
[   76.194689]  ? __pfx_kthread+0x10/0x10
[   76.198872]  ret_from_fork_asm+0x1b/0x30
[   76.203251]  </TASK>
[   76.205688] ---[ end trace 0000000000000000 ]---
[   76.217339] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[   76.244233] nvme nvme0: qid 0: authenticated with hash hmac(sha512)
dhgroup ffdhe4096
[   76.253049] nvme nvme0: qid 0: authenticated
[   76.257961] nvme nvme0: creating 56 I/O queues.
[   76.803497] nvme nvme0: new ctrl: "blktests-subsystem-1"
[   76.838043] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[   77.580673] run blktests nvme/045 at 2023-08-30 07:09:48
[   77.604563] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   77.621293] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
with DH-HMAC-CHAP.
[   77.640212] nvme nvme0: qid 0: authenticated with hash hmac(sha256)
dhgroup ffdhe2048
[   77.648962] nvme nvme0: qid 0: controller authenticated
[   77.654884] nvme nvme0: qid 0: authenticated
[   77.659805] nvme nvme0: creating 56 I/O queues.
[   77.750259] nvme nvme0: new ctrl: "blktests-subsystem-1"
[   77.779762] nvme nvme0: re-authenticating controller
[   77.786634] nvme nvme0: qid 0: authenticated with hash hmac(sha256)
dhgroup ffdhe2048
[   77.795379] nvme nvme0: qid 0: controller authenticated
[   77.803966] nvme nvme0: re-authenticating controller
[   77.810766] nvme nvme0: qid 0: authenticated with hash hmac(sha256)
dhgroup ffdhe2048
[   77.819510] nvme nvme0: qid 0: controller authenticated
[   77.827801] nvme nvme0: re-authenticating controller
[   77.834727] nvme nvme0: qid 0: authenticated with hash hmac(sha256)
dhgroup ffdhe2048
[   77.843472] nvme nvme0: qid 0: controller authenticated
[   77.852087] nvme nvme0: re-authenticating controller
[   77.859042] nvme nvme0: qid 0: authenticated with hash hmac(sha256)
dhgroup ffdhe2048
[   77.867788] nvme nvme0: qid 0: controller authenticated
[   77.876093] nvme nvme0: re-authenticating controller
[   77.882985] nvme nvme0: qid 0: authenticated with hash hmac(sha512)
dhgroup ffdhe2048
[   77.891731] nvme nvme0: qid 0: controller authenticated
[   78.209366] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"

-- 
Best Regards,
  Yi Zhang

