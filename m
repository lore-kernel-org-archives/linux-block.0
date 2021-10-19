Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F04C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 03:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B326103B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 03:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhJSDaI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 23:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229742AbhJSDaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 23:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634614075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9U72ZD1GAz0mO/zD/boGMJUMKf3KZeMbrSX+aq4r3b0=;
        b=UOaG7fo6AgPR2oJtSFNbk5l90ZVA6BE+OjREHv3U2UFV5OgglXgzGfbVgNfevwQ1Dk8v8W
        q74aTjnlP6b4ndyl49eLbIxLpd/pecOfCw7VSOvwBE3n7hpShr9O6CgcIbeIdPQ7OyUG0u
        F9i6Eah58YgSPzuvUsf62pYNCh9zSso=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42--5Fs1cuaMxqx785ybHkd1g-1; Mon, 18 Oct 2021 23:27:53 -0400
X-MC-Unique: -5Fs1cuaMxqx785ybHkd1g-1
Received: by mail-yb1-f199.google.com with SMTP id y16-20020a2586d0000000b005b752db8f97so22762522ybm.18
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 20:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9U72ZD1GAz0mO/zD/boGMJUMKf3KZeMbrSX+aq4r3b0=;
        b=wf829YtsYZtQY1g3bPxt1BRLgJqG9gXiBv7tK/mZU7C+EQy+pcBvxu7KtmCRVp1gk1
         Sg2Vsk8yljA0DK0mLiFsiCJmXbFL14uD7X29rEqxj7lqndfPgCzGbWDF69inXw0X6Hdh
         qz9PAjLoV66sX54fyDK3nrOiztTxI2k6DkHjCOhqdlqwS4qMVU8XpNciPUAbQLJMg5c/
         kgjwhcxLhDXmRC70KpPfV8uDGAka/yHe0+OcoG0GuJUuE7YjqUkLJSLn73syByC9djF4
         qeIJkiltDcSiOsfgmZRokzTcN2hxRAIljJjH9LsrzIZlNy+9OWrc/GJyfDGqayuNmizd
         qz0g==
X-Gm-Message-State: AOAM530ExqdEQ8GYGWZRoHNjcOULHaUGwKeSk39u/YXLwqVFgEjZmu7E
        lj3Ryr2Ofr4nkQX6q5M7h1JeFnzB5YZ+dkhvRkX3jBtS/YGozS1nJxWE4WZsL5pzHva2vuc9gVg
        ZizzM25QAq4EafP91MEmaXpgPSVMoPDeN2TKWsqI=
X-Received: by 2002:a25:bd03:: with SMTP id f3mr32056319ybk.412.1634614073108;
        Mon, 18 Oct 2021 20:27:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS/eEq7ByrZtEEXQiiYd/RS+UoWZJyXyEPxc+lD5MdXoglNGaisIEzBONkQFVRnmcdor4tWVHBxsIXUGOrg1o=
X-Received: by 2002:a25:bd03:: with SMTP id f3mr32056300ybk.412.1634614072881;
 Mon, 18 Oct 2021 20:27:52 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 19 Oct 2021 11:27:40 +0800
Message-ID: <CAHj4cs-_vkTW=dAzbZYGxpEWSpzpcmaNeY1R=vH311+9vMUSdg@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 4 PID: 10482 at block/mq-deadline.c:597 dd_exit_sched+0x198/0x1d0
To:     linux-block <linux-block@vger.kernel.org>
Cc:     skt-results-master@redhat.com,
        Bruno Goncalves <bgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

Here is another issue triggered with blktests nvmeof-mp/012 on ppc64le

>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>             Commit: 1983520d28d8 - Merge branch 'for-5.16/io_uring' into for-next


[  198.810575] run blktests nvmeof-mp/012 at 2021-10-18 14:04:34
[  198.880348] null_blk: module loaded
[  198.952441] device-mapper: table: 253:1: multipath: error getting device
[  198.952458] device-mapper: ioctl: error adding target to table
[  198.952642] SoftiWARP attached
[  199.070415] nvmet: adding nsid 1 to subsystem nvme-test
[  199.079054] nvmet_rdma: enabling port 1 (10.0.2.177:7777)
[  199.172211] nvmet: creating controller 1 for subsystem nvme-test
for NQN nqn.2014-08.org.nvmexpress:uuid:548b1456-be56-4e3b-b887-a93e4557c960.
[  199.172631] nvme nvme0: creating 8 I/O queues.
[  199.176935] nvme nvme0: mapped 8/0/0 default/read/poll queues.
[  199.177528] nvme nvme0: new ctrl: NQN "nvme-test", addr 10.0.2.177:7777
[  199.191054] device-mapper: table: 253:1: multipath: error getting device
[  199.191065] device-mapper: ioctl: error adding target to table
[  199.302695] device-mapper: table: 253:2: multipath: error getting device
[  199.302703] device-mapper: ioctl: error adding target to table
[  201.342136] ------------[ cut here ]------------
[  201.342149] statistics for priority 1: i 5803 m 0 d 5803 c 6467
[  201.342163] WARNING: CPU: 4 PID: 10482 at block/mq-deadline.c:597
dd_exit_sched+0x198/0x1d0
[  201.342171] Modules linked in: nvme nvmet_rdma nvmet siw null_blk
nvme_rdma nvme_fabrics rdma_cm iw_cm ib_cm dm_service_time
scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath ib_core nvme_core
bonding tls rfkill sunrpc ibmveth crct10dif_vpmsum pseries_rng drm
drm_panel_orientation_quirks i2c_core fuse zram ip_tables xfs ibmvscsi
nx_compress_pseries scsi_transport_srp nx_compress vmx_crypto
crc32c_vpmsum [last unloaded: siw]
[  201.342213] CPU: 4 PID: 10482 Comm: check Not tainted 5.15.0-rc6 #1
[  201.342218] NIP:  c0000000009733d8 LR: c0000000009733d4 CTR: 00000000006db41c
[  201.342223] REGS: c00000002134b720 TRAP: 0700   Not tainted  (5.15.0-rc6)
[  201.342227] MSR:  800000000282b033
<SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 4842828f  XER: 00000004
[  201.342239] CFAR: c000000000152b34 IRQMASK: 0
[  201.342239] GPR00: c0000000009733d4 c00000002134b9c0
c0000000028a9a00 0000000000000033
[  201.342239] GPR04: 00000000ffffdfff c00000002134b678
c00000002134b670 0000000000000027
[  201.342239] GPR08: 0000000000000001 c0000001ffa07f90
0000000000000023 0000000000000001
[  201.342239] GPR12: 000000002842828f c00000001eca9d00
0000000000000000 0000000000000000
[  201.342239] GPR16: 00000001334d87b8 00000001334d94d4
0000000020000000 00000001333eae80
[  201.342239] GPR20: c00000000ece5ebc 00000000000016ab
0000000000001943 0000000000000001
[  201.342239] GPR24: c00000000152b440 0000000000000000
c0000000027e2094 0000000000000000
[  201.342239] GPR28: c00000000ece5f48 c00000000ece5e00
0000000000000001 c00000000ece5e80
[  201.342289] NIP [c0000000009733d8] dd_exit_sched+0x198/0x1d0
[  201.342294] LR [c0000000009733d4] dd_exit_sched+0x194/0x1d0
[  201.342298] Call Trace:
[  201.342301] [c00000002134b9c0] [c0000000009733d4]
dd_exit_sched+0x194/0x1d0 (unreliable)
[  201.342308] [c00000002134ba80] [c000000000946f98]
blk_mq_exit_sched+0xe8/0x120
[  201.342314] [c00000002134bad0] [c0000000009251c4]
elevator_switch_mq+0x84/0x210
[  201.342319] [c00000002134bb50] [c000000000925a4c]
elv_iosched_store+0x47c/0x5d0
[  201.342325] [c00000002134bbb0] [c00000000092cb58] queue_attr_store+0x78/0xc0
[  201.342330] [c00000002134bc00] [c000000000644984] sysfs_kf_write+0x64/0x80
[  201.342336] [c00000002134bc20] [c000000000643e4c]
kernfs_fop_write_iter+0x1bc/0x2b0
[  201.342342] [c00000002134bc70] [c000000000521314] new_sync_write+0x124/0x1b0
[  201.342348] [c00000002134bd10] [c000000000524614] vfs_write+0x2c4/0x390
[  201.342353] [c00000002134bd60] [c000000000524988] ksys_write+0x78/0x130
[  201.342359] [c00000002134bdb0] [c00000000002d648]
system_call_exception+0x188/0x360
[  201.342365] [c00000002134be10] [c00000000000c1e8]
system_call_vectored_common+0xe8/0x278
[  201.342371] --- interrupt: 3000 at 0x7fffb664fee4
[  201.342375] NIP:  00007fffb664fee4 LR: 0000000000000000 CTR: 0000000000000000
[  201.342379] REGS: c00000002134be80 TRAP: 3000   Not tainted  (5.15.0-rc6)
[  201.342383] MSR:  800000000280f033
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48422488  XER: 00000000
[  201.342395] IRQMASK: 0
[  201.342395] GPR00: 0000000000000004 00007fffdfc43400
00007fffb6747000 0000000000000001
[  201.342395] GPR04: 0000010010ac2b20 0000000000000006
0000000000000010 0000010010acdec3
[  201.342395] GPR08: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
[  201.342395] GPR12: 0000000000000000 00007fffb688afa0
0000000000000000 0000000000000000
[  201.342395] GPR16: 00000001334d87b8 00000001334d94d4
0000000020000000 00000001333eae80
[  201.342395] GPR20: 0000000000000000 00007fffdfc43624
0000000133483128 00000001334d89bc
[  201.342395] GPR24: 00000001334d8a50 0000000000000000
0000010010ac2b20 0000000000000006
[  201.342395] GPR28: 0000000000000006 00007fffb67416d8
0000010010ac2b20 0000000000000006
[  201.342441] NIP [00007fffb664fee4] 0x7fffb664fee4
[  201.342445] LR [0000000000000000] 0x0
[  201.342447] --- interrupt: 3000
[  201.342450] Instruction dump:
[  201.342452] 2c090000 4082ff7c 9afa0000 81140000 80ff0038 80df0034
80bf0030 7d0807b4
[  201.342461] 7fc4f378 7f03c378 4b7df6fd 60000000 <0fe00000> 60420000
0fe00000 60000000
[  201.342470] ---[ end trace 108cf85114306689 ]---
[  202.926082] nvme nvme0: Removing ctrl: NQN "nvme-test"
[  203.272436] nvmet: creating controller 1 for subsystem nvme-test
for NQN nqn.2014-08.org.nvmexpress:uuid:548b1456-be56-4e3b-b887-a93e4557c960.
[  203.272975] nvme nvme0: creating 8 I/O queues.
[  203.277569] nvme nvme0: mapped 8/0/0 default/read/poll queues.
[  203.278187] nvme nvme0: new ctrl: NQN "nvme-test", addr 10.0.2.177:7777
[  203.290859] device-mapper: table: 253:1: multipath: error getting device
[  203.290866] device-mapper: ioctl: error adding target to table
[  203.401606] device-mapper: table: 253:1: multipath: error getting device
[  203.401614] device-mapper: ioctl: error adding target to table
[  207.146139] nvme nvme0: Removing ctrl: NQN "nvme-test"
[  207.927071] SoftiWARP detached

-- 
Best Regards,
  Yi Zhang

