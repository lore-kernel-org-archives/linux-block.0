Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005D3C433F5
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 16:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A7B60F92
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 16:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhILQ1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 12:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhILQ1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 12:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631463980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KUvcDG+LZkRehBjGgtAZRdSjLmT13XcRMqkSIyeAGEs=;
        b=iHcNRqzUr/mn0Vq8EBhB9NcktIlBl/z63fUjKPSQ/gJvJRGnCfT11Sz1soSjDCKa2CUCfD
        2ErjP2byRqxctnHWHZ6JUWVA4iu1mw3Ou/ua0IgVjmlD31czJey6WTCH343u2BjUspdhoD
        DvJJ9KC0tern0tV3qZlT12sA2BihfwQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-iiyIRPVmND2j641LmdiMOQ-1; Sun, 12 Sep 2021 12:26:18 -0400
X-MC-Unique: iiyIRPVmND2j641LmdiMOQ-1
Received: by mail-yb1-f197.google.com with SMTP id b84-20020a253457000000b0059e6b730d45so9857792yba.6
        for <linux-block@vger.kernel.org>; Sun, 12 Sep 2021 09:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KUvcDG+LZkRehBjGgtAZRdSjLmT13XcRMqkSIyeAGEs=;
        b=OIYkWQZgwvp8vzWMclcLUXj5/JxNcSWcZR1YPyL6OyiX7c5a76o9RKYtXdLKvpSyo3
         SGd7RP8K08l4Nuhq7qS9CdCT641e/ISaGaxkexs+BXb6nH31xqKZbHdJAZxIVirRP6+b
         mElQFc4vLbkhRmQDEu6M0Ix6O9gTwdyjXaFiPOqVfJhaQnAaXUUKzGdww1E1dDqavACm
         HLUQGZYUuVXpjvQVHebvRwHO++H9Fz3tSb1qKBvdH1QDZLfyR4/y0YFv4z5aHb//nrHy
         ynSem0A9kS+Ybh33lioivtO0sYXyuLA6iFqGkXnb8vBT3qehkTWbqjqbILBlLrMUDU0/
         wQ2Q==
X-Gm-Message-State: AOAM533O61k8F1HbFICgrxo4Koc94BMf5nOkcZnt91QIZ9RvreOK+CRe
        BJz4n+YNMgtf9QHugiIA0ofVXhP7pu4tZj1NGTeSqOx448hyDowkeTIjdOYEZGoogHy54gV8U6L
        3CyCyF/OOg77evVp0NcCGzk2JaZy82pcrsWVBnts=
X-Received: by 2002:a25:6b4d:: with SMTP id o13mr9417207ybm.241.1631463978035;
        Sun, 12 Sep 2021 09:26:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhXei7FOZIYPjd8Dq7I0/JFvN4hsDKQngxs4PDRD41e1ONpsXJs1Skx5akAh9fiVU7Yrqx7Uzajb3N3s1o9ic=
X-Received: by 2002:a25:6b4d:: with SMTP id o13mr9417186ybm.241.1631463977696;
 Sun, 12 Sep 2021 09:26:17 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 13 Sep 2021 00:26:05 +0800
Message-ID: <CAHj4cs8XNtkzbbiLnFmVu82wYeQpLkVp6_wCtrnbhODay+OP9w@mail.gmail.com>
Subject: [bug report] blktests srp/013 lead kernel panic with latest
 block/for-next and 5.13.15
To:     linux-block <linux-block@vger.kernel.org>
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

We've hit the following issue below with latest block/for-next and
5.13.15 on s390x, pls help check it, feel free to let me know if you
need any testing/debug info for it.

# use_siw=1 ./check srp/013
srp/013 (Direct I/O using a discontiguous buffer)            [passed]
    runtime    ...  2.065s

[  127.475787] run blktests srp/013 at 2021-09-12 12:02:09
[  127.632487] alua: device handler registered
[  127.635115] emc: device handler registered
[  127.637998] rdac: device handler registered
[  127.644060] null_blk: module loaded
[  127.790639] SoftiWARP attached
[  127.799681] enc1 speed is unknown, defaulting to 1000
[  127.799685] enc1 speed is unknown, defaulting to 1000
[  127.799699] enc1 speed is unknown, defaulting to 1000
[  127.799722] enc1 speed is unknown, defaulting to 1000
[  127.826812] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @
000000001388e38f
[  127.828344] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[  127.828349] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
[  127.828354] scsi host0: scsi_debug: version 0190 [20200710]
[  127.828354]   dev_size_mb=32, opts=0x0, submit_queues=1, statistics=0
[  127.829241] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug
  0190 PQ: 0 ANSI: 7
[  127.829447] sd 0:0:0:0: Power-on or device reset occurred
[  127.829464] sd 0:0:0:0: [sda] Enabling DIF Type 3 protection
[  127.829480] sd 0:0:0:0: [sda] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  127.829486] sd 0:0:0:0: [sda] Write Protect is off
[  127.829495] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  127.829507] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
[  127.829515] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  127.901964] sd 0:0:0:0: [sda] Enabling DIX T10-DIF-TYPE3-CRC protection
[  127.901975] sd 0:0:0:0: [sda] DIF application tag size 6
[  127.971979] sd 0:0:0:0: [sda] Attached SCSI disk
[  128.105497] enc1 speed is unknown, defaulting to 1000
[  128.122601] Rounding down aligned max_sectors from 4294967295 to 4294967288
[  128.131527] enc1 speed is unknown, defaulting to 1000
[  128.389958] Rounding down aligned max_sectors from 255 to 248
[  128.399984] Rounding down aligned max_sectors from 255 to 248
[  128.422487] Rounding down aligned max_sectors from 4294967295 to 4294967288
[  128.424359] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[  128.499155] enc1 speed is unknown, defaulting to 1000
[  128.510288] scsi host1:   REJ reason 0xffffff98
[  128.510295] scsi host1: ib_srp: Connection 0/2 to 10.0.160.59 failed
[  128.695427] ib_srpt Received SRP_LOGIN_REQ with i_port_id
0002:55a6:0677:0000:0000:0000:0000:0000, t_port_id
0202:55ff:fea6:0677:0202:55ff:fea6:0677 and it_iu_len 8260 on port 1
(guid=0002:55a6:0677:0000:0000:0000:0000:0000); pkey 0x00
[  128.710958] ib_srpt Received SRP_LOGIN_REQ with i_port_id
0002:55a6:0677:0000:0000:0000:0000:0000, t_port_id
0202:55ff:fea6:0677:0202:55ff:fea6:0677 and it_iu_len 8260 on port 1
(guid=0002:55a6:0677:0000:0000:0000:0000:0000); pkey 0x00
[  128.725662] scsi host1: SRP.T10:020255FFFEA60677
[  128.727233] scsi 1:0:0:0: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[  128.727450] scsi 1:0:0:0: alua: supports implicit and explicit TPGS
[  128.727456] scsi 1:0:0:0: alua: device
naa.60014056e756c6c62300000000000000 port group 0 rel port 1
[  128.727603] scsi 1:0:0:0: Attached scsi generic sg1 type 0
[  128.728031] sd 1:0:0:0: Warning! Received an indication that the
LUN assignments on this target have changed. The Linux SCSI layer does
not automatical
[  128.729735] scsi 1:0:0:2: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[  128.731038] scsi 1:0:0:2: alua: supports implicit and explicit TPGS
[  128.731042] scsi 1:0:0:2: alua: device
naa.60014057363736964626700000000000 port group 0 rel port 1
[  128.731113] sd 1:0:0:2: Attached scsi generic sg2 type 0
[  128.731373] scsi 1:0:0:1: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[  128.731505] scsi 1:0:0:1: alua: supports implicit and explicit TPGS
[  128.731509] scsi 1:0:0:1: alua: device
naa.60014056e756c6c62310000000000000 port group 0 rel port 1
[  128.731608] sd 1:0:0:1: Attached scsi generic sg3 type 0
[  128.731623] sd 1:0:0:1: Warning! Received an indication that the
LUN assignments on this target have changed. The Linux SCSI layer does
not automatical
[  128.735376] sd 1:0:0:2: [sdc] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  128.736151] sd 1:0:0:2: [sdc] Write Protect is off
[  128.736258] sd 1:0:0:2: [sdc] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  128.736278] srpt/0x000255a6067700000000000000000000: Unsupported
SCSI Opcode 0xa3, sending CHECK_CONDITION.
[  128.736339] sd 1:0:0:2: [sdc] Optimal transfer size 524288 bytes
[  128.739390] scsi host2: ib_srp: Already connected to target port
with id_ext=020255fffea60677;ioc_guid=020255fffea60677;dest=fe80:0000:0000:0000:0202:55ff:fea6:0677
[  128.751950] sd 1:0:0:0: alua: transition timeout set to 60 seconds
[  128.751957] sd 1:0:0:0: alua: port group 00 state A non-preferred
supports TOlUSNA
[  128.751963] sd 1:0:0:1: alua: transition timeout set to 60 seconds
[  128.751966] sd 1:0:0:1: alua: port group 00 state A non-preferred
supports TOlUSNA
[  128.752237] sd 1:0:0:1: [sdd] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  128.752282] sd 1:0:0:1: [sdd] Write Protect is off
[  128.752307] sd 1:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  128.752361] sd 1:0:0:0: [sdb] Write Protect is off
[  128.752377] sd 1:0:0:1: [sdd] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[  128.752394] srpt/0x000255a6067700000000000000000000: Unsupported
SCSI Opcode 0xa3, sending CHECK_CONDITION.
[  128.752478] sd 1:0:0:1: [sdd] Optimal transfer size 126976 bytes
[  128.752505] sd 1:0:0:0: [sdb] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[  128.752517] srpt/0x000255a6067700000000000000000000: Unsupported
SCSI Opcode 0xa3, sending CHECK_CONDITION.
[  128.752812] sd 1:0:0:0: [sdb] Optimal transfer size 126976 bytes
[  128.773126] sd 1:0:0:2: alua: transition timeout set to 60 seconds
[  128.773133] sd 1:0:0:2: alua: port group 00 state A non-preferred
supports TOlUSNA
[  128.852620] sd 1:0:0:0: [sdb] Attached SCSI disk
[  128.872622] sd 1:0:0:1: [sdd] Attached SCSI disk
[  128.873284] sd 1:0:0:2: [sdc] Attached SCSI disk
[  128.905378] device-mapper: multipath service-time: version 0.3.0 loaded
[  129.682590] sd 1:0:0:2: [sdc] Synchronizing SCSI cache
[  129.761679] scsi 1:0:0:0: alua: Detached
[  129.851668] scsi 1:0:0:2: alua: Detached
[  129.882680] ib_srpt receiving failed for ioctx 00000000009471f4 with status 5
[  129.882691] ib_srpt receiving failed for ioctx 00000000a87fed08 with status 5
[  129.882692] ib_srpt receiving failed for ioctx 00000000aad23569 with status 5
[  129.882694] ib_srpt receiving failed for ioctx 0000000070d12b2e with status 5
[  129.882696] ib_srpt receiving failed for ioctx 00000000b19e3451 with status 5
[  129.882698] ib_srpt receiving failed for ioctx 00000000f3cf8cea with status 5
[  129.882699] ib_srpt receiving failed for ioctx 00000000c9c6774e with status 5
[  129.882701] ib_srpt receiving failed for ioctx 000000001eac69e6 with status 5
[  129.882702] ib_srpt receiving failed for ioctx 0000000097705934 with status 5
[  129.882704] ib_srpt receiving failed for ioctx 0000000053368827 with status 5
[  130.016899] device-mapper: multipath: 253:2: Failing path 8:48.
[  130.811836] scsi 1:0:0:1: alua: Detached
[  130.851910] Unable to handle kernel pointer dereference in virtual
kernel address space
[  130.851918] Failing address: 000003ff80815000 TEID: 000003ff80815803
[  130.851920] Fault in home space mode while using kernel ASCE.
[  130.851923] AS:000000002f200007 R3:0000000080280007
S:0000000095d93800 P:0000000000000400
[  130.852020] Oops: 0011 ilc:3 [#1] SMP
[  130.852024] Modules linked in: dm_service_time scsi_transport_srp
target_core_pscsi target_core_file ib_srpt target_core_iblock
target_core_mod rdma_cm iw_cm ib_cm ib_umad ib_uverbs scsi_debug siw
null_blk scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath ib_core
sunrpc virtio_net net_failover failover vfio_ccw mdev s390_trng
vfio_iommu_type1 vfio drm drm_panel_orientation_quirks fb font fuse
backlight i2c_core zram ip_tables xfs crc32_vx_s390 ghash_s390 prng
aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390
sha256_s390 sha1_s390 sha_common virtio_blk pkey zcrypt [last
unloaded: ib_srp]
[  130.852068] CPU: 1 PID: 950 Comm: multipathd Not tainted 5.14.0 #1
[  130.852071] Hardware name: IBM 8561 LT1 400 (KVM/Linux)
[  130.852073] Krnl PSW : 0704e00180000000 000000002e37e7cc
(scsi_mq_exit_request+0x2c/0x58)
[  130.852085]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3
CC:2 PM:0 RI:0 EA:3
[  130.852087] Krnl GPRS: 00000000000001d0 000003ff80815390
000000009a84c000 000000009dc20000
[  130.852089]            0000000000000000 0000000000000002
0000000000000000 0000000000000000
[  130.852091]            0000000000000000 000000009bfc1d80
0000000000000000 000000009dc20000
[  130.852093]            000000008596e000 000002aa008aa520
0000038000643990 0000038000643960
[  130.852101] Krnl Code: 000000002e37e7bc: b90400b3 lgr %r11,%r3
[  130.852101]            000000002e37e7c0: e32020600004 lg %r2,96(%r2)
[  130.852101]           #000000002e37e7c6: e31020980004 lg %r1,152(%r2)
[  130.852101]           >000000002e37e7cc: e31010480002 ltg %r1,72(%r1)
[  130.852101]            000000002e37e7d2: a7840007 brc 8,000000002e37e7e0
[  130.852101]            000000002e37e7d6: 41303128 la %r3,296(%r3)
[  130.852101]            000000002e37e7da: 0de1 basr %r14,%r1
[  130.852101]            000000002e37e7dc: 47000700 bc 0,1792
[  130.852113] Call Trace:
[  130.852115]  [<000000002e37e7cc>] scsi_mq_exit_request+0x2c/0x58
[  130.852120]  [<000000002e1c2608>] blk_mq_free_rqs+0x80/0x218
[  130.852125]  [<000000002e1c2f0a>] blk_mq_free_tag_set+0x5a/0x128
[  130.852128]  [<000000002e3774d0>] scsi_host_dev_release+0xb0/0x118
[  130.852130]  [<000000002e33fe10>] device_release+0x48/0xb0
[  130.852136]  [<000000002e28bf12>] kobject_put+0xca/0x1f0
[  130.852140]  [<000000002e33fe10>] device_release+0x48/0xb0
[  130.852142]  [<000000002e28bf12>] kobject_put+0xca/0x1f0
[  130.852145]  [<000000002dc1324a>] execute_in_process_context+0x4a/0xf0
[  130.852149]  [<000000002e33fe10>] device_release+0x48/0xb0
[  130.852151]  [<000000002e28bf12>] kobject_put+0xca/0x1f0
[  130.852153]  [<000000002e38e49e>] sd_release+0x6e/0xf8
[  130.852158]  [<000000002e1a86d0>] blkdev_put+0xe0/0x278
[  130.852162]  [<000000002e1a9946>] blkdev_close+0x3e/0x50
[  130.852164]  [<000000002de94728>] __fput+0xa0/0x280
[  130.852168]  [<000000002dc19190>] task_work_run+0x88/0xd0
[  130.852170]  [<000000002dc89b9e>] exit_to_user_mode_loop+0x1ce/0x1d8
[  130.852175]  [<000000002dc89c22>] exit_to_user_mode_prepare+0x7a/0x80
[  130.852178]  [<000000002e6e70be>] __do_syscall+0x106/0x1e8
[  130.852181]  [<000000002e6f5518>] system_call+0x78/0xa0
[  130.852184] Last Breaking-Event-Address:
[  130.852185]  [<000000008596e808>] 0x8596e808
[  130.852189] Kernel panic - not syncing: Fatal exception: panic_on_oops


-- 
Best Regards,
  Yi Zhang

