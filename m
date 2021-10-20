Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B35BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 02:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6983760F57
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 02:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhJTCcS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 22:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTCcS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 22:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634697004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=NZmvzV0mf98Khx8m3ilA4xAt2SbZcOkIM+K2Hi/uNuE=;
        b=EKO+1yCyuHSqy905EZt87e+KGNKPdG7cGROVltUG8DFA7s6ilD42BRl4onYaEDyiG094iq
        /3OINcScaniRJykj644Y4cObaIvNsOdNKAMP10LIysfvgE/9bHv9+HkKJhVxcjVWwweVQ8
        CCCZm9vCFsoxpnkR0uwcfl33ZTJdomI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-TmoBrgFJP9GHjBB2b5rpTQ-1; Tue, 19 Oct 2021 22:30:03 -0400
X-MC-Unique: TmoBrgFJP9GHjBB2b5rpTQ-1
Received: by mail-yb1-f199.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so28071155ybk.16
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 19:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NZmvzV0mf98Khx8m3ilA4xAt2SbZcOkIM+K2Hi/uNuE=;
        b=XsRBzmgd0ACJFtq6WfyzE8OCSAYdsVcZZ59v5njV1N7iv5CWCwV7hnEmLQU1gPZ/96
         n5loMi0PIze4gv+zsFsA+YbEcXU8r6MO9CtSDEznO3YygTZsOkhf1wkP3T2IyQRR3/BH
         7zqGJQgxG3jF+v0hBPjx5l0Jqu/IG0ICKXCym2xfnnRf6pTOd24OLZwljupQ3lMOmMhU
         hw1x1A8WDFHqbCW4+ZYDBKvgGAxUJ+spygqgQueeYtIauBtog56xda/OgxgFenYqXz2L
         YiVRwbD7NfRO3CiMDWepQMxEwA5yMP98Qn30lPzWmhgnaekwQjXtM7G1Hs1gjuwrn+Yk
         oYMQ==
X-Gm-Message-State: AOAM532uhEG8ZHm0/umaqMFu+lBvGH4F4V46EePP3TLI4xQPbeZ5GLWl
        zQTyRrThB3GJliG0IzSyCGXUdshp8BykCmDArYKs6UVsAPDOByUpjOzeNHwv2cwwHc6yuB2a1g2
        vGvnMG7aN/n01c5kn93ex6WcSfmQMHT2qEK00bsw=
X-Received: by 2002:a25:cb03:: with SMTP id b3mr40430546ybg.138.1634697002090;
        Tue, 19 Oct 2021 19:30:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMGU6xLgGvJGMleBbYzYFZkHBD4tUq1Hv4QIKmOpO0wJdRThjhKM7fOC5Ksu/e/R1iVcNP9B1DqDn35QIMClE=
X-Received: by 2002:a25:cb03:: with SMTP id b3mr40430509ybg.138.1634697001607;
 Tue, 19 Oct 2021 19:30:01 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 20 Oct 2021 10:29:50 +0800
Message-ID: <CAHj4cs80zAUc2grnCZ015-2Rvd-=gXRfB_dFKy=RTm+wRo09HQ@mail.gmail.com>
Subject: [bug report] kernel BUG at block/blk-mq.c:1042!
To:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

Below issue was triggered with blktests srp/ tests during CKI run on
linux-block/for-next,
seems it was introduced from [2], and still can be reproduced with [1]

[1]
4ff840e57c84 Merge branch 'for-5.16/drivers' into for-next
[2]
59d62b58f120 Merge branch 'for-5.16/block' into for-next

[  108.059798] run blktests srp/005 at 2021-10-19 16:06:40
[  108.255646] null_blk: module loaded
[  108.332655] SoftiWARP attached
[  108.340999] enP2p1s0f1 speed is unknown, defaulting to 1000
[  108.341030] enP2p1s0f1 speed is unknown, defaulting to 1000
[  108.341077] enP2p1s0f1 speed is unknown, defaulting to 1000
[  108.341394] enP2p1s0f1 speed is unknown, defaulting to 1000
[  108.343816] enP2p1s0f1 speed is unknown, defaulting to 1000
[  108.345277] enP2p1s0f2 speed is unknown, defaulting to 1000
[  108.345305] enP2p1s0f2 speed is unknown, defaulting to 1000
[  108.345350] enP2p1s0f2 speed is unknown, defaulting to 1000
[  108.345629] enP2p1s0f2 speed is unknown, defaulting to 1000
[  108.348057] enP2p1s0f1 speed is unknown, defaulting to 1000
[  108.348115] enP2p1s0f2 speed is unknown, defaulting to 1000
[  108.349625] enP2p1s0f3 speed is unknown, defaulting to 1000
[  108.349649] enP2p1s0f3 speed is unknown, defaulting to 1000
[  108.349687] enP2p1s0f3 speed is unknown, defaulting to 1000
[  108.349930] enP2p1s0f3 speed is unknown, defaulting to 1000
[  108.369010] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @
00000000cdaf1e69
[  108.369378] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[  108.369398] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
[  108.369422] scsi host1: scsi_debug: version 0190 [20200710]
[  108.369422]   dev_size_mb=32, opts=0x0, submit_queues=1, statistics=0
[  108.369757] scsi 1:0:0:0: Direct-Access     Linux    scsi_debug
  0190 PQ: 0 ANSI: 7
[  108.370059] sd 1:0:0:0: Power-on or device reset occurred
[  108.370153] sd 1:0:0:0: [sdb] Enabling DIF Type 3 protection
[  108.370231] sd 1:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  108.370260] sd 1:0:0:0: [sdb] Write Protect is off
[  108.370301] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  108.370320] sd 1:0:0:0: Attached scsi generic sg2 type 0
[  108.370357] sd 1:0:0:0: [sdb] Optimal transfer size 524288 bytes
[  108.603860] sd 1:0:0:0: [sdb] Enabling DIX T10-DIF-TYPE3-CRC protection
[  108.603883] sd 1:0:0:0: [sdb] DIF application tag size 6
[  108.714067] sd 1:0:0:0: [sdb] Attached SCSI disk
[  108.850543] enP2p1s0f1 speed is unknown, defaulting to 1000
[  108.865922] enP2p1s0f2 speed is unknown, defaulting to 1000
[  108.880902] enP2p1s0f3 speed is unknown, defaulting to 1000
[  108.910754] Rounding down aligned max_sectors from 4294967295 to 4294967168
[  108.925829] enP2p1s0f1 speed is unknown, defaulting to 1000
[  108.925868] enP2p1s0f2 speed is unknown, defaulting to 1000
[  108.925911] enP2p1s0f3 speed is unknown, defaulting to 1000
[  109.012123] Rounding down aligned max_sectors from 255 to 128
[  109.024700] Rounding down aligned max_sectors from 255 to 128
[  109.074022] Rounding down aligned max_sectors from 4294967295 to 4294967168
[  109.076234] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[  109.524559] scsi host2:   REJ reason 0xffffff98
[  109.524613] scsi host2: ib_srp: Connection 0/1 to 10.16.214.130 failed
[  109.829577] ib_srpt Received SRP_LOGIN_REQ with i_port_id
ac1f:6b09:a3da:0000:0000:0000:0000:0000, t_port_id
ae1f:6bff:fe09:a3da:ae1f:6bff:fe09:a3da and it_iu_len 8260 on port 1
(guid=ac1f:6b09:a3da:0000:0000:0000:0000:0000); pkey 0x00
[  109.838078] scsi host2: SRP.T10:AE1F6BFFFE09A3DA
[  109.838975] scsi 2:0:0:0: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[  109.839546] scsi 2:0:0:0: alua: supports implicit and explicit TPGS
[  109.839568] scsi 2:0:0:0: alua: device
naa.60014056e756c6c62300000000000000 port group 0 rel port 1
[  109.839863] sd 2:0:0:0: Warning! Received an indication that the
LUN assignments on this target have changed. The Linux SCSI layer does
not automatical
[  109.839912] sd 2:0:0:0: Attached scsi generic sg3 type 0
[  109.864457] sd 2:0:0:0: alua: transition timeout set to 60 seconds
[  109.864492] sd 2:0:0:0: alua: port group 00 state A non-preferred
supports TOlUSNA
[  109.865527] scsi 2:0:0:2: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[  109.865785] sd 2:0:0:0: [sdc] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  109.865900] sd 2:0:0:0: [sdc] Write Protect is off
[  109.865993] scsi 2:0:0:2: alua: supports implicit and explicit TPGS
[  109.866016] scsi 2:0:0:2: alua: device
naa.60014057363736964626700000000000 port group 0 rel port 1
[  109.866094] sd 2:0:0:0: [sdc] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[  109.866149] srpt/0xac1f6b09a3da00000000000000000000: Unsupported
SCSI Opcode 0xa3, sending CHECK_CONDITION.
[  109.866188] sd 2:0:0:2: Attached scsi generic sg4 type 0
[  109.866324] sd 2:0:0:0: [sdc] Optimal transfer size 65536 bytes
[  109.866612] scsi 2:0:0:1: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[  109.866909] sd 2:0:0:2: [sdd] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  109.867009] scsi 2:0:0:1: alua: supports implicit and explicit TPGS
[  109.867031] scsi 2:0:0:1: alua: device
naa.60014056e756c6c62310000000000000 port group 0 rel port 1
[  109.867046] sd 2:0:0:2: [sdd] Write Protect is off
[  109.867188] sd 2:0:0:1: Attached scsi generic sg5 type 0
[  109.867213] sd 2:0:0:2: [sdd] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  109.867275] srpt/0xac1f6b09a3da00000000000000000000: Unsupported
SCSI Opcode 0xa3, sending CHECK_CONDITION.
[  109.867392] sd 2:0:0:2: [sdd] Optimal transfer size 524288 bytes
[  109.868049] sd 2:0:0:1: Warning! Received an indication that the
LUN assignments on this target have changed. The Linux SCSI layer does
not automatical
[  109.871388] scsi host3: ib_srp: Already connected to target port
with id_ext=ae1f6bfffe09a3da;ioc_guid=ae1f6bfffe09a3da;dest=fe80:0000:0000:0000:ae1f:6bff:fe09:a3da
[  109.923853] sd 2:0:0:1: alua: transition timeout set to 60 seconds
[  109.923888] sd 2:0:0:1: alua: port group 00 state A non-preferred
supports TOlUSNA
[  109.928326] sd 2:0:0:1: [sde] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  109.928488] sd 2:0:0:1: [sde] Write Protect is off
[  109.928756] sd 2:0:0:1: [sde] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[  109.928810] srpt/0xac1f6b09a3da00000000000000000000: Unsupported
SCSI Opcode 0xa3, sending CHECK_CONDITION.
[  109.928998] sd 2:0:0:1: [sde] Optimal transfer size 65536 bytes
[  109.964047] sd 2:0:0:2: alua: transition timeout set to 60 seconds
[  109.964068] sd 2:0:0:2: alua: port group 00 state A non-preferred
supports TOlUSNA
[  109.982975] enP2p1s0f1 speed is unknown, defaulting to 1000
[  110.001719] enP2p1s0f2 speed is unknown, defaulting to 1000
[  110.021328] enP2p1s0f3 speed is unknown, defaulting to 1000
[  110.164512] sd 2:0:0:2: [sdd] Attached SCSI disk
[  110.254516] sd 2:0:0:0: [sdc] Attached SCSI disk
[  110.274378] sd 2:0:0:1: [sde] Attached SCSI disk
[  111.416965] ------------[ cut here ]------------
[  111.416994] kernel BUG at block/blk-mq.c:1042!
[  111.417017] Oops: Exception in kernel mode, sig: 5 [#1]
[  111.417030] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  111.417055] Modules linked in: ib_srp scsi_transport_srp
target_core_user uio target_core_pscsi target_core_file ib_srpt
target_core_iblock target_core_mod rdma_cm iw_cm ib_cm scsi_debug siw
null_blk dm_service_time ib_umad ib_uverbs scsi_dh_rdac scsi_dh_emc
scsi_dh_alua dm_multipath ib_core rfkill sunrpc joydev i40e ses
enclosure scsi_transport_sas at24 tpm_i2c_nuvoton regmap_i2c rtc_opal
i2c_opal ipmi_powernv ipmi_devintf ipmi_msghandler ofpart opal_prd
powernv_flash crct10dif_vpmsum mtd fuse zram ip_tables xfs ast
i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect
sysimgblt fb_sys_fops cec drm_ttm_helper ttm vmx_crypto drm
crc32c_vpmsum i2c_core aacraid drm_panel_orientation_quirks [last
unloaded: null_blk]
[  111.417323] CPU: 73 PID: 9808 Comm: systemd-udevd Not tainted 5.15.0-rc6 #1
[  111.417357] NIP:  c00000000093ce08 LR: c00000000093cdb0 CTR: c00000000098c3e0
[  111.417392] REGS: c00000005d033300 TRAP: 0700   Not tainted  (5.15.0-rc6)
[  111.417430] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
24428242  XER: 20040000
[  111.417467] CFAR: c00000000093cdbc IRQMASK: 0
[  111.417467] GPR00: c00000000093cdb0 c00000005d0335a0
c0000000028a9a00 c0000000110f7800
[  111.417467] GPR04: c00000061d9d2e00 0000000000000000
c00000005d033350 00000000000d9479
[  111.417467] GPR08: 0000000000000000 0000000000000001
c00000061d9d2e47 c00800000a416808
[  111.417467] GPR12: 0000000000000000 c000000ffff90280
0000000000000000 c00000005d033cd0
[  111.417467] GPR16: 0000000148dfab64 61c8864680b583eb
0000000000080001 c0000000966459d8
[  111.417467] GPR20: c00000002a895198 0000000000000000
0000000000080001 0000000000000000
[  111.417467] GPR24: 00000000000001ff c00000061d9d2f28
c000000016f10520 c00000061d9d2f78
[  111.417467] GPR28: c00000061d9d2e00 0000000000000064
c000000016f10000 c00000061d9d2e00
[  111.417754] NIP [c00000000093ce08] blk_mq_requeue_request+0x88/0xb0
[  111.417791] LR [c00000000093cdb0] blk_mq_requeue_request+0x30/0xb0
[  111.417828] Call Trace:
[  111.417845] [c00000005d0335a0] [c00000000093cdb0]
blk_mq_requeue_request+0x30/0xb0 (unreliable)
[  111.417884] [c00000005d0335e0] [c000000000db6038]
dm_requeue_original_request+0x98/0x120
[  111.417920] [c00000005d033620] [c000000000db628c] dm_mq_queue_rq+0x1cc/0x4e0
[  111.417958] [c00000005d0336d0] [c00000000093d6b4]
__blk_mq_try_issue_directly+0x1b4/0x220
[  111.417995] [c00000005d033730] [c00000000093eae4]
blk_mq_request_issue_directly+0x54/0xf0
[  111.418034] [c00000005d033780] [c00000000093ee68]
blk_mq_flush_plug_list+0x2e8/0x3a0
[  111.418075] [c00000005d033810] [c00000000092c828]
blk_flush_plug_list+0x158/0x1a0
[  111.418111] [c00000005d033880] [c00000000092cab0] blk_finish_plug+0x50/0x6c
[  111.418139] [c00000005d0338b0] [c0000000003f4654] read_pages+0x1d4/0x4c0
[  111.418175] [c00000005d033930] [c0000000003f4b68]
page_cache_ra_unbounded+0x228/0x340
[  111.418215] [c00000005d0339e0] [c0000000003f5378]
force_page_cache_ra+0x108/0x190
[  111.418252] [c00000005d033a20] [c0000000003e5104]
filemap_get_pages+0x124/0x8b0
[  111.418290] [c00000005d033b00] [c0000000003e5980] filemap_read+0xf0/0x490
[  111.418327] [c00000005d033c40] [c00000000091eec8] blkdev_read_iter+0x68/0xa0
[  111.418365] [c00000005d033c70] [c000000000521304] new_sync_read+0x124/0x1b0
[  111.418400] [c00000005d033d10] [c0000000005243a0] vfs_read+0x1d0/0x240
[  111.418437] [c00000005d033d60] [c0000000005249d8] ksys_read+0x78/0x130
[  111.418475] [c00000005d033db0] [c00000000002d648]
system_call_exception+0x188/0x360
[  111.418515] [c00000005d033e10] [c00000000000c1e8]
system_call_vectored_common+0xe8/0x278
[  111.418554] --- interrupt: 3000 at 0x7fffa9d38d34
[  111.418589] NIP:  00007fffa9d38d34 LR: 0000000000000000 CTR: 0000000000000000
[  111.418624] REGS: c00000005d033e80 TRAP: 3000   Not tainted  (5.15.0-rc6)
[  111.418659] MSR:  900000000280f033
<SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44424848  XER: 00000000
[  111.418714] IRQMASK: 0
[  111.418714] GPR00: 0000000000000003 00007fffda32bdb0
00007fffa9d67f00 0000000000000006
[  111.418714] GPR04: 0000000148eca768 0000000000000040
0000000000000000 0000000000000001
[  111.418714] GPR08: 0000000000000008 0000000000000000
0000000000000000 0000000000000000
[  111.418714] GPR12: 0000000000000000 00007fffa8a07ed0
0000000000000000 0000000000000000
[  111.418714] GPR16: 0000000148dfab64 00007fffda331138
0000000148f74500 ffffffffffffffff
[  111.418714] GPR20: 00007fffa9e10394 00007fffa9de38e8
00007fffa9de38f8 00007fffda32bfd0
[  111.418714] GPR24: 00007fffda32bfc8 0000000000000000
0000000148e5d050 0000000148eca740
[  111.418714] GPR28: 0000000000000040 0000000001ff0000
0000000148e5d000 0000000148eca758
[  111.419006] NIP [00007fffa9d38d34] 0x7fffa9d38d34
[  111.419040] LR [0000000000000000] 0x0
[  111.419060] --- interrupt: 3000
[  111.419081] Instruction dump:
[  111.419101] 2c2c0000 41820018 7d8903a6 7fe3fb78 4e800421 e8410018
e8a10028 e93f0048
[  111.419149] 395f0048 7d295278 3149ffff 7d2a4910 <0b090000> 38210040
7fe3fb78 38800001
[  111.419203] ---[ end trace fd7185979edf4363 ]---
[  111.622004]
[  112.622024] Kernel panic - not syncing: Fatal exception
[  114.488291] ---[ end Kernel panic - not syncing: Fatal exception ]---


-- 
Best Regards,
  Yi Zhang

