Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB70C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 06:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9779660E74
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 06:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhKBGpR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 02:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhKBGpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 02:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635835362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=+WU134pzBslfGCIE0PWhHY8wo0ozkVnjp/DvYUqFEho=;
        b=Wu9PynsNKZe7+H+C2dlpk6JOiKD8UxOTZcKHyrSYP5xcNgjpFKyYJUsj3oAq4FO3wqDUkq
        sjRQjZzEzFUDE4iE9tamQ7mIlTjkeLyUdgq7wFeLt/bvbes1naPGU8iVZLdhUwfRJFdS6L
        xZmcqWfGvex21pFOmHBzZ//iTpgKAJQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-GZc4KoVbNaemtey-3698kw-1; Tue, 02 Nov 2021 02:42:41 -0400
X-MC-Unique: GZc4KoVbNaemtey-3698kw-1
Received: by mail-yb1-f197.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so9969733ybe.3
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 23:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+WU134pzBslfGCIE0PWhHY8wo0ozkVnjp/DvYUqFEho=;
        b=BovSEarZnZjDk+yl7R+h7hmApXpsupts6/PM99xSixUFIzadpLS7AgnGD4dJrKLhlx
         sSziFo0G883QfjwHu5ew9kOhRgHiUOkcb835ofQGcUYP0vZAUuo3xtVDW5UllinI/fs3
         BlgXEW9v0vr3MyjbsWJkOSVRydx/v6c/8G+ToC2NQUMOieaDbfwBv2BKry5UM1U4kouH
         lqQqISEfqc31B+2XhAq5KhZWRxrXsZhVSfNGJ33vzQfA6FExmoZBnLJC/NPdoIs3Lh7c
         FP8X2X49QZ1puSMF5V5aL+dfkZ26ckCaHlzzd+8DQHoAJZOJVz6aBcQHh6/on1/pl1lQ
         brqw==
X-Gm-Message-State: AOAM531M1aMLsVeLX+MUg1+Z1QMT0C0kEfg03o74y7Z7WhF+q9HRQR9D
        dVGZIH7EUrBRplUQwNqgMx3wOlEgWo2nYozxfohlw/jfFCa49SMUFtrjcy/9dWEixfeGNg5eN6l
        /3tZVSrkmJLa2cmJ3mV1DXD3BfeoB6R25iZsoCBE=
X-Received: by 2002:a25:8746:: with SMTP id e6mr28752927ybn.138.1635835360497;
        Mon, 01 Nov 2021 23:42:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQIQ22YsbucpYrYzlWey2+hLJJBfHSOk9cWAzqCV56xbjnXIAaCB3oyvSxbdt6YX569LiAyEaudHtaoPfpmO0=
X-Received: by 2002:a25:8746:: with SMTP id e6mr28752884ybn.138.1635835359888;
 Mon, 01 Nov 2021 23:42:39 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 2 Nov 2021 14:42:28 +0800
Message-ID: <CAHj4cs-NUKzGj5pgzRhDgdrGGbgPBqUoQ44+xgvk6njH9a_RYQ@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 1 PID: 1386 at block/blk-mq-sched.c:432 blk_mq_sched_insert_request+0x54/0x178
To:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

Below WARNING was triggered with blktests srp/001 on the latest
linux-block/for-next, and it cannot be reproduced with v5.15, pls help
check it, thanks.

88d2c6ab15f7 (origin/for-next) Merge branch 'for-5.16/block' into for-next

[ 3879.719249] run blktests srp/001 at 2021-11-02 02:34:41
[ 3879.936482] alua: device handler registered
[ 3879.939573] emc: device handler registered
[ 3879.955539] rdac: device handler registered
[ 3879.961500] null_blk: module loaded
[ 3880.411157] rdma_rxe: loaded
[ 3880.417183] infiniband enc8000_rxe: set active
[ 3880.417189] infiniband enc8000_rxe: added enc8000
[ 3880.490765] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @
00000000bc8fbaf0
[ 3880.491746] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[ 3880.491751] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
[ 3880.491757] scsi host0: scsi_debug: version 0190 [20200710]
                 dev_size_mb=32, opts=0x0, submit_queues=1, statistics=0
[ 3880.492377] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug
  0190 PQ: 0 ANSI: 7
[ 3880.492525] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[ 3880.492611] sd 0:0:0:0: Power-on or device reset occurred
[ 3880.492638] sd 0:0:0:0: [sda] Enabling DIF Type 3 protection
[ 3880.492663] sd 0:0:0:0: [sda] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[ 3880.492673] sd 0:0:0:0: [sda] Write Protect is off
[ 3880.492677] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
[ 3880.492688] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[ 3880.492714] sd 0:0:0:0: [sda] Optimal transfer size 524288 bytes
[ 3880.569117] sd 0:0:0:0: [sda] Enabling DIX T10-DIF-TYPE3-CRC protection
[ 3880.569122] sd 0:0:0:0: [sda] DIF application tag size 6
[ 3880.669956] sd 0:0:0:0: [sda] Attached SCSI disk
[ 3881.307672] Rounding down aligned max_sectors from 4294967295 to 4294967288
[ 3881.320237] ib_srpt:srpt_add_one: ib_srpt device = 000000002c17ba8e
[ 3881.320248] ib_srpt:srpt_use_srq: ib_srpt
srpt_use_srq(enc8000_rxe): use_srq = 0; ret = 0
[ 3881.320251] ib_srpt:srpt_add_one: ib_srpt Target login info:
id_ext=00debdfffebeef80,ioc_guid=00debdfffebeef80,pkey=ffff,service_id=00debdfffebeef80
[ 3881.320343] ib_srpt:srpt_add_one: ib_srpt added enc8000_rxe.
[ 3881.630292] Rounding down aligned max_sectors from 255 to 248
[ 3881.645933] Rounding down aligned max_sectors from 255 to 248
[ 3881.657016] Rounding down aligned max_sectors from 4294967295 to 4294967288
[ 3881.721809] ib_srp:srp_add_one: ib_srp: srp_add_one:
18446744073709551615 / 4096 = 4503599627370495 <> 512
[ 3881.721814] ib_srp:srp_add_one: ib_srp: enc8000_rxe: mr_page_shift
= 12, device->max_mr_size = 0xffffffffffffffff,
device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
mr_max_size = 0x200000
[ 3881.740282] ib_srp:srp_parse_in: ib_srp: 10.16.69.39 -> 10.16.69.39:0
[ 3881.740287] ib_srp:srp_parse_in: ib_srp: 10.16.69.39:5555 -> 10.16.69.39:5555
[ 3881.740289] ib_srp:add_target_store: ib_srp: max_sectors = 1024;
max_pages_per_mr = 512; mr_page_size = 4096; max_sectors_per_mr =
4096; mr_per_cmd = 2
[ 3881.740292] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len = 8260
[ 3881.740898] ib_srpt Received SRP_LOGIN_REQ with i_port_id
fe80:0000:0000:0000:00de:bdff:febe:ef80, t_port_id
00de:bdff:febe:ef80:00de:bdff:febe:ef80 and it_iu_len 8260 on port 1
(guid=fe80:0000:0000:0000:00de:bdff:febe:ef80); pkey 0xffff
[ 3881.741000] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset = 68
[ 3881.743965] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib:
max_cqe= 8191 max_sge= 32 sq_size = 4096 ch= 0000000047db61ff
[ 3881.743979] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr
10.16.69.39 or i_port_id 0xfe8000000000000000debdfffebeef80
[ 3881.744007] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection
sess=00000000c4985ffa name=10.16.69.39 ch=0000000047db61ff
[ 3881.744035] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len = 8260
[ 3881.744038] scsi host1: ib_srp: using immediate data
[ 3881.744434] ib_srpt:srpt_zerolength_write: ib_srpt 10.16.69.39-18:
queued zerolength write
[ 3881.744450] ib_srpt:srpt_zerolength_write_done: ib_srpt
10.16.69.39-18 wc->status 0
[ 3881.744788] ib_srpt Received SRP_LOGIN_REQ with i_port_id
fe80:0000:0000:0000:00de:bdff:febe:ef80, t_port_id
00de:bdff:febe:ef80:00de:bdff:febe:ef80 and it_iu_len 8260 on port 1
(guid=fe80:0000:0000:0000:00de:bdff:febe:ef80); pkey 0xffff
[ 3881.744889] ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset = 68
[ 3881.746942] ib_srpt:srpt_create_ch_ib: ib_srpt srpt_create_ch_ib:
max_cqe= 8191 max_sge= 32 sq_size = 4096 ch= 000000008a436a72
[ 3881.746956] ib_srpt:srpt_cm_req_recv: ib_srpt registering src addr
10.16.69.39 or i_port_id 0xfe8000000000000000debdfffebeef80
[ 3881.746972] ib_srpt:srpt_cm_req_recv: ib_srpt Establish connection
sess=0000000071825d44 name=10.16.69.39 ch=000000008a436a72
[ 3881.746995] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len = 8260
[ 3881.746996] scsi host1: ib_srp: using immediate data
[ 3881.747394] ib_srpt:srpt_zerolength_write: ib_srpt 10.16.69.39-20:
queued zerolength write
[ 3881.747399] scsi host1: SRP.T10:00DEBDFFFEBEEF80
[ 3881.747405] ib_srpt:srpt_zerolength_write_done: ib_srpt
10.16.69.39-20 wc->status 0
[ 3881.748617] scsi 1:0:0:0: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[ 3881.748743] scsi 1:0:0:0: alua: supports implicit and explicit TPGS
[ 3881.748750] scsi 1:0:0:0: alua: device
naa.60014056e756c6c62300000000000000 port group 0 rel port 1
[ 3881.749320] sd 1:0:0:0: Warning! Received an indication that the
LUN assignments on this target have changed. The Linux SCSI layer does
not automatical
[ 3881.749604] sd 1:0:0:0: Attached scsi generic sg1 type 0
[ 3881.759041] sd 1:0:0:0: alua: transition timeout set to 60 seconds
[ 3881.759058] sd 1:0:0:0: alua: port group 00 state A non-preferred
supports TOlUSNA
[ 3881.759508] scsi 1:0:0:2: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[ 3881.759538] sd 1:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[ 3881.759569] sd 1:0:0:0: [sdb] Write Protect is off
[ 3881.759573] sd 1:0:0:0: [sdb] Mode Sense: 43 00 00 08
[ 3881.759622] scsi 1:0:0:2: alua: supports implicit and explicit TPGS
[ 3881.759624] sd 1:0:0:0: [sdb] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[ 3881.759627] scsi 1:0:0:2: alua: device
naa.60014057363736964626700000000000 port group 0 rel port 1
[ 3881.759637] srpt/10.16.69.39: Unsupported SCSI Opcode 0xa3, sending
CHECK_CONDITION.
[ 3881.759681] sd 1:0:0:0: [sdb] Optimal transfer size 126976 bytes
[ 3881.759926] sd 1:0:0:2: [sdc] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[ 3881.759986] sd 1:0:0:2: [sdc] Write Protect is off
[ 3881.759993] sd 1:0:0:2: [sdc] Mode Sense: 43 00 10 08
[ 3881.760045] sd 1:0:0:2: [sdc] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[ 3881.760059] srpt/10.16.69.39: Unsupported SCSI Opcode 0xa3, sending
CHECK_CONDITION.
[ 3881.760105] sd 1:0:0:2: [sdc] Optimal transfer size 524288 bytes
[ 3881.761156] sd 1:0:0:2: Attached scsi generic sg2 type 0
[ 3881.761657] scsi 1:0:0:1: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[ 3881.761778] scsi 1:0:0:1: alua: supports implicit and explicit TPGS
[ 3881.761782] scsi 1:0:0:1: alua: device
naa.60014056e756c6c62310000000000000 port group 0 rel port 1
[ 3881.761844] scsi 1:0:0:1: Attached scsi generic sg3 type 0
[ 3881.761867] ib_srp:srp_add_target: ib_srp: host1: SCSI scan
succeeded - detected 3 LUNs
[ 3881.761869] scsi host1: ib_srp: new target: id_ext 00debdfffebeef80
ioc_guid 00debdfffebeef80 sgid fe80:0000:0000:0000:00de:bdff:febe:ef80
dest 10.16.69.39
[ 3881.763539] sd 1:0:0:1: Warning! Received an indication that the
LUN assignments on this target have changed. The Linux SCSI layer does
not automatical
[ 3881.764276] ib_srp:srp_parse_in: ib_srp: 10.16.69.39 -> 10.16.69.39:0
[ 3881.764280] ib_srp:srp_parse_in: ib_srp: 10.16.69.39:5555 -> 10.16.69.39:5555
[ 3881.764286] ib_srp:srp_parse_in: ib_srp:
[2620:52:0:1040:de:bdff:febe:ef80] ->
[2620:52:0:1040:de:bdff:febe:ef80]:0/168838439%0
[ 3881.764291] ib_srp:srp_parse_in: ib_srp:
[2620:52:0:1040:de:bdff:febe:ef80]:5555 ->
[2620:52:0:1040:de:bdff:febe:ef80]:5555/168838439%0
[ 3881.764293] scsi host2: ib_srp: Already connected to target port
with id_ext=00debdfffebeef80;ioc_guid=00debdfffebeef80;dest=2620:0052:0000:1040:00de:bdff:febe:ef80
[ 3881.789301] sd 1:0:0:2: alua: transition timeout set to 60 seconds
[ 3881.789308] sd 1:0:0:2: alua: port group 00 state A non-preferred
supports TOlUSNA
[ 3881.799016] sd 1:0:0:1: alua: transition timeout set to 60 seconds
[ 3881.799023] sd 1:0:0:1: alua: port group 00 state A non-preferred
supports TOlUSNA
[ 3881.799347] sd 1:0:0:1: [sdd] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[ 3881.799446] sd 1:0:0:1: [sdd] Write Protect is off
[ 3881.799450] sd 1:0:0:1: [sdd] Mode Sense: 43 00 00 08
[ 3881.799531] sd 1:0:0:1: [sdd] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[ 3881.799548] srpt/10.16.69.39: Unsupported SCSI Opcode 0xa3, sending
CHECK_CONDITION.
[ 3881.799615] sd 1:0:0:1: [sdd] Optimal transfer size 126976 bytes
[ 3881.802141] ib_srp:srp_parse_in: ib_srp: 10.16.69.39 -> 10.16.69.39:0
[ 3881.802150] ib_srp:srp_parse_in: ib_srp: 10.16.69.39:5555 -> 10.16.69.39:5555
[ 3881.802156] ib_srp:srp_parse_in: ib_srp:
[2620:52:0:1040:de:bdff:febe:ef80] ->
[2620:52:0:1040:de:bdff:febe:ef80]:0/168838439%0
[ 3881.802161] ib_srp:srp_parse_in: ib_srp:
[2620:52:0:1040:de:bdff:febe:ef80]:5555 ->
[2620:52:0:1040:de:bdff:febe:ef80]:5555/168838439%0
[ 3881.802167] ib_srp:srp_parse_in: ib_srp:
[fe80::de:bdff:febe:ef80%2] -> [fe80::de:bdff:febe:ef80]:0/168838439%2
[ 3881.802172] ib_srp:srp_parse_in: ib_srp:
[fe80::de:bdff:febe:ef80%2]:5555 ->
[fe80::de:bdff:febe:ef80]:5555/168838439%2
[ 3881.802175] scsi host2: ib_srp: Already connected to target port
with id_ext=00debdfffebeef80;ioc_guid=00debdfffebeef80;dest=fe80:0000:0000:0000:00de:bdff:febe:ef80
[ 3881.829489] ------------[ cut here ]------------
[ 3881.829493] WARNING: CPU: 1 PID: 1386 at block/blk-mq-sched.c:432
blk_mq_sched_insert_request+0x54/0x178
[ 3881.829504] Modules linked in: ib_srp scsi_transport_srp
target_core_pscsi target_core_file ib_srpt target_core_iblock
target_core_mod rdma_cm iw_cm ib_cm ib_umad scsi_debug rdma_rxe
ib_uverbs ip6_udp_tunnel udp_tunnel null_blk scsi_dh_rdac scsi_dh_emc
scsi_dh_alua dm_multipath ib_core sunrpc qeth_l2 bridge stp llc qeth
qdio ccwgroup vfio_ccw mdev vfio_iommu_type1 vfio zcrypt_cex4 drm fb
fuse font drm_panel_orientation_quirks i2c_core backlight zram
ip_tables xfs crc32_vx_s390 ghash_s390 prng aes_s390 des_s390 libdes
sha512_s390 sha256_s390 sha1_s390 sha_common dasd_eckd_mod dasd_mod
pkey zcrypt
[ 3881.829553] CPU: 1 PID: 1386 Comm: kworker/u128:2 Not tainted 5.15.0+ #3
[ 3881.829556] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
[ 3881.829558] Workqueue: events_unbound async_run_entry_fn
[ 3881.829564] Krnl PSW : 0704e00180000000 000000001055afc0
(blk_mq_sched_insert_request+0x58/0x178)
[ 3881.829569]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3
CC:2 PM:0 RI:0 EA:3
[ 3881.829572] Krnl GPRS: 0000000000000004 000000000000003d
00000000448bf400 0000000000000001
[ 3881.829575]            0000000000000001 0000000000000000
000000004352bc00 000000002e0f3000
[ 3881.829577]            0000000000000000 0000000000000001
0000000000000001 00000000448bf400
[ 3881.829580]            000000001ee72100 000003ff7e82dd00
00000380022f7838 00000380022f77c8
[ 3881.829587] Krnl Code: 000000001055afb4: a71effff chi %r1,-1
                          000000001055afb8: a7840004 brc 8,000000001055afc0
                         #000000001055afbc: af000000 mc 0,0
                         >000000001055afc0: 5810b01c l %r1,28(%r11)
                          000000001055afc4: ec213bbb0055 risbg %r2,%r1,59,187,0
                          000000001055afca: a7740057 brc 7,000000001055b078
                          000000001055afce: 5810b018 l %r1,24(%r11)
                          000000001055afd2: c01b000000ff nilf %r1,255
[ 3881.829607] Call Trace:
[ 3881.829609]  [<000000001055afc0>] blk_mq_sched_insert_request+0x58/0x178
[ 3881.829616]  [<000000001054b876>] blk_execute_rq+0x56/0xd8
[ 3881.829620]  [<000000001070e3a0>] __scsi_execute+0x110/0x230
[ 3881.829625]  [<000000001070e602>] scsi_mode_sense+0x142/0x340
[ 3881.829627]  [<000000001071f8ee>] sd_revalidate_disk.isra.0+0x74e/0x2240
[ 3881.829632]  [<0000000010721912>] sd_probe+0x312/0x4b0
[ 3881.829634]  [<00000000106d4c30>] really_probe+0xd0/0x4b0
[ 3881.829639]  [<00000000106d51c0>] driver_probe_device+0x40/0xf0
[ 3881.829642]  [<00000000106d58cc>] __device_attach_driver+0xa4/0x128
[ 3881.829645]  [<00000000106d1fd0>] bus_for_each_drv+0x88/0xc0
[ 3881.829649]  [<00000000106d4130>] __device_attach_async_helper+0x90/0xf0
[ 3881.829652]  [<000000000ffb0f46>] async_run_entry_fn+0x4e/0x1b0
[ 3881.829655]  [<000000000ffa384a>] process_one_work+0x21a/0x498
[ 3881.829658]  [<000000000ffa3ff4>] worker_thread+0x64/0x498
[ 3881.829661]  [<000000000ffac8e0>] kthread+0x150/0x160
[ 3881.829665]  [<000000000ff37468>] __ret_from_fork+0x40/0x58
[ 3881.829670]  [<0000000010a8550a>] ret_from_fork+0xa/0x30
[ 3881.829675] Last Breaking-Event-Address:
[ 3881.829676]  [<0000000000000007>] 0x7
[ 3881.829679] ---[ end trace a501db666d088cc7 ]---
[ 3881.834807] sd 1:0:0:2: [sdc] Attached SCSI disk
[ 3881.861777] rdma_rxe: rxe_invalidate_mr: rkey (0x8400) doesn't
match mr->ibmr.rkey (0x8401)
[ 3881.861792] scsi host1: ib_srp: failed RECV status WR flushed (5)
for CQE 00000000a85dbe16



-- 
Best Regards,
  Yi Zhang

