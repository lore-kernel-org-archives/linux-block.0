Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE35AC433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 07:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35E460EB8
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 07:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhKBHee (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 03:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231651AbhKBHed (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 03:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635838318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=Sr7geq7rPhJtd5VaymyWj+UVjGG9KZLk1hASmE+z158=;
        b=NjnBkvBVGIBzSgDnMVT3iApBQrXUvBM/URKnfFc5KQDYh8gSxhrRRVVoRVHHgaRtyYS7jI
        sSfXD8oNbIsJ+V5wdpdcaPUb5/QQpESWQZhkf8l8n5RTQiJ7rgST+1WVvPwuulEzv6/VqN
        ApIvnwsLiutnWGQWYGU20pblpOK+zWk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-Gy-2dRD7PIShtZz1otd9TQ-1; Tue, 02 Nov 2021 03:31:56 -0400
X-MC-Unique: Gy-2dRD7PIShtZz1otd9TQ-1
Received: by mail-yb1-f199.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so29696841ybb.4
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 00:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Sr7geq7rPhJtd5VaymyWj+UVjGG9KZLk1hASmE+z158=;
        b=TPGwiAxkmYZti4jV2VK6A861IAtXUW+Xp4tTJpGyVvOD6qvUnJ90na5lveiRK4sLvP
         LGkgJZUgFxkVxQswk6MPLIXtw477QG7+b0/ojCh2yBgNtWzZNKTa51/pGTskVSm5Le65
         6I/o82249zIso5J3ZQwXsIAoC3dbilc6TFfT9G6HROK9tI15pnqes375voRB/EGN5YDJ
         9EVfVotIck0TJk3Jb2NashYg2hrDACr6n5r7LGFhcifYWHyMlQAKuYxuS+CW6R34wPNu
         V1dzI1YEk4bjD2TZLSwdsZLhWHHF7jThmaQdH4fccLGpaIZMeIOYR7W5zfPZhUjC5Klr
         YJ1Q==
X-Gm-Message-State: AOAM533ltWLQT54EFuWOLu6Nf5EyLPbCZjyY6T3a3FtD1ZrHb+0bSA+K
        63kGiETBMqQAFk3mZkLjlWZwvzMSQp1e4YlX5FjXK+nfdculy3Bi2qLYo2dSdYDegACp75MnLzU
        EMnosuWs8RvW9uGpdMvNVQIEyE9GYtXIw67nu+NE=
X-Received: by 2002:a25:6b4e:: with SMTP id o14mr11289624ybm.86.1635838315772;
        Tue, 02 Nov 2021 00:31:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIjkFdceOQTmAPVyzxG34VxdtMIyB/OOxwJhii6BunjOcTUwXN3C8HcLTj1rJYDuEg9oI3rrjXryA6iel8he4=
X-Received: by 2002:a25:6b4e:: with SMTP id o14mr11289569ybm.86.1635838314996;
 Tue, 02 Nov 2021 00:31:54 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 2 Nov 2021 15:31:43 +0800
Message-ID: <CAHj4cs-QxAmz=pM=cd1UJEg+HRUH_yMf5jDnBbirgW1oq1CaKw@mail.gmail.com>
Subject: [bug report] kernel null pointer observed with blktests srp/006 on 5.14.15
To:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

Below null pointer was triggered with blktests srp/006 on aarch64, pls
help check it, thanks.

[  459.562211] run blktests srp/006 at 2021-11-02 03:21:05
[  459.965081] null_blk: module loaded
[  460.113063] rdma_rxe: loaded
[  460.142056] infiniband enP2p1s0v0_rxe: set active
[  460.146754] infiniband enP2p1s0v0_rxe: added enP2p1s0v0
[  460.170050] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.175637] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.181281] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.194410] infiniband enP2p1s0v1_rxe: set down
[  460.198968] infiniband enP2p1s0v1_rxe: added enP2p1s0v1
[  460.204195] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.217610] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.227631] enP2p1s0v2 speed is unknown, defaulting to 1000
[  460.233214] enP2p1s0v2 speed is unknown, defaulting to 1000
[  460.239017] enP2p1s0v2 speed is unknown, defaulting to 1000
[  460.252230] infiniband enP2p1s0v2_rxe: set down
[  460.256753] infiniband enP2p1s0v2_rxe: added enP2p1s0v2
[  460.262001] enP2p1s0v2 speed is unknown, defaulting to 1000
[  460.274406] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.280138] enP2p1s0v2 speed is unknown, defaulting to 1000
[  460.290163] enP2p1s0v3 speed is unknown, defaulting to 1000
[  460.295747] enP2p1s0v3 speed is unknown, defaulting to 1000
[  460.301416] enP2p1s0v3 speed is unknown, defaulting to 1000
[  460.314619] infiniband enP2p1s0v3_rxe: set down
[  460.319157] infiniband enP2p1s0v3_rxe: added enP2p1s0v3
[  460.324383] enP2p1s0v3 speed is unknown, defaulting to 1000
[  460.337509] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.343197] enP2p1s0v2 speed is unknown, defaulting to 1000
[  460.348904] enP2p1s0v3 speed is unknown, defaulting to 1000
[  460.358889] enP2p1s0v4 speed is unknown, defaulting to 1000
[  460.364473] enP2p1s0v4 speed is unknown, defaulting to 1000
[  460.370115] enP2p1s0v4 speed is unknown, defaulting to 1000
[  460.383178] infiniband enP2p1s0v4_rxe: set down
[  460.387727] infiniband enP2p1s0v4_rxe: added enP2p1s0v4
[  460.392952] enP2p1s0v4 speed is unknown, defaulting to 1000
[  460.408726] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.414412] enP2p1s0v2 speed is unknown, defaulting to 1000
[  460.420120] enP2p1s0v3 speed is unknown, defaulting to 1000
[  460.425805] enP2p1s0v4 speed is unknown, defaulting to 1000
[  460.435806] enP2p1s0v5 speed is unknown, defaulting to 1000
[  460.441425] enP2p1s0v5 speed is unknown, defaulting to 1000
[  460.447046] enP2p1s0v5 speed is unknown, defaulting to 1000
[  460.460204] infiniband enP2p1s0v5_rxe: set down
[  460.464728] infiniband enP2p1s0v5_rxe: added enP2p1s0v5
[  460.469973] enP2p1s0v5 speed is unknown, defaulting to 1000
[  460.482462] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.488164] enP2p1s0v2 speed is unknown, defaulting to 1000
[  460.493836] enP2p1s0v3 speed is unknown, defaulting to 1000
[  460.499540] enP2p1s0v4 speed is unknown, defaulting to 1000
[  460.505227] enP2p1s0v5 speed is unknown, defaulting to 1000
[  460.515236] enP2p1s0v6 speed is unknown, defaulting to 1000
[  460.520859] enP2p1s0v6 speed is unknown, defaulting to 1000
[  460.526481] enP2p1s0v6 speed is unknown, defaulting to 1000
[  460.539682] infiniband enP2p1s0v6_rxe: set down
[  460.544206] infiniband enP2p1s0v6_rxe: added enP2p1s0v6
[  460.549451] enP2p1s0v6 speed is unknown, defaulting to 1000
[  460.561521] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.567236] enP2p1s0v2 speed is unknown, defaulting to 1000
[  460.572922] enP2p1s0v3 speed is unknown, defaulting to 1000
[  460.578631] enP2p1s0v4 speed is unknown, defaulting to 1000
[  460.584317] enP2p1s0v5 speed is unknown, defaulting to 1000
[  460.590033] enP2p1s0v6 speed is unknown, defaulting to 1000
[  460.600071] enP2p1s0v7 speed is unknown, defaulting to 1000
[  460.605653] enP2p1s0v7 speed is unknown, defaulting to 1000
[  460.611325] enP2p1s0v7 speed is unknown, defaulting to 1000
[  460.624468] infiniband enP2p1s0v7_rxe: set down
[  460.629005] infiniband enP2p1s0v7_rxe: added enP2p1s0v7
[  460.634231] enP2p1s0v7 speed is unknown, defaulting to 1000
[  460.645535] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.651236] enP2p1s0v2 speed is unknown, defaulting to 1000
[  460.656907] enP2p1s0v3 speed is unknown, defaulting to 1000
[  460.662624] enP2p1s0v4 speed is unknown, defaulting to 1000
[  460.668336] enP2p1s0v5 speed is unknown, defaulting to 1000
[  460.674007] enP2p1s0v6 speed is unknown, defaulting to 1000
[  460.679716] enP2p1s0v7 speed is unknown, defaulting to 1000
[  460.697348] infiniband enP6p144s0f0_rxe: set down
[  460.702045] infiniband enP6p144s0f0_rxe: added enP6p144s0f0
[  460.718020] enP2p1s0v1 speed is unknown, defaulting to 1000
[  460.723707] enP2p1s0v2 speed is unknown, defaulting to 1000
[  460.729418] enP2p1s0v3 speed is unknown, defaulting to 1000
[  460.735102] enP2p1s0v4 speed is unknown, defaulting to 1000
[  460.740803] enP2p1s0v5 speed is unknown, defaulting to 1000
[  460.746487] enP2p1s0v6 speed is unknown, defaulting to 1000
[  460.752197] enP2p1s0v7 speed is unknown, defaulting to 1000
[  460.769954] infiniband enP6p144s0f1_rxe: set down
[  460.774652] infiniband enP6p144s0f1_rxe: added enP6p144s0f1
[  460.904469] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @
00000000e700d5da
[  460.912933] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[  460.922001] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
[  460.928504] scsi host4: scsi_debug: version 0190 [20200710]
[  460.928504]   dev_size_mb=32, opts=0x0, submit_queues=1, statistics=0
[  460.941168] scsi 4:0:0:0: Direct-Access     Linux    scsi_debug
  0190 PQ: 0 ANSI: 7
[  460.949819] sd 4:0:0:0: Power-on or device reset occurred
[  460.949864] sd 4:0:0:0: Attached scsi generic sg1 type 0
[  460.955311] sd 4:0:0:0: [sdb] Enabling DIF Type 3 protection
[  460.966290] sd 4:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  460.973663] sd 4:0:0:0: [sdb] Write Protect is off
[  460.978529] sd 4:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  460.987130] sd 4:0:0:0: [sdb] Optimal transfer size 524288 bytes
[  461.120113] sd 4:0:0:0: [sdb] Enabling DIX T10-DIF-TYPE3-CRC protection
[  461.126721] sd 4:0:0:0: [sdb] DIF application tag size 6
[  461.287392] sd 4:0:0:0: [sdb] Attached SCSI disk
[  461.622624] enP2p1s0v1 speed is unknown, defaulting to 1000
[  461.687587] enP2p1s0v2 speed is unknown, defaulting to 1000
[  461.752313] enP2p1s0v3 speed is unknown, defaulting to 1000
[  461.817427] enP2p1s0v4 speed is unknown, defaulting to 1000
[  461.882291] enP2p1s0v5 speed is unknown, defaulting to 1000
[  461.946997] enP2p1s0v6 speed is unknown, defaulting to 1000
[  462.011965] enP2p1s0v7 speed is unknown, defaulting to 1000
[  462.204466] Rounding down aligned max_sectors from 4294967295 to 4294967288
[  462.254325] enP2p1s0v1 speed is unknown, defaulting to 1000
[  462.260010] enP2p1s0v2 speed is unknown, defaulting to 1000
[  462.265622] enP2p1s0v3 speed is unknown, defaulting to 1000
[  462.271265] enP2p1s0v4 speed is unknown, defaulting to 1000
[  462.276880] enP2p1s0v5 speed is unknown, defaulting to 1000
[  462.282510] enP2p1s0v6 speed is unknown, defaulting to 1000
[  462.288149] enP2p1s0v7 speed is unknown, defaulting to 1000
[  462.730599] Rounding down aligned max_sectors from 255 to 248
[  462.787672] Rounding down aligned max_sectors from 255 to 248
[  462.844084] Rounding down aligned max_sectors from 4294967295 to 4294967288
[  469.404559] ib_srpt Received SRP_LOGIN_REQ with i_port_id
fe80:0000:0000:0000:1e1b:0dff:fe9f:67c2, t_port_id
1e1b:0dff:fe9f:67c2:1e1b:0dff:fe9f:67c2 and it_iu_len 8260 on port 1
(guid=fe80:0000:0000:0000:1e1b:0dff:fe9f:67c2); pkey 0xffff
[  469.431993] scsi host5: SRP.T10:1E1B0DFFFE9F67C2
[  469.437806] scsi 5:0:0:0: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[  469.446631] scsi 5:0:0:0: alua: supports implicit and explicit TPGS
[  469.452969] scsi 5:0:0:0: alua: device
naa.60014056e756c6c62300000000000000 port group 0 rel port 1
[  469.462429] sd 5:0:0:0: Attached scsi generic sg2 type 0
[  469.462490] sd 5:0:0:0: Warning! Received an indication that the
LUN assignments on this target have changed. The Linux SCSI layer does
not automatical
[  469.517507] sd 5:0:0:0: alua: transition timeout set to 60 seconds
[  469.517762] scsi 5:0:0:2: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[  469.518227] sd 5:0:0:0: [sdc] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  469.518403] sd 5:0:0:0: [sdc] Write Protect is off
[  469.518736] sd 5:0:0:0: [sdc] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[  469.518805] srpt/10.19.240.85: Unsupported SCSI Opcode 0xa3,
sending CHECK_CONDITION.
[  469.519073] sd 5:0:0:0: [sdc] Optimal transfer size 126976 bytes
[  469.523683] sd 5:0:0:0: alua: port group 00 state A non-preferred
supports TOlUSNA
[  469.532471] scsi 5:0:0:2: alua: supports implicit and explicit TPGS
[  469.580621] scsi 5:0:0:2: alua: device
naa.60014057363736964626700000000000 port group 0 rel port 1
[  469.590052] sd 5:0:0:2: Attached scsi generic sg3 type 0
[  469.590888] sd 5:0:0:2: [sdd] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  469.596057] scsi 5:0:0:1: Direct-Access     LIO-ORG  IBLOCK
  4.0  PQ: 0 ANSI: 6
[  469.602852] sd 5:0:0:2: [sdd] Write Protect is off
[  469.610973] sd 5:0:0:2: alua: transition timeout set to 60 seconds
[  469.612170] scsi 5:0:0:1: alua: supports implicit and explicit TPGS
[  469.612180] scsi 5:0:0:1: alua: device
naa.60014056e756c6c62310000000000000 port group 0 rel port 1
[  469.612532] sd 5:0:0:1: Attached scsi generic sg4 type 0
[  469.612629] sd 5:0:0:1: Warning! Received an indication that the
LUN assignments on this target have changed. The Linux SCSI layer does
not automatical
[  469.621763] sd 5:0:0:2: alua: port group 00 state A non-preferred
supports TOlUSNA
[  469.623489] scsi host6: ib_srp: Already connected to target port
with id_ext=1e1b0dfffe9f67c2;ioc_guid=1e1b0dfffe9f67c2;dest=2620:0052:0000:13f0:1e1b:0dff:fe9f:67c2
[  469.628431] sd 5:0:0:2: [sdd] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  469.637276] sd 5:0:0:1: alua: transition timeout set to 60 seconds
[  469.638096] sd 5:0:0:1: [sde] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  469.638272] sd 5:0:0:1: [sde] Write Protect is off
[  469.638602] sd 5:0:0:1: [sde] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[  469.638669] srpt/10.19.240.85: Unsupported SCSI Opcode 0xa3,
sending CHECK_CONDITION.
[  469.638913] sd 5:0:0:1: [sde] Optimal transfer size 126976 bytes
[  469.642446] srpt/10.19.240.85: Unsupported SCSI Opcode 0xa3,
sending CHECK_CONDITION.
[  469.655940] sd 5:0:0:1: alua: port group 00 state A non-preferred
supports TOlUSNA
[  469.663772] sd 5:0:0:2: [sdd] Optimal transfer size 524288 bytes
[  469.807501] scsi host6: ib_srp: Already connected to target port
with id_ext=1e1b0dfffe9f67c2;ioc_guid=1e1b0dfffe9f67c2;dest=fe80:0000:0000:0000:1e1b:0dff:fe9f:67c2
[  469.867487] rdma_rxe: rxe_invalidate_mr: rkey (0x4d9) doesn't match
mr->ibmr.rkey (0x4da)
[  469.875679] scsi host5: ib_srp: failed RECV status WR flushed (5)
for CQE 000000005048e292
[  469.875727] scsi host5: ib_srp: failed INV RKEY status local QP
operation error (2) for CQE 000000003d8969c2
[  469.944228] enP2p1s0v1 speed is unknown, defaulting to 1000
[  470.027844] enP2p1s0v2 speed is unknown, defaulting to 1000
[  470.109710] enP2p1s0v3 speed is unknown, defaulting to 1000
[  470.191528] enP2p1s0v4 speed is unknown, defaulting to 1000
[  470.273361] enP2p1s0v5 speed is unknown, defaulting to 1000
[  470.354762] enP2p1s0v6 speed is unknown, defaulting to 1000
[  470.436438] enP2p1s0v7 speed is unknown, defaulting to 1000
[  476.896886] scsi host5: SRP abort called
[  477.016881] scsi host5: SRP abort called
[  479.104418] sd 5:0:0:0: rejecting I/O to dead device
[  479.109630] blk_update_request: I/O error, dev sdc, sector 65408 op
0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  479.120291] sd 5:0:0:0: rejecting I/O to dead device
[  479.125255] blk_update_request: I/O error, dev sdc, sector 65408 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  479.135486] Buffer I/O error on dev sdc, logical block 8176, async page read
[  480.197122] ib_srpt receiving failed for ioctx 00000000997f786a with status 5
[  480.201407] sd 5:0:0:0: rejecting I/O to dead device
[  480.204253] ib_srpt receiving failed for ioctx 0000000066ace573 with status 5
[  480.209246] sd 5:0:0:0: [sdc] Attached SCSI disk
[  480.216356] ib_srpt receiving failed for ioctx 00000000e5a1b0ea with status 5
[  480.228112] ib_srpt receiving failed for ioctx 0000000003670b36 with status 5
[  480.235238] ib_srpt receiving failed for ioctx 000000007d2d3bf6 with status 5
[  480.242375] ib_srpt receiving failed for ioctx 000000009efda043 with status 5
[  480.249534] ib_srpt receiving failed for ioctx 00000000b760797c with status 5
[  480.256664] ib_srpt receiving failed for ioctx 00000000f816cb73 with status 5
[  480.263818] ib_srpt receiving failed for ioctx 00000000d502ad16 with status 5
[  480.270971] ib_srpt receiving failed for ioctx 000000006ec645e7 with status 5
[  480.310695] ib_srpt Received SRP_LOGIN_REQ with i_port_id
fe80:0000:0000:0000:1e1b:0dff:fe9f:67c2, t_port_id
1e1b:0dff:fe9f:67c2:1e1b:0dff:fe9f:67c2 and it_iu_len 8260 on port 1
(guid=fe80:0000:0000:0000:1e1b:0dff:fe9f:67c2); pkey 0xffff
[  480.333411] scsi host5: ib_srp: reconnect succeeded
[  480.417318] rdma_rxe: rxe_invalidate_mr: rkey (0x4441d) doesn't
match mr->ibmr.rkey (0x4441e)
[  480.425859] scsi host5: ib_srp: failed RECV status WR flushed (5)
for CQE 00000000f95b2e1a
[  480.537051] scsi 5:0:0:0: alua: Detached
[  487.446658] scsi host5: SRP abort called
[  491.036882] srpt_recv_done: 118 callbacks suppressed
[  491.036888] ib_srpt receiving failed for ioctx 000000006ec6d1da with status 5
[  491.041277] sd 5:0:0:2: rejecting I/O to dead device
[  491.041846] ib_srpt receiving failed for ioctx 0000000071797f86 with status 5
[  491.049029] sd 5:0:0:2: [sdd] Attached SCSI disk
[  491.053957] ib_srpt receiving failed for ioctx 00000000d07c5b0e with status 5
[  491.072836] ib_srpt receiving failed for ioctx 0000000021d9c4ee with status 5
[  491.079974] ib_srpt receiving failed for ioctx 00000000d265e029 with status 5
[  491.087125] ib_srpt receiving failed for ioctx 00000000733e0a59 with status 5
[  491.094252] ib_srpt receiving failed for ioctx 000000009023db51 with status 5
[  491.101384] ib_srpt receiving failed for ioctx 00000000f07935d5 with status 5
[  491.108535] ib_srpt receiving failed for ioctx 00000000375d4cf6 with status 5
[  491.115662] ib_srpt receiving failed for ioctx 0000000037c14713 with status 5
[  491.150502] ib_srpt Received SRP_LOGIN_REQ with i_port_id
fe80:0000:0000:0000:1e1b:0dff:fe9f:67c2, t_port_id
1e1b:0dff:fe9f:67c2:1e1b:0dff:fe9f:67c2 and it_iu_len 8260 on port 1
(guid=fe80:0000:0000:0000:1e1b:0dff:fe9f:67c2); pkey 0xffff
[  491.173311] scsi host5: ib_srp: reconnect succeeded
[  491.178506] sd 5:0:0:1: [sde] Attached SCSI disk
[  491.406562] scsi 5:0:0:2: alua: Detached
[  491.519937] device-mapper: multipath: 253:1: Failing path 8:64.
[  491.656616] scsi 5:0:0:1: alua: Detached
[  491.786766] Unable to handle kernel paging request at virtual
address ffff8000096f9438
[  491.794676] Mem abort info:
[  491.797480]   ESR = 0x96000007
[  491.800527]   EC = 0x25: DABT (current EL), IL = 32 bits
[  491.805833]   SET = 0, FnV = 0
[  491.808896]   EA = 0, S1PTW = 0
[  491.812028]   FSC = 0x07: level 3 translation fault
[  491.816901] Data abort info:
[  491.819769]   ISV = 0, ISS = 0x00000007
[  491.823593]   CM = 0, WnR = 0
[  491.826553] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000f82320000
[  491.833243] [ffff8000096f9438] pgd=1000000fff0ff003,
p4d=1000000fff0ff003, pud=1000000fff0fe003, pmd=100000010c48a003,
pte=0000000000000000
[  491.845768] Internal error: Oops: 96000007 [#1] SMP
[  491.850636] Modules linked in: target_core_user uio
target_core_pscsi target_core_file ib_srpt target_core_iblock
target_core_mod rdma_cm iw_cm ib_cm scsi_debug rdma_rxe ib_uverbs
ip6_udp_tunnel udp_tunnel null_blk dm_service_time ib_umad
crc32_generic scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath
ib_core rfkill sunrpc vfat fat joydev be2net nicvf cavium_ptp
mdio_thunder cavium_rng_vf nicpf thunderx_edac mdio_cavium thunder_bgx
thunder_xcv cavium_rng ipmi_ssif ipmi_devintf ipmi_msghandler fuse
zram ip_tables xfs ast i2c_algo_bit drm_vram_helper drm_kms_helper
syscopyarea sysfillrect sysimgblt fb_sys_fops crct10dif_ce cec
ghash_ce drm_ttm_helper ttm drm i2c_thunderx thunderx_mmc aes_neon_bs
[last unloaded: scsi_transport_srp]
[  491.915381] CPU: 6 PID: 11622 Comm: multipathd Not tainted 5.14.15 #1
[  491.921812] Hardware name: GIGABYTE R120-T34-00/MT30-GS2-00, BIOS
F02 08/06/2019
[  491.929196] pstate: 20400005 (nzCv daif +PAN -UAO -TCO BTYPE=--)
[  491.935192] pc : scsi_mq_exit_request+0x28/0x60
[  491.939721] lr : blk_mq_free_rqs+0x7c/0x1ec
[  491.943897] sp : ffff800016a536c0
[  491.947200] x29: ffff800016a536c0 x28: ffff0001375b8000 x27: 0000000000000131
[  491.954330] x26: ffff000102bb5c28 x25: ffff0001333d1000 x24: ffff0001333d1200
[  491.961460] x23: 0000000000000000 x22: ffff0001386870a8 x21: 0000000000000000
[  491.968589] x20: 0000000000000001 x19: ffff00010d878128 x18: ffffffffffffffff
[  491.975719] x17: 5342555300355f66 x16: 6d745f697363732f x15: 0000000000000000
[  491.982848] x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
[  491.989977] x11: ffff8000114a1298 x10: 0000000000001c90 x9 : ffff800010764030
[  491.997109] x8 : ffff0001375b9cf0 x7 : 0000000000000004 x6 : 00000002a7f08498
[  492.004242] x5 : 0000000000000001 x4 : ffff000130092128 x3 : ffff800010b1e7e0
[  492.011371] x2 : 0000000000000000 x1 : ffff8000096f93f0 x0 : ffff000138687000
[  492.018501] Call trace:
[  492.020937]  scsi_mq_exit_request+0x28/0x60
[  492.025112]  blk_mq_free_rqs+0x7c/0x1ec
[  492.028939]  blk_mq_free_tag_set+0x58/0x100
[  492.033113]  scsi_mq_destroy_tags+0x20/0x30
[  492.037286]  scsi_host_dev_release+0x9c/0x100
[  492.041633]  device_release+0x40/0xa0
[  492.045286]  kobject_cleanup+0x4c/0x180
[  492.049115]  kobject_put+0x50/0xd0
[  492.052510]  put_device+0x20/0x30
[  492.055819]  scsi_target_dev_release+0x34/0x44
[  492.060253]  device_release+0x40/0xa0
[  492.063905]  kobject_cleanup+0x4c/0x180
[  492.067732]  kobject_put+0x50/0xd0
[  492.071124]  put_device+0x20/0x30
[  492.074428]  scsi_device_dev_release_usercontext+0x228/0x244
[  492.080079]  execute_in_process_context+0x50/0xa0
[  492.084775]  scsi_device_dev_release+0x28/0x3c
[  492.089208]  device_release+0x40/0xa0
[  492.092860]  kobject_cleanup+0x4c/0x180
[  492.096686]  kobject_put+0x50/0xd0
[  492.100081]  put_device+0x20/0x30
[  492.103396]  scsi_device_put+0x38/0x50
[  492.107140]  sd_release151]  free_multipath+0x80/0xc0 [dm_multipath]
[  492.132109]  multipath_dtr+0x38/0x50 [dm_multipath]
[  492.136980]  dm_table_destroy+0x68/0x150
[  492.140892]  __dm_destroy+0x138/0x204
[  492.144548]  dm_destroy+0x20/0x30
[  492.147859]  dev_remove+0x144/0x1e0
[  492.151339]  ctl_ioctl+0x278/0x4d0
[  492.154731]  dm_ctl_ioctl+0x1c/0x30
[  492.158210]  __arm64_sys_ioctl+0xb4/0x100
[  492.162212]  invoke_syscall+0x50/0x120
[  492.165955]  el0_svc_common+0x48/0x100
[  492.169694]  do_el0_svc+0x34/0xa0
[  492.173000]  el0_svc+0x2c/0x54
[  492.176048]  el0t_64_sync_handler+0xa4/0x130
[  492.180307]  el0t_64_sync+0x19c/0x1a0
[  492.183962] Code: f9000bf3 9104a033 f9403000 f9404c01 (f9402422)
[  492.190068] ---[ end trace dbfeac019a702ce7 ]---
[  492.194678] Kernel panic - not syncing: Oops: Fatal exception
[  492.200431] SMP: stopping secondary CPUs
[  492.204354] Kernel Offset: 0x80000 from 0xffff800010000000
[  492.209828] PHYS_OFFSET: 0x0
[  492.212697] CPU features: 0x00180051,20800a40
[  492.217043] Memory Limit: none
[  492.220102] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---


-- 
Best Regards,
  Yi Zhang

